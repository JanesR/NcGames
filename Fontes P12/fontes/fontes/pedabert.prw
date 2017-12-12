#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"     



/*****************************************************************************

Programa pedabert

Desenvolvido por Paulo Palhares
Tipo: Relatório
Objetivo: Impressao de pedidos que foram faturados parcialmente analisando o estoque atual
para formentar venda ao cliente.
Data: 06/2009
Cliente: NCGAMES

Parametros:


Perguntas: PDABER

mv_par01 : Data de
mv_par02 : Data Ate
mv_par03 : Vendedor de
mv_par04 : Vendedor ate
mv_par05 : Somente produtos com estoque ou saldo de PC? (Sim/Nao)
mv_par06 : Quebra por vendedor (Nao/Sim)
mv_par07 : Somente Faturado Parcial (Nao/Sim)
mv_par08 : Filtra Eliminado Residuo? (Sim/Nao)


******************************************************************************/




User Function pedabert()

Local imprime      	 := .T.
Local cDesc1         := " Posicao de Pedidos com Saldos - NC GAMES"
Local cDesc2         := " "
Local cDesc3         := " "
Local cPict          := ""
Local aOrd 			 := {}
Local titulo     	 := "POSIÇÃO DE PEDIDOS COM SALDOS"
Local nLin        	 := 80   
Local nTotLib        := 0 // Valor Liberado de Pedidos
Local nTotMai        := 0 // Valor a maior do Limite de Crédito
Local nQReg          := 0 // Quantidade de Registros Impressos
//					   0		 10        20		 30		   40 	     50		   60		 70		   80		 90		   100		 110	   120  	 130	   140		 150	   160	     170
//                     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
               //EDUARDO RAMIRO  01041302768     DYNASTY WARRIORS:GUNDAM 2 X360 NAM                 000535-A1 DEPOSITO SARAIVA               033861 05/06/09      45      17      28      10       0       0       0         
                                    
Local Cabec1 := "VENDEDOR        COD.PRODUTO     DESC PROD NCGAMES                            RESIDUO  NU.PED DT.PED    QTD    QTD      QTD      QTD   QTD     QTD     QTD     DATA"
Local Cabec2 := "                                                                                                       PEDIDO FATURAD  SALPED   ESTOQ RESERVA PD.TERC PE.COMP CHEGADA"
Private nTOT_FRET_SEG	 := 0
Private CbTxt        := ""
Private cString
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "G"
Private nomeprog     := "PEDABERT"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "PDABER"
Private cbtxt      	 := Space(10)
Private cbcont     	 := 00
Private CONTFL     	 := 01
Private m_pag      	 := 01
Private wnrel      	 := "PEDABERT"
Private cString 	 := "SB1"
Public _aDevs 		 := {}
Private	nTOTALGp 	 := 0
Private	nCUSTOGp 	 := 0
Private	nCUSTOAp 	 := 0
Private	nDESCONTp 	 := 0

VALIDPERG()

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
If nLastKey == 27
	Return
EndIf
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
EndIf

nTipo := If(aReturn[4]==1,15,18)

       


RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return


/*********************************///////////////////////


Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local cVend:=" "
Local cCliente:=" "


IF MV_PAR09 == 1
	aDbStru := {}
	
	AADD(aDbStru,{"VEND","C",30,0})
	AADD(aDbStru,{"CODPROD","C",20,0})
	AADD(aDbStru,{"DESCPROD","C",50,0})
	AADD(aDbStru,{"RESIDUO","C",01,0})
	AADD(aDbStru,{"NUMPEDV","C",06,0})
	AADD(aDbStru,{"DTPED","C",08,0} )
	AADD(aDbStru,{"QTDPEDV","N",14,2} )
	AADD(aDbStru,{"QTDFATUR","N",14,2} )
	AADD(aDbStru,{"QTDSALPED","N",14,2} )
	AADD(aDbStru,{"QTDEST","N",14,2} )
	AADD(aDbStru,{"QTDRESER","N",14,2} )
	AADD(aDbStru,{"QTDDISP","N",14,2} )
	AADD(aDbStru,{"PERDREAL","N",14,2} )
	AADD(aDbStru,{"QTDPODTER","N",14,2} )
	AADD(aDbStru,{"QTDPEDCOM","N",14,2} )
	AADD(aDbStru,{"DTCHEG","C",08,0} )
	AADD(aDbStru,{"CODBAR","C",15,0})
	AADD(aDbStru,{"PUBLISH","C",30,0})
	AADD(aDbStru,{"CONSINIC","C",08,0})

	CNOMEDBF := "PERDA-"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))
	
  	If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
		FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	EndIf
	
	//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
	DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
	DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)
