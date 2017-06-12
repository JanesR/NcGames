#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCWEBM01(cMensagem)
Local aAreaAtu		:=GetArea()
Local aAreaSB1		:=SB1->(GetArea())
Local cParametros	:=""
Local cUser			:=Alltrim(U_MyNewSX6("WM_NCG0000","PROTHEUS" ,"C","Usuario Autenticacao WebManager","","",.F. ))
Local cPassword	:=Alltrim(U_MyNewSX6("WM_NCG0001","PROTHEUS" ,"C","Senha Autenticacao WebManager","","",.F. ))
Local cCodProduto:=""
Local aProdutos	:={}
Local oSite
Local nInd
Local lTemUsado:=.F.
Local lUsado
Local cDescricao
Local cPathLog:="\Logs\WebManager\Produtos\"+AllTrim(SB1->B1_COD)+"\"
Local nHandle 
Local cNomeLog:=Dtos(MsDate() )+StrTran(Time(),":","")+".txt"
Local cRetorno:=""
Local cMensLog:=""
Local cToken:=""
Default cMensagem	:=""


If !ExistDir(cPathLog)
	MakeDir(cPathLog)
EndIf
nHandle:= FCreate(cPathLog+cNomeLog)

WEB01Write("Inicio Enviar Produto para o WebManager(NCWEBM01)-"+Time()+CRLF,nHandle)

cMensagem:=""            

oSite:=ApiWebManager():New()

If Empty(SB1->B1_XCODUSA) .And. SB1->B1_SBCATEG $"AA*UB" .And. SB1->B1_XUSADO<>"1"   //Jogos / Acessorios  Cria Usado	
	WEB01CriaUsa(nHandle) 
EndIf

If !Empty(SB1->B1_XCODUSA)
	If !Empty(cCodCliProd:=GetWMProd(oSite,SB1->B1_XCODUSA,SB1->B1_XCODUSA,.T.,cUser,cPassword))
		cMensagem+="Produto Usado:"+SB1->B1_XCODUSA+Space(1)+AllTrim(SB1->B1_XDESC)+" já cadastrado.Codigo WM ="+cCodCliProd+CRLF
	Else
		AADD(aProdutos,SB1->B1_XCODUSA)//Produto Usado		
	EndIf

EndIf                                         

If !Empty(cCodCliProd:=GetWMProd(oSite,AllTrim(SB1->B1_CODBAR),SB1->B1_COD,.F.,cUser,cPassword))
	cMensagem+="Produto:"+SB1->B1_COD+Space(1)+AllTrim(SB1->B1_XDESC)+" já cadastrado.Codigo WM ="+cCodCliProd+CRLF
Else
	AADD(aProdutos,SB1->B1_COD)
EndIf

SB1->(DbSetOrder(1))

