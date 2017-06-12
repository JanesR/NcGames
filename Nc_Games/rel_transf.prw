#Include 'Protheus.ch'
#DEFINE CRLF Chr(13) + Chr(10)

user function rel_transf()

Local aArea := GetArea()
Local cPerg := "relTranf"

ajustaSX1()

if Pergunte(cPerg,.t.)

	geraRel(DtoS(MV_PAR01), DtoS(MV_PAR02), MV_PAR04, MV_PAR03, MV_PAR05,MV_PAR06,MV_PAR07)

EndIf
RestArea(aArea)
return


Static Function geraRel( dDataIni, dDataFim ,filtro, envioNF, EmpEnv, FilIni, FilFim)

Local aArea := GetArea()
Local cQuery01 := ""
Local aCab := {}
Local aItens :={}
Local dataIni := dDataIni
Local dataFim := dDataFim
Local cFiltro := filtro
Local cEnvio := envioNF
Local cEmpresa := EmpEnv
Local cFilIni := FilIni
Local cFilFim := FilFim

aCab := GeraCab()
aItens := GeraItens(dataIni, dataFim, cFiltro, cEnvio, cEmpresa,cFilIni, cFilFim )
gravaRel(aCab, aItens)

RestArea(aArea)
return

Static Function GeraCab()

Local aArea:=GetArea()
Local axCab :={}

aadd(axCab, {"Cliente","C",06,0})
aadd(axCab, {"Loja","C",02,0})
aadd(axCab, {"Nome Cliente","C",30,0})
aadd(axCab, {"Emp. Dest","C",02,0})
aadd(axCab, {"Fil. Dest", "C", 02,0})
aadd(axCab, {"Forn. Dest","C",06,0})
aadd(axCab, {"Nota","C",09,0})
aadd(axCab, {"Serie","C",03,0})
aadd(axCab, {"Especie","C",05,0})
aadd(axCab, {"Dt. Emisao","D",08,0})
aadd(axCab, {"Status do Envio","C",20,0})
aadd(axCab, {"Status Nota no Dest.","C",20,0})
aadd(axCab, {"Status Env. Conf. Cega","C",20,0})
aadd(axCab, {"Chave da Nota","C",60,0})
aadd(axCab, {" ","C",20,0})



RestArea(aArea)
Return axCab

Static Function GeraItens(dataIni, dataFim, filtro, envio, empresa, FilIni, FilFim)
Local aArea:= GetArea()
Local aItens:={}
Local cQuery1:=""
Local cAliasQr1:=GetNextAlias()

