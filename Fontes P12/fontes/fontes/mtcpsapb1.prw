#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"

//----------------------------------------------------------------------------------------------------------------//
// Exportacao de dados para arquivo csv.
// Utilizado para integração do cadastro de produtos do sistema Protheus para o sistema SAP Business One
// Elaborado por Marcio A. Zechetti 
//----------------------------------------------------------------------------------------------------------------//
User Function MTCPSAPB1()
 
Local oExcel
Local cArq
Local nArq
Local cPath
Local cQrySb1 := ""
Local QuerySB1 := ""
Local lAuto := IIF(Select("SM0") > 0, .f., .t.)

IF lAuto
	QOUT("Preparando Environment ... "+dtoc(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SB1,SB2,SA1,SA2,SC5,SC6,SC9,SD2,SF2,SF1,SD1,SF4'
	dDtAtu	:= ddatabase
ENDIF
  
cArq  := "Produto_Protheus_SAPB1"
cPath := "\\192.168.0.200\D$\Integracao\"
nArq  := FCreate(cPath + cArq + ".CSV")
 
If nArq == -1
 MsgAlert("Nao conseguiu criar o arquivo!")
 Return
EndIf
 
FWrite(nArq, "ItemCode;ItemName;ForeignName;MaterialType;SalesUnit;PurchaseUnit;U_MCG_PUBLISH;U_MCG_CODBARV;U_MCG_STACMLD;U_MCG_ECIV;U_MCG_OLD;U_MCG_ITEMCC;U_MCG_GROUP;U_MCG_PLATAF;U_MCG_PLATEXT;BarCode;PurchaseUnitWeight;SalesUnitWeight;U_MCG_STACML;U_MCG_PESBRU;U_MCG_DESCPAI;U_MCG_LANC;U_MCG_CC;U_MCG_FABRIC" + Chr(13) + Chr(10)) 
FWrite(nArq, "ItemCode;ItemName;ForeignName;MaterialType;SalesUnit;PurchaseUnit;U_MCG_PUBLISH;U_MCG_CODBARV;U_MCG_STACMLD;U_MCG_ECIV;U_MCG_OLD;U_MCG_ITEMCC;U_MCG_GROUP;U_MCG_PLATAF;U_MCG_PLATEXT;Barcode;BWeight1;SWeight1;U_MCG_STACML;U_MCG_PESBRU;U_MCG_DESCPAI;U_MCG_LANC;U_MCG_CC;U_MCG_FABRIC" + Chr(13) + Chr(10))  

dbSelectArea("SB1") 
cQrySb1 := " SELECT * FROM "+RetSqlName("SB1")
cQrySb1 += " WHERE B1_TIPO = 'PA' AND "
cQrySb1 += " (B1_INTEGRA = 'N' OR B1_INTEGRA = '') AND "
cQrySb1 += " D_E_L_E_T_ <> '*' "
cQrySb1 += " ORDER BY B1_COD "


TcQuery cQrySb1 Alias "TSB1" New
DbSelectArea("TSB1")

While !(Eof())   
 FWrite(nArq, TSB1->B1_COD + ";" + TSB1->B1_XDESC + ";" + TSB1->B1_DESC + ";" + "1" + ";" + ;
              TSB1->B1_UMMIAMI + ";" + TSB1->B1_UMMIAMI + ";" + TSB1->B1_PUBLISH + ";" + ; 
              TSB1->B1_CODBARV + ";" + TSB1->B1_STACMLD + ";" + TSB1->B1_ECIV + ";" + ;
              TSB1->B1_OLD + ";" + TSB1->B1_ITEMCC + ";" + TSB1->B1_GRUPO + ";" + ; 
              TSB1->B1_PLATAF + ";" + TSB1->B1_PLATEXT + ";" + TSB1->B1_CODBAR + ";" + REPLACE(STR(round(TSB1->B1_PESO/0.4536,2)),",",".") + ";" + ;
              REPLACE(STR(round(TSB1->B1_PESO/0.4536,2)),",",".") + ";" + TSB1->B1_STACML + ";" + REPLACE(STR(TSB1->B1_PESBRU),",",".") + ";" + ;
              substr(Posicione("SYA",1,xFilial("SYA")+TSB1->B1_PAISPRO,"YA_DESCR"),1,20) + ";" + TSB1->B1_LANC + ";" + TSB1->B1_CC + ";" + TSB1->B1_FABRIC + Chr(13) + Chr(10))
              

 dbSelectArea("SB1")
 DbSeek(xFilial()+TSB1->B1_COD)
 If !Eof() 
    RecLock("SB1",.F.)
    SB1->B1_INTEGRA := "S"  
    MsUnLock() 
 EndIf
 
 DbSelectArea("TSB1") 
 TSB1->(dbSkip())
End

FClose(nArq)

TSB1->(DbCloseArea()) 
SB1->(DbCloseArea()) 
 
/*oExcel := MSExcel():New()
oExcel:WorkBooks:Open(cPath + cArq + ".CSV")
oExcel:SetVisible(.T.)
oExcel:Destroy()
 
FErase(cPath + cArq + ".CSV")*/
 
Return