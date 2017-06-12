#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"     



/*****************************************************************************

Programa relndc

Desenvolvido por Paulo Palhares - Everest Consultoria
Tipo: Relatório
Objetivo: Impressão de Tabela de preços com informações de estoque e valor de venda.
Data: 10/2009
Cliente: NCGAMES

Parametros:


Perguntas: TABPRE

mv_par01 : Tabela
mv_par02 : Estoque?
mv_par03 : Só sem preço?
mv_par04 : Latamel?


******************************************************************************/




User Function tabpreco()

Local imprime      	 := .T.
Local cDesc1         := " Tabela de Preços - NC GAMES"
Local cDesc2         := " "
Local cDesc3         := " "
Local cPict          := ""
Local aOrd 			 := {}
Local titulo     	 := "TABELA DE PREÇOS NCGAMES"
Local nLin        	 := 80   
Local Cabec1 := " "
Local Cabec2 := " "
Private nTOT_FRET_SEG	 := 0
Private CbTxt        := ""
Private cString
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "G"
Private nomeprog     := "TABPRE"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "TABPRE"
Private cbtxt      	 := Space(10)
Private cbcont     	 := 00
Private CONTFL     	 := 01
Private m_pag      	 := 01
Private wnrel      	 := "TABPRE"
Private cString 	 := "SB1"
Public _aDevs 	     := {}


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

DA0->(DbSetOrder(1))
DA0->(Dbseek(xFilial("DA0")+mv_par01))

       
if mv_par02=1
//		   0		 10        20		 30		   40 	     50		   60		 70		   80		 90		   100		 110	   120  	 130	   140		 150	   160	     170
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
         //01031101459     083717241188       WINNING ELEVEN PES 2007 NDS KON                                                                         JOGOS NINTENDO DS                    4      69.92 NAO CADASTRADO                   ______         
Cabec1 := "   CODIGO NC    CODIGO DE BARRAS   DESCRICAO NCGAMES                                                                                       GRUPO                          ESTOQUE      VALOR GENERO    DT.LANC   "
Cabec2 := "TABELA: "+ALLTRIM(DA0->DA0_DESCRI)+" ESTOQUE FILIAL: "+mv_par06+" ALMOXARIFADO (LOCAL): "+mv_par07
Else

//		   0		 10        20		 30		   40 	     50		   60		 70		   80		 90		   100		 110	   120  	 130	   140		 150	   160	     170
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
         //01010400510     752919520239       FULL SPECTRUM WARRIOR XB THQ                                                                            JOGOS XB                            60      43.17    ______
Cabec1 := "   CODIGO NC    CODIGO DE BARRAS   DESCRICAO NCGAMES                                                                                       GRUPO                                       VALOR GENERO    DT.LANC   "
Cabec2 := "TABELA: "+DA0->DA0_DESCRI

Endif



RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return


/*********************************///////////////////////


Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)      

Private cQuery:=" "


    cQuery:=" "
	
	cQuery+=" select b1.b1_cod, "
	cQuery+=" b1.b1_codbar, "
	cQuery+=" b1.b1_xdesc,   "
    cQuery+=" bm.bm_desc,  "
    cQuery+=" decode(b2.b2_qatu,null,0,b2.b2_qatu) Estoque,  "
    cQuery+=" decode(da1.da1_prcven,null,0,da1.da1_prcven) da1_prcven,  "
    cQuery+=" decode(b1.b1_genero2,'1','1ºPESSOA','2','3ºPESSOA','3','ACAO/AVENTURAS','4','ACESSORIOS','5','ARCADE','6','ACAO','7','AVENTURA','8','CORRIDA','9','CARD','A','DANCA','B','ESPORTE','C','ESTRATEGIA','NAO CADASTRADO') b1_genero2, "
    cQuery+=" decode(substr(b1.b1_dtlan,1,1),' ',' ',to_char(to_date(b1.b1_dtlan,'yyyymmdd'),'dd/mm/yy')) b1_dtlan, "
    cQuery+=" decode(substr(b1.b1_dtlanc,1,1),' ',' ',to_char(to_date(b1.b1_dtlanc,'yyyymmdd'),'dd/mm/yy')) b1_dtlanc  "
    cQuery+=" from sb1010 b1 , (select bm_grupo, bm_desc from sbm010 where D_E_L_E_T_!='*') bm,  "
    cQuery+="             (select b2_cod, b2_qatu from sb2010 where b2_filial='"+mv_par06+"' and b2_local='"+mv_par07+"') b2,  "
    cQuery+="             (select da1_codtab, da1_codpro, da1_prcven from da1010 where D_E_L_E_T_!='*' and da1_codtab='"+mv_par01+"') da1  "
    cQuery+=" where D_E_L_E_T_!='*'  "
    cQuery+=" and  b1.b1_cod=b2.b2_cod(+)  "
    cQuery+=" and  b1.b1_msblql!='1'  "    
    cQuery+=" and  b1.b1_cod=da1.da1_codpro(+)  "
    cQuery+=" and  b1.b1_grupo=bm.bm_grupo(+)  "
    if mv_par03=2
        cQuery+=" and  da1.da1_codpro is not null "
    Else
        cQuery+=" and  da1.da1_codpro is  null "
    Endif
    if mv_par05=1
        cQuery+=" and b2.b2_qatu>0  "
    Endif
    
/*	
mv_par01 : Tabela
mv_par02 : Estoque?
mv_par03 : Só sem preço?
mv_par04 : Latamel?
mv_par05 : Somente estoque>0
mv_par06 : Filial do Estoque
mv_par07 : Local do Estoque
*/
    If select("SQL") <> 0  // VerIfica se já existe o Alias
		SQL->(dbclosearea("SQL"))
	End 
	TCQuery cQuery ALIAS "SQL" NEW 

   	dbGoTop("SQL") 

	While SQL->(!Eof())

		If lAbortPrint
			@nLin,000 PSay "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf
		If	nLin > 75 
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		EndIf
		                
		if mv_par02=1
           @nLin,000 PSay sql->(b1_cod+" "+b1_codbar+"    "+b1_xdesc+"    "+bm_desc+" "+transform(Estoque,"999,999")+" "+transform(da1_prcven,"999,999.99")+" "+b1_genero2+" "+b1_dtlanc)
        Else
           @nLin,000 PSay sql->(b1_cod+" "+b1_codbar+"    "+b1_xdesc+"    "+bm_desc+"         "+transform(da1_prcven,"999,999.99")+" "+b1_genero2+" "+b1_dtlanc)
        Endif           
        nLin++
   	
		SQL->(DbSkip())                                                
		
    	if nLin>70 // Se linha maior que 70, forca troca de página!
		   nLin:=80
		Endif
	EndDo
              

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


