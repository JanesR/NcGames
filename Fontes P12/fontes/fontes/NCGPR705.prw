#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#Define Enter Chr(13)+Chr(10)

Static lTipoVPC:=.T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  01/16/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705Aviso(aDados)
Local cQuery
Local nDiasAviso
Local cMailDest
Local cAlias
Local cBody
Local nDias
Local cMensagem

Default aDados:={"01","03"}

RpcClearEnv()
RpcSetEnv(aDados[1],aDados[2] )

cAlias		:= GetNextAlias()
nDiasAviso	:=U_MyNewSX6("NCG_PR705A",5,"N","Numero de dias do vencimento do contrato","Numero de dias do vencimento do contrato","Numero de dias do vencimento do contrato",.F. )
cMailDest	:=Alltrim(U_MyNewSX6("NCG_PR705E","lfelipe@ncgames.com.br","C","E-mail do responsavel pelos contratos VPC","E-mail do responsavel pelos contratos VPC","E-mail do responsavel pelos contratos VPC",.F. ))

cQuery:=" Select ZZ7.R_E_C_N_O_ RecZZ7 "+CRLF
cQuery+=" From "+RetSqlName("ZZ7")+" ZZ7 "+CRLF
cQuery+=" Where ZZ7.ZZ7_FILIAL='"+xFilial("ZZ7")+"'"+CRLF
cQuery+=" And ZZ7.ZZ7_DTVFIM<='"+Dtos(dDataBase+nDiasAviso)+"'"+CRLF
cQuery+=" And ZZ7.ZZ7_FLAG='1'"+CRLF
cQuery+=" And ZZ7.ZZ7_STATUS='3'"+CRLF
cQuery+=" And ZZ7.ZZ7_DTALTE=' ' "+CRLF   
cQuery+=" And ZZ7.D_E_L_E_T_=' '"+CRLF
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)

Do While (cAlias)->(!Eof())
	
	ZZ7->(DbGoTo((cAlias)->RecZZ7))
	cBody:='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
	cBody+='<html xmlns="http://www.w3.org/1999/xhtml">'
	cBody+='<head>'
	cBody+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'
	cBody+='<title>Workflow Protheus Nc Games </title>'
	
	cBody+='</head>'
	
	cBody+='<!-- CONTEUDO DA PAGINA -->'
	cBody+='<body 	style="'
	cBody+='		margin: 0px; '
	cBody+='		padding: 0px; " >'
	cBody+='<!-- ABERTURA DA DIV PRINCIPAL --> '
	cBody+='<div id="principal" style="	'
	cBody+='					width: 90%;'
	cBody+='					padding: 15px;'
	cBody+='					margin-right: auto;'
	cBody+='					margin-left: auto;'
	cBody+='					margin-top: 20px;'
	cBody+='					margin-bottom: 20px;'
	cBody+='					background-color: #FFF; " >'
	cBody+='  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">'
	cBody+='    <tr>'
	cBody+='      <td height="39" valign="middle" style="font-family: Trebuchet MS, Arial, Helvetica, sans-serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >Protheus '
	cBody+='		NC GAMES </td>'
	cBody+='    </tr>'
	cBody+='  </table>'
	cBody+='  <hr />'
	cBody+='<form name="form1" method="post" action="mailto:%WFMailTo%">'
	cBody+='  <p>&nbsp;</p>'
	cBody+='  <table width="95%" border="0" align="center" cellpadding="5" cellspacing="5" id="tbinternoeexterno">'
	cBody+='    <tr>'
	cBody+='      <td><span style=" font-family: Verdana, Geneva, sans-serif; '
	cBody+='         		font-size: 11px; '
	cBody+='                color: #000; " >'+""+'</span> <span style="'
	cBody+='        		font-family: Arial, Helvetica, sans-serif;'
	cBody+='				font-size: 13px;'
	cBody+='				color: #039;'
	cBody+='				font-weight: bold; ">'+""+'</span></td>'
	cBody+='    </tr>'
	cBody+='    <tr>'
	cBody+='      <td><p>'
	cBody+='		<span style="font-family: Verdana, Geneva, sans-serif; font-size: 11px">'
	
	cMensagem:=" vencerแ em "
	If (nDias:= (ZZ7->ZZ7_DTVFIM-dDataBase) )<0
		cMensagem:=" vencido a "
	EndIf
	
	cMensagem+=AllTrim( Str(nDias)	)+" dias."
	
	cBody+='		Contrato VPC&nbsp; '+ZZ7->( ZZ7_CODIGO+"/"+ZZ7_VERSAO+"-"+ZZ7_DESC)+"-Vig๊ncia "+Dtoc(ZZ7->ZZ7_DTVINI)+" "+Dtoc(ZZ7->ZZ7_DTVFIM)+cMensagem+' </span></p></td>'
	cBody+='    </tr>'
	cBody+='  </table>'
	cBody+='<p>&nbsp;</p>'
	cBody+='</form>'
	cBody+='<table width="100%" border="0" id="tbrodape">'
	cBody+='  <tr>'
	cBody+='    <td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif; '
	cBody+='         		font-size: 11px; '
	cBody+='                color: #000; "> WORKFLOW PROTHEUS</td>'
	cBody+='  </tr>'
	cBody+='</table>'
	cBody+='</div>'
	cBody+='</body>'
	cBody+='</html>'
	
	MySndMail("Vencimento VPC", cBody, , cMailDest, )
	
	(cAlias)->(DbSkip())
	
EndDo


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  12/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705VERBA()
U_NCGPR705("VERBA")
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  18/07/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR705(cParam)
Local cFiltro	:=	"ZZ7_DTALTE=' ' "
Local aCores	:={}

Private cCadastro := "VPC Contratos"
Private aRotina
Default cParam:="VPC"

lTipoVPC:=(cParam=="VPC")
aRotina   := MenuDef(cParam)

If cParam=="VPC"
	cCadastro := "VPC Contratos"
	cFiltro	  +="And ZZ7_FLAG='1'"
Else
	cCadastro := "Verba Extra"
	cFiltro	  +="And ZZ7_FLAG='2'"
EndIf

AADD(aCores,{"ZZ7_STATUS='1'" , 'BR_BRANCO'   })
AADD(aCores,{"ZZ7_STATUS='2'" , 'BR_AMARELO'   })
AADD(aCores,{"ZZ7_STATUS='3'" , 'BR_VERDE'   })
AADD(aCores,{"ZZ7_STATUS='4'" , 'BR_PRETO'   })
AADD(aCores,{"ZZ7_STATUS='5'" , 'BR_VERMELHO'   })


mBrowse(,,,,"ZZ7",,,,,,aCores,,,,,,,,cFiltro)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/18/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MenuDef()
Local aRotina:={ }

AADD(aRotina,{"Pesquisar"			,"AxPesqui"	   ,0,1})
AADD(aRotina,{"Visualizar"			,"U_R705Manut" ,0,2})
AADD(aRotina,{"Incluir"				,"U_R705Manut" ,0,3})
AADD(aRotina,{"Alterar"				,"U_R705Manut" ,0,4})
AADD(aRotina,{"Excluir"				,"U_R705Manut" ,0,5})
AADD(aRotina,{"Anexar Documentos"	,"MsDocument"  ,0,2})
AADD(aRotina,{"Encerrar "+IIf(lTipoVPC,"Contrato","Verba Extra")	,"U_R705Encer" ,0,2})
AADD(aRotina,{"Enviar Aprova็ใo"	,"U_R705Send"  ,0,2})
AADD(aRotina,{"Legenda"         	,"U_R705Legend"  ,0,2})

Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/18/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705Manut(cAlias,nReg,nOpc,cOpcao,bAprovar,bReprovar,bSair)
Local cPerg		:= Padr("R705MANUT",Len(SX1->X1_GRUPO))
Local lGravar	:= .F.
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:= {|| Iif(Obrigatorio(aGets,aTela) .And. U_R705TOK(nOpc,aHeadItens,oGetItens:aCols,aHeadClasse,oGetClasse:aCols,aHeadNoProduto,oGetNoProduto:aCols,aHeadZZA,oGetZZA:aCols,aHeadZZBP,oGetZZBP:aCols,aHeadZZBV,oGetZZBV:aCols),(lGravar:=.T.,oDlgPR705:End()),) }
Local bCancel	:= {|| lGravar:=.F.,oDlgPR705:End() }
Local aStatus	:= RetSx3Box( Posicione("SX3", 2, "ZZ7_STATUS","X3CBox()" ),,,1)
Local aButtons	:= {}
Local aCombo	:= RetSx3Box( Posicione("SX3", 2, "ZZ7_STATUS","X3CBox()" ),,,1)
Local nOpcy		:= IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0   )
Local aCpoZZ8

Local cSeekKey	:=xFilial("ZZ7")+ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO)
Local bSeekWhile := {|| ZZ7_FILIAL+ZZ7_CODIGO+ZZ7_VERSAO}
Local uSeekFor	:={}

Default cOpcao:=""
Default bAprovar	:={||  }
Default bReprovar	:={||  }
Default bSair		:={||  }