cQuery1:= "SELECT                                                                                                                                                          " + CRLF
cQuery1+= "    NOTAS_SAIDA.CODIGO CODCLI,                                                                                                                                  " + CRLF
cQuery1+= "    NOTAS_SAIDA.LOJA AS LJCLI,                                                                                                                                  " + CRLF
cQuery1+= "    NOTAS_SAIDA.NOME_CLIENTE AS NOMECLI,                                                                                                                        " + CRLF
cQuery1+= "    NOTAS_SAIDA.EMP_DEST AS EMPDEST,                                                                                                                            " + CRLF
cQuery1+= "    NOTAS_SAIDA.FILDEST AS FILDEST,                                                                                                                             " + CRLF
cQuery1+= "    NOTAS_SAIDA.FORNDEST AS FORNDEST,                                                                                                                           " + CRLF
cQuery1+= "    NOTAS_SAIDA.NOTA_SAIDA AS NOTA,                                                                                                                             " + CRLF
cQuery1+= "    NOTAS_SAIDA.SERIE_SAIDA AS SERIE,                                                                                                                           " + CRLF
cQuery1+= "    NOTAS_SAIDA.ESPECIE AS ESPECIE,                                                                                                                             " + CRLF
cQuery1+= "    NOTAS_SAIDA.DATAEMISSAO AS DTEMISSAO,                                                                                                                       " + CRLF
cQuery1+= "    NOTAS_SAIDA.CHAVE AS CHVNFE,                                                                                                                                " + CRLF
cQuery1+= "    (CASE                                                                                                                                                       " + CRLF
cQuery1+= "      WHEN NOTAS_ENTRADA.STATUS = 'A' THEN 'CLASSIFICADA'                                                                                                       " + CRLF
cQuery1+= "      WHEN NOTAS_ENTRADA.STATUS = ' ' THEN 'NÃO CLASSIFICADA'                                                                                                   " + CRLF
cQuery1+= "      WHEN NOTAS_ENTRADA.STATUS IS NULL THEN 'NOTA NAO ENCONTRADA'                                                                                             " + CRLF
cQuery1+= "    END                                                                                                                                                         " + CRLF
cQuery1+= "     )  AS STANF," + CRLF
cQuery1+= "     (CASE" + CRLF
cQuery1+= "     WHEN ENVNOTAS.ZAO_NFORIG IS NULL THEN 'NT' " + CRLF
cQuery1+= "     WHEN ENVNOTAS.ZAO_NFORIG IS NOT NULL THEN 'T' " + CRLF
cQuery1+= "     END" + CRLF
cQuery1+= "     ) ENVNT,                                                                                                                                              " + CRLF
cQuery1+= "     NOTAS_ENTRADA.CHVWM                                                                                                                                        " + CRLF
cQuery1+= "                                                                                                                                                                " + CRLF
cQuery1+= "FROM                                                                                                                                                            " + CRLF
cQuery1+= "(                                                                                                                                                               " + CRLF
cQuery1+= "    SELECT                                                                                                                                                      " + CRLF
cQuery1+= "          SA1.A1_COD AS CODIGO,                                                                                                                                 " + CRLF
cQuery1+= "          SA1.A1_LOJA AS LOJA,                                                                                                                                  " + CRLF
cQuery1+= "          SA1.A1_NREDUZ AS NOME_CLIENTE,                                                                                                                        " + CRLF
cQuery1+= "          SA1.A1_YEMPDES AS EMP_DEST,                                                                                                                           " + CRLF
cQuery1+= "          SA1.A1_YFILDES AS FilDest,                                                                                                                            " + CRLF
cQuery1+= "          SA1.A1_YLOJDES AS LojDest,                                                                                                                            " + CRLF
cQuery1+= "          SA1.A1_YFORDES AS FornDest,                                                                                                                           " + CRLF
cQuery1+= "          SF2.F2_DOC AS Nota_Saida,                                                                                                                             " + CRLF
cQuery1+= "          SF2.F2_SERIE AS Serie_saida,                                                                                                                          " + CRLF
cQuery1+= "          SF2.F2_ESPECIE AS Especie,                                                                                                                            " + CRLF
cQuery1+= "          SF2.F2_EMISSAO AS DATAEMISSAO,                                                                                                  " + CRLF
cQuery1+= "          SF2.F2_CHVNFE AS Chave                                                                                                                                " + CRLF
cQuery1+= "          FROM SF2010 SF2 RIGHT JOIN SA1010 SA1                                                                                                                 " + CRLF
cQuery1+= "    ON (SF2.F2_CLIENTE = SA1.A1_COD AND SF2.F2_LOJA = SA1.A1_LOJA)                                                                                              " + CRLF
cQuery1+= "                                                                                                                                                                " + CRLF
cQuery1+= "    WHERE SA1.A1_FILIAL = ' '                                                                                                                                   " + CRLF
cQuery1+= "    AND SF2.F2_FILIAL = '03'                                                                                                                                    " + CRLF
cQuery1+= "                                                                                                                                                                " + CRLF
cQuery1+= "    AND SA1.D_E_L_E_T_ = ' '                                                                                                                                    " + CRLF
cQuery1+= "    AND SF2.D_E_L_E_T_ = ' '         

If (empresa == 1)
	cQuery1+= "    AND A1_YEMPDES IN( '03')                                                                                                                               " + CRLF
ElseIf (empresa == 2)
	cQuery1+= "    AND A1_YEMPDES IN( '40')                                                                                                                               " + CRLF
Else
	cQuery1+= "    AND A1_YEMPDES IN( '03','40')                                                                                                                               " + CRLF
EndIF

cQuery1+= "    AND SA1.A1_YFILDES BETWEEN '"+FilIni+"' AND '"+FilFim+"'                                                                                                                            " + CRLF