For nInd:=1 To Len(aProdutos)
	
	SB1->(MsSeek(xFilial("SB1")+aProdutos[nInd]))
	
	oSite:cParametros:='?Usuario='+cUser+'&Senha='+cPassword 
	oSite:NextCodigo()
	cCodProduto:=oSite:cResponse
	lUsado:=(SB1->B1_XUSADO=="1")
	
	//Exemplo via URL: http://www.wm10.com.br/uzgames_matriz/Protheus/integracao_produto.asp?Usuario=teste&senha=password&Cod_produto=12345&Cod_barra=7895487896325 ...
	cParametros:='?'
	cParametros+='Usuario='+cUser  											//String 22
	cParametros+='&Senha='+cPassword  										//String 50
	
	
	
	cParametros+='&Cod_produto='	+cCodProduto  					//Numérico 15,0
	cParametros+='&Cod_barra='+	Iif(lUsado,Trim(SB1->B1_COD),AllTrim(SB1->B1_CODBAR))						//String 40
	cDescricao:=FwNoAccent(AllTrim(SB1->B1_APLICAB)+IIf(lUsado,"U","")+Space(1)+AllTrim(Posicione("SB5",1,xFilial("SB5")+SB1->B1_COD,"B5_CEME")))
	
	cMensLog+="Produto:"+cCodProduto+Space(1)+cDescricao+CRLF
	
	cParametros+='&Altura='			+AllTrim(Transform(SB1->B1_ALT     ,"@E 99,999.99"))	  		//Numérico 8,2
	cParametros+='&Comprimento='	+AllTrim(Transform(SB1->B1_PROF	   ,"@E 99,999.99"))			//Numérico 8,2
	cParametros+='&Largura='		+AllTrim(Transform(SB1->B1_LARGURA ,"@E 99999.99"))			//Numérico 8,2
	cParametros+='&Peso='			+AllTrim(Transform(SB1->B1_PESO    ,"@E 999.9999"))			//Numérico 8,4
	cParametros+='&Nome='			+StrTran( EnCodeUtf8(AllTrim(cDescricao)),Space(1),"%20") //String 100
	cParametros+='&Nome_internet='+StrTran( EnCodeUtf8(AllTrim(cDescricao)),Space(1),"%20") //String 150
	
	If (lUsado) .Or. Empty(SB1->B1_XCODUSA) // produto usado
		cParametros+='&Cod_produto_usado=0' 							//Numérico 15,0
		cMensLog+="Cod_produto_usado=0"+cCodProduto+CRLF
	ElseIf !Empty(SB1->B1_XCODUSA)
		cParametros+='&Cod_produto_usado='+AllTrim(GetWMProd(oSite,SB1->B1_XCODUSA,SB1->B1_XCODUSA,.T.,cUser,cPassword))
		cMensLog+='Cod_produto_usado='+AllTrim(GetWMProd(oSite,SB1->B1_XCODUSA,SB1->B1_XCODUSA,.T.,cUser,cPassword))+CRLF
	EndIf                                                            
	
	cParametros+='&Cod_categoria='				+GetCategoria(AllTrim(SB1->B1_SBCATEG),lUsado) 	 	//Numérico 8,0
	cMensLog+="Cod_categoria Protheus="+AllTrim(SB1->B1_SBCATEG)+" WM ="+GetCategoria(AllTrim(SB1->B1_SBCATEG),lUsado,@cToken)+Space(1)+AvSx3("B1_SBCATEG",5)+CRLF
	
	//cParametros+='&Cod_subcategoria1='  		+GetSubCategoria(SB1->B1_GRUPO,lUsado) 	 	//Numérico 8,0
	cParametros+='&Cod_classificacao_fiscal='	+Iif(lUsado,"67",GetNCM(SB1->B1_POSIPI))  			//Numérico 8,0     
	cMensLog+="Cod_classificacao_fiscal Protheus="+AllTrim(SB1->B1_POSIPI)+" WM ="+Iif(lUsado,"67",GetNCM(SB1->B1_POSIPI,@cToken))+Space(1)+AvSx3("B1_POSIPI",5)+CRLF
	
	cParametros+='&Cod_material='					+GetMaterial(SB1->B1_ITEMCC)		//Numérico 8,0
	cMensLog+="Cod_material Protheus="+AllTrim(SB1->B1_ITEMCC)+" WM ="+GetMaterial(SB1->B1_ITEMCC,@cToken)+cToken+Space(1)+AvSx3("B1_ITEMCC",5)+CRLF
	
	cParametros+='&Cod_forma='						+GetForma(SB1->B1_CODGEN,lUsado)  			//Numérico 8,0
	cMensLog+="Cod_forma Protheus="+AllTrim(SB1->B1_CODGEN)+" WM ="+GetForma(SB1->B1_CODGEN,lUsado,@cToken)+cToken+Space(1)+AvSx3("B1_CODGEN",5)+CRLF
	
	
	cParametros+='&Cod_unidade='					+GetUnidade(SB1->B1_UM)  		//Numérico 8,0
	cMensLog+="Cod_unidade="+AllTrim(SB1->B1_UM)+" WM ="+GetUnidade(SB1->B1_UM)+CRLF
		
	cParametros+='&Ativo_internet=0'  										//Booleano 1
	cParametros+='&disponivel_venda=1'  									//Booleano 1
	
	If lUsado  // produto usado
		cParametros+='&Produto_usado=1' 			 								//Booleano 1
	Else
		cParametros+='&Produto_usado=0' 			 								//Booleano 1
	EndIf
	
	cParametros+='&Preco_venda='+AllTrim(Transform(SB1->B1_CONSUMI    ,"@E 999,999,999.99")) 										//Numérico 8,2
	cParametros+='&ID_ERP_Protheus='+SB1->B1_COD
	cMensLog+=CRLF
	
	//cParametros+='&Cod_faixa_etaria='  									//Numérico 8,0
	//cParametros+='&Restricao_indicativa='  								//String 1000
	//cParametros+='&Garantia='  												//Numérico 8,0
	//cParametros+='&data_lancamento='  									//Data	10
	oSite:cParametros:=""
	oSite:cParametros:=cParametros
	oSite:AddProd()
	cRetorno:=AllTrim(SB1->B1_COD)+"-"+oSite:cResponse+CRLF
	cMensagem+=cRetorno
	If oSite:cResponse$"Produto cadastrado com sucesso."
		U_NCGRAVASA7("000000","01",cCodProduto,SB1->B1_DESC,SB1->B1_COD)		
		U_PR117Copia(.F.)//Copiar para empresas NcGames
	ElseIf lUsado
		cMensagem+="Erro na gravaçao do produto usado, gravacao do produto anulado."+CRLF
		Exit		
	EndIf	
Next

cMensagem+="*****************Campos Obrigatorios****************************"+CRLF
cMensagem+=cMensLog			
         

RestArea(aAreaSB1)
RestArea(aAreaAtu)

WEB01Write("Mensagem Retorno WM:"+cRetorno+CRLF,nHandle)
WEB01Write("*****************Campos Obrigatorios****************************"+CRLF+AllTrim(cMensLog)+CRLF+"****************************************************************"+CRLF,nHandle)


WEB01Write("Fim Enviar Produto para o WebManager(NCWEBM01)-"+Time()+CRLF,nHandle)

If nHandle>0
	FClose(nHandle)
EndIf	

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCategoria(cCodigo,lUsado,cToken)
Local aDados  :={}
Local cRetorno:=""

Default cToken:=""
 

AADD(aDados,{'98','0062 '})
AADD(aDados,{'AA','0041'})
AADD(aDados,{'AB','0030'})
AADD(aDados,{'AC','0059'})
AADD(aDados,{'AD','0063'})
AADD(aDados,{'AE','0064'})
AADD(aDados,{'BA','0044'})
AADD(aDados,{'BB','0043'})
AADD(aDados,{'BC','0060'})
AADD(aDados,{'UA','0055'})
AADD(aDados,{'UB','0042'})
AADD(aDados,{'UC','0054'})
AADD(aDados,{'UD','0045'})
AADD(aDados,{'UE','0015'})
AADD(aDados,{'UF','0048'})
AADD(aDados,{'UG','0065'})
AADD(aDados,{'UH','0061'})
AADD(aDados,{'UI','0066'})
AADD(aDados,{'UJ','0039'})
AADD(aDados,{'UK','0067'})
AADD(aDados,{'UL','0068'})
AADD(aDados,{'UX','0056'})
AADD(aDados,{'XW','0057'})
AADD(aDados,{'XX','0053'})
AADD(aDados,{'XZ','0058'})