Private aFolders
Private oDlgPR705

Private oGetItens
Private aHeadItens:={}
Private aColsItens:={}

Private oGetNoProduto
Private aHeadNoProduto:={}
Private aColsNoProduto:={}


Private oGetClasse
Private aHeadClasse:={}
Private aColsClasse:={}

Private oFolder
Private oEnchoice

Private oGetZZA
Private aHeadZZA:={}
Private aColsZZA:={}

Private oGetZZBP
Private aHeadZZBP:={}
Private aColsZZBP:={}


Private oGetZZBV
Private aHeadZZBV:={}
Private aColsZZBV:={}


Private aTELA[0][0],aGETS[0]

Private aCols	:={}
Private aHeader:={}


If ALTERA .And. !ZZ7->ZZ7_STATUS$"1" //1=Em Negociacao;2=Em Aprovacao;3=Aprovado;4=Reprovado;5=Encerrado
	If ZZ7->ZZ7_STATUS=="2"
		MsgStop(Iif(lTipoVPC,"Contrato","Verba Extra ")+AllTrim(aCombo[Ascan(aCombo,{|a| a[2]=="2"} ),3])+" (Aguardando aprova็ใo "+U_PR705LstAprov(ZZ7->ZZ7_CODIGO,ZZ7->ZZ7_VERSAO)+")" )
		Return
	ElseIf ZZ7->ZZ7_STATUS=="3"
		If !MsgYesNo( Iif(lTipoVPC,"Contrato","Verba Extra ")+AllTrim(aCombo[Ascan(aCombo,{|a| a[2]=="3"} ),3])+",em caso de altera็ใo serแ necessแrio uma nova aprova็ใo.Deseja continuar?")
			Return
		EndIf
	Else
		MsgStop("Status "+Iif(lTipoVPC,"do Contrato"," da Verba Extra")+" igual "+AllTrim(aCombo[Ascan(aCombo,{|a| a[2]==ZZ7->ZZ7_STATUS} ),3])+" nใo pode ser alterado")
		Return
	EndIf
	
EndIf

aFolders:={OemToAnsi('Classe Produtos'),OemToAnsi(IIf(lTipoVPC,'VPC','Verba Extra')),OemToAnsi('Exce็ใo Produtos'),OemToAnsi('Contrato Crescimento')}

RegToMemory("ZZ7",nOpc==3)
If lTipoVPC
	M->ZZ7_FLAG:="1"
	aCpoCab:={"ZZ7_CODIGO","ZZ7_VERSAO","ZZ7_GRPCLI","ZZ7_CLIENT","ZZ7_LOJA","ZZ7_DTVINI","ZZ7_DTVFIM","ZZ7_RENOVA","ZZ7_STATUS","ZZ7_TPERLI","ZZ7_TPERBR","ZZ7_DESGRU","ZZ7_DESCLI","ZZ7_DESC"}
	
Else
	M->ZZ7_FLAG:="2"
	If INCLUI
		PutSx1(cPerg,"01","Tipo Verba","Tipo Verba","Tipo Verba","mv_ch1","N",01,0,1,"C","","","","","mv_par01","NCC Periodica","NCC Periodica","NCC Periodica","","Pedido Venda","Pedido Venda","Pedido Venda","","","","","","","","","",{},{},{})
		If !Pergunte(cPerg)
			Return
		EndIf
		M->ZZ7_TPVERB:=StrZero(mv_par01,1)
	EndIf
	
	If M->ZZ7_TPVERB=='2'
		aCpoCab:={"ZZ7_CODIGO","ZZ7_VERSAO","ZZ7_PEDIDO","ZZ7_TPVERB","ZZ7_CLIENT","ZZ7_LOJA","ZZ7_DESCLI","ZZ7_DESC"}
		aCpoZZ8:={"ZZ8_TIPO","ZZ8_DESCTI","ZZ8_REPASS","ZZ8_PERCEN","ZZ8_VLRVEB","ZZ8_TPFAT"}
	Else
		aCpoCab:={"ZZ7_CODIGO","ZZ7_VERSAO","ZZ7_TPVERB","ZZ7_CLIENT","ZZ7_LOJA","ZZ7_DESCLI","ZZ7_DTVINI","ZZ7_DTVFIM","ZZ7_VLRMET","ZZ7_GRPCLI","ZZ7_DESGRU","ZZ7_DESC"}
	EndIf
EndIf

AADD(aCpoCab,"NOUSER")

//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet

//Itens
bSeekWhile := {|| ZZ8_FILIAL+ZZ8_CODIGO+ZZ8_VERSAO}
ZZ8->(FillGetDados ( nOpc, "ZZ8",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, aCpoZZ8, .T., /*[ cQuery]*/, /*bMontCols*/, nOpc==3, aHeadItens, aColsItens,/*bAfterCols*/, /*bBeforeCols*/, /*bAfterHeader*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., aCpoZZ8 ))


// Exce็ใo Produto
bSeekWhile := {|| ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG}
ZZ9->(FillGetDados ( nOpc, "ZZ9",1, cSeekKey+"2", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZ9_PRODUT","ZZ9_DESPRO"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadNoProduto, aColsNoProduto, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZ9_PRODUT","ZZ9_DESPRO"} ))

//Classe do Produto
bSeekWhile := {|| ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG}
ZZ9->(FillGetDados ( nOpc, "ZZ9",1, cSeekKey+"3", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZ9_CLASSE","ZZ9_DESCLA"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadClasse, aColsClasse, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZ9_CLASSE","ZZ9_DESCLA"} ))


//Contrato de Crescimento
bSeekWhile := {|| ZZA_FILIAL+ZZA_CODIGO+ZZA_VERSAO}
ZZA->(FillGetDados ( nOpc, "ZZA",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadZZA, aColsZZA, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., /*{}*/ ))

