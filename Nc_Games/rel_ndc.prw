#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"     



/*****************************************************************************

Programa relndc

Desenvolvido por Paulo Palhares - Everest Consultoria
Tipo: Relatório
Objetivo: Impressão de NDC em aberto com dados de nota cliente e vendedor.
Data: 08/2009
Cliente: NCGAMES

Parametros:


Perguntas: RELNDC

mv_par01 : Data de
mv_par02 : Data Ate
mv_par03 : Vendedor de
mv_par04 : Vendedor ate
mv_par05 : Cliente de 
mv_par06 : Cliente Ate
mv_par07 : Loja de
mv_par08 : Loja Ate
mv_par09 : Quebra por Vendedor
mv_par10 : Quebra por Cliente


******************************************************************************/




User Function relndc()

Local imprime      	 := .T.
Local cDesc1         := " Posicao de NDC em Aberto - NC GAMES"
Local cDesc2         := " "
Local cDesc3         := " "
Local cPict          := ""
Local aOrd 			 := {}
Local titulo     	 := "POSIÇÃO DE NDC EM ABERTO"
Local nLin        	 := 80   
//					   0		 10        20		 30		   40 	     50		   60		 70		   80		 90		   100		 110	   120  	 130	   140		 150	   160	     170
//                     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
               //NDC 15/07/2009 R$      51.03 R$      51.03 NDI 037547 CUSTAS PROTESTO                          000670 01 FIRST BUREAU OF INTERNETT S/C LTDA ME    MATRIX INFINITY                UNI VN0025 ROGERIO        
Local Cabec1 := "TIPO   EMISSAO    VLR TITULO     VLR SALDO PREF.  NUM HISTORICO                               COD.CLI LJ NOME DO CLIENTE                          NOME REDUZIDO                 SRNF CO.VEN VENDEDOR"
Local Cabec2 := " "
Private nTOT_FRET_SEG	 := 0
Private CbTxt        := ""
Private cString
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "G"
Private nomeprog     := "RELNDC"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RELNDC"
Private cbtxt      	 := Space(10)
Private cbcont     	 := 00
Private CONTFL     	 := 01
Private m_pag      	 := 01
Private wnrel      	 := "RELNDC"
Private cString 	 := "SB1"
Public _aDevs 		 := {}

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
Local cVend   :=" "
Local cCliente:=" "                                                     
Local cCli2   :=" "
Local nTCli   :=0
Local nTGer   :=0


    //-----------------------------------------------------------------
	
	cQuery:=" select e1.e1_tipo, "
    cQuery+=" to_char(to_date(e1.e1_emissao,'yyyymmdd'),'dd/mm/yyyy') e1_emissao, "
    cQuery+=" e1.e1_valor, "
    cQuery+=" e1.e1_saldo, "
    cQuery+=" e1.e1_prefixo, "
    cQuery+=" e1.e1_num, "
    cQuery+=" substr(e1.e1_hist,1,40) e1_hist, "
    cQuery+=" e1.e1_cliente, "
    cQuery+=" e1.e1_loja, "
    cQuery+=" a1.a1_nome, "
    cQuery+=" a1.a1_nreduz, "
    cQuery+=" decode(f2.f2_serie,null,' ',f2.f2_serie) f2_serie, "
    cQuery+=" decode(f2.f2_vend1,null,' ',f2.f2_vend1) f2_vend1, "
    cQuery+=" decode(a3.a3_nreduz,null,' ',a3.a3_nreduz) a3_nreduz "
    cQuery+=" from se1010 e1, (select a1_cod, a1_loja, a1_nome, a1_nreduz from sa1010 where D_E_L_E_T_!='*') a1, "
    cQuery+="                 (select f2_doc, f2_serie, f2_vend1, f2_cliente, f2_loja from sf2010 where D_E_L_E_T_!='*') f2, "
    cQuery+="                 (select a3_cod, a3_nome, a3_nreduz from sa3010 where D_E_L_E_T_!='*') a3 "
    cQuery+=" where e1.D_E_L_E_T_!='*' "
    cQuery+=" and   e1.e1_saldo>0 "
    cQuery+=" and   e1.e1_tipo='NDC' "
    cQuery+=" and   e1.e1_cliente=a1.a1_cod(+) "
    cQuery+=" and   e1.e1_loja=a1.a1_loja(+) "
    cQuery+=" and   e1.e1_num=f2.f2_doc(+) "
    cQuery+=" and   e1.e1_cliente=f2.f2_cliente(+) "
    cQuery+=" and   e1.e1_loja=f2.f2_loja(+) "
    cQuery+=" and   f2.f2_vend1=a3.a3_cod(+) "
    cQuery+=" and   e1.e1_emissao>='"+dtos(mv_par01)+"'"
    cQuery+=" and   e1.e1_emissao<='"+dtos(mv_par02)+"'"       
    cQuery+=" and   ((f2.f2_vend1>='"+mv_par03+"'"
    cQuery+=" and   f2.f2_vend1<='"+mv_par04+"') or f2.f2_vend1 is null)"
    cQuery+=" and   e1.e1_cliente>='"+mv_par05+"'"
    cQuery+=" and   e1.e1_cliente<='"+mv_par06+"'"
    cQuery+=" and   e1.e1_loja>='"+mv_par07+"'"
    cQuery+=" and   e1.e1_loja<='"+mv_par08+"'"
    cQuery+=" order by f2.f2_vend1, e1.e1_cliente, e1.e1_loja"
	
    If select("SQL") <> 0  // VerIfica se já existe o Alias
		SQL->(dbclosearea("SQL"))
	End 
	TCQuery cQuery ALIAS "SQL" NEW 

   	dbGoTop("SQL") 

   	cCli2:=sql->e1_cliente
	While SQL->(!Eof())

		If lAbortPrint
			@nLin,000 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf
		If	nLin > 75 .or. (sql->f2_vend1!=cVend .and. mv_par09=1) .or. (sql->e1_cliente!=cCliente .and. mv_par10=1)
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			cVend:=sql->f2_vend1
			cCliente:=sql->e1_cliente
			nLin := 8
		EndIf
     	@nLin,000 PSay sql->(e1_tipo+" "+e1_emissao+"    "+transform(e1_valor,"999,999.99")+"    "+transform(e1_saldo,"999,999.99")+" "+e1_prefixo+" "+e1_num+" "+e1_hist+" "+e1_cliente+" "+e1_loja+" "+a1_nome+" "+a1_nreduz+" "+f2_serie+" "+f2_vend1+" "+a3_nreduz)
     	nLin++

        nTCli   +=sql->e1_saldo
        nTGer   +=sql->e1_saldo      

    	
		SQL->(DbSkip())                                                
		
        if cCli2!=sql->e1_cliente
           @nLin,000 PSay replicate('-',200)       
           nLin++
           @nLin,000 PSay "Total do Cliente: "+transform(nTCli,"999,999.99")
           nLin++
           @nLin,000 PSay replicate('-',200)       
           nLin+=2
           nTCli:=0       
           cCli2:=sql->e1_cliente                          
        Endif
	
    	if nLin>70 // Se linha maior que 70, forca troca de página!
		   nLin:=80
		Endif
	EndDo
              

    @nLin,000 PSay replicate('-',200)       
    nLin++
    @nLin,000 PSay "Total Geral.....: "+transform(nTGer,"999,999.99")
    nLin++
    @nLin,000 PSay replicate('-',200)                  
    nTGer:=0

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