If (nAscan:=Ascan( aDados,{|a| AllTrim(Upper(a[1]))==AllTrim(Upper(cCodigo))}    )  )>0
	cRetorno:=aDados[nAscan,2]
EndIf   

cToken:=""
If Empty(cRetorno)
	cToken:="Vazio<======================="
EndIf	

Return cRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetSubCategoria(cCodigo,cToken)
Local aDados  :={}
Local cRetorno:=""
Default cToken:=""

AADD(aDados,{'AA01','0467'})
AADD(aDados,{'AA02','0466'})
AADD(aDados,{'AA05','0328'})
AADD(aDados,{'AA06','0468'})
AADD(aDados,{'AA10','0322'})
AADD(aDados,{'AA11','0469'})
AADD(aDados,{'AA12','0470'})
AADD(aDados,{'AA13','0315'})
AADD(aDados,{'AA14','0314'})
AADD(aDados,{'AA15','0327'})
AADD(aDados,{'AA20','0326'})
AADD(aDados,{'AA21','0316'})
AADD(aDados,{'AA22','0311'})
AADD(aDados,{'AA23','0318'})
AADD(aDados,{'AA24','0408'})
AADD(aDados,{'AA30','0312'})
AADD(aDados,{'AA31','0410'})
AADD(aDados,{'AB01','0471'})
AADD(aDados,{'AB02','0472'})
AADD(aDados,{'AB05','0473'})
AADD(aDados,{'AB06','0474'})
AADD(aDados,{'AB10','0353'})
AADD(aDados,{'AB11','0475'})
AADD(aDados,{'AB12','0476'})
AADD(aDados,{'AB13','0222'})
AADD(aDados,{'AB14','0221'})
AADD(aDados,{'AB15','0309'})
AADD(aDados,{'AB20','0332'})
AADD(aDados,{'AB21','0313'})
AADD(aDados,{'AB22','0224'})
AADD(aDados,{'AB23','0323'})
AADD(aDados,{'AB24','0416'})
AADD(aDados,{'AB30','0223'})
AADD(aDados,{'AB31','0420'})
AADD(aDados,{'AC01','0477'})
AADD(aDados,{'AC02','0478'})
AADD(aDados,{'AC05','0479'})
AADD(aDados,{'AC06','0480'})
AADD(aDados,{'AC10','0481'})
AADD(aDados,{'AC11','0482'})
AADD(aDados,{'AC12','0483'})
AADD(aDados,{'AC13','0484'})
AADD(aDados,{'AC14','0485'})
AADD(aDados,{'AC15','0486'})
AADD(aDados,{'AC20','0487'})
AADD(aDados,{'AC21','0488'})
AADD(aDados,{'AC22','0489'})
AADD(aDados,{'AC23','0490'})
AADD(aDados,{'AC24','0491'})
AADD(aDados,{'AC30','0492'})
AADD(aDados,{'AC31','0493'})
AADD(aDados,{'BA01','0494'})
AADD(aDados,{'BB01','0495'})
AADD(aDados,{'BC01','0496'})
AADD(aDados,{'UA01','0497'})
AADD(aDados,{'UB01','0498'})
AADD(aDados,{'UB02','0499'})
AADD(aDados,{'UB05','0363'})
AADD(aDados,{'UB06','0500'})
AADD(aDados,{'UB10','0344'})
AADD(aDados,{'UB11','0501'})
AADD(aDados,{'UB12','0502'})
AADD(aDados,{'UB13','0342'})
AADD(aDados,{'UB14','0346'})
AADD(aDados,{'UB15','0349'})
AADD(aDados,{'UB20','0343'})
AADD(aDados,{'UB21','0347'})
AADD(aDados,{'UB22','0338'})
AADD(aDados,{'UB23','0348'})
AADD(aDados,{'UB24','0414'})
AADD(aDados,{'UB30','0345'})
AADD(aDados,{'UB31','0412'})
AADD(aDados,{'UC01','0503'})
AADD(aDados,{'UD01','0504'})

If (nAscan:=Ascan( aDados,{|a| AllTrim(Upper(a[1]))==AllTrim(Upper(cCodigo))}    )  )>0
	cRetorno:=aDados[nAscan,2]
EndIf

cToken:=""
If Empty(cRetorno)
	cToken:="Vazio<======================="
EndIf	


Return cRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetNCM(cCodigo,cToken) //10001000
Local aDados  :={}
Local cRetorno:="66"
Default cToken:=""