//Contrato de Crescimento Percentual
bSeekWhile := {|| ZZB_FILIAL+ZZB_CODIGO+ZZB_VERSAO}
ZZB->(FillGetDados ( nOpc, "ZZB",1, cSeekKey, bSeekWhile,{|| ZZB_PERINI>0 .Or. ZZB_PERFIM>0 } , /*aNoFields*/,  {"ZZB_PERINI","ZZB_PERFIM","ZZB_PERCEN","ZZB_VALOR"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadZZBP, aColsZZBP, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZB_PERINI","ZZB_PERFIM","ZZB_PERCEN","ZZB_VALOR"}))

//Contrato de Crescimento Valor
bSeekWhile := {|| ZZB_FILIAL+ZZB_CODIGO+ZZB_VERSAO}
ZZB->(FillGetDados ( nOpc, "ZZB",1, cSeekKey, bSeekWhile,  {|| ZZB_VLRINI>0 .Or. ZZB_VLRFIM>0 }, /*aNoFields*/,  {"ZZB_VLRINI","ZZB_VLRFIM","ZZB_PERCEN","ZZB_VALOR"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadZZBV, aColsZZBV, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZB_VLRINI","ZZB_VLRFIM","ZZB_PERCEN","ZZB_VALOR"}))


aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,   100, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )


aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCalcula o Size para os Foldersณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlgPR705 TITLE OemtoAnsi(IIf(lTipoVPC,"Cadastro de VPC - Contratos","Verba Extra")) From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

oEnchoice:=MsMGet():New( "ZZ7", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlgPR705, .F. , .T. , .F. , , .T. , .F. )

oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','',''},oDlgPR705,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4

If cOpcao$"A*V"
	nGd3 :=aPosObj[2,3]
	If cOpcao=="A"
		oButton1	:= tButton():New(nGd3, nGd4-115, "Aprovar"  , oDlgPR705, bAprovar  , 0040, 0015, , , , .T.)
		oButton2	:= tButton():New(nGd3, nGd4-075 , "Reprovar" , oDlgPR705, bReprovar , 0040, 0015, , , , .T.)
	EndIf
	oButton3	:= tButton():New(nGd3, nGd4-035 , "Sair"   , oDlgPR705, bSair, 0040, 0015, , , , .T.)
EndIf


//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto

oGetClasse    := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,'U_R705ValLine("ZZ9_CLASSE",oGetClasse:nAt,oGetClasse:aHeader,oGetClasse:aCols)' ,"U_R705ZZ8(oGetItens:aHeader,oGetItens:aCols)",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"U_R705DELOK()" ,oFolder:aDialogs[1],aHeadClasse,aColsClasse)
oGetItens     := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,'U_R705ValLine("ZZ8",oGetItens:nAt,oGetItens:aHeader,oGetItens:aCols)'           ,"U_R705ZZ8(oGetItens:aHeader,oGetItens:aCols)",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"U_R705DELOK()" ,oFolder:aDialogs[2],aHeadItens,aColsItens)
oGetNoProduto := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,'U_R705ValLine("ZZ9",oGetNoProduto:nAt,oGetNoProduto:aHeader,oGetNoProduto:aCols)',"AllwaysTrue()"                   ,/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[3],aHeadNoProduto,aColsNoProduto)

oGetZZA     := MsNewGetDados():New(nGd1,nGd2,nGd3/2,nGd4,nOpcy     ,'U_R705ValLine("ZZA",oGetZZA:nAt,oGetZZA:aHeader,oGetZZA:aCols)',"AllwaysTrue()",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"AllwaysTrue()" ,oFolder:aDialogs[4],aHeadZZA,aColsZZA)


oFolderZZB := TFolder():New(nGd3*0.50,nGd2,{"Escala %","Escala R$"},{'','',''},oFolder:aDialogs[4],,,,.T.,.F.,nGd4,nGd3)
oGetZZBP    := MsNewGetDados():New(nGd1,nGd2,nGd3*0.95,nGd4,nOpcy,'U_R705ValLine("ZZBP",oGetZZBP:nAt,oGetZZBP:aHeader,oGetZZBP:aCols)',"AllwaysTrue()",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"AllwaysTrue()" ,oFolderZZB:aDialogs[1],aHeadZZBP,aColsZZBP)
oGetZZBV    := MsNewGetDados():New(nGd1,nGd2,nGd3*0.95,nGd4,nOpcy,'U_R705ValLine("ZZBV",oGetZZBV:nAt,oGetZZBV:aHeader,oGetZZBV:aCols)',"AllwaysTrue()",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,"AllwaysTrue()" ,oFolderZZB:aDialogs[2],aHeadZZBV,aColsZZBV)

If !lTipoVPC
	If (nPosCpo:=GdFieldPos(" ZZ8_REPASS",oGetItens:aHeader))>0
		oGetItens:aHeader[nPosCpo][12]:=M->ZZ7_TPVERB
	EndIf
	If INCLUI
		GDFieldPut ( "ZZ8_REPASS",M->ZZ7_TPVERB, oGetItens:nAt, oGetItens:aHeader, oGetItens:aCols)
	EndIf
	
	If M->ZZ7_TPVERB=="2"
		oFolder:aDialogs[1]:lActive	:=.F.
		oFolder:aDialogs[3]:lActive	:=.F.
	EndIf
	
	oFolder:aDialogs[4]:lActive	:=.F.
EndIf


ACTIVATE MSDIALOG oDlgPR705 ON INIT IIf(Empty(cOpcao),EnchoiceBar(oDlgPR705,bOk,bCancel,,aButtons),)

If cOpcao=="A*V#"
	//
Else
	If nOpc<>2 .And. lGravar
		Begin Transaction
		If lTipoVPC
			Processa( {|| R705Grv(nOpc,aHeadItens,oGetItens:aCols,aHeadClasse,oGetClasse:aCols,aHeadNoProduto,oGetNoProduto:aCols,aHeadZZA,oGetZZA:aCols,aHeadZZBP,oGetZZBP:aCols,aHeadZZBV,oGetZZBV:aCols) } )
		Else
			Processa( {|| R705Grv(nOpc,aHeadItens,oGetItens:aCols,aHeadClasse,oGetClasse:aCols,aHeadNoProduto,oGetNoProduto:aCols) } )
		EndIf
		
		End Transaction
	ElseIf __lSX8
		RollBackSX8()
	EndIf
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  11/17/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705Gat()



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/23/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R705Grv(nOpc,aHeadItens,aColsItens,aHeadClasse,aColsClasse,aHeadNoProduto,aColsNoProduto,aHeaderZZA,aColsZZA,aHeadZZBP,aColsZZBP,aHeadZZBV,aColsZZBV)
Local cFilZZ7		:=xFilial("ZZ7")
Local cFilZZ8		:=xFilial("ZZ8")
Local cFilZZ9		:=xFilial("ZZ9")
Local cFilZZA		:=xFilial("ZZA")
Local cFilZZB		:=xFilial("ZZB")
Local cChave		:=M->(ZZ7_CODIGO+ZZ7_VERSAO)
Local nInd
Local aStatus	:=RetSx3Box( Posicione("SX3", 2, "ZZ7_STATUS","X3CBox()" ),,,1)
Local bCampo 	:= {|nCPO| Field(nCPO) }

Default aHeaderZZA	:={}
Default aColsZZA  	:={}
Default aHeadZZBP	:={}
Default aColsZZBP	:={}

Default aHeadZZBV	:={}
Default aColsZZBV	:={}


If nOpc==5 // Exclusao
	
	If M->ZZ7_STATUS=="1"//Em negocia็ใo
		ZZ7->(RecLock("ZZ7",.F.))
		ZZ7->(DbDelete())
		ZZ7->(MsUnLock())
		
		ZZ8->(DbSetOrder(1))//ZZ8_FILIAL+ZZ8_CODIGO+ZZ8_VERSAO
		ZZ8->(DbSeek(cChave))
		ZZ8->( DbEval( {|| RecLock("ZZ8",.F.),DbDelete(),MsUnLock()  },{|| ZZ8_FILIAL+ZZ8_CODIGO+ZZ8_VERSAO==cFilZZ8+cChave  },{|| .T. }  )    )
		
		ZZ9->(DbSetOrder(1))//ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO+ZZ9_FLAG
		ZZ9->(DbSeek(cChave))
		ZZ9->( DbEval( {|| RecLock("ZZ9",.F.),DbDelete(),MsUnLock()  },{|| ZZ9_FILIAL+ZZ9_CODIGO+ZZ9_VERSAO==cFilZZ9+cChave  },{|| .T. }  )    )
		
		ZZA->(DbSetOrder(1))//ZZA_FILIAL+ZZA_CODIGO+ZZA_VERSAO
		ZZA->(DbSeek(cChave))
		ZZA->( DbEval( {|| RecLock("ZZA",.F.),DbDelete(),MsUnLock()  },{|| ZZA_FILIAL+ZZA_CODIGO+ZZA_VERSAO==cFilZZA+cChave  },{|| .T. }  )    )
		
		ZZB->(DbSetOrder(1))//ZZA_FILIAL+ZZA_CODIGO+ZZA_VERSAO
		ZZB->(DbSeek(cChave))
		ZZB->( DbEval( {|| RecLock("ZZB",.F.),DbDelete(),MsUnLock()  },{|| ZZB_FILIAL+ZZB_CODIGO+ZZB_VERSAO==cFilZZA+cChave  },{|| .T. }  )    )
	Else
		MsgInfo(IIf(lTipoVPC,"Contrato","Verba Extra")+aStatus[Ascan(aStatus,{|a| a[2]==ZZ7->ZZ7_STATUS} ),3]+" exclusใo nใo permitida.")
	EndIf
	
Else
	cNextVersao:=M->ZZ7_VERSAO
	
	If nOpc==4//Alterar
		ZZ7->(RecLock("ZZ7",.F.))
		ZZ7->ZZ7_DTALTE:=MsDate()
		ZZ7->(MsUnLock())
		cNextVersao:=Soma1(cNextVersa)
	EndIf
	
	ZZ7->(RecLock("ZZ7",.T.))
	For nY := 1 TO ZZ7->(FCount())
		If ("FILIAL" $ ZZ7->(FieldName(nY)) )
			ZZ7->(FieldPut(nY,cFilZZ7))
		Else
			ZZ7->(FieldPut(nY,M->&(EVAL(bCampo,nY))))
		EndIf
	Next nY
	ZZ7->ZZ7_VERSAO:=cNextVersao
	ZZ7->ZZ7_STATUS	:="1"
	ZZ7->ZZ7_FLAG	:=Iif(lTipoVPC,"1","2")
	ZZ7->(MsUnLock())
	
	For nInd:=1 To Len(aColsItens)
		If !GdDeleted( nInd , aHeadItens ,aColsItens)
			ZZ8->(RecLock("ZZ8",.T.))
			R705Grava(aHeadItens ,aColsItens,nInd,"ZZ8")
			ZZ8->ZZ8_FILIAL:=cFilZZ8
			ZZ8->ZZ8_CODIGO:=M->ZZ7_CODIGO
			ZZ8->ZZ8_VERSAO:=cNextVersao
			ZZ8->(MsUnLock())
		EndIf
	Next
	
	For nInd:=1 To Len(aColsClasse)
		If !GdDeleted( nInd , aHeadClasse,aColsClasse) .And. !Empty(GdFieldGet("ZZ9_CLASSE",nInd,,aHeadClasse ,aColsClasse) )
			ZZ9->(RecLock("ZZ9",.T.))
			R705Grava(aHeadClasse ,aColsClasse,nInd,"ZZ9")
			ZZ9->ZZ9_FILIAL	:=cFilZZ9
			ZZ9->ZZ9_CODIGO	:=M->ZZ7_CODIGO
			ZZ9->ZZ9_VERSAO	:=cNextVersao
			ZZ9->ZZ9_FLAG		:="3"
			ZZ9->(MsUnLock())
		EndIf
	Next
	
	For nInd:=1 To Len(aColsNoProduto)
		If !GdDeleted( nInd , aHeadNoProduto ,aColsNoProduto) .And. !Empty(GdFieldGet("ZZ9_PRODUT",nInd,,aHeadNoProduto ,aColsNoProduto) )
			ZZ9->(RecLock("ZZ9",.T.))
			R705Grava(aHeadNoProduto ,aColsNoProduto,nInd,"ZZ9")
			ZZ9->ZZ9_FILIAL	:=cFilZZ9
			ZZ9->ZZ9_CODIGO	:=M->ZZ7_CODIGO
			ZZ9->ZZ9_VERSAO	:=cNextVersao
			ZZ9->ZZ9_FLAG		:="2"
			ZZ9->(MsUnLock())
		EndIf
	Next
	
	For nInd:=1 To Len(aColsZZA)
		If !GdDeleted( nInd , aHeaderZZA ,aColsZZA)
			ZZA->(RecLock("ZZA",.T.))
			R705Grava(aHeaderZZA ,aColsZZA,nInd,"ZZA")
			ZZA->ZZA_FILIAL:=cFilZZA
			ZZA->ZZA_CODIGO:=M->ZZ7_CODIGO
			ZZA->ZZA_VERSAO:=cNextVersao
			ZZA->(MsUnLock())
		EndIf
	Next
	
	
	For nInd:=1 To Len(aColsZZBP)
		If !GdDeleted( nInd , aHeadZZBP ,aColsZZBP) .And. (  GdFieldGet("ZZB_PERINI",nInd,,aHeadZZBP, aColsZZBP)>0 .Or. GdFieldGet("ZZB_PERFIM",nInd,,aHeadZZBP, aColsZZBP) >0)
			ZZB->(RecLock("ZZB",.T.))
			R705Grava(aHeadZZBP ,aColsZZBP,nInd,"ZZB")
			ZZB->ZZB_FILIAL:=cFilZZB
			ZZB->ZZB_CODIGO:=M->ZZ7_CODIGO
			ZZB->ZZB_VERSAO:=cNextVersao
			ZZB->(MsUnLock())
		EndIf
	Next

	For nInd:=1 To Len(aColsZZBV)
		If !GdDeleted( nInd , aHeadZZBV ,aColsZZBV) .And. (  GdFieldGet("ZZB_VLRINI",nInd,,aHeadZZBV, aColsZZBV)>0 .Or. GdFieldGet("ZZB_VLRFIM",nInd,,aHeadZZBV, aColsZZBV) >0)
			ZZB->(RecLock("ZZB",.T.))
			R705Grava(aHeadZZBV ,aColsZZBV,nInd,"ZZB")
			ZZB->ZZB_FILIAL:=cFilZZB
			ZZB->ZZB_CODIGO:=M->ZZ7_CODIGO
			ZZB->ZZB_VERSAO:=cNextVersao
			ZZB->(MsUnLock())
		EndIf
	Next
	
	
	ConfirmSX8()
EndIf

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/23/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R705Grava(aHeader,aCols,nInd,cTabela)
Local nColuna
Local nYnd

For nYnd:=1 To Len(aHeader)
	nColuna:=(cTabela)->(FieldPos(aHeader[nYnd,2]))
	If nColuna>0
		(cTabela)->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
	EndIf
Next

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/23/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705Valid(cCampo)
Local aAreaAtu	:=GetArea()
Local aAreaSA1	:=SA1->(GetArea())
Local lReturn 	:=.T.
Local nVlrPer
Local nYnd
Local cTipoRepasse
Local lFirst
Local nLinhaAux

Default cCampo:=__ReadVar

If "ZZ7_DTVINI"$cCampo
	If !Empty(M->ZZ7_DTVFIM) .And. M->ZZ7_DTVINI>M->ZZ7_DTVFIM
		MsgInfo(Trim(AvSx3("ZZ7_DTVINI",5))+" nใo pode ser superior a "+Trim(AvSx3("ZZ7_DTVFIM",5)))
		lReturn :=.F.
	EndIf
ElseIf "ZZ7_DTVFIM"$cCampo
	If !Empty(M->ZZ7_DTVINI) .And. M->ZZ7_DTVFIM<M->ZZ7_DTVINI
		MsgInfo(Trim(AvSx3("ZZ7_DTVFIM",5))+" nใo pode ser inferior a "+Trim(AvSx3("ZZ7_DTVINI",5)))
		lReturn :=.F.
	EndIf
	
ElseIf "ZZ7_CLIENT"$cCampo .Or. "ZZ7_LOJA"$cCampo
	
	SA1->(DbSetOrder(1))
	
	cLoja:=M->ZZ7_LOJA
	cCodCli:=M->ZZ7_CLIENT
	
	
	cChaveSA1:=xFilial("SA1")+cCodCli+IIf(!Empty(cLoja),cLoja,"")
	If !SA1->(DbSeek(cChaveSA1))
		lReturn:=ExistCpo("SA1",cChaveSA1)
	Else
		M->ZZ7_DESCLI:=SA1->A1_NOME
	EndIf
ElseIf "ZZ7_PEDIDO"$cCampo
	If U_PR705TemPV(M->ZZ7_PEDIDO,.T.)
		lReturn:=.F.
	EndIf
ElseIf "ZZ8_PERIOD"$cCampo
	
	cTipoRepasse:=GdFieldGet("ZZ8_REPASS",oGetItens:nAt,,oGetItens:aHeader, oGetItens:aCols)
	For nInd:=1 To 12
		GDFieldPut ( "ZZ8_MES"+StrZero(nInd,2), IIf(M->ZZ8_PERIOD=="1" .And. cTipoRepasse=="1"  ,"X"," "), oGetItens:nAt, oGetItens:aHeader, oGetItens:aCols)
	Next
	
	If cTipoRepasse<>"1"
		MsgStop("Repasse Pedido Venda nใo permite a edi็ใo deste campo")
		lReturn:=.F.
	EndIf
	
ElseIf "ZZ8_MES"$cCampo
	
	cTipoRepasse:=GdFieldGet("ZZ8_REPASS",oGetItens:nAt,,oGetItens:aHeader, oGetItens:aCols)
	
	If cTipoRepasse<>"1"
		MsgStop("Repasse Pedido Venda nใo permite a edi็ใo deste campo")
		lReturn:=.F.
	EndIf
	
ElseIf "ZZ8_REPASS"$cCampo
	
	If M->ZZ8_REPASS=="2"
		For nInd:=1 To 12
			GDFieldPut ( "ZZ8_MES"+StrZero(nInd,2)," ", oGetItens:nAt, oGetItens:aHeader, oGetItens:aCols)
		Next
	EndIf
	
ElseIf "ZZB_PERINI"$cCampo
	
	
	//GDFieldPut ( "ZZB_VLRINI",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_VLRFIM",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_VALOR" ,0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	
	
	nVlrPer:=GdFieldGet("ZZB_PERFIM",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols)
	If !Empty(nVlrPer) .And. M->ZZB_PERINI>nVlrPer
		MsgInfo(Trim(AvSx3("ZZB_PERINI",5))+" nใo pode ser superior a "+Trim(AvSx3("ZZB_PERFIM",5)))
		lReturn:=.F.
	EndIf
	
ElseIf "ZZB_PERFIM"$cCampo
	
	//GDFieldPut ( "ZZB_VLRINI",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_VLRFIM",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_VALOR" ,0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	
	
	nVlrPer:=GdFieldGet("ZZB_PERINI",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols)
	If !Empty(nVlrPer) .And. M->ZZB_PERFIM<nVlrPer
		MsgInfo(Trim(AvSx3("ZZB_PERFIM",5))+" nใo pode ser Inferior a "+Trim(AvSx3("ZZB_PERINI",5)))
		lReturn:=.F.
	EndIf
	
ElseIf "ZZB_PERCEN"$cCampo
	
	//GDFieldPut ( "ZZB_VLRINI",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_VLRFIM",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	GDFieldPut ( "ZZB_VALOR" ,0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	GDFieldPut ( "ZZB_VALOR" ,0, oGetZZBV:nAt, oGetZZBV:aHeader, oGetZZBV:aCols)
	
	
ElseIf "ZZB_VLRINI"$cCampo
	
	//GDFieldPut ( "ZZB_PERINI",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_PERFIM",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_PERCEN" ,0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	
	
	nVlrPer:=GdFieldGet("ZZB_VLRFIM",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols)
	If !Empty(nVlrPer) .And. M->ZZB_VLRINI>nVlrPer
		MsgInfo(Trim(AvSx3("ZZB_VLRINI",5))+" nใo pode ser superior a "+Trim(AvSx3("ZZB_VLRFIM",5)))
		lReturn:=.F.
	EndIf
	
ElseIf "ZZB_VLRFIM"$cCampo
	
	//GDFieldPut ( "ZZB_PERINI",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_PERFIM",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_PERCEN" ,0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	
	nVlrPer:=GdFieldGet("ZZB_VLRINI",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols)
	If !Empty(nVlrPer) .And. M->ZZB_PERFIM<nVlrPer
		MsgInfo(Trim(AvSx3("ZZB_VLRFIM",5))+" nใo pode ser Inferior a "+Trim(AvSx3("ZZB_VLRINI",5)))
		lReturn:=.F.
	EndIf
	
ElseIf "ZZB_VALOR"$cCampo
	
	//GDFieldPut ( "ZZB_PERINI",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	//GDFieldPut ( "ZZB_PERFIM",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	GDFieldPut ( "ZZB_PERCEN",0, oGetZZBP:nAt, oGetZZBP:aHeader, oGetZZBP:aCols)
	GDFieldPut ( "ZZB_PERCEN",0, oGetZZBV:nAt, oGetZZBV:aHeader, oGetZZBV:aCols)
	
EndIf

RestArea(aAreaSA1)
RestArea(aAreaAtu)
Return lReturn
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/23/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705TOK(nOpc,aHeadItens,aColsItens,aHeadClasse,aColsClasse,aHeadNoProduto,aColsNoProduto,aHeaderZZA,aColsZZA,aHeadZZBP,aColsZZBP,aHeadZZBV,aColsZZBV)
Local aAreaAtu	:=GetArea()
Local lReturn :=.T.
Local nInd
Local aCposZZA:= {"ZZA_REFERE","ZZA_BASE","ZZA_APURAC"}
Local lValidarZZA:=.F.
Local cClasse:=""
Local cCodProd:=""
Local lTemEscala:=.F.

If Empty(M->ZZ7_GRPCLI) .And. Empty(M->ZZ7_CLIENT)
	MsgInfo("Preencha o campo "+Trim(AvSx3("ZZ7_GRPCLI",5))+" ou campo "+Trim(AvSx3("ZZ7_CLIENT",5)))
	Return .F.
EndIf

If !U_PR705Valid("M->ZZ7_DTVINI") .Or. !U_PR705Valid("M->ZZ7_DTVFIM")
	lReturn :=.F.
EndIf

//Verificar primeiro a Classe de Produto
For nInd:=1 To Len(aColsClasse)
	If GdDeleted( nInd,aHeadClasse,aColsClasse)
		Loop
	EndIf
	If !U_R705ValLine("ZZ9_CLASSE",nInd,aHeadClasse,aColsClasse)
		Return .F.
	EndIf
	cClasse+=GdFieldGet("ZZ9_CLASSE",nInd,,aHeadClasse,aColsClasse)+";"
Next

cClasse:=Left(cClasse,Len(cClasse)-1)//Retirar o ultimo ';'

If nOpc<>5 .And. !PR705Duplic(cClasse)
	Return .F.
EndIf

For nInd:=1 To Len(aColsItens)
	
	If GdDeleted( nInd,aHeadItens,aColsItens)
		Loop
	EndIf
	
	If lTipoVPC.And. Posicione("P00",1,xFilial("P00")+GdFieldGet("ZZ8_TIPO",nInd,,aHeadItens,aColsItens),"P00_TIPO"  )=="3" .And. GdFieldGet("ZZ8_REPASS",nInd,,aHeadItens,aColsItens)<>"2"
		MsgInfo("Tipo VPC Over Price somente utilizado para repasse Pedido Venda","NcGames")
		Return .F.
	EndIf
	If !lTipoVPC.And. Empty(GdFieldGet("ZZ8_PERCEN",nInd,,aHeadItens,aColsItens)+GdFieldGet("ZZ8_VLRVEB",nInd,,aHeadItens,aColsItens))
		MsgInfo("Preencha o campo "+Trim(AvSx3("ZZ8_PERCEN",5))+" ou campo "+Trim(AvSx3("ZZ8_VLRVEB",5)))
		Return .F.
	EndIf
	
	
	If GdFieldGet("ZZ8_REPASS",nInd,,aHeadItens,aColsItens)=="1" .And. Empty(GdFieldGet("ZZ8_PERIOD",nInd,,aHeadItens,aColsItens))
		MsgStop("Campo "+Trim(AvSx3("ZZ8_REPASS",5)) +" obrigat๓rio.")
		Return .F.
	EndIf
	
	
	If !U_R705ValLine("ZZ8",nInd,aHeadItens,aColsItens)
		Return .F.
	EndIf
Next


For nInd:=1 To Len(aColsNoProduto)
	
	If GdDeleted( nInd,aHeadNoProduto,aColsNoProduto)  .Or. Empty(cCodProd:=GdFieldGet("ZZ9_PRODUT",nInd,,aHeadNoProduto,aColsNoProduto))
		Loop
	EndIf
	
	If !U_R705ValLine("ZZ9",nInd,aHeadNoProduto,aColsNoProduto)
		Return .F.
	EndIf
	
	SB1->(DbSetOrder(1))
	SB1->(DbSeek(xFilial("SB1")+cCodProd))
	
	If !Empty(cClasse) .And. !SB1->B1_YCLASSE$cClasse
		MsgStop("Produto "+AllTrim(SB1->B1_COD)+" na pasta "+aFolders[3]+"(classe "+SB1->B1_YCLASSE+") nใo pertence a(s) classe(s) cadastradas na pasta "+aFolders[1]+"." )
		Return .F.
	EndIf
Next


For nInd:=1 To Len(aColsZZA)
	
	
	If GdDeleted( nInd,aHeaderZZA,aColsZZA)
		Loop
	EndIf
	
	
	If Empty(GdFieldGet("ZZA_REFERE",nInd,,aHeaderZZA ,aColsZZA))
		Loop
	EndIF
	
	lValidarZZA:=.T.
	
	If  !U_R705ValLine("ZZA",nInd,aHeaderZZA,aColsZZA)
		Return .F.
	EndIf
Next


If lValidarZZA
	
	For nInd:=1 To Len(aColsZZBP)
		
		If GdDeleted( nInd,aHeadZZBP,aColsZZBP)  .Or. Empty( GdFieldGet("ZZB_PERINI",nInd,,aHeadZZBP,aColsZZBP)+GdFieldGet("ZZB_PERFIM",nInd,,aHeadZZBP,aColsZZBP)   )
			Loop
		EndIf
		
		If !PR705ESCALA("ZZBP")
			Return .F.
		EndIf
		
		lTemEscala:=.T.
		
		
	Next
	
	For nInd:=1 To Len(aColsZZBV)
		
		If GdDeleted( nInd,aHeadZZBV,aColsZZBV)  .Or. Empty( GdFieldGet("ZZB_VLRINI",nInd,,aHeadZZBV,aColsZZBV)+GdFieldGet("ZZB_VLRFIM",nInd,,aHeadZZBV,aColsZZBV)   )
			Loop
		EndIf
		
		If !PR705ESCALA("ZZBV")
			Return .F.
		EndIf
		
		lTemEscala:=.T.
	Next
	
	If !lTemEscala
		MsgStop("Dados de Escala obrigat๓rio.")
		Return .F.
	EndIf
	
	
	
EndIf



If lReturn
	U_R705ZZ8()
EndIf

RestArea(aAreaAtu)
Return lReturn
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/23/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705ValLine(cTabela,nLinha,aHeadAux,aColsAux)
Local aCposObrigat
Local aCposKey:={}
Local cMensagem:=""

If cTabela=="ZZ8"
	If !R705VALMES(nLinha,aHeadAux,aColsAux)
		Return .F.
	EndIf
	aCposKey		:= {"ZZ8_TIPO"}
	cMensagem:="VPC Duplicado"
ElseIf cTabela=="ZZ9"
	aCposKey		:= {"ZZ9_PRODUT"}
	cMensagem:="Exce็ใo Produtos Duplicado"
ElseIf cTabela=="ZZ9_CLASSE"
	aCposKey		:= {"ZZ9_CLASSE"}
	cMensagem:="Classe Produtos Duplicado"
ElseIf cTabela=="ZZA"
	aCposKey		:= {"ZZA_REFERE","ZZA_BASE","ZZA_TPFAT","ZZA_APURAC"}
	cMensagem:="Contrato de Crescimento Duplicado"
EndIf

aCols		:=aClone(aColsAux)
aHeader	:=aClone(aHeadAux)
N			:=nLinha

aCposObrigat:= GdObrigat( aHeader )

If ( Len(aCposKey)> 0 .Or.  Len(aCposObrigat)> 0)  .And. !GdCheckKey(aCposKey,4,aCposObrigat,cMensagem,,nLinha) //Verifica Itens duplicados na getdados ( aCpo , nModelo , aNoEmpty , cMsgAviso , lShowAviso )
	//MsgStop(cMensagem)
	Return .F.
EndIf

If "ZZB"$cTabela
	If !PR705ESCALA(cTabela)
		Return .F.
	EndIf
EndIf

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/29/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705ZZ8(aHeadItens,aColsItens,lDelete,nLinha,lJaExcluido)
Default aHeadItens:=oGetItens:aHeader
Default aColsItens:=oGetItens:aCols
Default lDelete	:=.F.
Default nLinha		:=oGetItens:nAt
Default lJaExcluido:=.F.

If lTipoVPC
	
	M->ZZ7_TPERLI:=0
	M->ZZ7_TPERBR:=0
	
	For nInd:=1 To Len(aColsItens)
		
		If !lJaExcluido
			If GdDeleted( nInd,aHeadItens,aColsItens) .Or. ( lDelete .And. nLinha==nInd )
				Loop
			EndIf
		EndIf
		
		If GdFieldGet("ZZ8_TPFAT",nInd,,aHeadItens,aColsItens)=="1"
			M->ZZ7_TPERBR+=GdFieldGet("ZZ8_PERCEN",nInd,,aHeadItens,aColsItens)
		Else
			M->ZZ7_TPERLI+=GdFieldGet("ZZ8_PERCEN",nInd,,aHeadItens,aColsItens)
		Endif
		
	Next
EndIf
oEnchoice:EnchRefreshAll()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/29/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705DELOK()
Local lJaExcluido:=GdDeleted( oGetItens:nAt,oGetItens:aHeader,oGetItens:aCols)
U_R705ZZ8(oGetItens:aHeader,oGetItens:aCols,.T.,oGetItens:nAt,lJaExcluido)
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  07/29/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R705VALMES(nLinha,aHeadItens,aColsItens)
Local nInd
Local nPosIni		:=GdFieldPos("ZZ8_MES01",aHeadItens)
Local aMeses		:={}
Local cPeriodo		:=GdFieldGet("ZZ8_PERIOD",nLinha,,aHeadItens,aColsItens)    //1=Mensal;2=Bimestral;3=Trimestral;4=Semestral;5=Anual
Local cTipo			:=GdFieldGet("ZZ8_TIPO",nLinha,,aHeadItens,aColsItens)+"-"+GdFieldGet("ZZ8_DESCTI",nLinha,,aHeadItens,aColsItens)
Local cMes
Local aNomes		:={"Janeiro","Fevereiro","Mar็o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}

If GdFieldGet("ZZ8_REPASS",nLinha,,aHeadItens,aColsItens)=="2"
	Return .T.
EndIf

For nInd:=1 To 12
	cMes:=GdFieldGet("ZZ8_MES"+StrZero(nInd,2),nLinha,,aHeadItens,aColsItens)
	If GdDeleted( nLinha , aHeadItens ,aColsItens) .Or. Empty(cMes)
		Loop
	EndIf
	AADD(aMeses,nInd)
Next

If Len(aMeses)==0
	MsgStop("Nใo foi marcado nenhum m๊s de apura็ใo para o tipo "+cTipo)
	Return .F.
EndIf

If ! ( Len(aMeses)==1 .Or. cPeriodo=="1" )
	For nInd:=2 To Len(aMeses)
		nDiferenca:=aMeses[nInd]-aMeses[nInd-1]
		If (cPeriodo=="2" .And. nDiferenca<2) .Or. (cPeriodo=="3" .And. nDiferenca<3) .Or. (cPeriodo=="4" .And. nDiferenca<4) .Or. (cPeriodo=="5" .And. nDiferenca<12)
			MsgStop("Haverแ uma sobreposi็ใo de cแlculo nas apura็๕es dos meses "+aNomes[aMeses[nInd-1]]+" e "+aNomes[aMeses[nInd]]+" na linha do Tipo "+cTipo)
			Return .F.
		EndIf
	Next
EndIf
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  08/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                           admin                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705Send()
Local aAreaAtu:=GetArea()
Local aAreaZZ7:=ZZ7->(GetArea())
Local lGerouP0B
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "ZZ7_STATUS","X3CBox()" ),,,1)

If ZZ7->ZZ7_STATUS<>"1" //1=Em Negociacao;2=Em Aprovacao;3=Aprovado;4=Reprovado;5=Encerrado
	MsgStop("Status do "+Iif(lTipoVPC,"contrato","verba extra")+" igual "+aCombo[Ascan(aCombo,{|a| a[2]==ZZ7->ZZ7_STATUS} ),3]+",somente status "+aCombo[Ascan(aCombo,{|a| a[2]=="1"} ),3]+" pode ser enviado para aprova็ใo.")
	Return
EndIf

lGerouP0B:=U_GETALCAVPC(0,"3","ZZ7",ZZ7->(ZZ7_CODIGO+ZZ7_VERSAO),1,"ZZ7",,,"")
RestArea(aAreaZZ7)

If lGerouP0B
	ZZ7->(RecLock("ZZ7",.F.))
	ZZ7->ZZ7_STATUS:="2"
	ZZ7->(MsUnLock())
	MsgInfo(Iif(lTipoVPC,"Contrato","Verba extra")+" enviado para aprova็ใo.")
Else
	MsgStop("Erro ao enviar o "+Iif(lTipoVPC,"contrato","verba extra")+" para aprova็ใo.")
EndIf


RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR706  บAutor  ณMicrosiga           บ Data ณ  08/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705ExstMemNiv(cNumAlc,cNivel)
Local llRet 	:= .F.
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()


cSql	:= " SELECT "
cSql	+= " P0B_USER "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL = '"+cNivel+"'"
cSql	+= " AND P0B.P0B_USER <> '"+Alltrim(cUserLog)+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.P0B_TABORI = 'ZZ7'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	llRet := .T.
EndIf

(cAlias)->(dbCloseArea())

Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  08/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705GetNextNivel(cNumAlc,cNivel)
Local llRet 	:= .F.
Local cSql 		:= ""
Local cTabOrig	:= ""
Local _VERVPC	:= ""
Local _CodVPC	:= ""
Local cPreCampo	:= ""
Local cAlias	:= GetNextAlias()
Local aAreaP0B	:= P0B->(GetArea())

cSql	:= " SELECT "
cSql	+= " P0B_NUM "
cSql	+= " ,P0B_TIPO "
cSql	+= " ,P0B_USER "
cSql	+= " ,P0B_NIVEL "
cSql	+= " ,P0B_WF "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL > '"+cNivel+"'" // Proximo Nivel
cSql	+= " AND P0B.D_E_L_E_T_= ' ' "
cSql	+= " AND P0B.P0B_TABORI = 'ZZ7'"
cSql	+= " ORDER BY P0B_NIVEL "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	
	llRet := .T.
	
	P0B->(dbSetOrder(2)) //P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_USER
	
	cNextNivel := Alltrim((cAlias)->P0B_NIVEL)
	
	While (cAlias)->(!Eof())
		
		If Alltrim(cNextNivel) == Alltrim((cAlias)->P0B_NIVEL)
			If P0B->(dbSeek(xFilial("P0B")+ (cAlias)->(P0B_TIPO+P0B_NUM+P0B_USER )))
				
				If P0B->(RecLock("P0B",.F.))
					P0B->P0B_STATUS := '01'
					P0B->(MsUnLock())
				EndIf
				
				// Fazer Tratamento para enviar WF para a Proxima Fase
				If (cAlias)->P0B_WF == "1"
					
					cMailDest := Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_EMAIL" )
					cNomeAprov:= Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_NOME")
					
					cTabOrig	:= P0B->P0B_TABORI
					cPreCampo	:= Right(cTabOrig,2)
					
					dbSelectArea(cTabOrig)
					
					&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))
					If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
						//U_R705ENVWF(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO)
					EndIf
					
				EndIf
				
			EndIf
		Else
			Exit
		EndIf
		(cAlias)->(dbSkip())
		
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())

