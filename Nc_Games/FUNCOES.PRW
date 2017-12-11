#include 'protheus.ch'
#include 'parmtype.ch'
#include 'fwmvcdef.ch'

CLASS FuncoesDiversas
    Data cEmail
    Data cHtml
    Data cErroEmail
    Data oExcel
    Data cNomeExcel
    Data cNomeTab

    Method New() Constructor
    Method retornaEmailVendedorPedido(cNumPV)
    Method getHtml()
    Method setHtml(cHtm)
    Method enviaEmail()
    Method getErro()
    Method executaQuery(cQuery, cTipo)
    MEthod getNomeExcel()
    Method setNomeExcel(cNome)
    MEthod getNomeTabela()
    Method setNomeTabela(cNome)
    Method criaExcelSimples(aCabeca, aDados)

EndClass

Method New() Class FuncoesDiversas
    Self:cEmail := ""
    Self:cHtml := ""
    Self:cErroEmail :=""
Return

Method getHtml() Class FuncoesDiversas
return Self:cHtml 

Method setHtml(cHtm) Class FuncoesDiversas
    Self:cHtml := cHtm
return

Method getErro() Class FuncoesDiversas
Return Self:cErroEmail

Method setNomeExcel(cNome) Class FuncoesDiversas
    Self:cNomeExcel := cNome
return

Method getNomeExcel() Class FuncoesDiversas
Return Self:cNomeExcel

Method setNomeTabela(cNome) Class FuncoesDiversas
    Self:cNomeTab := cNome
return

Method getNomeTabela() Class FuncoesDiversas
Return Self:cNomeTab

Method retornaEmailVendedorPedido(cNumPV) Class FuncoesDiversas
        SC5->(DbSelectArea("SC5"))
		SC5->(DbSetOrder(1))
        
        If SC5->(DbSeek(xFilial("SC5")+cNumPV))
            SA3->(DbSelectArea("SA3"))
            SA3->(DbSetOrder(1))
            If SA3->(DbSeek(xFilial("SA3")+SC5->C5_VEND1))
                    Self:cEmail := AllTrim(SA3->A3_EMAIL)
            EndIf
            SA3->(DbCloseArea("SA3"))
        EndIf
    SC5->(DbCloseArea("SC5"))
    
Return Self:cEmail

Method enviaEmail (cAssunto, aAnexos, cEmailTo, cEmailCc) Class FuncoesDiversas

Local lRetorno	:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Default aAnexos	:= {}
Default cAssunto:= ""
Default cEmailCc:=""

If MailSmtpOn( cServer, cAccount, cPassword ) 
	If lMailAuth
		If ! ( lRetorno := MailAuth(cAccount,cPassword) )
			lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
		EndIf
	Endif
	If lRetorno
		If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,Self:cHtml,aAnexos,.F.)
			Self:cErroEmail := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
			lRetorno := .F.
		EndIf
	Else
		Self:cErroEmail := "Erro na tentativa de autenticação da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	Self:cErroEmail := "Erro na tentativa de conexão com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf

Return lRetorno 

Method executaQuery(cQuery, cTipo) Class FuncoesDiversas
//cRet sempre inicia vazia
Local cRet:=""

If !Empty(cQuery)
	If cTipo == Nil
		cRet := GetNextAlias()
		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cRet,.F.,.F.)
	Else
		If cTipo == "Exec"
			If (TcSqlExec(cQuery)) >= 0
				TcSqlExec("COMMIT")
				cRet := "Ok"
			EndIF
		end If
	Endif
EndIf

Return cRet

Method criaExcelSimples(aCabeca, aDados) Class FuncoesDiversas

Local oExcelApp
Local cTemp := "C:\Relatorios\"
Local bChave

bChave := .T.
	If Self:cNomeExcel != Nil .And. Self:cNomeTab != Nil
		oExcel := FWMSEXCEL():New()
		oExcel:AddWorkSheet(Self:cNomeTab)
		oExcel:AddTable(Self:cNomeTab,Self:cNomeExcel)
		
		
		If ValType(aCabeca) == "A"
			For i:=1 to Len(aCabeca)
			 	If ValType(aCabeca[i]) == "A"
			 		oExcel:AddColumn(Self:cNomeTab,Self:cNomeExcel, aCabeca[i][1],aCabeca[i][2],aCabeca[i][3])			
				Endif
			Next
		else
			bChave := .F.
		End If
		
		If ValType(aDados) == "A"
			For i:=1 to Len(aDados)
			 	If ValType(aDados[i]) == "A"
			 		oExcel:AddRow(Self:cNomeTab,Self:cNomeExcel, aDados[i])			
				Endif
			Next
		else
			bChave := .F.
		End If
		
		oExcel:Activate()
		
		Self:cNomeExcel = Self:cNomeExcel+".xml"
		
		oExcel:GetXMLFile(Self:cNomeExcel)
		
		 CpyS2T("\SYSTEM\"+Self:cNomeExcel, cTemp)
		 If ApOleClient("MSExcel") 
			 oExcelApp := MsExcel():New()
			 oExcelApp:WorkBooks:Open(cTemp+Self:cNomeExcel) // Abre a planilha
			 oExcelApp:SetVisible(.T.)
		 Endif
		 
	End if
	
Retur bChave