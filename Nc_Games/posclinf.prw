#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"     



/*****************************************************************************

Programa Posclinf 

Desenvolvido por Paulo Palhares
Tipo: Relatório
Objetivo: Imprimir posição de cliente dos faturamentos emitidos no dia para 
avaliar crédito e condição de pagamento
Data: 06/2009
Cliente: NCGAMES

Parametros:


Perguntas:

mv_par01 : Data de
mv_par02 : Data Ate
mv_par03 : Ordem (1 - Serie Nota, 2 - Maior Faturamento, 3 - Maior Saldo, 4 - Maior Dif Saldo-LC
mv_par04 : Quantidade de Registros
mv_par05 : Somente Registros Liberados Financeiro


******************************************************************************/




User Function posclinf()

Local imprime      	 := .T.
Local cDesc1         := " Faturamento e Posição de Crédito - NC GAMES"
Local cDesc2         := " "
Local cDesc3         := " "
Local cPict          := ""
Local aOrd 			 := {}
Local titulo     	 := "POSIÇÃO DE CLIENTE FATURADO"
Local nLin        	 := 80   
Local nTotLib        := 0 // Valor Liberado de Pedidos
Local nTotMai        := 0 // Valor a maior do Limite de Crédito
Local nQReg          := 0 // Quantidade de Registros Impressos
//					   0		 10        20		 30		   40 	     50		   60		 70		   80		 90		   100		 110	   120  	 130	   140		 150	   160	     170
//                     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                                    
//               Cliente: 000098-01 VIRTUA GAME COM DE BRINQUEDOS LTDA EPP   VIRTUA GAMES                        41,018.23     50,000.00 20/40/50/60/80  D
//               Nota   : UNI 050437 02/06/09         992.56 30/60           02/06/09 SILVIA                        
Local Cabec1 := "         CLIENTE   NOME                                     FANTASIA                          SAL.DUP.FIL    LIMITE.FIL COND.PADRAO   RISCO   SAL.DUP.CLI     LIMITE.CLI  MEDIA.COM.CLI"
               //Cliente: 000227-01 SS SILVA BRINQUEDOS                      NORTE GAMES                          1,998.64      2,000.00 10              D        1,998.64       2,000.00         993.10