RestArea(aAreaP0B)

Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  08/29/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PR705ESCALA(cTabela)
Local lFirst	:=.T.
Local nYnd
Local nPerIni	:=0
Local	nPerFim	:=0
Local	nValor	:=0
Local	lEscalaValor
Local	lEscalaPercent
Local	nLinhaAux:=1

If cTabela=="ZZBP"
	
	For nYnd:=1 To Len(oGetZZBP:aCols)
		
		If GdDeleted( nYnd , oGetZZBP:aHeader, oGetZZBP:aCols)
			Loop
		EndIf
		
		If !PR705ZZB(.F.,.T.) // Valida se foi preenchido o campos de escala valor
			MsgInfo("Campos da Escala Valor jแ preenchidas!! Edi็ใo da linha "+StrZero(nYnd,2)+" nใo permitida.")
			Return .F.
		EndIf
		
		
		If Empty( GdFieldGet("ZZB_PERINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols))  .And. Empty( GdFieldGet("ZZB_PERFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols))
			MsgStop("Campos obrigat๓rios nใo preenchidos na linha "+StrZero(nYnd,2)+".Verifique os campos:"+AllTrim(AvSx3("ZZB_PERINI",5))+","+AllTrim(AvSx3("ZZB_PERFIM",5)) )
			Return .F.
		EndIf
		
		
		
		If GdFieldGet("ZZB_PERFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols) < GdFieldGet("ZZB_PERINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols)
			MsgInfo(Trim(AvSx3("ZZB_PERFIM",5))+" nใo pode ser Inferior a "+Trim(AvSx3("ZZB_PERINI",5)))
			Return .F.
		EndIf
		
		
		If GdFieldGet("ZZB_PERINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols) > GdFieldGet("ZZB_PERFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols)
			MsgInfo(Trim(AvSx3("ZZB_PERINI",5))+" nใo pode ser superior a "+Trim(AvSx3("ZZB_PERFIM",5)))
			Return .F.
		EndIf
		
		If !lFirst .And. !( GdFieldGet("ZZB_PERINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols)> nPerFim  .And. GdFieldGet("ZZB_PERFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols)> nPerFim )
			MsgInfo("Hแ uma sobreposi็ใo na escala de Percentual entre as linhas "+StrZero(nLinhaAux,2)+" e "+StrZero(nYnd,2))
			Return .F.
		EndIf
		
		
		nPerIni		:=GdFieldGet("ZZB_PERINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols)
		nPerFim		:=GdFieldGet("ZZB_PERFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols)
		nLinhaAux	:=nYnd
		lFirst		:=.F.
	Next
	
Else
	
	For nYnd:=1 To Len(oGetZZBV:aCols)
		
		If GdDeleted( nYnd , oGetZZBV:aHeader, oGetZZBV:aCols)
			Loop
		EndIf
		
		If !PR705ZZB(.T.,.F.) // Valida se foi preenchido o campos de escala percentual
			MsgInfo("Campos da Escala Percentual jแ preenchidas!! Edi็ใo da linha "+StrZero(nYnd,2)+" nใo permitida.")
			Return .F.
		EndIf
		
		If Empty( GdFieldGet("ZZB_VLRINI",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols))  .And. Empty( GdFieldGet("ZZB_VLRFIM",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols))
			MsgStop("Campos obrigat๓rios nใo preenchidos na linha "+StrZero(nYnd,2)+".Verifique os campos:"+AllTrim(AvSx3("ZZB_VLRINI",5))+","+AllTrim(AvSx3("ZZB_VLRFIM",5)) )
			Return .F.
		EndIf
		
		If GdFieldGet("ZZB_VLRFIM",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols) < GdFieldGet("ZZB_VLRINI",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols)
			MsgInfo(Trim(AvSx3("ZZB_VLRFIM",5))+" nใo pode ser Inferior a "+Trim(AvSx3("ZZB_VLRINI",5)))
			Return .F.
		EndIf
		
		
		If GdFieldGet("ZZB_VLRINI",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols) > GdFieldGet("ZZB_VLRFIM",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols)
			MsgInfo(Trim(AvSx3("ZZB_VLRINI",5))+" nใo pode ser superior a "+Trim(AvSx3("ZZB_VLRFIM",5)))
			Return .F.
		EndIf
		
		If !lFirst .And. !( GdFieldGet("ZZB_VLRINI",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols)> nPerFim  .And. GdFieldGet("ZZB_VLRFIM",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols)> nPerFim )
			MsgInfo("Hแ uma sobreposi็ใo na escala de Valor entre as linhas "+StrZero(nLinhaAux,2)+" e "+StrZero(nYnd,2))
			Return .F.
		EndIf
		
		
		nPerIni		:=GdFieldGet("ZZB_VLRINI",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols)
		nPerFim		:=GdFieldGet("ZZB_VLRFIM",nYnd,,oGetZZBV:aHeader, oGetZZBV:aCols)
		nLinhaAux	:=nYnd
		lFirst		:=.F.
		
	Next
	
	
	
EndIf

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  08/29/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออCอออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705When(cCampo)
Local lWhen :=.T.

If cCampo=="ZZB_VALOR"
	lWhen:= Empty( GdFieldGet("ZZB_PERINI",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols) ) .And.	Empty( GdFieldGet("ZZB_PERFIM",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols)	 )
ElseIf cCampo=="ZZB_PERINI"
	lWhen:= Empty( GdFieldGet("ZZB_VALOR",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols) )
ElseIf cCampo=="ZZB_PERFIM"
	lWhen:= Empty( GdFieldGet("ZZB_VALOR",oGetZZBP:nAt,,oGetZZBP:aHeader, oGetZZBP:aCols) )
ElseIf cCampo=="ZZ7_GRPCLI"
	lWhen:= Empty( M->ZZ7_CLIENT )
ElseIf cCampo=="ZZ7_CLIENT"
	If !lTipoVPC .And. M->ZZ7_TPVERB=="2"
		lWhen:=.F.
	Else
		lWhen:= Empty( M->ZZ7_GRPCLI )
	EndIf
ElseIf cCampo=="ZZ7_LOJA"
	lWhen:= !Empty( M->ZZ7_CLIENT )
EndIf


Return lWhen
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  08/29/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705ENVWF(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,cTabOrig,ChaveInd,nInd )
Local lReturn		:=.T.
Local aAreaP0B		:= P0B->(GetArea())
Local cBody			:=""

P0B->(DbSetOrder(1))//P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
P0B->(DbSeek(xFilial("P0B")+cTpDocAlc+cNumAlc))

cBody+='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
cBody+='<html xmlns="http://www.w3.org/1999/xhtml">'
cBody+='<head>'
cBody+='<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'
cBody+='<title>Workflow Protheus Nc Games </title>'

cBody+='</head>'

cBody+='<!-- CONTEUDO DA PAGINA -->'
cBody+='<body 	style="'
cBody+='		margin: 0px; '
cBody+='		padding: 0px; " >'
cBody+='<!-- ABERTURA DA DIV PRINCIPAL --> '
cBody+='<div id="principal" style="	'
cBody+='					width: 90%;'
cBody+='					padding: 15px;'
cBody+='					margin-right: auto;'
cBody+='					margin-left: auto;'
cBody+='					margin-top: 20px;'
cBody+='					margin-bottom: 20px;'
cBody+='					background-color: #FFF; " >'
cBody+='  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">'
cBody+='    <tr>'
cBody+='      <td height="39" valign="middle" style="font-family: Trebuchet MS, Arial, Helvetica, sans-serif; font-size: 30px; color: #999; text-transform: uppercase; text-align: left;" >Protheus '
cBody+='		NC GAMES </td>'
cBody+='    </tr>'
cBody+='  </table>'
cBody+='  <hr />'
cBody+='<form name="form1" method="post" action="mailto:%WFMailTo%">'
cBody+='  <p>&nbsp;</p>'
cBody+='  <table width="95%" border="0" align="center" cellpadding="5" cellspacing="5" id="tbinternoeexterno">'
cBody+='    <tr>'
cBody+='      <td><span style=" font-family: Verdana, Geneva, sans-serif; '
cBody+='         		font-size: 11px; '
cBody+='                color: #000; " >Sr(a).</span> <span style="'
cBody+='        		font-family: Arial, Helvetica, sans-serif;'
cBody+='				font-size: 13px;'
cBody+='				color: #039;'
cBody+='				font-weight: bold; ">'+cNomeAprov+'</span></td>'
cBody+='    </tr>'
cBody+='    <tr>'
cBody+='      <td><p>'
cBody+='		<span style="font-family: Verdana, Geneva, sans-serif; font-size: 11px">'
cBody+='		Contrato VPC&nbsp; '+ZZ7->( ZZ7_CODIGO+"/"+ZZ7_VERSAO+"-"+ZZ7_DESC)+' aguardando sua aprova็ใo</span></p></td>'
cBody+='    </tr>'
cBody+='  </table>'
cBody+='<p>&nbsp;</p>'
cBody+='</form>'
cBody+='<table width="100%" border="0" id="tbrodape">'
cBody+='  <tr>'
cBody+='    <td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif; '
cBody+='         		font-size: 11px; '
cBody+='                color: #000; "> WORKFLOW PROTHEUS</td>'
cBody+='  </tr>'
cBody+='</table>'
cBody+='</div>'
cBody+='</body>'
cBody+='</html>'

MySndMail("Aprova็ใo VPC", cBody, , cMailDest, )

RestArea(aAreaP0B)

Return lReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  11/17/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705GET(cAlias,cCliente, cLoja,cCodGrup,dDtEmissao,cFlag,cPedido)
Local aAreaAtu:=GetArea()
Local cQuery

Default cPedido:=""

cQuery:=" Select ZZ7.R_E_C_N_O_ RecZZ7 "+CRLF
cQuery+=" From "+RetSqlName("ZZ7")+" ZZ7 "+CRLF
cQuery+=" Where ZZ7.ZZ7_FILIAL='"+xFilial("ZZ7")+"'"+CRLF

If cFlag=='1'
	cQuery+=" And ( '"+Dtos(dDtEmissao)+"' Between ZZ7.ZZ7_DTVINI And ZZ7.ZZ7_DTVFIM OR ZZ7_RENOVA='S')"+CRLF
EndIf	    

cQuery+=" And ZZ7.ZZ7_FLAG='"+cFlag+"'"+CRLF
cQuery+=" And ZZ7.ZZ7_STATUS='3'"+CRLF
cQuery+=" And ZZ7.ZZ7_DTALTE=' ' "+CRLF
cQuery+=" And ( "+CRLF
cQuery+=" ( ZZ7.ZZ7_CLIENT ='"+cCliente+"' AND ZZ7.ZZ7_LOJA ='"+cLoja+"') " +CRLF
cQuery+=" Or "+CRLF
cQuery+=" ( ZZ7.ZZ7_CLIENT ='"+cCliente+"')" +CRLF
cQuery+=" Or "+CRLF
cQuery+=" ZZ7.ZZ7_GRPCLI='"+cCodGrup+"'"+CRLF
cQuery+=")"+CRLF
cQuery+=" And ZZ7.D_E_L_E_T_=' '"+CRLF

If !Empty(cPedido)
	cQuery+=" And ZZ7.ZZ7_PEDIDO='"+cPedido+"'"+CRLF
EndIf

If cFlag=='2' .And. Empty(cPedido)
	cQuery+=" And ZZ7.ZZ7_TPVERB='1'"+CRLF
EndIf


DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  11/17/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MySndMail(cAssunto, cMensagem, aAnexos, cEmailTo, cEmailCc, cErro)
Local lRetorno 		:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)

Default aAnexos		:= {}
Default cMensagem	:= ""
Default cAssunto	:= ""
Default cErro		:= ""
Default cEmailCc  :=""
If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cMensagem)
	If MailSmtpOn( cServer, cAccount, cPassword )
		If lMailAuth
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
			EndIf
		Endif
		If lRetorno
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cMensagem,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
			EndIf
		Else
			cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
