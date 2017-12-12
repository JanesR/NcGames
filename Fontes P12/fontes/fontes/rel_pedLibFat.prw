#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "FILEIO.CH"
#include "TOTVS.CH"

user function viewLibFat(ItensLib)

Local aArea:= GetArea()
Local pedidos := ItensLib
Local itensTab := ""
Local cFil :=""
Local cPedido:=""
Local cPedCli:=""
Local cCliente:=""
Local cCidade:=""
Local cUF:=""
Local cVol:=""
Local cPeso:=""
Local cValor:=""
Local cTransp:=""
Local cQuery1 :=""
Local cAlias01 :=GetNextAlias()
Local cTEXT :=""
Local aPedLido :={}
Local tipoEcom :=""
Local pedEcom:=""
Local vendedor:=""
Local pago:=""
Private cDir :="C:\relatorios\pedidoliberado"+DTOS(msdate())+STRTRAN(Time(),':','-')+".html"


for nX :=1 to len(pedidos)
	
	cQuery1 :="		select "
	cQuery1 +="		    distinct c5.c5_FILIAL FIL ,  "+ CRLF
	cQuery1 +="		    c5.c5_num PEDIDO,  "+ CRLF
	cQuery1 +="		    c5.C5_PEDCLI PEDCLI,  "+ CRLF
	cQuery1 +="		    c5.C5_CLIENTE||'/'||c5.C5_LOJACLI||' - '||a1.A1_NREDUZ CLIENTE, "+ CRLF
	cQuery1 +="		    cc2.CC2_MUN MUNICIPIO, "+ CRLF
	cQuery1 +="		    cc2.CC2_EST ESTADO, "+ CRLF
	cQuery1 +="		           	CASE    "+ CRLF
	cQuery1 +="		              WHEN (CS.CS_QTDE_VOLUMES  IS NOT  NULL) THEN CS.CS_QTDE_VOLUMES   "+ CRLF
	cQuery1 +="		            	ELSE C5.C5_VOLUME1   "+ CRLF
	cQuery1 +="		           END   VOLUMES, "+ CRLF
	cQuery1 +="		           CASE "+ CRLF
	cQuery1 +="		              WHEN (DS.DPCS_PESO IS NOT  NULL) THEN DS.DPCS_PESO  "+ CRLF
	cQuery1 +="		              ELSE 0 "+ CRLF
	cQuery1 +="		           END PESO, "+ CRLF
	cQuery1 +="		           CASE "+ CRLF
	cQuery1 +="		              WHEN (DS.DPCS_VALOR  IS NOT  NULL) THEN DS.DPCS_VALOR "+ CRLF
	cQuery1 +="		              ELSE 0 "+ CRLF
	cQuery1 +="		           END VALOR, "+ CRLF
	cQuery1 +="		           CASE "+ CRLF
	cQuery1 +="		              WHEN (DPCS_DESC_TRANSPORTADOR  IS NOT  NULL) THEN DPCS_DESC_TRANSPORTADOR "+ CRLF
	cQuery1 +="		              ELSE 'SEM TRANSPORTADORA' "+ CRLF
	cQuery1 +="		           END TRANSPORT, "+ CRLF
	cQuery1 +="		           	CASE
	cQuery1 +="		           		WHEN ZC5.ZC5_NUM <> 0 AND ZC5.ZC5_NUMPV IS NOT NULL  then 'B2C' " + CRLF
	cQuery1 +="		           		WHEN ZC5.ZC5_NUM  = 0 AND ZC5.ZC5_NUMPV IS NOT NULL   then 'B2B' " + CRLF
	cQuery1 +="		           		ELSE '0' " + CRLF
	cQuery1 +="		           END TIPOECOM, " + CRLF
	cQuery1 +="		                            CASE " + CRLF
	cQuery1 +="		                              WHEN ZC5.ZC5_NUM <> 0 AND ZC5.ZC5_NUMPV IS NOT NULL  then  TRIM(CAST(ZC5.ZC5_NUM AS CHAR(100))) " + CRLF
	cQuery1 +="		                              WHEN ZC5.ZC5_NUM  = 0 AND ZC5.ZC5_NUMPV IS NOT NULL   then ZC5.ZC5_PVVTEX " + CRLF
	cQuery1 +="		                              ELSE '0' " + CRLF
	cQuery1 +="		                            END NUMECOMERCE, " + CRLF
	cQuery1 +="		                            CASE " + CRLF
	cQuery1 +="		                             WHEN ZC5.ZC5_STATUS = '10' THEN 'SIM' " + CRLF
	cQuery1 +="		                             ELSE 'NÃO' " + CRLF
	cQuery1 +="		                            END PAGO, " + CRLF
	cQuery1 +="		                            SA3.A3_NOME VENDEDOR " + CRLF
	cQuery1 +="		from "+RetSQLNAme("sc5")+" c5 left join "+RetSQLName("sa1")+" a1 "+ CRLF
	cQuery1 +="		on c5.C5_CLIENTE = a1.A1_COD and c5.C5_LOJACLI = a1.A1_LOJA "+ CRLF
	cQuery1 +="		left join "+RetSQLName("CC2")+" cc2 "+ CRLF
	cQuery1 +="		on a1.A1_COD_MUN = cc2.CC2_CODMUN and a1.A1_EST = cc2.CC2_EST "+ CRLF
	cQuery1 +="		left join WMS.TB_WMSINTERF_CONF_SEPARACAO CS   "+ CRLF
	cQuery1 +="		on C5.C5_FILIAL||C5.C5_NUM = CS.CS_COD_CHAVE   "+ CRLF
	cQuery1 +="		left join wms.tb_wmsinterf_doc_saida DS "+ CRLF
	cQuery1 +="		on c5.c5_num = DS.DPCS_NUM_DOCUMENTO "+ CRLF
	cQuery1 +="		left join "+RetSQLName("ZC5")+" zc5 "+ CRLF
	cQuery1 +="		on c5.C5_NUM = zc5.ZC5_NUMPV and c5.c5_filial = zc5.ZC5_FILIAL "+ CRLF
	cQuery1 +="		left join "+RetSQLName("SA3")+" SA3 "+ CRLF
	cQuery1 +="		ON c5.C5_VEND1 = SA3.A3_COD "+ CRLF
	cQuery1 +="		where  "+ CRLF
	cQuery1 +="		      c5.c5_filial = '"+pedidos[nx][1]+"' "+ CRLF
	cQuery1 +="		  and c5.c5_num = '"+pedidos[nx][2]+"' "+ CRLF
	cQuery1 +="		  and c5.D_E_L_E_T_ = ' ' "+ CRLF
	
	Iif(Select(cAlias01) > 0,(cAlias01)->(dbCloseArea()),Nil)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),cAlias01,.T.,.T.)
	
	while (cAlias01)->(!EOF())
		
		cFil	 		:= (cAlias01)->FIL +"/"+ substr( Posicione("XX8",2,PADR(SM0->M0_CODIGO, 12 )+(cAlias01)->FIL,"XX8_DESCRI"),0,40)
		cPedido 		:= (cAlias01)->PEDIDO
		cPedCli 		:= (cAlias01)->PEDCLI
		cCliente 	:= (cAlias01)->CLIENTE
		cCidade 		:= (cAlias01)->MUNICIPIO
		cUF 			:= (cAlias01)->ESTADO
		
		cVol 			:= CVALTOCHAR((cAlias01)->VOLUMES)
		cPeso 		:= CVALTOCHAR((cAlias01)->PESO   )
		cValor 		:= CVALTOCHAR((cAlias01)->VALOR  )
		cTransp 		:= (cAlias01)->TRANSPORT
		
		tpEcom :=(cAlias01)->TIPOECOM
 		pedEcom:=(cAlias01)->NUMECOMERCE
 		vend:=(cAlias01)->VENDEDOR
 		pago:=(cAlias01)->PAGO
		
		
		(cAlias01)->(dBSKip())
			
			itensTab +=		'	<div>' + CRLF
			itensTab +=		'		<table align="center" class="pedido">' + CRLF
			itensTab +=		'			<tr>'+ CRLF
			itensTab +=		'				<td colspan=1 class="Cab">Filial</td>' + CRLF
			itensTab +=		'				<td colspan=5>'+ cFil +'</td>' + CRLF
			itensTab +=		'				<td colspan=1 class="Cab">Pedido</td>' + CRLF
			itensTab +=		'				<td colspan=5>'+cPedido+'</td>' + CRLF
			itensTab +=		'			</tr>' + CRLF
			itensTab +=		'			<tr>' + CRLF                              
			IF (tpEcom == "0")
			itensTab +=		'				<td colspan=1 class="Cab">Pedido Cliente</td>' + CRLF
			itensTab +=		'				<td colspan=11>'+cPedCli+'</td>' + CRLF
			ELSE
			itensTab +=		'				<td colspan=1 class="Cab">Pedido Ecommerce</td>' + CRLF
			itensTab +=		'				<td colspan=6>'+cPedCli+'</td>' + CRLF
			itensTab +=		'				<td colspan=1 class="Cab">Pago</td>' + CRLF
			itensTab +=		'				<td colspan=1>'+pago+'</td>' + CRLF
			itensTab +=		'				<td colspan=1 class="Cab">Tipo</td>' + CRLF
			itensTab +=		'				<td colspan=2>'+tpEcom+'</td>' + CRLF
			ENDIF
			itensTab +=		'			</tr>' + CRLF
			itensTab +=		'			<tr>' + CRLF
			itensTab +=		'				<td colspan=1 class="Cab">Cliente</td>' + CRLF
			itensTab +=		'				<td colspan=5>'+cCliente+'</td>' + CRLF
			itensTab +=		'				<td colspan=1 class="Cab">Vendedor</td>' + CRLF
			itensTab +=		'				<td colspan=5>'+vend+'</td>' + CRLF
			itensTab +=		'			</tr>' + CRLF
			itensTab +=		'			<tr>' + CRLF
			itensTab +=		'				<td class="Cab">Cidade</td>' + CRLF
			itensTab +=		'				<td >'+cCidade+'</td>' + CRLF
			itensTab +=		'				<td class="Cab">UF</td>' + CRLF
			itensTab +=		'				<td >'+cUF+'</td>' + CRLF
			itensTab +=		'				<td class="Cab">Volumes</td>' + CRLF
			itensTab +=		'				<td >'+cVol+'</td>' + CRLF
			itensTab +=		'				<td class="Cab">Peso</td>' + CRLF
			itensTab +=		'				<td >'+cPeso+'</td>' + CRLF
			itensTab +=		'				<td class="Cab">Valor</td>' + CRLF
			itensTab +=		'				<td >'+cValor+'</td>' + CRLF
			itensTab +=		'				<td class="Cab">Transportadora</td>' + CRLF
			itensTab +=		'				<td >'+cTransp+'</td>' + CRLF
			itensTab +=		'			</tr>' + CRLF
			itensTab +=		'		</table>' + CRLF
			itensTab +=		'	</div>' + CRLF             
			
			cFil	 		:= ""
			cPedido 		:= ""
			cPedCli 		:= ""
			cCliente 	:= ""
			cCidade 		:= ""
			cUF 			:= ""
			cVol 			:= ""
			cPeso 		:= ""
			cValor 		:= ""
			cTransp 		:= ""
		
	ENDDO
	
	(cAlias01)->(dbCloseArea())
	