Local Cabec2 := "         SER.NOTA   EMISSAO        VALOR NF COND.NOTA       DT.LI.CR USUARIO LIB. CRED.            "
Private nTOT_FRET_SEG	 := 0
Private CbTxt        := ""
Private cString
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "G"
Private nomeprog     := "POSCLINF"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "PCLINF"
Private cbtxt      	 := Space(10)
Private cbcont     	 := 00
Private CONTFL     	 := 01
Private m_pag      	 := 01
Private wnrel      	 := "POSCLINF"
Private cString 	 := "SD2"
Public _aDevs 		 := {}
Private	nTOTALGp 	 := 0
Private	nCUSTOGp 	 := 0
Private	nCUSTOAp 	 := 0
Private	nDESCONTp 	 := 0


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
Local nOrdem

    //-----------------------------------------------------------------
	 
	cQuery:=          " select a1.a1_cod, "
	cQuery:= cQuery + "       a1.a1_loja, "
	cQuery:= cQuery + "       a1.a1_nome, "
	cQuery:= cQuery + "       a1.a1_nreduz, " 
	cQuery:= cQuery + "       f2.f2_valfat, "
	cQuery:= cQuery + "       a1.a1_saldup, "
	cQuery:= cQuery + "       a1.a1_lc, "
	cQuery:= cQuery + "       a1.a1_risco, "
	cQuery:= cQuery + "       f2.f2_serie, "
	cQuery:= cQuery + "       f2.f2_doc, "
	cQuery:= cQuery + "       f2.f2_emissao, "
	cQuery:= cQuery + "       f2.f2_cond, "
	cQuery:= cQuery + "       e41.e4_descri descrinf, "
	cQuery:= cQuery + "       a1.a1_cond, "
	cQuery:= cQuery + "       e42.e4_descri descricli, "
	cQuery:= cQuery + "       c9.c9_ulibcrd, "
	cQuery:= cQuery + "       c9.c9_dtlicrd,  "
	cQuery:= cQuery + "       a1b.a1_saldup saldup2, 
	cQuery:= cQuery + "       a1b.a1_lc lc2, 
	cQuery:= cQuery + "       a1b.f2_valfat valfat2 "
	cQuery:= cQuery + " from "+RetSQLName("SA1")+" a1, (select f2_doc, f2_serie, f2_cliente, f2_loja, f2_cond, to_char(to_date(f2_emissao,'yyyymmdd'),'dd/mm/yy') f2_emissao, (f2_valmerc+f2_valipi+f2_seguro+f2_frete) f2_valfat "
	cQuery:= cQuery + "                 from "+RetSQLName("SF2")+" "
	cQuery:= cQuery + "                 where D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 and   f2_emissao>='"+dtos(mv_par01)+"'
	cQuery:= cQuery + "                 and   f2_emissao<='"+dtos(mv_par02)+"') f2, "
	cQuery:= cQuery + "                (select * from "+RetSQLName("SE4")+" where D_E_L_E_T_!='*') e41, "
	cQuery:= cQuery + "                (select * from "+RetSQLName("SE4")+" where D_E_L_E_T_!='*') e42, "
	cQuery:= cQuery + "                (select c9_nfiscal, c9_serienf, c9_ulibcrd, decode(trim(c9_dtlicrd),'',' ',to_char(to_date(c9_dtlicrd,'yyyymmdd'),'dd/mm/yy')) c9_dtlicrd  "
	cQuery:= cQuery + "                 from "+RetSQLName("SC9")+" "
	cQuery:= cQuery + "                 where D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 group by c9_nfiscal, c9_serienf, c9_ulibcrd,  c9_dtlicrd ) c9, "
	cQuery:= cQuery + "                (select a.a1_cod,  round(sum(a.a1_saldup),2) a1_saldup, round(sum(a.a1_lc),2) a1_lc, f.f2_valfat f2_valfat "
	cQuery:= cQuery + "                 from "+RetSQLName("SA1")+" a, (select f2.f2_cliente, round(avg(f2.f2_valfat),2) f2_valfat "
	cQuery:= cQuery + "                 from "+RetSQLName("SF2")+" f2 "
	cQuery:= cQuery + "                 where f2.D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 and f2.f2_valfat>0 "
	cQuery:= cQuery + "                 group by f2.f2_cliente   ) f "
	cQuery:= cQuery + "                 where "
	cQuery:= cQuery + "                 a.D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 and   a.a1_cod=f.f2_cliente(+) "
	cQuery:= cQuery + "                 group by a.a1_cod,  f.f2_valfat) a1b "
	cQuery:= cQuery + " where a1.D_E_L_E_T_!='*' "
	cQuery:= cQuery + " and   a1.a1_cod=f2.f2_cliente(+) "
	cQuery:= cQuery + " and   a1.a1_cod=a1b.a1_cod(+) "	
	cQuery:= cQuery + " and   a1.a1_loja=f2.f2_loja(+) "
	cQuery:= cQuery + " and   f2.f2_serie=c9.c9_serienf(+) "
	cQuery:= cQuery + " and   f2.f2_doc=c9.c9_nfiscal(+) "
	cQuery:= cQuery + " and   f2.f2_cliente is not null "               
	cQuery:= cQuery + " and   f2.f2_cond=e41.e4_codigo "
	cQuery:= cQuery + " and   a1.a1_cond=e42.e4_codigo "                                            
    if mv_par05=1
	   cQuery:= cQuery +=" and trim(c9.c9_ulibcrd)!=' ' "
	Endif

	
	//mv_par03 : Ordem (1 - Serie Nota, 2 - Maior Faturamento, 3 - Maior Saldo, 4 - Maior Dif Saldo-LC
	
	Do Case
	    Case mv_par03=1
        	 cQuery:= cQuery + " order by f2.f2_serie, f2.f2_doc "
        Case mv_par03=2
         	 cQuery:= cQuery + " order by f2.f2_valfat desc "
        Case mv_par03=3
             cQuery:= cQuery + " order by a1.a1_saldup desc "
        Case mv_par03=4
             cQuery:= cQuery + " order by (a1.a1_saldup-a1.a1_lc) Desc "
    OtherWise                                                      
        cQuery:= cQuery + " order by f2.f2_serie, f2.f2_doc "
    EndCase
    	

    If select("SQL") <> 0  // VerIfica se já existe o Alias
		SQL->(dbclosearea("SQL"))
	End 
	TCQuery cQuery ALIAS "SQL" NEW 

   	dbGoTop("SQL")
   	//-------------------------------------------------------
   	
   	
	nTotLib        := 0
    nTotMai        := 0
    
    nQReg:=1
	While SQL->(!Eof())

		If lAbortPrint
			@nLin,000 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf
		If	nLin > 75
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		EndIf
        @nLin,000 PSay "Cliente: "+sql->(a1_cod+"-"+a1_loja+" "+a1_nome+" "+a1_nreduz+" "+;
        transform(a1_saldup,"999,999,999.99")+;
        transform(a1_lc,"999,999,999.99")+" "+;
        descricli+" "+a1_risco+"  "+;
        transform(saldup2,"999,999,999.99")+" "+;
        transform(lc2,"999,999,999.99")+" "+;
        transform(valfat2,"999,999,999.99"))
        
        nLin++
        @nLin,000 PSay "Nota   : "+sql->(f2_serie+" "+f2_doc+" "+f2_emissao+" "+transform(f2_valfat,"999,999,999.99")+" "+descrinf+" "+c9_dtlicrd+" "+c9_ulibcrd)
		nLin++
		@nLin,000 PSay replicate("-",80)
		nLin+=2           
		              
		if Alltrim(c9_ulibcrd)!=""
		   nTotLib+=sql->f2_valfat
		Endif
		
		SQL->(DbSkip())                                      
		 
		// Define a quantidade de registros a serem impressos
		nQReg++
		if mv_par04!=0 .and. nQReg>mv_par04
		      Exit
        Endif
        
	EndDo