ENDIF



    //-----------------------------------------------------------------
	
	cQuery:=          " select b1.b1_cod, "
	cQuery:= cQuery + "       b1.b1_xdesc, " 
	cQuery:= cQuery + "       b1.b1_codbar, "
	cQuery:= cQuery + "       b1.b1_PUBLISH, "
	cQuery:= cQuery + "       b1.b1_CONINI, "
	cQuery:= cQuery + "       a1.a1_nome, "
	cQuery:= cQuery + "       a1.a1_nreduz,"
	cQuery:= cQuery + "       c6.c6_cli, "
	cQuery:= cQuery + "       c6.c6_loja, "
	cQuery:= cQuery + "       c6.c6_qtdven, "
	cQuery:= cQuery + "       c6.c6_qtdent, "
	cQuery:= cQuery + "       c6.c5_vend1, "
	cQuery:= cQuery + "       c6.c5_emissao, "
	cQuery:= cQuery + "       c6.c6_num, "
	cQuery:= cQuery + "       b2.b2_qatu, "
	cQuery:= cQuery + "       b2.b2_reserva, "
	cQuery:= cQuery + "       b2.b2_qter, "
	cQuery:= cQuery + "       b2.b2_filial, "	//stch
	cQuery:= cQuery + "       a3.a3_nreduz, "
	cQuery:= cQuery + "       c7.c7_emissao, "	
	cQuery:= cQuery + "       c6.c6_blq, "	
	cQuery:= cQuery + "       decode(c7.c7_quant,null,0,c7.c7_quant) c7_quant "
	cQuery:= cQuery + " from "+RetSQLName("SB1")+" b1, (select c6.c6_num, c6.c6_blq, c6.c6_produto, c6.c6_cli,c6.c6_loja, c6.c6_qtdven, c6.c6_qtdent, c5.c5_vend1, to_char(to_date(c5.c5_emissao,'yyyymmdd'),'dd/mm/yy')  c5_emissao "
	cQuery:= cQuery + "                 from "+RetSQLName("SC6")+" c6, (select c5_filial, c5_num, c5_emissao,c5_vend1 from "+RetSQLName("SC5")+" where D_E_L_E_T_!='*') c5, "
	cQuery:= cQuery + "                                                (select f4_codigo from "+RetSQLName("SF4")+" where D_E_L_E_T_!='*' and f4_venda='S') f4 "		
	cQuery:= cQuery + "                 where c6.c6_filial=c5.c5_filial(+) "
	cQuery:= cQuery + "                 and   c6.c6_num=c5.c5_num(+) "
	cQuery:= cQuery + "                 and   c6.c6_tes=f4.f4_codigo(+) "
	cQuery:= cQuery + "                 and   f4.f4_codigo is not null "
  	cQuery:= cQuery + "                 and   c6.D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 and   c6.c6_qtdven!=c6.c6_qtdent "
	
	if mv_par07=1  // Parametro que filtra somente os pedidos com saldos ja faturados ou mostra inclusive
	               // Pedidos nao faturados!
       cQuery:= cQuery + "                 and   c6.c6_qtdent>0 "
	Endif
	
	if mv_par08=1  // Parametro que filtra os pedidos que foram eliminado residuo
       cQuery:= cQuery + "                 and   c6.c6_blq!='R' "
	Endif
	
	cQuery:= cQuery + "                 and   c5.c5_vend1>='"+mv_par03+"'"
	cQuery:= cQuery + "                 and   c5.c5_vend1<='"+mv_par04+"'"
	cQuery:= cQuery + "                 and   c5.c5_emissao>='"+dtos(mv_par01)+"'"
	cQuery:= cQuery + "                 and   c5.c5_emissao<='"+dtos(mv_par02)+"') c6, "
	cQuery:= cQuery + "                (select b2_cod, b2_local, b2_qatu, b2_reserva, b2_qter,b2_filial from "+RetSQLName("SB2")+" where D_E_L_E_T_!='*' and b2_local='01' and b2_filial='03') b2, "
	cQuery:= cQuery + "                (select c.c7_produto, to_char(to_date(c.c7_emissao,'yyyymmdd'),'dd/mm/yy') c7_emissao, sum(c.c7_quant-c.c7_quje) c7_quant "
	cQuery:= cQuery + "                 from "+RetSQLName("SC7")+" c, (select c7_produto, min(c7_emissao) c7_emissao "
	cQuery:= cQuery + "                                 from "+RetSQLName("SC7")+" c7 "
	cQuery:= cQuery + "                                 where D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                                 and   c7_quje<c7_quant "
	cQuery:= cQuery + "                                 and   c7_residuo!='S' "
	cQuery:= cQuery + "                                 group by c7_produto) ca "
	cQuery:= cQuery + "                where c.D_E_L_E_T_!='*'                "
	cQuery:= cQuery + "                and   c.c7_emissao=ca.c7_emissao(+) "
	cQuery:= cQuery + "                and   c.c7_produto=ca.c7_produto(+) "
	cQuery:= cQuery + "                and   c.c7_quje<c.c7_quant  "
	cQuery:= cQuery + "                group by c.c7_produto, c.c7_emissao) c7, "
	cQuery:= cQuery + "                (select a1_nome, a1_nreduz, a1_cod, a1_loja from "+RetSQLName("SA1")+" where D_E_L_E_T_!='*') a1, "
	cQuery:= cQuery + "                (select a3_cod, a3_nreduz from "+RetSQLName("SA3")+" where D_E_L_E_T_!='*') a3 "
	cQuery:= cQuery + " where b1.D_E_L_E_T_!='*' "
	cQuery:= cQuery + " and  b1.b1_cod=c6.c6_produto(+) "
	cQuery:= cQuery + " and  c6.c6_produto is not null "
	cQuery:= cQuery + " and  b1.b1_cod=b2.b2_cod(+) "
	cQuery:= cQuery + " and  b1.b1_cod=c7.c7_produto(+) "
	cQuery:= cQuery + " and  c6.c6_cli=a1.a1_cod(+) "
	cQuery:= cQuery + " and  c6.c6_loja=a1.a1_loja(+) "
	cQuery:= cQuery + " and  c6.c5_vend1=a3.a3_cod(+) "
	if mv_par05=1
	   cQuery:= cQuery + " and  ((b2.b2_qatu>0 and b2.b2_qatu is not null)  "
	   cQuery:= cQuery + " or  (c7.c7_quant is not null and c7.c7_quant>0)) "
	End
	cQuery:= cQuery + " order by c6.c5_vend1, a1.a1_cod, a1.a1_loja, c6.c6_num, b1.b1_cod "


    If select("SQL") <> 0  // VerIfica se já existe o Alias
		SQL->(dbclosearea("SQL"))
	End 
	TCQuery cQuery ALIAS "SQL" NEW 

   	dbGoTop("SQL") 
   	//-------------------------------------------------------     
   	


    cCliente:=" "
	While SQL->(!Eof())

		If lAbortPrint
			@nLin,000 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf
		If	nLin > 75 .or. (sql->c5_vend1!=cVend .and. mv_par06=2)
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			cVend:=sql->c5_vend1
			nLin := 9
		EndIf
		if cCliente==" "
    	   @nLin,000 PSay "Cliente: "+sql->(c6_cli+"-"+c6_loja+" "+a1_nreduz+" "+a1_nome)
    	   cCliente:=sql->c6_cli
		   nLin++
        Endif			   	
    	@nLin,000 PSay sql->(a3_nreduz+" "+b1_cod+" "+substr(b1_xdesc,1,50)+" "+c6_blq+" "+c6_num+" "+c5_emissao+" "+transform(round(c6_qtdven,0),"999,999")+" "+transform(round(c6_qtdent,0),"999,999")+" "+transform(round(c6_qtdven-c6_qtdent,0),"999,999")+" "+transform(round(b2_qatu,0),"999,999")+" "+transform(round(b2_reserva,0),"999,999")+" "+transform(round(b2_qter,0),"999,999")+" "+transform(round(c7_quant,0),"999,999")+" "+c7_emissao )
    	nLin++           
    	
	IF MV_PAR09 == 1
		XLS->(RECLOCK("XLS",.T.))

		XLS->VEND		:= SQL->A3_NREDUZ
		XLS->CODPROD	:= SQL->B1_COD
		XLS->DESCPROD	:= substr(SQL->B1_XDESC,1,50)
		XLS->RESIDUO	:= SQL->C6_BLQ
		XLS->NUMPEDV	:= SQL->C6_NUM
		XLS->DTPED		:= SQL->C5_EMISSAO//SUBSTR(SQL->C5_EMISSAO,7,2)+"/"+SUBSTR(SQL->C5_EMISSAO,5,2)+"/"+SUBSTR(SQL->C5_EMISSAO,1,4)
		XLS->QTDPEDV	:= round(SQL->C6_QTDVEN,0)
	 	XLS->QTDFATUR	:= round(c6_qtdent,0)
	 	XLS->QTDSALPED	:= round(c6_qtdven-c6_qtdent,0)
	 	XLS->QTDEST		:= round(b2_qatu,0)
		XLS->QTDRESER	:= round(b2_reserva,0)
		XLS->QTDDISP	:= round(b2_qatu-b2_reserva,0)
		XLS->PERDREAL	:= round(c6_qtdven-c6_qtdent,0)-round(b2_qatu-b2_reserva,0)
		XLS->QTDPODTER	:= round(b2_qter,0)
		XLS->QTDPEDCOM	:= round(c7_quant,0)
		XLS->DTCHEG		:= C7_EMISSAO //SUBSTR(SQL->C7_EMISSAO,7,2)+"/"+SUBSTR(SQL->C7_EMISSAO,5,2)+"/"+SUBSTR(SQL->C7_EMISSAO,1,4)
		XLS->CODBAR		:= SQL->B1_CODBAR
		XLS->PUBLISH	:= SQL->B1_PUBLISH
		XLS->CONSINIC	:= SUBSTR(SQL->B1_CONINI,7,2)+"/"+SUBSTR(SQL->B1_CONINI,5,2)+"/"+SUBSTR(SQL->B1_CONINI,3,2)

		
	ENDIF

		SQL->(DbSkip())                                      
		
		if cCliente!=sql->c6_cli
		   nLin+=2              
		   @nLin,000 Psay Replicate("-",200)
		   nLin++	
		   if nLin>75 // Se linha maior que 70, forca troca de página!
		      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		      nLin:=9
		   Endif
		   cCliente:=" "
		Endif
        
	EndDo

