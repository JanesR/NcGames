#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM09   ºAutor  ³Elton C.	         º Data ³  09/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para gravar log de processamento          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCECOM09(nPediSite, cPedido,cAcao,cObservacao,cStatus,lErro,cCodCiaShop,cCadastro,cPVVtex,cPlataf)
Local aArea 	:= GetArea()
Local cNomeUser	:= ""
Local lAppend	:=.T.
Local cAliasQry 
Local cQuery
Local lPvVtex    

Default lErro		:=.F.
nPediSite := If( nPediSite == nil, 0, nPediSite )
Default cPedido		:=""
Default cAcao	  		:=""
Default cObservacao	:=""
Default lErro			:=.F.
Default cStatus		:=""
Default cCodCiaShop	:=""
Default cCadastro		:=""
Default cPVVtex		:=""
Default cPlataf		:=""

If IsBlind()
	cNomeUser:="JOB"
Else  
 	cNomeUser	:= UsrFullName( RetCodUsr())	
EndIf
             
lPvVtex:=!Empty(cPVVtex)


ZC7->(DbSetOrder(1))

If  cAcao=="IMPORTA_CLIENTE" 
	cQuery:=" Select Max(ZC7.R_E_C_N_O_) RecZC7"
	cQuery+=" From "+RetSqlName("ZC7")+" ZC7 "		
	cQuery+=" Where ZC7.ZC7_FILIAL='"+xFilial("ZC7")+"'"	
	cQuery+=" And ZC7.ZC7_CADAST='CLIENTE'	
	If lPvVtex
		cQuery+=" And ZC7.ZC7_PVVTEX='"+cPVVtex+"'"	
	Else	
		cQuery+=" And ZC7.ZC7_CODCIA='"+cCodCiaShop+"'"
	EndIf	
	cQuery+=" And ZC7.D_E_L_E_T_=' '"	
                                                  
    cAliasQry:=GetNextAlias()
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .F., .T.)
	
	If (cAliasQry)->RecZC7>0
		ZC7->(DbGoTo((cAliasQry)->RecZC7))	
		lAppend	:=.F.
	EndIf
	(cAliasQry)->(DbCloseArea())
Else
	cQuery:=" Select Max(ZC7.R_E_C_N_O_) RecZC7"
	cQuery+=" From "+RetSqlName("ZC7")+" ZC7 "		
	cQuery+=" Where ZC7.ZC7_FILIAL='"+xFilial("ZC7")+"'"	
	cQuery+=" And ZC7.ZC7_ACAO='"+cAcao+"'"        
	
	If lPvVtex
		cQuery+=" And ZC7.ZC7_PVVTEX='"+cPVVtex+"'"	
	Else		
		cQuery+=" And ZC7.ZC7_CADAST='"+ cCadastro+"'"
	EndIf	
	cQuery+=" And ZC7.D_E_L_E_T_=' '"	
                                                  
    cAliasQry:=GetNextAlias()
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .F., .T.)
	
	If (cAliasQry)->RecZC7>0
		ZC7->(DbGoTo((cAliasQry)->RecZC7))	
		lAppend	:=.F.
	EndIf
	(cAliasQry)->(DbCloseArea())	
EndIf
	
DbSelectArea("ZC7")		
ZC7->(RecLock("ZC7",lAppend))	
	
ZC7->ZC7_FILIAL	:=xFilial("ZC7")
ZC7->ZC7_PVECOM	:= nPediSite
ZC7->ZC7_NUM 		:= cPedido
ZC7->ZC7_ACAO		:= cAcao
ZC7->ZC7_DATA		:= MsDate()
ZC7->ZC7_HORA		:= Time()
ZC7->ZC7_USUARIO	:= cNomeUser
ZC7->ZC7_OBS		:= cObservacao
ZC7->ZC7_STATPV	:= cStatus
ZC7->ZC7_CADAST	:= cCadastro
ZC7->ZC7_CODCIA	:= cCodCiaShop
ZC7->ZC7_PVVTEX	:= cPVVtex
ZC7->ZC7_PLATAF:=cPlataf


If lErro
	ZC7->ZC7_ERRO  :="S"
Else
	ZC7->ZC7_ERRO  :="N"
EndIf

ZC7->(MsUnLock())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM09  ºAutor  ³Microsiga           º Data ³  03/06/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM09CAD(cCodCad,cCadastro,cAcao,cObservacao,cErro,cNome,aDadosCli)
Local aAreaAtu:=GetArea()
Local aAreaZC2:=ZC2->(GetArea())
Default cErro:=""
Default cNome:=""                                                      
Default aDadosCli:={}

     
cCadastro:=Padr(cCadastro,AvSx3("ZC2_CODCIA",3))
ZC2->(DbSetOrder(4))//ZC2_FILIAL+ZC2_CADAST+ZC2_CODCIA
If !ZC2->(DbSeek(xFilial("ZC2")+cCadastro+cCodCad))
	ZC2->(RecLock("ZC2",.T.))
	ZC2->ZC2_FILIAL:=xFilial("ZC2")
	ZC2->ZC2_CADAST	:=cCadastro
	ZC2->ZC2_CODCIA	:=cCodCad
	ZC2->ZC2_NOME	:=cNome
	If Len(aDadosCli)>0
		ZC2->ZC2_CNPJ	:=aDadosCli[1]
		ZC2->ZC2_CODERP	:=aDadosCli[2]
	EndIf
Else 
	ZC2->(RecLock("ZC2",.F.))	
EndIf
ZC2->ZC2_ERRO	:=Iif(Empty(cErro),"N","S")
ZC2->(MsUnLock())

U_NCECOM09(0,"",cAcao,cObservacao+CRLF+cErro,,!Empty(cErro),cCodCad,cCadastro)

RestArea(aAreaZC2)
RestArea(aAreaAtu)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM09  ºAutor  ³Microsiga           º Data ³  05/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM09PV(cCodCad,cCadastro,cAcao,cObservacao,cErro,cNome)
Local aAreaAtu:=GetArea()
Local aAreaZC5:=ZC5->(GetArea())

Default cErro:=""
Default cNome:=""                                                      
//Default aDadosCli:={}

cCadastro:=Padr(cCadastro,AvSx3("ZC5_CODCIA",3))
ZC5->(DbSetOrder(3))//ZC5_FILIAL+ZC5_CADAST+ZC5_CODCIA
If !ZC5->(DbSeek(xFilial("ZC5")+cCadastro+cCodCad))
	ZC5->(RecLock("ZC5",.T.))
	ZC5->ZC5_FILIAL:=xFilial("ZC5")
	ZC5->ZC5_CADAST:=cCadastro
	ZC5->ZC5_CODCIA:=cCodCad
	ZC5->ZC5_NOMCIA:=cNome
	ZC5->ZC5_FLAG	:="1"
	ZC5->(MsUnLock())
EndIf
U_NCECOM09(0,"",cAcao,cObservacao+CRLF+cErro,,!Empty(cErro),cCodCad,cCadastro)

RestArea(aAreaZC5)
RestArea(aAreaAtu)
Return