Else
	If Empty(cEmailTo)
		cErro := "ษ neessแrio fornecer o destinแtario para o e-mail. "
		lRetorno := .F.
	EndIf
	If Empty(cAssunto)
		cErro := "ษ neessแrio fornecer o assunto para o e-mail. "
		lRetorno := .F.
	EndIf
	If Empty(cMensagem)
		cErro := "ษ neessแrio fornecer o corpo do e-mail. "
		lRetorno := .F.
	EndIf
Endif

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  11/20/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR705Duplic(cClasse)
Local aAreaAtu	:=GetArea()
Local lRetorno	:=.T.
Local cQryAlias:= GetNextAlias()
Local cQuery	:=""
Local cContrato:=""

cQuery:=" Select ZZ7_CODIGO,ZZ7_VERSAO "+CRLF
cQuery+=" From "+RetSqlName("ZZ7")+" ZZ7"+CRLF


If !Empty(cClasse)
	cQuery+=","+RetSqlName("ZZ9")+" ZZ9"+CRLF
EndIf

cQuery+=" Where ZZ7.ZZ7_FILIAL='"+xFilial("ZZ7")+"'"+CRLF
cQuery+=" And ZZ7.ZZ7_CODIGO<>'"+ZZ7->ZZ7_CODIGO+"'"+CRLF
cQuery+=" And ZZ7.ZZ7_DTALTE=' ' "+CRLF
cQuery+=" And ZZ7.ZZ7_FLAG='"+Iif(lTipoVPC,"1","2")+"'"+CRLF