// Query para pegar os limites de créditos estourados
  
  	cQuery:=          " select a1.a1_cod, a1.a1_loja, a1.a1_nome,  a1.a1_nreduz, a1.a1_saldup, a1.a1_lc "
	cQuery:= cQuery + " from "+RetSQLName("SA1")+" a1, (select f2_doc, f2_serie, f2_cliente, f2_loja, f2_cond, to_char(to_date(f2_emissao,'yyyymmdd'),'dd/mm/yy') f2_emissao, (f2_valmerc+f2_valipi+f2_seguro+f2_frete) f2_valfat "
	cQuery:= cQuery + "                 from "+RetSQLName("SF2")+" "
	cQuery:= cQuery + "                 where D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 and   f2_emissao>='"+dtos(mv_par01)+"'
	cQuery:= cQuery + "                 and   f2_emissao<='"+dtos(mv_par02)+"') f2, "
	cQuery:= cQuery + "                (select * from "+RetSQLName("SE4")+" where D_E_L_E_T_!='*') e41, "
	cQuery:= cQuery + "                (select * from "+RetSQLName("SE4")+" where D_E_L_E_T_!='*') e42, "
	cQuery:= cQuery + "                (select c9_nfiscal, c9_serienf, c9_ulibcrd, decode(trim(c9_dtlicrd),'',' ',to_char(to_date(c9_dtlicrd,'yyyymmdd'),'dd/mm/yy')) c9_dtlicrd  "
	cQuery:= cQuery + "                 from "+RetSQLName("SC9")+" "
	cQuery:= cQuery + "                 where D_E_L_E_T_!='*' "
	cQuery:= cQuery + "                 group by c9_nfiscal, c9_serienf, c9_ulibcrd,  c9_dtlicrd ) c9 "
	cQuery:= cQuery + " where a1.D_E_L_E_T_!='*' "
	cQuery:= cQuery + " and   a1.a1_cod=f2.f2_cliente(+) "
	cQuery:= cQuery + " and   a1.a1_loja=f2.f2_loja(+) "
	cQuery:= cQuery + " and   f2.f2_serie=c9.c9_serienf(+) "
	cQuery:= cQuery + " and   f2.f2_doc=c9.c9_nfiscal(+) "
	cQuery:= cQuery + " and   f2.f2_cliente is not null "
	cQuery:= cQuery + " and   f2.f2_cond=e41.e4_codigo "
	cQuery:= cQuery + " and   a1.a1_cond=e42.e4_codigo "
	cQuery:= cQuery + " and   a1.a1_saldup>a1.a1_lc "
	cQuery:= cQuery + " group by a1.a1_cod, a1.a1_loja, a1.a1_nome,  a1.a1_nreduz, a1.a1_saldup, a1.a1_lc "
	cQuery:= cQuery + " order by (a1.a1_saldup-a1.a1_lc) Desc "
	
    If select("SQL") <> 0  // VerIfica se já existe o Alias
		SQL->(dbclosearea("SQL"))
	End
	TCQuery cQuery ALIAS "SQL" NEW 

    Cabec1 := " "
    Cabec2 := " "

    Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9

    @nLin,000 Psay "Resumo dos clientes com saldo de duplicatas acima do limíte de crédito faturados de:"+dtoc(mv_par01)+" à "+dtoc(mv_par02)+":"
    nLin+=2

    While sql->(!Eof())
    	  If lAbortPrint
		     @nLin,000 PSay "*** CANCELADO PELO OPERADOR ***"
			 Exit
		  EndIf
		  If nLin > 75
		     Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			 nLin := 9
		  EndIf                                              
		  @nLin,000 Psay sql->(a1_cod+"-"+a1_loja+" "+a1_nome+" "+a1_nreduz+" "+transform(a1_saldup,"999,999,999.99")+transform(a1_lc,"999,999,999.99"))
		  nLin++
		  nTotMai+=sql->(a1_saldup-a1_lc)
          sql->(DbSkip())
    Enddo

@nLin+=3

If	nLin > 72
    Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9
EndIf

@nLin,000 Psay "Total de Saldo Acima do Limite de Crédito :"+transform(nTotMai,"999,999,999.99")
nLin+=2
@nLin,000 Psay "Total de Faturamento Liberado pelo Crédito:"+transform(nTotLib,"999,999,999.99")


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