AADD(aDados,{' Indefinido','1'})
AADD(aDados,{'8733019','148'})
AADD(aDados,{'30003000','68'})
AADD(aDados,{'34029090','15'})
AADD(aDados,{'34070010','156'})
AADD(aDados,{'35069120','135'})
AADD(aDados,{'39049000','69'})
AADD(aDados,{'39199000','101'})
AADD(aDados,{'39202090','127'})
AADD(aDados,{'39211900','139'})
AADD(aDados,{'39231090','168'})
AADD(aDados,{'39232990','43'})
AADD(aDados,{'39239000','70'})
AADD(aDados,{'39261000','19'})
AADD(aDados,{'39264000','95'})
AADD(aDados,{'39269090','54'})
AADD(aDados,{'40070019','155'})
AADD(aDados,{'40161090','143'})
AADD(aDados,{'40169590','163'})
AADD(aDados,{'40169990','25'})
AADD(aDados,{'42021210','71'})
AADD(aDados,{'42021220','55'})
AADD(aDados,{'42021900','72'})
AADD(aDados,{'42022210','116'})
AADD(aDados,{'42022220','113'})
AADD(aDados,{'42022900','20'})
AADD(aDados,{'42023200','90'})
AADD(aDados,{'42023900','144'})
AADD(aDados,{'42029200','39'})
AADD(aDados,{'42029900','10'})
AADD(aDados,{'47071000','151'})
AADD(aDados,{'48114110','47'})
AADD(aDados,{'49019900','122'})
AADD(aDados,{'49029000','73'})
AADD(aDados,{'49111010','18'})
AADD(aDados,{'49111090','74'})
AADD(aDados,{'49119900','37'})
AADD(aDados,{'61082100','134'})
AADD(aDados,{'61091000','75'})
AADD(aDados,{'61099100','76'})
AADD(aDados,{'63049900','102'})
AADD(aDados,{'63101000','146'})
AADD(aDados,{'65050011','152'})
AADD(aDados,{'65050012','153'})
AADD(aDados,{'65050019','154'})
AADD(aDados,{'69149000','160'})
AADD(aDados,{'73269090','35'})
AADD(aDados,{'84713012','45'})
AADD(aDados,{'84714110','91'})
AADD(aDados,{'84714190','132'})
AADD(aDados,{'84714190','133'})
AADD(aDados,{'84714900','77'})
AADD(aDados,{'84715010','100'})
AADD(aDados,{'84716052','42'})
AADD(aDados,{'84716053','60'})
AADD(aDados,{'84716059','29'})
AADD(aDados,{'84718000','140'})
AADD(aDados,{'84719019','131'})
AADD(aDados,{'84735090','129'})
AADD(aDados,{'85041091','32'})
AADD(aDados,{'85044010','51'})
AADD(aDados,{'85044030','78'})
AADD(aDados,{'85044090','11'})
AADD(aDados,{'85051990','164'})
AADD(aDados,{'85061010','7'})
AADD(aDados,{'85061020','125'})
AADD(aDados,{'85073019','62'})
AADD(aDados,{'85074000','126'})
AADD(aDados,{'85075000','169'})
AADD(aDados,{'85078000','8'})
AADD(aDados,{'85171231','94'})
AADD(aDados,{'85176241','137'})
AADD(aDados,{'85176299','142'})
AADD(aDados,{'85177099','136'})
AADD(aDados,{'85182100','115'})
AADD(aDados,{'85182200','79'})
AADD(aDados,{'85182900','59'})
AADD(aDados,{'85183000','24'})
AADD(aDados,{'85184000','149'})
AADD(aDados,{'85185000','105'})
AADD(aDados,{'85198190','121'})
AADD(aDados,{'85219090','3'})
AADD(aDados,{'85219290','80'})
AADD(aDados,{'85224022','17'})
AADD(aDados,{'85229090','167'})
AADD(aDados,{'85231190','27'})
AADD(aDados,{'85233511','28'})
AADD(aDados,{'85234011','61'})
AADD(aDados,{'85234990','66'})
AADD(aDados,{'85234990','41'})
AADD(aDados,{'85234990','67'})
AADD(aDados,{'85234990','93'})
AADD(aDados,{'85234990','1'})
AADD(aDados,{'85234990','40'})
AADD(aDados,{'85234990','112'})
AADD(aDados,{'85235110','58'})
AADD(aDados,{'85235190','31'})
AADD(aDados,{'85235990','81'})
AADD(aDados,{'85238000','46'})
AADD(aDados,{'85243100','57'})
AADD(aDados,{'85243900','38'})
AADD(aDados,{'85254011','49'})
AADD(aDados,{'85254090','34'})
AADD(aDados,{'85258019','104'})
AADD(aDados,{'85258029','50'})
AADD(aDados,{'85264029','82'})
AADD(aDados,{'85269200','16'})
AADD(aDados,{'85271390','6'})
AADD(aDados,{'85279200','159'})
AADD(aDados,{'85287119','147'})
AADD(aDados,{'85363000','130'})
AADD(aDados,{'85366990','128'})
AADD(aDados,{'85369090','83'})
AADD(aDados,{'85372090','117'})
AADD(aDados,{'85437099','48'})
AADD(aDados,{'85442000','13'})
AADD(aDados,{'85444100','161'})
AADD(aDados,{'85444200','14'})
AADD(aDados,{'85444200','109'})
AADD(aDados,{'85444290','120'})
AADD(aDados,{'85444900','23'})
AADD(aDados,{'85447010','84'})
AADD(aDados,{'85447010','110'})
AADD(aDados,{'85447090','85'})
AADD(aDados,{'85716052','86'})
AADD(aDados,{'85716053','22'})
AADD(aDados,{'87089990','118'})
AADD(aDados,{'90291090','87'})
AADD(aDados,{'90328911','88'})
AADD(aDados,{'94017900','106'})
AADD(aDados,{'94019090','107'})
AADD(aDados,{'94037000','162'})
AADD(aDados,{'94044000','4'})
AADD(aDados,{'94051099','89'})
AADD(aDados,{'94056000','158'})
AADD(aDados,{'95021090','12'})
AADD(aDados,{'95030010','123'})
AADD(aDados,{'95030022','36'})
AADD(aDados,{'95030022','124'})
AADD(aDados,{'95030031','141'})
AADD(aDados,{'95030039','44'})
AADD(aDados,{'95030060','165'})
AADD(aDados,{'95030080','114'})
AADD(aDados,{'95030097','92'})
AADD(aDados,{'95030098','145'})
AADD(aDados,{'95030099','9'})
AADD(aDados,{'95041009','52'})
AADD(aDados,{'95041090','56'})
AADD(aDados,{'95041091','33'})
AADD(aDados,{'95041091','108'})
AADD(aDados,{'95041099','21'})
AADD(aDados,{'95041099','138'})
AADD(aDados,{'95044000','5'})
AADD(aDados,{'95045000','30'})
AADD(aDados,{'95045000','111'})
AADD(aDados,{'95049090','26'})
AADD(aDados,{'95049090','150'})
AADD(aDados,{'95055900','157'})
AADD(aDados,{'95059090','53'})
AADD(aDados,{'96062200','166'})
AADD(aDados,{'99000642','170'})
AADD(aDados,{'99999999','119'})