cQuery1+= "    AND SF2.F2_EMISSAO BETWEEN '"+dataIni+"' AND '"+dataFim+"'                                                                                                        " + CRLF
cQuery1+= ") NOTAS_SAIDA                                                                                                                                                   " + CRLF
cQuery1+= "LEFT JOIN                                                                                                                                                       " + CRLF
cQuery1+= "(                                                                                                                                                               " + CRLF

IF( empresa == 1 .OR. empresa == 3)
	cQuery1+= "    select '03' AS EMPRESA, SF1.F1_FILIAL FILIAL, SF1.F1_DOC NOTA_Entrada, SF1.F1_SERIE SERIE_Entrada, SF1.F1_FORNECE Fornecedor_Entrada, SF1.F1_STATUS STATUS, " + CRLF
	cQuery1+= "    F1_DOC||F1_SERIE||F1_FORNECE||F1_LOJA||F1_TIPO CHVWM                                                                                                        " + CRLF
	cQuery1+= "    from sf1030 sF1                                                                                                                                             " + CRLF
	cQuery1+= "    WHERE                                                                                                                                                       " + CRLF
	cQuery1+= "    sF1.D_E_L_E_T_ = ' '                                                                                                                                        " + CRLF
	cQuery1+= "    and sf1.f1_TIPO = 'N'                                                                                                                                       " + CRLF
	cQuery1+= "    AND sF1.F1_ESPECIE = 'SPED'                                                                                                                                 " + CRLF
	cQuery1+= "    and sf1.f1_filial BETWEEN '"+FilIni+"' AND '"+FilFim+"'	"+ CRLF
	
	If filtro = 1
		cQuery1+= "    AND SF1.F1_STATUS = 'A'                                                                                                                                     " + CRLF
	elseIF filtro = 2
		cQuery1+= "    AND SF1.F1_STATUS = ' '                                                                                                                                     " + CRLF
	elseIF filtro= 3 
		cQuery1+= "    AND SF1.F1_STATUS in( 'A',' ')                                                                                                                                     " + CRLF
	endIf
	
EndIf

If(empresa == 3)
	cQuery1+= "    union all                                                                                                                                                   " + CRLF
EndIF

If(empresa == 2 .or. empresa == 3)
	cQuery1+= "    select '40' AS EMPRESA, SF1.F1_FILIAL FILIAL, SF1.F1_DOC NOTA_Entrada, SF1.F1_SERIE SERIE_Entrada, SF1.F1_FORNECE Fornecedor_Entrada, SF1.F1_STATUS STATUS, " + CRLF
	cQuery1+= "    F1_DOC||F1_SERIE||F1_FORNECE||F1_LOJA||F1_TIPO CHVWM                                                                                                        " + CRLF
	cQuery1+= "    from sf1400 sF1                                                                                                                                             " + CRLF
	cQuery1+= "                                                                                                                                                                " + CRLF
	cQuery1+= "    WHERE sF1.D_E_L_E_T_ = ' '                                                                                                                                  " + CRLF
	cQuery1+= "    and sf1.f1_TIPO = 'N'  " 																																+ CRLF
	cQuery1+= "    AND sF1.F1_ESPECIE = 'SPED'                                                                                                                                 " + CRLF
	cQuery1+= "    and sf1.f1_filial BETWEEN '"+FilIni+"' AND '"+FilFim+"'	"+ CRLF                                                                                                           
	
	If filtro = 1
		cQuery1+= "    AND SF1.F1_STATUS = 'A'                                                                                                                                     " + CRLF
	elseIF filtro = 2
		cQuery1+= "    AND SF1.F1_STATUS = ' '                                                                                                                                     " + CRLF
	elseIF filtro= 3 
		cQuery1+= "    AND SF1.F1_STATUS in( 'A',' ')                                                                                                                                     " + CRLF
	endIf  

	cQuery1+= "    AND sF1.F1_ESPECIE = 'SPED'                                                                                                                                 " + CRLF
EndIf

