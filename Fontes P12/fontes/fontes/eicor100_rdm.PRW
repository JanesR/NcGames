#include "Average.ch"
Static cDescDPAux := "" //Descrição do item 

//+-------------------------------------------------------------------------------------------//
//|Empresa...: NC Games - 12/01/2013                                                          //
//|Funcao....: EICOR100_RDM()                                                                 //
//|Autor.....: Luiz Fernando                                                                  //
//|Uso.......: SIGAEIC                                                                        //
//|Versao....: Protheus - 10                                                                  //
//|Descricao.: Ponto de entrada para que a integração com Despachante receba valor da Midia   //
//|Observação:                                                                                //
//--------------------------------------------------------------------------------------------//

*----------------------------------------------*
User Function EICOR100()
*----------------------------------------------*
Local _VLnInc 	:= 0    
Local cCodBar	:= ""

IF GETMV("MV_LAYDESP",,.F.)
	_VLnInc := 10
Else
	_VLnInc := 0
Endif

Do Case
	
	//+-----------------------------------------------------------------------------------//
	//|Parametro..: "CAP3"
	//|Descricao..: Preenche os Valore Texto Recebendo inf PO (Capa Arq Txt)
	//+-----------------------------------------------------------------------------------//
	Case ParamIxb == "CAP3"
		
		****************************************************************************************
		/// Seleciona o Valor da Mídia Na Capa do PO (Purshase Order)
		****************************************************************************************
		IF ! EMPTY(SW2->W2_VLMIDIA)
			_OldArea := GetArea()
			SA2->(DbSetOrder(1))
			SA2->(DBSEEK(xFilial()+SW6->W6_PO_NUM))
			If !Eof()
				// Valor Midia
				cTexto := STUFF(cTexto,020,020,ORI100Numero(SW2->W2_VLMIDIA,17,02,.T.))
				// Tem Liminar (S/N)  - W6_XLIMINA
				cTexto := STUFF(cTexto,080,001,SW6->W6_XLIMINA)
			Endif
			RestArea(_OldArea)
		Endif
		****************************************************************************************
		
		//	Case ParamIxb == "ITEA_VALORES"
		//	  If !Empty(SW2->W2_VLMIDIA)
		//	  		   IF LEN(ALLTRIM(STR(INT(cValor_Uni)))) <= 5
		//				   cTexto := STUFF(cTexto,069+_VLnInc,012,ORI100Numero((cValor_Uni-SW2->W2_VLMIDIA),05,06,.T.))
		//				ELSE
		//				   cTexto := STUFF(cTexto,069+_VLnInc,012,ORI100Numero((cValor_Uni-SW2->W2_VLMIDIA),09,02,.T.))
		//				ENDIF //Alterado em 15/07/2013
		//	  Endif
		
	Case ParamIxb == "ITEA"
		
		****************************************************************************************
		/// Seleciona a Quantidade de Midias do Produto
		****************************************************************************************
		_cCodProd := SUBSTR(eval(bProduto),1,20)
		_nProdQtdMid := Posicione("SB1",1,xFilial("SB1")+_cCodProd,"B1_QTMIDIA")
		//Altera o codigo do produto pelo codigo de barra 
		cCodBar	:= ""
		cCodBar	:= GetCodBarra(Alltrim(_cCodProd))//Busca o código de barra de acordo com o código do produto
		If Empty(cCodBar) .And. !IsBlind()
		   If  Aviso("Codigo de Barra", "Código de Barra não encontrado para o produto "+Alltrim(_cCodProd)+;
		    			". Deseja utilizar o código do produto na geração do arquivo ? ",{"Sim","Não"}) == 1
		    			
				cTexto := STUFF(cTexto,020,015+_VLnInc,	SUBSTR(eval(bProduto),1,15+_VLnInc) )		    			
		   Else
				cTexto := STUFF(cTexto,020,015+_VLnInc,	SUBSTR(cCodBar,1,15+_VLnInc) )		   		
		   EndIf        
		   
		ElseIf Empty(cCodBar) .And. IsBlind()//Processo executado por job                           
			cTexto := STUFF(cTexto,020,015+_VLnInc,	SUBSTR(eval(bProduto),1,15+_VLnInc) ) //Será utilizado o codigo do produto		
		Else
			cTexto := STUFF(cTexto,020,015+_VLnInc,	SUBSTR(cCodBar,1,15+_VLnInc) )		
		EndIf                                                                  
		
		If _nProdQtdMid > 0
			cTexto := STUFF(cTexto,087+_VLnInc,010,ORI100Numero(SW2->W2_VLMIDIA,07,02,.T.))
			IF LEN(ALLTRIM(STR(INT(cValor_Uni)))) <= 5
				cTexto := STUFF(cTexto,069+_VLnInc,012,ORI100Numero((cValor_Uni-SW2->W2_VLMIDIA),05,06,.T.))
			ELSE
				cTexto := STUFF(cTexto,069+_VLnInc,012,ORI100Numero((cValor_Uni-SW2->W2_VLMIDIA),09,02,.T.))
			ENDIF //Alterado em 15/07/2013
			      //cTexto := STUFF(cTexto,087+_VLnInc,010,ORI100Numero(_nProdQtdMid,07,02,.T.))
		Endif
		****************************************************************************************
		
	Case ParamIxb == "ITEB"
		
		****************************************************************************************
		/// Informa o Percentual do ICM´s no Item do Processo // Atualizacao em 18/02/2013
		****************************************************************************************
		_cCodNcm := SW7->W7_NCM
		_nAliqNcm := Posicione("SYD",1,xFilial("SYD")+_cCodNcm+Space(03)+Space(03),"YD_ICMS_RE")
		
		If _nAliqNcm > 0
			cTexto := STUFF(cTexto,070+_VLnInc,006,ORI100Numero(_nAliqNcm,03,02,.T.))
		Endif
		****************************************************************************************
		
	Case ParamIxb == "DESC_LI_GIP"  
        
        nTamItem := TAMSX3("B1_VM_GI")[1]

		//Guarda a descrição da LI original "B1_VM_GI", na variavél Static.
		//Esse valor será utilizado no ponto de entrada a seguir "DPNN",
		//para deixar a descrição da LI em uma só linha
		cDescDPAux 		:= cDescricaoItem   
		
		//Altera a descrição original da LI, para que não seja efetuada a quebra de linha.
		cDescricaoItem  := SubStr(cDescricaoItem,1,20) //Diminui a descrição da           
		
	Case ParamIxb == "DPNN"	
		
		//Inclui a descrição da LI em uma só linha, de acordo com a descrição original utilizada na variavel Static, no PE "DESC_LI_GIP"
	 	//cTexto := Alltrim(STUFF(cTexto,040,nTamReg,cDescDPAux))
	 	If Upper(SubStr(cTexto,1,2)) == "DP"
	 		cTexto := SubStr(cTexto,1,39)+Alltrim(cDescDPAux)
	 	EndIf        
	
			 	
 	Case ParamIxb == "TAM_REG"
        //Atualiza o tamanho do layout 
		nTamReg := U_MyNewSX6(	"NC_TAMDLI", ;
								"2000", ;
								"N", ;
								"Tamanho do campo para descrição LI, na geração do arquivo para despachante  ",;
								"Tamanho do campo para descrição LI, na geração do arquivo para despachante  ",;
								"Tamanho do campo para descrição LI, na geração do arquivo para despachante  ",;
								.F. )
EndCase


Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetCodBarra	ºAutor  ³Elton C.	     º Data ³  28/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o código de barra de acordo com o código do produtoº±±
±±º		     ³ 														 	  º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCodBarra(cCodProd)

Local aArea := GetArea()
Local cRet	:= ""

Default cCodProd := ""

DbSelectArea("SB1")
DbSetOrder(1)
If SB1->(DbSeek(xFilial("SB1") + cCodProd ))
	cRet := SB1->B1_CODBAR
EndIf

RestArea(aArea)
Return cRet 