next

cTEXT :=	MontaHtml(itensTab)

GeraHtml(cTEXT)

ImprimeRel(cDir)

RestArea(aArea)
return


static function GeraHtml(cTEXT)
Local aArea:=GetArea()
Private cArqHTML := ""


cArqHTML := FCREATE(cDir ,0)

if cArqHTML = -1
	conout("Erro ao criar arquivo - ferror " + Str(Ferror()))
else
	FWrite(cArqHTML, cTEXT)
	FClose(cArqHTML)
endif

RestArea(aArea)
return

static function MontaHtml(itensTab)
Local aArea:=GetArea()
Local cHtml:=""

cHtml:= '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' + CRLF
cHtml+='<html xmlns="http://www.w3.org/1999/xhtml"> ' + CRLF
cHtml+='<head>' + CRLF
cHtml+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />' + CRLF
cHtml+='	<style type="text/css">' + CRLF
cHtml+='form                                                                   ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='azimuth:center;	                                                       ' + CRLF
cHtml+='background:#FFFFFF;                                                    ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='body                                                                   ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	background:#FFFFFF;                                                ' + CRLF
cHtml+='	font-family:"Courier New", Courier, monospace;                     ' + CRLF
cHtml+='	font:small;	                                                       ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='div                                                                    ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	width:910px;                                                       ' + CRLF
cHtml+='	background-color:#CCCCCC;                                          ' + CRLF
cHtml+='	border-style:inherit;                                              ' + CRLF
cHtml+='	azimuth:center;                                                    ' + CRLF
cHtml+='	align: center;                                                     ' + CRLF
cHtml+='	border-radius: 10px;	                                           ' + CRLF
cHtml+='	                                                                   ' + CRLF
cHtml+='	margin-bottom:1px;                                                 ' + CRLF
cHtml+='	margin-top:2px;                                                    ' + CRLF
cHtml+='	                                                                   ' + CRLF
cHtml+='	padding-bottom:1px;                                                ' + CRLF
cHtml+='	padding-left:1px;                                                  ' + CRLF
cHtml+='	padding-right:1px;                                                 ' + CRLF
cHtml+='	padding-top:1px;                                                   ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='table                                                                  ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	width:900px;                                                       ' + CRLF
cHtml+='	position:relative;                                                 ' + CRLF
cHtml+='	background-color:#FFFFFF;                                          ' + CRLF
cHtml+='	border-bottom-style:inherit;	                                   ' + CRLF
cHtml+='	border-radius: 10px;                                               ' + CRLF
cHtml+='                                                                       ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='table.pedido                                                           ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	width:900px;                                                       ' + CRLF
cHtml+='	position:relative;                                                 ' + CRLF
cHtml+='	background-color:#FFFFFF;                                          ' + CRLF
cHtml+='	                                                                   ' + CRLF
cHtml+='	border-bottom-style:inherit;                                       ' + CRLF
cHtml+='	border: 1px solid #000000;                                         ' + CRLF
cHtml+='	border-radius: 5px;	                                               ' + CRLF
cHtml+='	                                                                   ' + CRLF
cHtml+='	font-family:"Courier New", Courier, monospace;                     ' + CRLF
cHtml+='	font:small;	                                                       ' + CRLF
cHtml+='	margin-bottom:5px;                                                 ' + CRLF
cHtml+='	margin-left:5px;                                                   ' + CRLF
cHtml+='	margin-right:5px;                                                  ' + CRLF
cHtml+='	margin-top:5px;                                                    ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='td                                                                     ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	border: 1px #999999 solid;                                         ' + CRLF
cHtml+='	border-radius: 10px;                                               ' + CRLF
cHtml+='	text-align:center;                                                 ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='td.Cab                                                                 ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	background:#666666;                                                ' + CRLF
cHtml+='	border-radius: 10px;                                               ' + CRLF
cHtml+='	font:bold;                                                         ' + CRLF
cHtml+='	color:#FFFFFF;                                                     ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='td.tagLiberacao                                                        ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	color:#FF3300;                                                     ' + CRLF
cHtml+='	font-family:"Courier New", Courier, monospace;                     ' + CRLF
cHtml+='	font:xx-large bold italic;                                         ' + CRLF
cHtml+='	border-radius: 10px;	                                           ' + CRLF
cHtml+='	border: 0px hidden;                                                ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='table.head                                                             ' + CRLF
cHtml+='{                                                                      ' + CRLF
cHtml+='	width:900px;                                                       ' + CRLF
cHtml+='	position:relative;                                                 ' + CRLF
cHtml+='	background-color:#FFFFFF;                                          ' + CRLF
cHtml+='	                                                                   ' + CRLF
cHtml+='	border-bottom-style:inherit;                                       ' + CRLF
cHtml+='	border: 1px solid #000000;                                         ' + CRLF
cHtml+='	border-radius: 5px;	                                               ' + CRLF
cHtml+='	margin-bottom:5px;                                                 ' + CRLF
cHtml+='	margin-left:5px;                                                   ' + CRLF
cHtml+='	margin-right:5px;                                                  ' + CRLF
cHtml+='	margin-top:5px;                                                    ' + CRLF
cHtml+='}                                                                      ' + CRLF
cHtml+='                                                                       ' + CRLF
cHtml+='	</style>' + CRLF
cHtml+='<title>Pedidos liberados para faturamento</title>' + CRLF
cHtml+='</head>'  + CRLF
cHtml+='<body>' + CRLF
cHtml+='<center>' + CRLF
cHtml+='	<div>' + CRLF
cHtml+='	<hr>' + CRLF
cHtml+='	<table align="center" class="head">' + CRLF
cHtml+='		<tr>' + CRLF
cHtml+='		<td class="tagLiberacao"><img src="http://www.ncgameslatam.com/assets/static_pages/logo2.png" height="61" width="240"></td>' + CRLF
cHtml+='		<td class="tagLiberacao">Liberação de Faturamento</td>' + CRLF
cHtml+='		</tr>' + CRLF
cHtml+='	</table>' + CRLF
cHtml+='	<hr>' + CRLF
cHtml+='	</div>' + CRLF
cHtml+=itensTab + CRLF
cHtml+='	</center>' + CRLF
cHtml+='</body>' + CRLF
cHtml+='</html>' + CRLF



RestArea(aArea)
return cHtml


static function ImprimeRel(lHtml)
Local aArea := GetArea()
DEFINE DIALOG oDlgPres TITLE "Relatório de pedidos liberados" FROM 360,360 TO 1100,1400 PIXEL

oTIBrowser := TIBrowser():New(0,0,520,340, lHtml,oDlgPres )

TButton():New( 344, 204, "Imprimir", oDlgPres, {|| oTIBrowser:Print() },40,010,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE DIALOG oDlgPres CENTERED
RestArea(aArea)
Return