IF MV_PAR09 == 1
	XLS->(DBGOTOP())
	CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
	Alert("Arquivo salvo em C:\RELATORIOS\" + CNOMEDBF + ".DBF" )
	
	If ! ApOleClient( 'MsExcel' )
		MsgStop( 'MsExcel nao instalado' )
		Return
	EndIf
	
	DbSelectArea("SQL")
	DbCloseArea()
	
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
ENDIF

SET DEVICE TO SCREEN
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
EndIf
MS_FLUSH()
//Descarrega a Query da memoria
SQL->(dbCloseArea())
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VALIDPERG ³ Autor ³ RAIMUNDO PEREIRA      ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/            

Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Vendedor De?","","","mv_ch3","C", 6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"04","Vendedor Ate?","","","mv_ch4","C",6,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"05","Som.Prod.Sald.Estoq/PC?","","","mv_ch5","C",1,0,1,"C","","mv_par05","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Quebra por Vendedor?","","","mv_ch6","C",1,0,1,"C","","mv_par06","NÃO","","","","","SIM","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Somente Faturados?","","","mv_ch7","C",1,0,1,"C","","mv_par07","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Som.Prod.Sald.Estoq/PC?","","","mv_ch8","C",1,0,1,"C","","mv_par08","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Exporta Excel?","","","mv_ch9","C",1,0,1,"C","","mv_par09","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
Return