If (nAscan:=Ascan( aDados,{|a| AllTrim(Upper(a[1]))==AllTrim(Upper(cCodigo))}    )  )>0
	cRetorno:=aDados[nAscan,2]
EndIf

cToken:=""
If Empty(cRetorno)
	cToken:="Vazio<======================="
EndIf	

Return cRetorno



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetMaterial(cCodigo,cToken)
Local cRetorno	:="188"
Local aDados	:={}
Default cToken:=""

AADD(aDados,{'1111','152'})
AADD(aDados,{'1112','17'})
AADD(aDados,{'1113','104'})
AADD(aDados,{'1114','104'})
AADD(aDados,{'1115','104'})
AADD(aDados,{'1116','104'})
AADD(aDados,{'1117','68'})
AADD(aDados,{'1118','139'})
AADD(aDados,{'1119','139'})
AADD(aDados,{'1121','190'})
AADD(aDados,{'1122','190'})
AADD(aDados,{'1123','137'})
AADD(aDados,{'1124','137'})
AADD(aDados,{'1125','402'})
AADD(aDados,{'1126','402'})
AADD(aDados,{'1127','142'})
AADD(aDados,{'1128','219'})
AADD(aDados,{'1131','80'})
AADD(aDados,{'1132','27'})
AADD(aDados,{'1133','27'})
AADD(aDados,{'1134','27'})
AADD(aDados,{'1135','383'})
AADD(aDados,{'1136','286'})
AADD(aDados,{'1139','123'})
AADD(aDados,{'1211','177'})
AADD(aDados,{'1212','199'})
AADD(aDados,{'1213','207'})
AADD(aDados,{'1214','207'})
AADD(aDados,{'1215','241'})
AADD(aDados,{'1216','241'})
AADD(aDados,{'1218','248'})
AADD(aDados,{'1219','194'})
AADD(aDados,{'1220','34'})
AADD(aDados,{'1221','191'})
AADD(aDados,{'1222','21'})
AADD(aDados,{'1223','21'})
AADD(aDados,{'1224','21'})
AADD(aDados,{'1225','162'})
AADD(aDados,{'1226','151'})
AADD(aDados,{'1227','271'})
AADD(aDados,{'1228','40'})
AADD(aDados,{'1229','4'})
AADD(aDados,{'1230','4'})
AADD(aDados,{'1231','132'})
AADD(aDados,{'1232','132'})
AADD(aDados,{'1233','155'})
AADD(aDados,{'1234','134'})
AADD(aDados,{'1311','131'})
AADD(aDados,{'1312','131'})
AADD(aDados,{'1313','238'})
AADD(aDados,{'1314','229'})
AADD(aDados,{'1315','359'})
AADD(aDados,{'1316','32'})
AADD(aDados,{'1317','32'})
AADD(aDados,{'1318','205'})
AADD(aDados,{'1319','20'})
AADD(aDados,{'1320','20'})
AADD(aDados,{'1321','56'})
AADD(aDados,{'1323','56'})
AADD(aDados,{'1415','203'})
AADD(aDados,{'1416','129'})
AADD(aDados,{'1417','96'})
AADD(aDados,{'1418','262'})
AADD(aDados,{'1419','125'})
AADD(aDados,{'1420','120'})
AADD(aDados,{'1421','212'})
AADD(aDados,{'1423','212'})
AADD(aDados,{'1424','212'})
AADD(aDados,{'1425','200'})
AADD(aDados,{'1426','200'})
AADD(aDados,{'1427','310'})
AADD(aDados,{'1428','14'})
AADD(aDados,{'1429','82'})
AADD(aDados,{'1430','145'})
AADD(aDados,{'1431','145'})
AADD(aDados,{'1511','186'})
AADD(aDados,{'1512','140'})
AADD(aDados,{'1513','46'})
AADD(aDados,{'1514','92'})
AADD(aDados,{'1515','92'})
AADD(aDados,{'1516','240'})
AADD(aDados,{'1517','231'})
AADD(aDados,{'1518','231'})
AADD(aDados,{'1519','231'})
AADD(aDados,{'1520','99'})
AADD(aDados,{'1521','99'})
AADD(aDados,{'1522','97'})
AADD(aDados,{'1523','97'})
AADD(aDados,{'1526','97'})
AADD(aDados,{'1527','421'})
AADD(aDados,{'1528','421'})
AADD(aDados,{'1529','421'})
AADD(aDados,{'1530','421'})
AADD(aDados,{'1531','421'})
AADD(aDados,{'1532','421'})
AADD(aDados,{'1600','421'})
AADD(aDados,{'1601','421'})
AADD(aDados,{'1602','421'})
AADD(aDados,{'1603','119'})
AADD(aDados,{'1604','119'})
AADD(aDados,{'1605','13'})
AADD(aDados,{'1606','230'})
AADD(aDados,{'1607','176'})
AADD(aDados,{'1608','307'})
AADD(aDados,{'1609','223'})
AADD(aDados,{'1610','223'})
AADD(aDados,{'1611','223'})
AADD(aDados,{'1612','223'})
AADD(aDados,{'1613','330'})
AADD(aDados,{'1614','330'})
AADD(aDados,{'1615','149'})
AADD(aDados,{'1617','149'})
AADD(aDados,{'1618','106'})
AADD(aDados,{'1619','247'})
AADD(aDados,{'1620','247'})
AADD(aDados,{'1621','247'})
AADD(aDados,{'1622','247'})
AADD(aDados,{'1623','247'})
AADD(aDados,{'1624','247'})
AADD(aDados,{'1625','247'})
AADD(aDados,{'1626','247'})
AADD(aDados,{'1627','247'})
AADD(aDados,{'1628','247'})
AADD(aDados,{'1629','247'})
AADD(aDados,{'1630','403'})
AADD(aDados,{'1631','403'})
AADD(aDados,{'1632','288'})
AADD(aDados,{'1633','288'})
AADD(aDados,{'1634','288'})
AADD(aDados,{'1635','244'})
AADD(aDados,{'1636','244'})
AADD(aDados,{'1637','244'})
AADD(aDados,{'1638','244'})
AADD(aDados,{'1639','244'})
AADD(aDados,{'1640','244'})
AADD(aDados,{'1641','244'})
AADD(aDados,{'1642','244'})
AADD(aDados,{'1643','382'})
AADD(aDados,{'1644','332'})
AADD(aDados,{'1645','332'})
AADD(aDados,{'1646','332'})
AADD(aDados,{'1647','332'})
AADD(aDados,{'1648','332'})
AADD(aDados,{'1649','332'})
AADD(aDados,{'1650','98'})
AADD(aDados,{'1651','98'})
AADD(aDados,{'1652','331'})
AADD(aDados,{'1653','311'})
AADD(aDados,{'1654','311'})
AADD(aDados,{'1655','325'})
AADD(aDados,{'1656','325'})
AADD(aDados,{'1657','325'})
AADD(aDados,{'1658','325'})
AADD(aDados,{'1659','221'})
AADD(aDados,{'1660','221'})
AADD(aDados,{'1661','221'})
AADD(aDados,{'1662','221'})
AADD(aDados,{'1663','221'})
AADD(aDados,{'1664','221'})
AADD(aDados,{'1665','221'})
AADD(aDados,{'1666','31'})
AADD(aDados,{'1667','364'})
AADD(aDados,{'1668','364'})
AADD(aDados,{'1669','364'})
AADD(aDados,{'1670','166'})
AADD(aDados,{'1671','166'})
AADD(aDados,{'1672','166'})
AADD(aDados,{'1673','250'})
AADD(aDados,{'1674','289'})
AADD(aDados,{'1675','369'})
AADD(aDados,{'1676','348'})
AADD(aDados,{'1677','348'})
AADD(aDados,{'1678','148'})
AADD(aDados,{'1679','148'})
AADD(aDados,{'1680','148'})
AADD(aDados,{'1681','25'})
AADD(aDados,{'1682','25'})
AADD(aDados,{'1683','280'})
AADD(aDados,{'1684','429'})
AADD(aDados,{'1685','429'})
AADD(aDados,{'1686','429'})
AADD(aDados,{'1687','429'})
AADD(aDados,{'1688','393'})
AADD(aDados,{'1689','282'})
AADD(aDados,{'1690','341'})
AADD(aDados,{'1691','341'})
AADD(aDados,{'1692','341'})
AADD(aDados,{'1693','341'})
AADD(aDados,{'1694','341'})
AADD(aDados,{'1695','341'})
AADD(aDados,{'1696','416'})
AADD(aDados,{'1697','312'})
AADD(aDados,{'1698','206'})
AADD(aDados,{'1699','386'})
AADD(aDados,{'1700','338'})
AADD(aDados,{'1701','428'})
AADD(aDados,{'1702','428'})
AADD(aDados,{'1703','428'})
AADD(aDados,{'1704','428'})
AADD(aDados,{'1705','428'})
AADD(aDados,{'1706','428'})
AADD(aDados,{'1707','428'})
AADD(aDados,{'1708','428'})
AADD(aDados,{'1709','428'})
AADD(aDados,{'1710','428'})
AADD(aDados,{'1711','428'})
AADD(aDados,{'1712','428'})
AADD(aDados,{'1713','428'})
AADD(aDados,{'1714','428'})
AADD(aDados,{'1715','428'})
AADD(aDados,{'1716','428'})
AADD(aDados,{'1717','428'})
AADD(aDados,{'1718','428'})
AADD(aDados,{'1719','428'})
AADD(aDados,{'1720','428'})
AADD(aDados,{'1721','428'})
AADD(aDados,{'1722','428'})
AADD(aDados,{'439','428'})
AADD(aDados,{'53','428'})
AADD(aDados,{'9997','428'})
AADD(aDados,{'9998','428'})
AADD(aDados,{'9999','336'})
AADD(aDados,{'C000090H5','381'})
AADD(aDados,{'C00059301','60'})
AADD(aDados,{'C00215001','121'})
AADD(aDados,{'C00733301','392'})
AADD(aDados,{'C00782501','76'})
AADD(aDados,{'C0091421 ','86'})
AADD(aDados,{'CA008ZA01','54'})
AADD(aDados,{'CA00BTO01','66'})
AADD(aDados,{'CA00F2001','400'})
AADD(aDados,{'F00001101','88'})
AADD(aDados,{'F00002501','67'})
AADD(aDados,{'F00003001','122'})
AADD(aDados,{'F00014901','44'})
AADD(aDados,{'F00117301','387'})
AADD(aDados,{'F00130401','160'})
AADD(aDados,{'F00202901','196'})
AADD(aDados,{'F00205601','306'})
AADD(aDados,{'F00249601','63'})
AADD(aDados,{'F00279901','361'})