If !Empty(M->ZZ7_GRPCLI)
	cQuery += " And ZZ7.ZZ7_GRPCLI = '"	+M->ZZ7_GRPCLI+"'"+CRLF
ElseIf !Empty(M->ZZ7_CLIENT) .and. !Empty(M->ZZ7_LOJA)
	cQuery += " And ZZ7.ZZ7_CLIENT = '"+M->ZZ7_CLIENT+"'"+CRLF
	cQuery += " And ZZ7.ZZ7_LOJA = '"+M->ZZ7_LOJA+"'"+CRLF
Else
	cQuery += " And ZZ7.ZZ7_CLIENT = '"	+M->ZZ7_CLIENT+"'"+CRLF
EndIf

cQuery+=" And ZZ7_STATUS NOT IN ('4','5')"+CRLF//1=Em Negociacao;2=Em Aprovacao;3=Aprovado;4=Reprovado;5=Encerrado
cQuery+=" And ( '"+DtoS(M->ZZ7_DTVINI)+ "' BETWEEN ZZ7.ZZ7_DTVINI AND ZZ7.ZZ7_DTVFIM  Or '"+DtoS(M->ZZ7_DTVFIM)+ "' BETWEEN ZZ7.ZZ7_DTVINI AND ZZ7.ZZ7_DTVFIM)"	+CRLF
cQuery+=" And ZZ7.D_E_L_E_T_=' '"+CRLF