cQuery1+= ") NOTAS_ENTRADA                                                                                                                                                 " + CRLF
cQuery1+= "                                                                                                                                                                " + CRLF
cQuery1+= "ON                                                                                                                                                              " + CRLF
cQuery1+= "                                                                                                                                                                " + CRLF
cQuery1+= "    NOTAS_SAIDA.EMP_DEST = NOTAS_ENTRADA.EMPRESA                                                                                                                " + CRLF
cQuery1+= "AND NOTAS_SAIDA.FilDest = NOTAS_ENTRADA.FILIAL                                                                                                                  " + CRLF
cQuery1+= "AND NOTAS_SAIDA.Nota_SAIDA = NOTAS_ENTRADA.NOTA_ENTRADA                                                                                                         " + CRLF
cQuery1+= "AND NOTAS_SAIDA.Serie_SAIDA = NOTAS_ENTRADA.SERIE_Entrada                                                                                                       " + CRLF
cQuery1+= "" + CRLF
cQuery1+= "LEFT JOIN" + CRLF
cQuery1+= "(" + CRLF
cQuery1+= "SELECT ZAO_NFORIG," + CRLF
cQuery1+= "ZAO_SERORI," + CRLF
cQuery1+= "ZAO_CLIORI," + CRLF
cQuery1+= "ZAO_EMPDES," + CRLF
cQuery1+= "ZAO_FILDES" + CRLF
cQuery1+= "FROM ZAO010 WHERE" + CRLF
cQuery1+= "ZAO_FILIAL = '03'" + CRLF
cQuery1+= "AND D_E_L_E_T_ = ' '" + CRLF
cQuery1+= "AND ZAO_EMNFOR BETWEEN '"+dataIni+"' AND '"+dataFim+"'" + CRLF
cQuery1+= "AND ZAO_ERRO = 'N'" + CRLF
cQuery1+= ")" + CRLF
cQuery1+= "ENVNOTAS" + CRLF
cQuery1+= "" + CRLF
cQuery1+= "on" + CRLF 
cQuery1+= "" + CRLF
cQuery1+= "NOTAS_SAIDA.NOTA_SAIDA = ENVNOTAS.ZAO_NFORIG" + CRLF
cQuery1+= "AND NOTAS_SAIDA.Serie_saida = ENVNOTAS.ZAO_SERORI" + CRLF
cQuery1+= "and NOTAS_SAIDA.CODIGO = ENVNOTAS.ZAO_CLIORI" + CRLF
cQuery1+= "Order By Emp_Dest, FILDEST, DATAEMISSAO                                                                                                                         " + CRLF



MsgRun( "Coletando os dados......","Coleta de Dados",{|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),cAliasQr1,.T.,.T.)} )

Do While(cAliasQr1)->(!Eof())
	IF( envio == 3 )
		AADD(aItens,{;    
				(cAliasQr1)->CODCLI,;
				(cAliasQr1)->LJCLI	,;
				(cAliasQr1)->NOMECLI	,;
				(cAliasQr1)->EMPDEST	,;
				" "+(cAliasQr1)->FILDEST + " "	,;
				(cAliasQr1)->FORNDEST	,;
				(cAliasQr1)->NOTA	,;
				(cAliasQr1)->SERIE	,;
				(cAliasQr1)->ESPECIE	,;
				StoD((cAliasQr1)->DTEMISSAO)	,;
				IIF((cAliasQr1)->ENVNT == 'T', "Enviada para o Destino", "Nao enviado para o destino"),;
				(cAliasQr1)->STANF	,;
				consWM((cAliasQr1)->CHVWM),;
				'"'+(cAliasQr1)->CHVNFE+'"',;
				""})
				
		DbSkip()
	ElseIF( envio == 2 .And. alltrim((cAliasQr1)->ENVNT) == 'NT')
		AADD(aItens,{;    
				(cAliasQr1)->CODCLI,;
				(cAliasQr1)->LJCLI	,;
				(cAliasQr1)->NOMECLI	,;
				(cAliasQr1)->EMPDEST	,;
				" "+(cAliasQr1)->FILDEST + " "	,;
				(cAliasQr1)->FORNDEST	,;
				(cAliasQr1)->NOTA	,;
				(cAliasQr1)->SERIE	,;
				(cAliasQr1)->ESPECIE	,;
				StoD((cAliasQr1)->DTEMISSAO)	,;
				"Nao enviado para o destino",;
				(cAliasQr1)->STANF	,;
				consWM((cAliasQr1)->CHVWM),;
				'"'+(cAliasQr1)->CHVNFE+'"',;
				""})
				
		DbSkip()
	ElseIF( envio == 1 .And. alltrim((cAliasQr1)->ENVNT) == 'T')
			AADD(aItens,{;    
				(cAliasQr1)->CODCLI,;
				(cAliasQr1)->LJCLI	,;
				(cAliasQr1)->NOMECLI	,;
				(cAliasQr1)->EMPDEST	,;
				" "+(cAliasQr1)->FILDEST + " "	,;
				(cAliasQr1)->FORNDEST	,;
				(cAliasQr1)->NOTA	,;
				(cAliasQr1)->SERIE	,;
				(cAliasQr1)->ESPECIE	,;
				StoD((cAliasQr1)->DTEMISSAO)	,;
				"Enviado para o destino",;
				(cAliasQr1)->STANF	,;
				consWM((cAliasQr1)->CHVWM),;
				'"'+(cAliasQr1)->CHVNFE+'"',;
				""})			
		DbSkip()
	Else    
		DbSkip()
	EndIF

