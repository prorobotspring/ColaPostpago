<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:mannindia="http://server.webservices.corte.com" xmlns:ax27="http://domain.webservices.corte.com/xsd">
	<!-- Version transformacion mannindia -->
	<xsl:output method="text" />

	<!-- CONSTANTS -->

	<xsl:variable name="textCargosAprox" select="' tiene un estimado de Bs.F '" />
	<xsl:variable name="textDispone" select="' por facturar y dispone de '" />
	<xsl:variable name="textPlan" select="' Plan '" />
	<xsl:variable name="textSeparadorBalance" select="'; '" />
	<xsl:variable name="textSegDig" select="'SegDig '" />
	<xsl:variable name="textSegOtra" select="'SegOtra '" />
	<xsl:variable name="textSMS" select="'SMS '" />
	<xsl:variable name="textMMS" select="'MMS '" />
	<xsl:variable name="textMB" select="'MB '" />
	<xsl:variable name="textMinDig" select="'MinDig '" />
	<xsl:variable name="textMinOtra" select="'MinOtra '" />
	<xsl:variable name="textSeg" select="'Seg '" />
	<xsl:variable name="textSegVPN" select="'SegVPN '" />
	<xsl:variable name="textMin" select="'Min '" />
 	<xsl:variable name="textPunto" select="'.'" />  
 	<xsl:variable name="textMinLDI" select="'MinLDI '" />
 	<xsl:variable name="textSMSInt" select="'SMSInt '" />
 	<xsl:variable name="Ilimitado" select="'Ilimitado'" />

	<xsl:decimal-format name="espaniol" decimal-separator="," grouping-separator="." />

	<!-- MAIN -->
	<xsl:template match="/">
		<xsl:apply-templates select="//mannindia:return"></xsl:apply-templates>
	</xsl:template>

	<xsl:template match="mannindia:return">

		<!-- Informacion general -->

		<!-- PLAN -->
		<xsl:variable name="SHORT_DESCRIPTION" select="ax27:short_Description" />

		<!-- FECHA_CONSUMO -->
		<xsl:variable name="FECHA_HORA" select="ax27:lastExtractionProcessEndDate" />

		<!-- TOTAL_CONSUMO -->
		<xsl:variable name="TOTAL_CONSUMOS" select="ax27:totalConsumptions" />

 		<xsl:variable name="newString" select="concat(normalize-space($TOTAL_CONSUMOS), ',')" />
  		
		<xsl:variable name="first" select="concat(concat(format-number( substring-before($newString, ','),'###.###.###','espaniol'),','),substring-after($newString, ','))" />
  		
		<xsl:variable name="MONTO" select="substring($first,1,(string-length($first)-1))" />

		<!-- SMS_FORMAT -->
		<xsl:variable name="SMS_FORMAT" select="ax27:smsFormatID" />

		<!-- Detalles del trafico -->

		<!-- Voz_D_D -->
		<xsl:variable name="VOZ_D_D" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='Voz D-D']/ax27:avaliableUnits)"/>

		<!-- Voz_OtOp -->
		<xsl:variable name="VOZ_OTOP" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='Voz OtOp']/ax27:avaliableUnits)"/>

		<!-- SMS -->
		<xsl:variable name="SMS" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='SMS']/ax27:avaliableUnits)" />

		<!-- MMS -->
		<xsl:variable name="MMS" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='MMS']/ax27:avaliableUnits)" />

		<!-- GPRS -->
		<xsl:variable name="GPRS" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='GPRS']/ax27:avaliableUnits)" />

		<!-- Voz_412 -->
		<xsl:variable name="VOZ_412" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='Voz 412']/ax27:avaliableUnits)" />

		<!-- Voz_Miembros -->
		<xsl:variable name="VOZ_MIEMBROS" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='Voz Miembros']/ax27:avaliableUnits)"/>

		<!-- Voz_D_D_Fija -->
		<xsl:variable name="VOZ_D_D_FIJA" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='Voz D-D Fija']/ax27:avaliableUnits)" />

		<!-- "Voz_OtOp_Fija" -->
		<xsl:variable name="VOZ_OTOP_FIJA" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='Voz OtOp Fija']/ax27:avaliableUnits)"/>
		
		<!-- VozLDI -->
		<xsl:variable name="VozLDI" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='VozLDI']/ax27:avaliableUnits)" />
		
		<!-- SMSInt -->
		<xsl:variable name="SMSInt" select="sum(ax27:trafficUsageDetails/ax27:trafficUsage[ax27:trafficDescription='SMSInt']/ax27:avaliableUnits)" />

		<!-- Fechas del corte  -->

		<!-- LastPayment -->
		<xsl:variable name="LASTPAYMENT" select="ax27:lastPayment" />

		<!-- LastPaymentDate -->
		<xsl:variable name="LASTPAYMENTDATE" select="ax27:lastPaymentDate" />



		<!-- *************************************************************************************************** -->
		<!-- MENSAJE RETORNADO -->

		<xsl:choose>
		
			<xsl:when test="$SMS_FORMAT = 'Formato 1'">
		
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textSegDig" />	
				<xsl:value-of select="$VOZ_D_D" />		
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSegOtra" />
				<xsl:value-of select="$VOZ_OTOP" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMMS" />
				<xsl:value-of select="$MMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>
		
			<xsl:when test="$SMS_FORMAT = 'Formato 2'">
				
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textMinDig" />	
				<xsl:value-of select="$VOZ_D_D" />	
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMinOtra" />
				<xsl:value-of select="$VOZ_OTOP" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMMS" />
				<xsl:value-of select="$MMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>

			<xsl:when test="$SMS_FORMAT = 'Formato 3'">
			
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textSeg" />	
				<xsl:value-of select="$VOZ_412" />		
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMMS" />
				<xsl:value-of select="$MMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>
			
			<xsl:when test="$SMS_FORMAT = 'Formato 4'">
 
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>

			<xsl:when test="$SMS_FORMAT = 'Formato 5'">
				
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textSegVPN" />	
				<xsl:value-of select="$VOZ_MIEMBROS" />	
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSeg" />
				<xsl:value-of select="$VOZ_412" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMMS" />
				<xsl:value-of select="$MMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>
			
			<xsl:when test="$SMS_FORMAT = 'Formato 6'">
				
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textMin" />	
				<xsl:value-of select="$VOZ_D_D_FIJA" />	
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMinOtra" />
				<xsl:value-of select="$VOZ_OTOP_FIJA" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMMS" />
				<xsl:value-of select="$MMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>
			
			<xsl:when test="$SMS_FORMAT = 'Formato 7'">
				
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textSeg" />
				<xsl:value-of select="$VOZ_D_D" />	
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSegOtra" />
				<xsl:value-of select="$VOZ_OTOP" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>
			
			<xsl:when test="$SMS_FORMAT = 'Formato 9'">
		
				<xsl:value-of select="concat(substring($FECHA_HORA,1,6),concat(substring($FECHA_HORA,9,5),substring($FECHA_HORA,21,2)))" />
				<xsl:value-of select="$textCargosAprox" />
				<xsl:value-of select="$MONTO" />
				<xsl:value-of select="$textDispone" />
				<xsl:value-of select="$textSeg" />	
				<xsl:value-of select="$VOZ_412" />		
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMS" />
				<xsl:value-of select="$SMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMMS" />
				<xsl:value-of select="$MMS" />
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMB" />
				<xsl:choose>
					<xsl:when test="$GPRS &gt; 9899999">
						<xsl:value-of select="$Ilimitado" />
					</xsl:when>
					<xsl:when test="$GPRS &lt; 9900000">
						<xsl:value-of select="format-number( ($GPRS) div 1024,'########0,00','espaniol')" />
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textMinLDI" />	
				<xsl:value-of select="$VozLDI" />		
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textSMSInt" />	
				<xsl:value-of select="$SMSInt" />		
				<xsl:value-of select="$textSeparadorBalance" />
				<xsl:value-of select="$textPlan" />
				<xsl:value-of select="$SHORT_DESCRIPTION" />																					
				<xsl:value-of select="$textPunto" />
			</xsl:when>
			
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>