If !Empty(cClasse)
	cQuery+=" And ZZ9.ZZ9_FILIAL=ZZ7.ZZ7_FILIAL "+CRLF
	cQuery+=" And ZZ9.ZZ9_CODIGO=ZZ7.ZZ7_CODIGO "+CRLF
	cQuery+=" And ZZ9.ZZ9_VERSAO=ZZ7.ZZ7_VERSAO "+CRLF
	cQuery+=" And ZZ9.ZZ9_FLAG='3'"+CRLF
	cQuery+=" And ZZ9_CLASSE In "+FormatIn(cClasse,";")+CRLF
	cQuery+=" And ZZ9.D_E_L_E_T_=' '"+CRLF
EndIf
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQryAlias, .F., .F.)

If (cQryAlias)->(!Eof()) .AND. (cQryAlias)->(!Bof())
	cContrato+="Contrato "+(cQryAlias)->ZZ7_CODIGO+"-"+(cQryAlias)->ZZ7_VERSAO+CRLF
	lRetorno := .F.
EndIf

If !lRetorno
	Aviso(ProcName()+" Linha:"+StrZero(ProcLine(),5),"Jแ existe um cadastro de VPC para o Grupo de Cliente ou Cliente e repasse no perํodo informado."+CRLF+cContrato,{"Ok"},3)
