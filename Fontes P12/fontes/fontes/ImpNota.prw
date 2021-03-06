
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �         � Autor �                       � Data �           ���
�������������������������������������������������������������������������Ĵ��
���Locacao   �                  �Contato �                                ���
�������������������������������������������������������������������������Ĵ��
���Descricao �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Aplicacao �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  �                                               ���
�������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               ���
���              �  /  /  �                                               ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

User Function impNotaCSV()
Private nCombo1
Private nCombo2
Private aItensOp1:={"","COMPRA","DEVOLU��O"}
Private aItensOp2:={"","DEVOLU��O"}
                                                            

SetPrvt("oDlg1","oSay1","oSay2","oCombo1","oCombo2","oBtn1","oCloseBTN")

oDlg1      := MSDialog():New( 091,232,247,521,"Importa��o de Notas em Excel",,,.F.,,,,,,.T.,,,.T. )
oSay1      := TSay():New( 008,008,{||"Tipo NF:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 028,008,{||"Tipo Fornecedor:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)

oCombo1    := TComboBox():New( 028,056,{|u| If(PCount()>0,nCombo1:=u,nCombo1)},{"","COMPRA","DEVOLU��O"},072,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCombo1 )
oCombo2    := TComboBox():New( 008,056,{|u| If(PCount()>0,nCombo2:=u,nCombo2)},{"","FORNECEDOR","CLIENTE"},072,010,oDlg1,,{|| iif(nCombo2 == "FORNECEDOR", oCombo1:SetItems(aItensOp1), oCombo1:SetItems(aItensOp2))},,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCombo2 )

oBtn1      := TButton():New( 052,092,"OK",oDlg1,{|| iniProc(), oDlg1:END() },037,012,,,,.T.,,"",,,,.F. )
oCloseBTN  := TButton():New( 052,048,"CANCELAR",oDlg1,{||oDlg1:END()},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)
      

Return                                            


Static Function iniProc()

/*������������������������������������������������������������������������ٱ�
�� Declara��o de cVariable dos componentes                                 ��
ٱ�������������������������������������������������������������������������*/
Private cFornece   := Space(6)
//Private cLocal     := Space(150)
Private cLoja      := Space(2)
Private cNota      := Space(9)
Private cSerie     := Space(3)
Private dEmissao   := CtoD(" ")

/*������������������������������������������������������������������������ٱ�
�� Declara��o de Variaveis Private dos Objetos                             ��
ٱ�������������������������������������������������������������������������*/
//SetPrvt("oDlg1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oNota","oSerie","oEmissao","oFornece")
//SetPrvt("oLocal","oGetArq","oImporta")

SetPrvt("oDlg2","oSay1","oSay2","oSay3","oSay4","oSay5","oNota","oSerie","oEmissao","oFornece")
SetPrvt("oImporta")


/*������������������������������������������������������������������������ٱ�
�� Definicao do Dialog e todos os seus componentes.                        ��
ٱ�������������������������������������������������������������������������*/
oDlg2      := MSDialog():New( 391,450,557,1121,"Importa Notas",,,.F.,,,,,,.T.,,,.T. )
oSay1      := TSay():New( 012,004,{||"Nota Fiscal:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 012,112,{||"S�rie:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay3      := TSay():New( 012,216,{||"Emiss�o:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
//oSay4      := TSay():New( 032,008,{||"Forncedor:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 032,112,{||"Loja:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
//oSay6      := TSay():New( 052,008,{||"Arquivo de Itens:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oNota      := TGet():New( 012,040,{|u| If(PCount()>0,cNota:=u,cNota)},oDlg2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNota",,)
oSerie     := TGet():New( 012,140,{|u| If(PCount()>0,cSerie:=u,cSerie)},oDlg2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cSerie",,)
oEmissao   := TGet():New( 012,252,{|u| If(PCount()>0,dEmissao:=u,dEmissao)},oDlg2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dEmissao",,) 

if nCombo2 == "CLIENTE"                                                                                
oSay4      := TSay():New( 032,008,{||"Cliente:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oFornece   := TGet():New( 032,040,{|u| If(PCount()>0,cFornece:=u,cFornece)},oDlg2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cFornece",,)
else                                                                                                   
oSay4      := TSay():New( 032,008,{||"Forncedor:"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oFornece   := TGet():New( 032,040,{|u| If(PCount()>0,cFornece:=u,cFornece)},oDlg2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","cFornece",,)
ENDIf

oLoja      := TGet():New( 032,140,{|u| If(PCount()>0,cLoja:=u,cLoja)},oDlg2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLoja",,)
//oLocal     := TGet():New( 052,056,{|u| If(PCount()>0,cLocal:=u,cLocal)},oDlg1,144,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLocal",,)
//oGetArq    := TButton():New( 052,208,"Selecionar Arquivo",oDlg1,{|| Import(tipo)},052,012,,,,.T.,,"",,,,.F. )
oImporta   := TButton():New( 052,268,"Importa NF",oDlg2,{|| Processa( {|| GetNota()},"","" ),MsgInfo("Processo finalizada"),oDlg2:END() },037,012,,,,.T.,,"",,,,.F. )

oDlg2:Activate(,,,.T.)

Return


static function GetNota()

local aArea := GetArea()
local aArrayItens :={}
Local aCab :={}
Local aLinha:={}
Local aItemSD1 :={}
Local cBuffer   	:= ""
Local cFileOpen 	:= ""
Local cTitulo1  	:= "Selecione o arquivo"
Local cExtens   	:= "Arquivo csv | *.csv"
Local dirPadr := "C:\notas-a-processar\"        
Local cQuerySB1 := ""
Local cNotProd	:=""
Local cChave :=""
Private lMsErroAuto := .F. //VARIAVEL DE ERRO

cFileOpen := cGetFile ( '*.csv|*.csv' , 'Notas (csv)', 1, dirPadr, .F., GETF_LOCALHARD + GETF_LOCALFLOPPY)
         
If Empty(cFileOpen)                                                                 
   MsgAlert("Nenhum arquivo selecionado! O processo ser� finalizado!","Arquivo Vazio!")
   Return
EndIF
If !File(cFileOpen)
   MsgAlert("Arquivo texto: "+cFileOpen+" n�o localizado!","Arquivo n�o encontrado!")
   Return
Endif

FT_FUSE(cFileOpen)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER

While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	IncProc("Efetuando a leitura do arquivo")

   // Capturar dados
   cBuffer := FT_FREADLN() //LENDO LINHA 
   
   aItens := strtokarr(cBuffer,";")
   
	IF len(aItens) < 12
		alert("Algum dos Campos da Planilha est� em n�o foi preenchido. Favor verificar e reprocessar.")
		return
	else 
		AADD(aArrayItens, aItens)
	EndIF

	FT_FSKIP()   //pr�ximo registro no arquivo txt
	
EndDo

FT_FUSE() //fecha o arquivo txt

IF nCombo1 == "COMPRA"
AAdd(aCab,{"F1_TIPO"	,"N"		   			  			,Nil})
ELSE
AAdd(aCab,{"F1_TIPO"	,"D"		   			  			,Nil})
ENDIF
AAdd(aCab,{"F1_FORMUL"	,"N"    	   		   		,Nil})
AAdd(aCab,{"F1_DOC"		,StrZero(Val(cNota), 9)		,Nil})
AAdd(aCab,{"F1_SERIE"	,cSerie							,Nil})
AAdd(aCab,{"F1_EMISSAO"	, dEmissao						,Nil})
AAdd(aCab,{"F1_FORNECE"	,cFornece						,Nil})
AAdd(aCab,{"F1_LOJA"	,cLoja								,Nil})
AAdd(aCab,{"F1_ESPECIE"	,"SPED"							,Nil})
AAdd(aCab,{"F1_CHVNFE"	,""								,Nil})

ProcRegua(LEN(aArrayItens))
FOR ny := 2 TO LEN(aArrayItens)

IF select("SB1") > 0
     dbCloseArea("SB1")
EndIF
 cQuerySB1 :=  "select B1_COD from "+RetSQLName("SB1")+" where b1_cod = '"+trataTexto(aArrayItens[ny][4])+"'"
 cQuerySB1 := ChangeQuery(cQuerySB1)
 dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySB1),"SB1",.T.,.T.)

 IF(Empty(SB1->B1_COD))
	 cNotProd+= "Item: "+aArrayItens[ny][1]+" C�d.:"+ aArrayItens[ny][4]+ "-"	+aArrayItens[ny][5]+CRLF
 EndIf 
 dbCloseArea("SB1")
 
next   
IF(!cNotProd =="")
	alert("Os seguintes produtos n�o forma encontrados no cadastro de produtos:"+CRLF+cNotProd)  
	return
EndIf

FOR ny := 2 TO LEN(aArrayItens)
	IncProc("Processando os dados...")
	AAdd(aLinha,{"D1_ITEM"		, trataTexto(aArrayItens[ny][1])	         					,".T."})
	AAdd(aLinha,{"D1_COD"		, trataTexto(aArrayItens[ny][4])      							,".T."})
	AAdd(aLinha,{"D1_UM"		, "UN" 															,".T."})
	AAdd(aLinha,{"D1_SEGUM"		, "UN" 															,".T."})
	AAdd(aLinha,{"D1_QUANT"		, NCONVVAL(aArrayItens[ny][6])  								,".T."})
	AAdd(aLinha,{"D1_VUNIT"		, NCONVVAL(aArrayItens[ny][7]) 									,".T."})
	AAdd(aLinha,{"D1_TOTAL"		, NCONVVAL(aArrayItens[ny][6]) * NCONVVAL(aArrayItens[ny][7]) 	,".T."})
	AAdd(aLinha,{"D1_TES"		, trataTexto(aArrayItens[nY][9])								,".T."})
	AAdd(aLinha,{"D1_LOCAL"		, strZero( val(trataTexto(aArrayItens[nY][10]))	,2)				,".T."})  
	AAdd(aLinha,{"D1_NFORI"		, trataTexto(aArrayItens[nY][11])								,".T."})  
	AAdd(aLinha,{"D1_SERIORI"	, trataTexto(aArrayItens[nY][12])								,".T."})  
	AAdd(aItemSD1,aLinha)
	aLinha:={}
next

MSExecAuto({|x,y,z| MATA140(x,y,z)}, aCab, aItemSD1,3)

If lMsErroAuto
	
	MostraErro()
	RETURN
EndIf

if select("SD1") > 0
     DBCLOSEAREA("SD1")
ENDIF

	dbSelectArea("SD1")
	DbSetOrder(1)
	
	FOR ny := 2 TO LEN(aArrayItens)  
			
			
			cChave:= (xFilial("SD1")+StrZero(Val(cNota), 9)+ cSerie + cFornece + cLoja + PADR( trataTexto(aArrayItens[ny][4]),TamSx3("D1_COD")[1],' ') + PADR( trataTexto(aArrayItens[ny][1]),TamSx3("D1_ITEM")[1],' ' ) )
		    
		    if dbSeek(cChave)
				RECLOCK("SD1", .F.) 
			    SD1->D1_TES 		:= trataTexto(aArrayItens[nY][9])
			    SD1->D1_NFORI 		:= trataTexto(aArrayItens[nY][11])
    		  	SD1->D1_SERIORI 	:= trataTexto(aArrayItens[nY][12])
    		  	SD1->D1_LOCAL		:= strZero( VAL(SD1->D1_LOCAL),2)
    		  	SD1->( dbSkip() )
    		  	MSUNLOCK("SD1") 
		    endIf                                                  
			
	   Next
	   
	   if select("SD1") > 0
     			DBCLOSEAREA("SD1")
			ENDIF
RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCONVVAL �Autor  �Microsiga           � Data � 07/04/15    ���
�������������������������������������������������������������������������͹��
���Desc.     �Retira pontua��o do CNPJ           ���
���          �                   ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCONVVAL(cValor)

Local aArea  := GetArea()
Local nRet  := ""
Local cValorAux := ""

Default cValor := ""

cValorAux := STRTRAN(cValor,"R$","")
cValorAux := STRTRAN(cValorAux,".","")
cValorAux := STRTRAN(cValorAux,",",".")

nRet := Val(cValorAux)

RestArea(aArea)
Return nRet
Static Function trataTexto(cString)
Local aArea := GetArea()
Local cRet := ""
Local cTexto := ""

cTexto := alltrim(cString)
cTexto := STRTRAN(cTexto,"$","")
cTexto := STRTRAN(cTexto,"�","")
cTexto := STRTRAN(cTexto,".","")
cTexto := STRTRAN(cTexto,",","")
cTexto := STRTRAN(cTexto,";","")
cTexto := STRTRAN(cTexto,"'","")
cTexto := STRTRAN(cTexto,"!","")
cTexto := STRTRAN(cTexto,"@","")
cTexto := STRTRAN(cTexto,"#","")
cTexto := STRTRAN(cTexto,"%","")
cTexto := STRTRAN(cTexto,"%","")
cTexto := STRTRAN(cTexto,"�","")
cTexto := STRTRAN(cTexto,"&","")
cTexto := STRTRAN(cTexto,"*","")
cTexto := STRTRAN(cTexto,"(","")
cTexto := STRTRAN(cTexto,")","")
cTexto := STRTRAN(cTexto,"-","")
cTexto := STRTRAN(cTexto,"_","")
cTexto := STRTRAN(cTexto,"+","")
cTexto := STRTRAN(cTexto,"=","")
cTexto := STRTRAN(cTexto,"|","")
cTexto := STRTRAN(cTexto,"\","")
cTexto := STRTRAN(cTexto,"/","")
cTexto := STRTRAN(cTexto,"?","")
cTexto := STRTRAN(cTexto,"�","")
cTexto := STRTRAN(cTexto,"^","")
cTexto := STRTRAN(cTexto,"~","")
cTexto := STRTRAN(cTexto,"{","")
cTexto := STRTRAN(cTexto,"}","")
cTexto := STRTRAN(cTexto,"[","")
cTexto := STRTRAN(cTexto,"]","")
cTexto := STRTRAN(cTexto,":","")
cTexto := STRTRAN(cTexto,'"','')

cRet := cTexto
                        
RestArea(aArea)
Return cRet