If (nAscan:=Ascan( aDados,{|a| AllTrim(Upper(a[1]))==AllTrim(Upper(cCodigo))}    )  )>0
	cRetorno:=aDados[nAscan,2]
EndIf

cToken:=""
If Empty(cRetorno)
	cToken:="Vazio<======================="
EndIf	

Return cRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetForma(cCodigo,lUsado,cToken)
Local cRetorno	:=""
Local aDados	:={}
Default cToken:=""

AADD(aDados,{'01','3'})
AADD(aDados,{'02','1'})
AADD(aDados,{'03','54'})
AADD(aDados,{'04','11'})
AADD(aDados,{'05','48'})
AADD(aDados,{'06','14'})
AADD(aDados,{'07','6'})
AADD(aDados,{'08','9'})
AADD(aDados,{'09','12'})
AADD(aDados,{'10','58'})
AADD(aDados,{'11','10'})
AADD(aDados,{'12','57'})
AADD(aDados,{'13','11'})
AADD(aDados,{'14','55'})
AADD(aDados,{'15','56'})
AADD(aDados,{'16','13'})
AADD(aDados,{'17','64'})
AADD(aDados,{'18','24'})
AADD(aDados,{'20','8'})
AADD(aDados,{'21','66'})
AADD(aDados,{'22','53'})
AADD(aDados,{'23','4'})
AADD(aDados,{'24','59'})
AADD(aDados,{'25','60'})
AADD(aDados,{'26','67'})
AADD(aDados,{'27','32'})
AADD(aDados,{'28','68'})
AADD(aDados,{'29','69'})
AADD(aDados,{'30','26'})
AADD(aDados,{'31','70'})
AADD(aDados,{'32','71'})
AADD(aDados,{'33','72'})
AADD(aDados,{'34','73'})
AADD(aDados,{'35','62'})
AADD(aDados,{'36','63'})
AADD(aDados,{'37','74'})
AADD(aDados,{'38','10'})
AADD(aDados,{'39','17'})
AADD(aDados,{'40','16'})
AADD(aDados,{'41','75'})
AADD(aDados,{'42','5'})
AADD(aDados,{'43','76'})
AADD(aDados,{'44','77'})
AADD(aDados,{'45','44'})
AADD(aDados,{'99','78'})
AADD(aDados,{'AC','2'})
AADD(aDados,{'XX','79'})