EndIf

(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)
Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  11/21/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705Encer()
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "ZZ7_STATUS","X3CBox()" ),,,1)

If !ZZ7->ZZ7_STATUS=="3"
	MsgStop("Somente Contrato com status "+aCombo[Ascan(aCombo,{|a| a[2]=="3"} ),3]+" pode ser encerrado.")
ElseIf MsgNoYes("Deseja encerrar o contatro "+ZZ7->( ZZ7_CODIGO+"/"+ZZ7_VERSAO+"-"+ZZ7_DESC)+"?")
	ZZ7->(RecLock("ZZ7",.F.))
	ZZ7->ZZ7_STATUS:="5"
	ZZ7->(MsUnLock())
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  11/28/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705LstAprov(cContrato,cVersao)
Local aAreaAtu:=GetArea()
Local cUsuario:=""
Local cAlias	:= GetNextAlias()
Local cSql

cSql	:= " SELECT "
cSql	+= " P0B_USER "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_CHVIND = '"+cContrato+cVersao+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

cUsuario:=UsrFullName((cAlias)->P0B_USER)

(cAlias)->(dbCloseArea())

RestArea(aAreaAtu)
Return cUsuario

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  01/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705SET(lSet)
lTipoVPC:=lSet
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  01/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705TemPV(cPedido,lShow)
Local aAreaAtu:=GetArea()
Local cQuery
Local cAlias	:= GetNextAlias()
Local lRetorno:=.F.

cQuery:=" Select Count(1) Contar "+CRLF
cQuery+=" From "+RetSqlName("ZZ7")+" ZZ7 "+CRLF
cQuery+=" Where ZZ7.ZZ7_FILIAL='"+xFilial("ZZ7")+"'"+CRLF
cQuery+=" And ZZ7.ZZ7_PEDIDO='"+cPedido+"'"
cQuery+=" And ZZ7.D_E_L_E_T_=' '"+CRLF
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)

If lShow .And. (cAlias)->Contar>0
	MsgStop("Pedido de Venda "+cPedido+" jแ cont้m Verba Extra cadastrada.")
	lRetorno:=.T.
EndIf

(cAlias)->(DbCloseArea())
RestArea(aAreaAtu)

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  01/17/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR705ZZB(lPercent,lValor)
Local nYnd

If lPercent
	
	For nYnd:=1 To Len(oGetZZBP:aCols)
		
		If GdDeleted( nYnd , oGetZZBP:aHeader, oGetZZBP:aCols)
			Loop
		EndIf
		
		If !Empty( GdFieldGet("ZZB_PERINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols))  .Or. !Empty( GdFieldGet("ZZB_PERFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols))
			Return .F.
		EndIf
	Next
	
	
ElseIf lValor
	
	For nYnd:=1 To Len(oGetZZBV:aCols)
		
		If GdDeleted( nYnd , oGetZZBV:aHeader, oGetZZBV:aCols)
			Loop
		EndIf
		
		If !Empty( GdFieldGet("ZZB_VLRINI",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols))  .Or. !Empty( GdFieldGet("ZZB_VLRFIM",nYnd,,oGetZZBP:aHeader, oGetZZBP:aCols))
			Return .F.
		EndIf
	Next
	
	
EndIf


Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  01/18/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                 ü                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R705Legend()
Local aCor:={}

aAdd(aCor,{'BR_BRANCO'	   ,"Em Negocia็ใo"   })
aAdd(aCor,{'BR_AMARELO'	   ,"Em Aprova็ใo"   })
aAdd(aCor,{'BR_VERDE'      ,"Aprovado"	 })
aAdd(aCor,{'BR_PRETO'      ,"Reprovado"	 })
aAdd(aCor,{"BR_VERMELHO"   ,"Encerrado"	 })

BrwLegenda(,"Status",aCor)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR705  บAutor  ณMicrosiga           บ Data ณ  12/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR705XBFiltro()
Local cFiltro

If M->ZZ7_FLAG=="1"
	cFiltro:="@#P00->P00_TIPO$'1*3'@#"
Else
	cFiltro:="@#P00->P00_TIPO=='2'@#"
EndIf	


Return cFiltro
