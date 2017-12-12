#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/11/99

User Function Dupli2()         // incluido pelo assistente de conversao do AP5 IDE em 19/11/99

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3,CSTRING,ARETURN")
SetPrvt("CPERG,NLASTKEY,LI,I,CSAVSCR1,CSAVCUR1,CSAVROW1")
SetPrvt("CSAVCOL1,CSAVCOR1,WNREL,XVALOR,XDUPTOT")
                              
/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ DUPLI    ¦ Autor ¦ MICROSIGA             ¦ Data ¦ 03.12.05 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦EMITE DUPLICATA PADRAO MICROSIGA                            ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Sintaxe e ¦ DUPLI  (void)                                              ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦ Uso      ¦ Generico                                                   ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/
//+--------------------------------------------------------------+
//¦ Define Variaveis                                             ¦
//+--------------------------------------------------------------+
//+--------------------------------------------------------------+
//¦ Define Variaveis.                                            ¦
//+--------------------------------------------------------------+
tamanho := "P" 
limite  := 80
titulo  := "EMISSAO DE DUPLICATAS"
cDesc1  := "Este programa irá emitir as Duplicatas conforme"
cDesc2  := "parametros especificados."
cDesc3  := "Especifico L.W.S."
cString := "SE1"
aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
cPerg   :="DUPLI"
nLastKey:= 0
xDupTot := 0
li := 0
//+---------------------------------------------+
//¦ Variaveis utilizadas para parametros	      ¦
//¦ mv_par01		// Duplicata de		         ¦
//¦ mv_par02		// Duplicata ate	            ¦
//¦ mv_par03		// Serie                		¦
//+---------------------------------------------+
//+--------------------------------------------------------------+
//¦ Verifica as perguntas selecionadas                           ¦
//+--------------------------------------------------------------+
pergunte("DUPLI",.F.)

//+--------------------------------------------------------------+
//¦ Envia controle para a funcao SETPRINT.                       ¦
//+--------------------------------------------------------------+
wnrel:="DUPLI" 

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,)

If LastKey() == 27 .Or. nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If LastKey() == 27 .Or. nLastKey == 27
   Return
Endif


dbSelectArea("SE1")
dbSetOrder(1)
dbSeek(Xfilial()+mv_par03+mv_par01)
	
If Found()
	While SE1->E1_NUM >= mv_par01 .and. SE1->E1_NUM <= mv_par02 .And. SE1->E1_PREFIXO == mv_par03 .and. !Eof() 
	   xDupTot := xDupTot + SE1->E1_VALOR
	DbSkip()
	EndDO
EndIf                               


dbSeek(Xfilial()+mv_par03+mv_par01)
	
If Found()
	Set Century ON
	Set Device to Print
	
	While SE1->E1_NUM >= mv_par01 .and. SE1->E1_NUM <= mv_par02 .And. SE1->E1_PREFIXO == mv_par03 .and. !Eof() 

	    If SE1->E1_PARCELA >= mv_par04 .and. SE1->E1_PARCELA <= mv_par05
	    
		 	//@ li,001 PSAY chr(18) // Descompressao de impressao
		 
		 	@ li,001 PSAY chr(15)  // compressao de impressao	
		 	li:=li + 6 	
			@ li,102 PSAY SE1->E1_EMISSAO	
			li:= li + 5
			@ li,036 PSAY xDUPTOT PICTURE "@R@E 99,999,999.99"
	        @ li,056 PSAY SE1->E1_NUM
			@ li,070 PSAY SE1->E1_VALOR PICTURE "@r@e 99,999,999.99" // valor do titulo 			
		   	@ li,088 PSAY SE1->E1_NUM +" "+SE1->E1_PARCELA  
			@ li,106 PSAY SE1->E1_VENCTO
			li:= li + 3
			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek(Xfilial()+SE1->E1_CLIENTE+SE1->E1_LOJA)
			If found()
				//@ li,001 PSAY chr(15) // compressao de impressao
				li:= li + 3
				@ li,050 PSAY SA1->A1_NOME
				li:= li + 1
				@ li,050 PSAY ALLTRIM(SA1->A1_END)+" "+ALLTRIM(SA1->A1_BAIRRO)
				li:= li +1
				@ li,050 PSAY SA1->A1_MUN
			   	@ li,107 PSAY SA1->A1_EST
				@ li,122 PSAY SA1->A1_CEP PICTURE "@r 99999-999"
				li := li + 1
				@ li,050 PSAY ALLTRIM(SA1->A1_MUNC)+" - "+SA1->A1_ESTC
				li := li + 1				
				@ li,050 PSAY ALLTRIM(SA1->A1_ENDCOB)+" "+ALLTRIM(SA1->A1_BAIRROC)+" "+ALLTRIM(SA1->A1_CEPC)
				li := li + 1
				i:=len(AllTrim(SA1->A1_CGC))
				Do Case
				// Se CGC
				Case i>=14
					@ li,050 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99" 
				// Se CPF
				Case i==11
					@ li,050 PSAY SA1->A1_CGC PICTURE "@R 999.999.999-99" 
				// Se CGC Vazio
				Case Empty(SA1->A1_CGC)
					@ li,050 PSAY ""
				OtherWise	
					@ li,050 PSAY SA1->A1_CGC
	            EndCase  
	            
				@ li,102 PSAY SA1->A1_INSCR
				li := li + 1
			Endif	
   			DbSelectArea("SE1")			
		    XVALOR := SE1->E1_VALOR
			@ li,045 PSAY Subs(RTRIM(SUBS(EXTENSO(XVALOR),1,90)) + REPLICATE("*",90),1,90)
			li:= li + 1
      		@ li,045 PSAY Subs(RTRIM(SUBS(EXTENSO(XVALOR),91,90)) + REPLICATE("*",90),1,90) 
		    li:= li + 1
	   	    @ li,045 PSAY Subs(RTRIM(SUBS(EXTENSO(XVALOR),181,90)) + REPLICATE("*",90),1,90)
   			li:= li + 4
			@ li,045 PSAY mv_par06
   			li:= li + 1
			@ li,045 PSAY mv_par07  			
			li:= li + 9
			@ li,001 PSAY chr(18) // Descompressao de impressao
		Endif	
		DbSkip()
	EndDO
EndIf

Set Device to Screen
DbSelectArea("SE1")
DbSetOrder(1)
DbSelectArea("SA1")
DbSetOrder(1)
//+------------------------------------------------------------------+
//¦ Se impressao em Disco, chama Spool.                              ¦
//+------------------------------------------------------------------+
If aReturn[5] == 1
   Set Printer To 
   dbCommitAll()
   ourspool(wnrel)
Endif

//+------------------------------------------------------------------+
//¦ Libera relatorio para Spool da Rede.                             ¦
//+------------------------------------------------------------------+
FT_PFLUSH()