If (nAscan:=Ascan( aDados,{|a| AllTrim(Upper(a[1]))==AllTrim(Upper(cCodigo))}    )  )>0
	cRetorno:=aDados[nAscan,2]
ElseIf lUsado
	cRetorno:='2'
EndIf

cToken:=""
If Empty(cRetorno)
	cToken:="Vazio<======================="
EndIf	


Return cRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetUnidade()
Local cRetorno:="1"
Return cRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function WEB01CriaUsa(nHandle)
Local aAreaAtu	:=GetArea()
Local aAreaSB1	:=SB1->(GetArea())
Local aAreaSB5	:=SB5->(GetArea())
Local aAreaSBZ	:=SBZ->(GetArea())
Local aDadSB1	:={}
Local aDadSB5	:={}
Local aDadSBZ	:={}
Local nInd
                            
WEB01Write("Inicio Produto Usado(WEB01CriaUsa)"+CRLF,nHandle)

For nInd:=1 To SB1->(FCount())
	AADD(aDadSB1,SB1->(FieldGet(nInd)) )
Next

SB5->(DbSetOrder(1))
If SB5->(MsSeek(xFilial("SB5")+SB1->B1_COD))
	For nInd:=1 To SB5->(FCount())
		AADD(aDadSB5,SB5->(FieldGet(nInd)) )
	Next
EndIf

SBZ->(DbSetOrder(1))
If SBZ->(MsSeek(xFilial("SBZ")+SB1->B1_COD))
	For nInd:=1 To SBZ->(FCount())
		AADD(aDadSBZ,SBZ->(FieldGet(nInd)) )
	Next
EndIf

Begin Transaction

cCodUsado:=GetNextCod()
RecLock("SB1",.T.)
For nInd:=1 To Len(aDadSB1)
	SB1->(FieldPut(nInd,aDadSB1[nInd]) )
Next

SB1->B1_COD		:=cCodUsado
SB1->B1_DESC	:="USADO "+AllTrim(SB1->B1_DESC)
SB1->B1_XDESC	:="USADO "+AllTrim(SB1->B1_XDESC)
SB1->B1_GRUPO	:="AD"

SB1->B1_MSBLQL	:="1"
SB1->B1_XUSADO:="1"
//=============================================================================================================//
//Responsavel pela alteração: Flavio de Brito Borges														   //
//Data da altearação: 23/05/2017																			   //
//Tes de entrada adicionada como padrão por solicitação do Wesley Ortega									   //
//=============================================================================================================//
SB1->B1_TE	:=	"448"

If Len(aDadSB5)>0
	RecLock("SB5",.T.)
	For nInd:=1 To Len(aDadSB5)
		SB5->(FieldPut(nInd,aDadSB5[nInd]) )
	Next
	SB5->B5_COD		:=cCodUsado
	//SB5->B5_CEME   :="USADO "+AllTrim(SB5->B5_CEME)
	//SB5->B5_VSINTIT:="USADO "+AllTrim(SB5->B5_VSINTIT)
	
EndIf


If Len(aDadSBZ)>0
	RecLock("SBZ",.T.)
	For nInd:=1 To Len(aDadSBZ)
		SBZ->(FieldPut(nInd,aDadSBZ[nInd]) )
	Next
	SBZ->BZ_COD		:=cCodUsado
EndIf

RestArea(aAreaSB1)
RecLock("SB1",.F.)
SB1->B1_XCODUSA:=cCodUsado

MsUnLockAll()
U_NCGPR117(.F.,cCodUsado)
End Transaction