EndDo	
DbCloseArea(cAliasQr1)

RestArea(aArea)
Return aItens

Static Function gravaRel(aCab, aItens)

If !EMPTY(aItens)
	MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCab,aItens}})})
Else
	Alert("Nenhum dado encontrado!")
EndIf

return

Static Function consWM(chave)

Local nCodConf :=0
Local Status := ""
Local cQuery := ""
Local cMensagem:=""

cQuery:=" Select Cod_conferencia From "+U_NCGetBWM("Conferencia_cega")
cQuery+=" Where Cod_referencia='"+chave+"'"
cAliasQry:=U_NCIWMF02(cQuery,"1",cMensagem)

	If Select(cAliasQry)>0
		nCodConf:=(cAliasQry)->Cod_conferencia
		(cAliasQry)->(DbCloseArea())
	EndIf
	
	
	If nCodConf>0
		status :="Enviada para conferencia Cega"
		Return status
	Else 
		status :="Não Enviada para conferencia Cega"
		Return status
	EndIf

Return



Static Function ajustaSX1()
Local aArea := GetArea()
Local aHelpP	:= {}

Aadd( aHelpP, "Dt Emissao de ? " )
PutSx1("relTranf","01","Dt Emissao de?     "  ,"Dt Emissao de ?     ","Dt Emissao de?     ","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

Aadd( aHelpP, "Dt Emissao ate ? " )
PutSx1("relTranf","02","Dt Emissao ate?     "  ,"Dt Emissao ate ?     ","Dt Emissao ate?     ","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

Aadd( aHelpP, "Status Envio:" )
PutSx1("relTranf","03","Status Envio?    "  ,"Status Envio?     ","Status Envio?     ","mv_ch3","N",30,0,0,"C","","","","","mv_par03","Env. p/ o Destino","Env. p/ o Dest.","Env. p/ o Dest.","Nao Env.p/ o Dest.","Nao Env.p/ o Dest.","Nao Env.p/ o Dest.","Ambas","Ambas","Ambas","","","","","","","","",aHelpP)
aHelpP	:= {}


Aadd( aHelpP, "Status da Nota no Destino:" )
PutSx1("relTranf","04","Status no Destino?"  ,"Status no Destino?","Status no Destino?","mv_ch4","N",30,0,0,"C","","","","","mv_par04","Classificadas","Classificadas","Classificadas","Nao Classificadas","Não Classificadas","Não Classificadas","Ambas","Ambas","Ambas","","","","","","","","",aHelpP)
aHelpP	:= {}


Aadd( aHelpP, "Empresa Destino?" )
PutSx1("relTranf","05","Empresa Destino?    "  ,"Empresa Destino?     ","Empresa Destino?     ","mv_ch5","C",02,0,0,"C","","","","","mv_par05","Store","Store","Store","Proximo","Proximo","Proximo","Ambas","Ambas","Ambas","","","","","","","","",aHelpP)
aHelpP	:= {}
                    

Aadd( aHelpP, "Filial de:?" )
PutSx1("relTranf","06","Filial de?    "  ,"Filial de?     ","Filial de?     ","mv_ch6","C",02,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}
  

Aadd( aHelpP, "Filial ate:?" )
PutSx1("relTranf","07","Filial até?    "  ,"Filial ate?     ","Filial ate?     ","mv_ch7","C",02,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}


RestArea(aArea)
Return