WEB01Write("Fim Produto Usado(WEB01CriaUsa) Criado Produto:"+cCodUsado+CRLF,nHandle)

RestArea(aAreaSB1)
RestArea(aAreaSB5)
RestArea(aAreaSBZ)

RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetNextCod()
Local aAreaAtu		:=GetArea()
Local cQryAlias	:=GetNextAlias()
Local cQuery  		:=""
Local cCodigo		:=""


cQuery:=" Select Max(B1_COD) B1_COD From "+RetSqlName("SB1")+" SB1 "
cQuery+=" Where B1_FILIAL='"+xFilial("SB1")+"'"
cQuery+=" And B1_COD Between '99999900000' And '99999999999'"  //Produto usado ficara nesta faixa
cQuery+=" And D_E_L_E_T_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias  ,.F.,.T.)

cCodigo		:=AllTrim((cQryAlias)->B1_COD)
(cQryAlias)->(DbCloseArea())


cCodigo:=Soma1(cCodigo)

RestArea(aAreaAtu)
Return cCodigo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCliCod(cCodProd)
Local aAreaAtu :=GetArea()
Local aAreaSA7 :=SA7->(GetArea())
Local aDados	:=Separa( Alltrim(U_MyNewSX6("WEM_000000","000000;01" ,"C","Cliente Loja WebManager","","",.F. )) ,";")
Local cCodigo	:=""
SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

If !SA7->(MsSeek(xFilial("SA7")+aDados[1]+aDados[2] ))
	SA7->(RecLock("SA7",.T.))
	SA7->A7_FILIAL		:=xFilial("SA7")
	SA7->A7_CLIENTE	:=aDados[1]
	SA7->A7_LOJA		:=aDados[2]
	SA7->A7_PRODUTO	:=cCodProd
	SA7->A7_CODCLI		:=U_NextCodCli(aDados[1],aDados[2])
EndIf
cCodigo:=SA7->A7_CODCLI

RestArea(aAreaSA7)
RestArea(aAreaAtu)


Return cCodigo



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/13/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NextCodCli(cCliente,cLoja)
Local aAreaAtu		:=GetArea()
Local cQryAlias	:=GetNextAlias()
Local cQuery  		:=""
Local cCodigo		:=""

cQuery:=" Select Max(A7_CODCLI) A7_CODCLI From "+RetSqlName("SA7")+" SA7 "
cQuery+=" Where A7_FILIAL='"+xFilial("SA7")+"'"
cQuery+=" And A7_CLIENTE='"+cCliente+"'"
cQuery+=" And A7_LOJA='"+cLoja+"'"
cQuery+=" And D_E_L_E_T_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias  ,.F.,.T.)
cCodigo		:=AllTrim((cQryAlias)->A7_CODCLI)
(cQryAlias)->(DbCloseArea())

cCodigo:=Soma1(cCodigo)

RestArea(aAreaAtu)
Return cCodigo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/26/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetWMProd(oSite,cCodBar,cCodSB1,lUsado,cUser,cPassword)
Local cParametros
Local aCodBar:={}
Local nInd
Local cCodProd:=""

cCodBar		:=AllTrim(cCodBar)
cCodSemZero	:=AllTrim(Str(Val(cCodBar)))
AADD(aCodBar,cCodBar)
AADD(aCodBar,cCodSemZero)//Sem Zero a esquerda
AADD(aCodBar,Stuff( cCodSemZero,1,0,"0"))
AADD(aCodBar,Stuff( cCodSemZero,1,0,"00"))
AADD(aCodBar,Stuff( cCodSemZero,1,0,"000"))

// ALTERAR PARA NOVA REGRA
For nInd:=1 To Len(aCodBar)
	cParametros:='?'
	cParametros+='Usuario='+cUser  											//String 22
	cParametros+='&Senha='+cPassword  										//String 50
	//http://www.wm10.com.br/uzgames_matriz/Protheus/consulta_prod_ean_tipo.as
	cParametros+='&EAN='+aCodBar[nInd]+'&produto_usado='+IIf(lUsado,'1','0')
	
	oSite:cParametros:=cParametros
	oSite:GetProd()
	If ValType(oSite:cResponse)=='C'
		aDados:=Separa(oSite:cResponse ,"|")
		If Len(aDados)>0 .And. !Empty(aDados[1])
			cCodProd:=aDados[1]
			U_NCGRAVASA7("000000","01",aDados[1],aDados[5],cCodSB1)
		EndIf
		Exit
	EndIf
Next

Return cCodProd
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  03/26/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGRAVASA7(cCodCli,cLojaCli,cCodProdCli,cDescrProdCli,cCodSB1)
Local aAreaAtu		:=GetArea()
Local aAreaSA7		:=SA7->(GetArea())
Local lAppend

SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

If !SA7->(MsSeek(xFilial("SA7")+cCodCli+cLojaCli+cCodSB1 ))
	
	Begin Transaction
	SA7->(RecLock("SA7",.T.))
	SA7->A7_FILIAL	:=xFilial("SA7")
	SA7->A7_CLIENTE	:=cCodCli
	SA7->A7_LOJA	:=cLojaCli
	SA7->A7_PRODUTO	:=cCodSB1
	SA7->A7_CODCLI	:=cCodProdCli
	SA7->A7_DESCCLI	:=cDescrProdCli
	SA7->(MsUnLock())
	End Transaction	
EndIf
RestArea(aAreaSA7)
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM01  ºAutor  ³Microsiga           º Data ³  11/25/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function WEB01Write(cLine,nHandle)
If nHandle>0 
	FWrite(nHandle,cLine,Len(cLine))	
EndIf	
cLine:=""
Return