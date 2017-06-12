#include "rwmake.ch"        
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NFATR01   ºAutor  ³Reinaldo Caldas     º Data ³  07/26/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao de NF de Entrada/Saida                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NFatr01()

Local CbTxt  :=""
Local CbCont :=""
Local nOrdem :=0
Local Alfa   := 0
Local Z      :=0
Local M      :=0
Local tamanho:="M" 
Local limite :=132
Local titulo :="Nota Fiscal NC Games"
Local cDesc1 :="Este programa ira emitir a Nota Fiscal de Entrada/Saida"
Local cDesc2 :="da NC Games"
Local cNatureza:="" 
Local nomeprog:="NFatr01" 
Local nLastKey:= 0 
Local nLin:=0
wnrel    := "NFatr01"
cPerg:="NFSIGW"
aReturn := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
lContinua :=.T.
_lvia     :=.T.
_I        := 0
_nCont    := 1
_p        := 0
_V        := 0
_nOk      := 31
SetPrvt("CBTXT,CBCONT,NORDEM,ALFA,Z,M")
SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("NLIN,WNREL,NTAMNF,CSTRING,CPEDANT,NLININI")
SetPrvt("XNUM_NF,XSERIE,XEMISSAO,XTOT_FAT,XLOJA,XFRETE")
SetPrvt("XSEGURO,XBASE_ICMS,XBASE_IPI,XVALOR_ICMS,XICMS_RET,XVALOR_IPI")
SetPrvt("XVALOR_MERC,XNUM_DUPLIC,XCOND_PAG,XPBRUTO,XPLIQUI,XTIPO")
SetPrvt("XESPECIE,XVOLUME,CPEDATU,CITEMATU,XPED_VEND,XITEM_PED")
SetPrvt("XNUM_NFDV,XPREF_DV,XICMS,XCOD_PRO,XQTD_PRO,XPRE_UNI")
SetPrvt("XPRE_TAB,XIPI,XVAL_IPI,XDESC,XVAL_DESC,XVAL_MERC")
SetPrvt("XTES,XCF,XICMSOL,XICM_PROD,XPESO_PRO,XPESO_UNIT")
SetPrvt("XDESCRICAO,XUNID_PRO,XCOD_TRIB,XMEN_TRIB,XCOD_FIS,XCLAS_FIS")
SetPrvt("XMEN_POS,XISS,XTIPO_PRO,XLUCRO,XCLFISCAL,XPESO_LIQ")
SetPrvt("I,NPELEM,_CLASFIS,NPTESTE,XPESO_LIQUID,XPED")
SetPrvt("XPESO_BRUTO,XP_LIQ_PED,XCLIENTE,XTIPO_CLI,XCOD_MENS,XMENSAGEM")
SetPrvt("XTPFRETE,XCONDPAG,XCOD_VEND,XDESC_NF,XDESC_PAG,XPED_CLI")
SetPrvt("XDESC_PRO,J,XCOD_CLI,XNOME_CLI,XEND_CLI,XBAIRRO")
SetPrvt("XCEP_CLI,XCOB_CLI,XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI")
SetPrvt("XINSC_CLI,XTRAN_CLI,XTEL_CLI,XFAX_CLI,XSUFRAMA,XCALCSUF")
SetPrvt("ZFRANCA,XVENDEDOR,XBSICMRET,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP")
SetPrvt("XEST_TRANSP,XVIA_TRANSP,XCGC_TRANSP,XTEL_TRANSP,XPARC_DUP,XVENC_DUP")
SetPrvt("XVALOR_DUP,XDUPLICATAS,XNATUREZA,XFORNECE,XNFORI,XPEDIDO")
SetPrvt("XPESOPROD,XFAX,NOPC,CCOR,NTAMDET,XB_ICMS_SOL")
SetPrvt("XV_ICMS_SOL,NCONT,NCOL,NTAMOBS,NAJUSTE,BB")

//+--------------------------------------------------------------+
//¦ Variaveis utilizadas para parametros                         ¦
//¦ mv_par01             // Da Nota Fiscal                       ¦
//¦ mv_par02             // Ate a Nota Fiscal                    ¦ 
//¦ mv_par03             // Da Serie                             ¦ 
//¦ mv_par04             // Nota Fiscal de Entrada/Saida         ¦ 
//+---------
//-----------------------------------------------------+

//+-----------------------------------------------------------+
//¦ Tamanho do Formulario de Nota Fiscal (em Linhas)          ¦
//+-----------------------------------------------------------+

nTamNf:=72     // Apenas Informativo 

//+-------------------------------------------------------------------------+
//¦ Verifica as perguntas selecionadas, busca o padrao da Nfiscal           ¦
//+-------------------------------------------------------------------------+

Pergunte(cPerg,.F.)               // Pergunta no SX1

cString:="SF2"

//+--------------------------------------------------------------+
//¦ Envia controle para a funcao SETPRINT                        ¦
//+--------------------------------------------------------------+

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
Endif

//+--------------------------------------------------------------+
//¦ Verifica Posicao do Formulario na Impressora                 ¦          
//+--------------------------------------------------------------+
SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

RptStatus({|| RptDetail()})

Return

Static Function RptDetail()

Local J
Local I

If mv_par04 == 2
   dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
   dbSetOrder(1)
   dbSeek(xFilial()+mv_par01+mv_par03,.t.)

   dbSelectArea("SD2")                // * Itens de Venda da Nota Fiscal
   dbSetOrder(3)
   dbSeek(xFilial()+mv_par01+mv_par03)
   cPedant := SD2->D2_PEDIDO
Else
   dbSelectArea("SF1")                // * Cabecalho da Nota Fiscal Entrada
   DbSetOrder(1)
   dbSeek(xFilial()+mv_par01+mv_par03,.t.)

   dbSelectArea("SD1")                // * Itens da Nota Fiscal de Entrada
   dbSetOrder(3)
Endif

//+-----------------------------------------------------------+
//¦ Inicializa  regua de impressao                            ¦
//+-----------------------------------------------------------+
SetRegua(Val(mv_par02)-Val(mv_par01))
If mv_par04 == 2
   dbSelectArea("SF2")
   While !eof() .and. SF2->F2_DOC <= mv_par02 .and. lContinua
   
   	 If SF2->F2_SERIE != mv_par03    // Se a Serie do Arquivo for Diferente
         DbSkip()                    // do Parametro Informado !!!
         Loop
      Endif


	// INCLUIDO EM 27/01/05 By RC
	IF SF2->F2_FIMP == "S"
		MsgAlert("A Nota Fiscal "+SF2->F2_DOC+" nao pode ser reimpressa. Exclua e refaça o processo.")
		dbSkip()
		Loop
	EndIf


	IF lAbortPrint
		@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
	    lContinua := .F.
	    Exit
	 Endif

      nLinIni:=nLin   

      //+--------------------------------------------------------------+
      //¦ Inicio de Levantamento dos Dados da Nota Fiscal              ¦
      //+--------------------------------------------------------------+

      // * Cabecalho da Nota Fiscal

      xNUM_NF     :=SF2->F2_DOC             // Numero
      xSERIE      :=SF2->F2_SERIE           // Serie
      xEMISSAO    :=SF2->F2_EMISSAO         // Data de Emissao
      xTOT_FAT    :=SF2->F2_VALFAT          // Valor Total da Fatura
      if xTOT_FAT == 0
         xTOT_FAT := SF2->F2_VALMERC+SF2->F2_VALIPI+SF2->F2_SEGURO+SF2->F2_FRETE
      endif
      xLOJA       :=SF2->F2_LOJA            // Loja do Cliente
      xFRETE      :=SF2->F2_FRETE           // Frete
      xSEGURO     :=SF2->F2_SEGURO          // Seguro
      xBASE_ICMS  :=SF2->F2_BASEICM         // Base   do ICMS
      xBASE_IPI   :=SF2->F2_BASEIPI         // Base   do IPI
      xVALOR_ICMS :=SF2->F2_VALICM          // Valor  do ICMS
      xICMS_RET   :=SF2->F2_ICMSRET         // Valor  do ICMS Retido
      xVALOR_IPI  :=SF2->F2_VALIPI          // Valor  do IPI
      xVALOR_MERC :=SF2->F2_VALMERC         // Valor  da Mercadoria
      xNUM_DUPLIC :=SF2->F2_DUPL            // Numero da Duplicata
      xCOND_PAG   :=SF2->F2_COND            // Condicao de Pagamento
      xPBRUTO     :=SF2->F2_PBRUTO          // Peso Bruto
      xPLIQUI     :=SF2->F2_PLIQUI          // Peso Liquido
      xTIPO       :=SF2->F2_TIPO            // Tipo do Cliente
      xESPECIE    :=SF2->F2_ESPECI1         // Especie 1 no Pedido
      xVOLUME     :=SF2->F2_VOLUME1         // Volume 1 no Pedido

      dbSelectArea("SD2")                   // * Itens de Venda da N.F.
      dbSetOrder(3)
      dbSeek(xFilial()+xNUM_NF+xSERIE)

      cPedAtu := SD2->D2_PEDIDO
      cItemAtu := SD2->D2_ITEMPV

      xPED_VEND:={}                         // Numero do Pedido de Venda
      xITEM_PED:={}                         // Numero do Item do Pedido de Venda
      xNUM_NFDV:={}                         // nUMERO QUANDO HOUVER DEVOLUCAO
      xPREF_DV :={}                         // Serie  quando houver devolucao
      xICMS    :={}                         // Porcentagem do ICMS
      xCOD_PRO :={}                         // Codigo  do Produto
      xQTD_PRO :={}                         // Peso/Quantidade do Produto
      xPRE_UNI :={}                         // Preco Unitario de Venda
      xPRE_TAB :={}                         // Preco Unitario de Tabela
      xIPI     :={}                         // Porcentagem do IPI
      xVAL_IPI :={}                         // Valor do IPI
      xDESC    :={}                         // Desconto por Item
      xVAL_DESC:={}                         // Valor do Desconto
      xVAL_MERC:={}                         // Valor da Mercadoria
      xTES     :={}                         // TES
      xCF      :={}                         // Classificacao quanto natureza da Operacao
      xICMSOL  :={}                         // Base do ICMS Solidario
      xICM_PROD:={}                         // ICMS do Produto

      while !eof() .and. SD2->D2_DOC==xNUM_NF .and. SD2->D2_SERIE==xSERIE
	 If SD2->D2_SERIE != mv_par03        // Se a Serie do Arquivo for Diferente
        	 DbSkip()                   // do Parametro Informado !!!
	         Loop
	 Endif
         AADD(xPED_VEND ,SD2->D2_PEDIDO)
         AADD(xITEM_PED ,SD2->D2_ITEMPV)
         AADD(xNUM_NFDV ,IIF(Empty(SD2->D2_NFORI),"",SD2->D2_NFORI))
         AADD(xPREF_DV  ,SD2->D2_SERIORI)
         AADD(xICMS     ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
         AADD(xCOD_PRO  ,SD2->D2_COD)
         AADD(xQTD_PRO  ,SD2->D2_QUANT)     // Guarda as quant. da NF
         AADD(xPRE_UNI  ,SD2->D2_PRCVEN)
         AADD(xPRE_TAB  ,SD2->D2_PRUNIT)
         AADD(xIPI      ,IIF(Empty(SD2->D2_IPI),0,SD2->D2_IPI))
         AADD(xVAL_IPI  ,SD2->D2_VALIPI)
         AADD(xDESC     ,SD2->D2_DESC)
         AADD(xVAL_MERC ,SD2->D2_TOTAL)
         AADD(xTES      ,SD2->D2_TES)
         AADD(xCF       ,SD2->D2_CF)
         AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
         dbskip()
      End

      dbSelectArea("SB1")                     // * Desc. Generica do Produto
      dbSetOrder(1)
      xPESO_PRO:={}                           // Peso Liquido
      xPESO_UNIT :={}                         // Peso Unitario do Produto
      xDESCRICAO :={}                         // Descricao do Produto
      xUNID_PRO:={}                           // Unidade do Produto
      xCOD_TRIB:={}                           // Codigo de Tributacao
      xMEN_TRIB:={}                           // Mensagens de Tributacao
      xCOD_FIS :={}                           // Cogigo Fiscal
      xCLAS_FIS:={}                           // Classificacao Fiscal
      xMEN_POS :={}                           // Mensagem da Posicao IPI
      xISS     :={}                           // Aliquota de ISS
      xTIPO_PRO:={}                           // Tipo do Produto
      xLUCRO   :={}                           // Margem de Lucro p/ ICMS Solidario
      xCLFISCAL   :={}
      xPESO_LIQ := 0
      I:=1

      For I:=1 to Len(xCOD_PRO)

          dbSeek(xFilial()+xCOD_PRO[I])
          AADD(xPESO_PRO ,SB1->B1_PESO * xQTD_PRO[I])
          xPESO_LIQ  := xPESO_LIQ + xPESO_PRO[I]
          xDesc     :=Alltrim(SB1->B1_XDESC)+"( Cod.Barra: "+Alltrim(SB1->B1_CODBAR)+" )"
          AADD(xPESO_UNIT , SB1->B1_PESO)
          AADD(xUNID_PRO ,SB1->B1_UM)
          AADD(xDESCRICAO ,xDesc)
          AADD(xCOD_TRIB ,SB1->B1_ORIGEM)
          
          If Ascan(xMEN_TRIB, SB1->B1_ORIGEM)==0
             AADD(xMEN_TRIB ,SB1->B1_ORIGEM)
          Endif
		  AADD(xCOD_FIS ,SB1->B1_POSIPI)
          
          If SB1->B1_ALIQISS > 0
             AADD(xISS ,SB1->B1_ALIQISS)
          Endif
          AADD(xTIPO_PRO ,SB1->B1_TIPO)
          AADD(xLUCRO    ,SB1->B1_PICMRET)


         //
         // Calculo do Peso Liquido da Nota Fiscal
         //

         xPESO_LIQUID:=0                                 // Peso Liquido da Nota Fiscal
         For j:=1 to Len(xPESO_PRO)
            xPESO_LIQUID:=xPESO_LIQUID+xPESO_PRO[j]
         Next j

      Next I

      dbSelectArea("SC5")                            // * Pedidos de Venda
      dbSetOrder(1)

      xPED        := {}
      xPESO_BRUTO := 0
      xP_LIQ_PED  := 0

      For I:=1 to Len(xPED_VEND)

         dbSeek(xFilial()+xPED_VEND[I])

         If ASCAN(xPED,xPED_VEND[I])==0
            dbSeek(xFilial()+xPED_VEND[I])
            xCLIENTE    :=SC5->C5_CLIENTE            // Codigo do Cliente
            xNUM        :=SC5->C5_NUM
            xPEDCLI     :=SC5->C5_PEDCLI             // Numero Pedido do cliente    
            xTIPO_CLI   :=SC5->C5_TIPOCLI            // Tipo de Cliente
            xCOD_MENS   :=SC5->C5_MENPAD             // Codigo da Mensagem Padrao
            xMENNOTA    :=SC5->C5_MENNOTA            // Mensagem para a Nota Fiscal
            xTPFRETE    :=SC5->C5_TPFRETE            // Tipo de Entrega
            xCONDPAG    :=SC5->C5_CONDPAG            // Condicao de Pagamento
//            xFRETE      :=SC5->C5_FRETE           // Frete
            xPESO_BRUTO :=SC5->C5_PBRUTO             // Peso Bruto
            xP_LIQ_PED  :=xP_LIQ_PED + SC5->C5_PESOL // Peso Liquido
            xCOD_VEND:= {SC5->C5_VEND1,;             // Codigo do Vendedor 1
                         SC5->C5_VEND2,;             // Codigo do Vendedor 2
                         SC5->C5_VEND3,;             // Codigo do Vendedor 3
                         SC5->C5_VEND4,;             // Codigo do Vendedor 4
                         SC5->C5_VEND5}              // Codigo do Vendedor 5
            xDESC_NF := {SC5->C5_DESC1,;             // Desconto Global 1
                         SC5->C5_DESC2,;             // Desconto Global 2
                         SC5->C5_DESC3,;             // Desconto Global 3
                         SC5->C5_DESC4}              // Desconto Global 4
            AADD(xPED,xPED_VEND[I])
         Endif

         If xP_LIQ_PED >0
            xPESO_LIQ := xP_LIQ_PED
         Endif

      Next I

      //+---------------------------------------------+
      //¦ Pesquisa da Condicao de Pagto               ¦
      //+---------------------------------------------+

      dbSelectArea("SE4")                    // Condicao de Pagamento
      dbSetOrder(1)
      dbSeek(xFilial("SE4")+xCONDPAG)
      xDESC_PAG := SE4->E4_DESCRI

      dbSelectArea("SC6")                    // * Itens de Pedido de Venda
      dbSetOrder(1)
      xPED_CLI :={}                          // Numero de Pedido
      xDESC_PRO:={}                          // Descricao aux do produto
      J:=Len(xPED_VEND)
      For I:=1 to J
         dbSeek(xFilial()+xPED_VEND[I]+xITEM_PED[I])
         AADD(xPED_CLI ,SC6->C6_PEDCLI)
         AADD(xDESC_PRO,SC6->C6_DESCRI)
         AADD(xVAL_DESC,SC6->C6_VALDESC)
      Next j

      If xTIPO=='N' .OR. xTIPO=='C' .OR. xTIPO=='P' .OR. xTIPO=='I' .OR. xTIPO=='S' .OR. xTIPO=='T' .OR. xTIPO=='O

         dbSelectArea("SA1")                // * Cadastro de Clientes
         dbSetOrder(1)
         dbSeek(xFilial()+xCLIENTE+xLOJA)
         xCOD_CLI :=SA1->A1_COD             // Codigo do Cliente
         xNOME_CLI:=SA1->A1_NOME            // Nome
         xEND_CLI :=SA1->A1_END             // Endereco
         xBAIRRO  :=SA1->A1_BAIRRO          // Bairro
         xCEP_CLI :=SA1->A1_CEP             // CEP
         xCOB_CLI :=SA1->A1_ENDCOB          // Endereco de Cobranca
         xREC_CLI :=SA1->A1_ENDENT          // Endereco de Entrega
         xBAI_ENT :=SA1->A1_BAIRROE       // Bairro de entrega
         xCEP_ENT :=SA1->A1_CEPE
         xMUN_ENT :=SA1->A1_MUNE
         xEST_ENT :=SA1->A1_ESTE
         xMUN_CLI :=SA1->A1_MUN             // Municipio
         xEST_CLI :=SA1->A1_EST             // Estado
         xCGC_CLI :=SA1->A1_CGC             // CGC
         xINSC_CLI:=SA1->A1_INSCR           // Inscricao estadual
         xTRAN_CLI:=SA1->A1_TRANSP          // Transportadora
         xTEL_CLI :=SA1->A1_TEL             // Telefone
         xFAX_CLI :=SA1->A1_FAX             // Fax
         xSUFRAMA :=SA1->A1_SUFRAMA            // Codigo Suframa
         xCALCSUF :=SA1->A1_CALCSUF            // Calcula Suframa
         // Alteracao p/ Calculo de Suframa
         if !empty(xSUFRAMA) .and. xCALCSUF =="S"
            IF XTIPO == 'D' .OR. XTIPO == 'B'
               zFranca := .F.
            else
               zFranca := .T.
            endif
         Else
            zfranca:= .F.
         endif
			If Posicione("SC5",1,xFilial("SC5")+cPedAtu,"C5_XECOMER")=="C"
				U_COM05EndEnt(SD2->D2_PEDIDO,@xEND_CLI,@xBAIRRO,@xCEP_CLI,@xMUN_ENT,@xEST_ENT)
			EndIf

      Else
         zFranca:=.F.
         dbSelectArea("SA2")                // * Cadastro de Fornecedores
         dbSetOrder(1)
         dbSeek(xFilial()+xCLIENTE+xLOJA)
         xCOD_CLI :=SA2->A2_COD             // Codigo do Fornecedor
         xNOME_CLI:=SA2->A2_NOME            // Nome Fornecedor
         xEND_CLI :=SA2->A2_END             // Endereco
         xBAIRRO  :=SA2->A2_BAIRRO          // Bairro
         xCEP_CLI :=SA2->A2_CEP             // CEP
         xCOB_CLI :=""                      // Endereco de Cobranca
         xREC_CLI :=""                      // Endereco de Entrega
        xBAI_ENT :=SA2->A2_BAIRRO                   // Bairro de Entrega
         xMUN_CLI :=SA2->A2_MUN             // Municipio
         xEST_ENT:=SA2->A2_EST             // Estado de Entrega
         xMUN_ENT:=SA2->A2_MUN          // Municipio de Entrega
         xCEP_ENT:=SA2->A2_CEP          // Cep de Entrega
         xEST_CLI :=SA2->A2_EST             // Estado
         xCGC_CLI :=SA2->A2_CGC             // CGC
         xINSC_CLI:=SA2->A2_INSCR           // Inscricao estadual
         xTRAN_CLI:=SA2->A2_TRANSP          // Transportadora
         xTEL_CLI :=SA2->A2_TEL             // Telefone
         xFAX_CLI :=SA2->A2_FAX             // Fax
      Endif
      dbSelectArea("SA3")                   // * Cadastro de Vendedores
      dbSetOrder(1)
      xVENDEDOR:={}                         // Nome do Vendedor
      I:=1
      J:=Len(xCOD_VEND)
      For I:=1 to J
         dbSeek(xFilial()+xCOD_VEND[I])
         Aadd(xVENDEDOR,SA3->A3_COD)
      Next j

      If xICMS_RET >0                          // Apenas se ICMS Retido > 0
         dbSelectArea("SF3")                   // * Cadastro de Livros Fiscais
         dbSetOrder(4)
         dbSeek(xFilial()+SA1->A1_COD+SA1->A1_LOJA+SF2->F2_DOC+SF2->F2_SERIE)
         If Found()
            xBSICMRET:=F3_VALOBSE
         Else
            xBSICMRET:=0
         Endif
      Else
         xBSICMRET:=0
      Endif
      dbSelectArea("SA4")                   // * Transportadoras
      dbSetOrder(1)
      dbSeek(xFilial()+SF2->F2_TRANSP)
      xNOME_TRANSP :=SA4->A4_NOME           // Nome Transportadora
      xEND_TRANSP  :=SA4->A4_END            // Endereco
      xMUN_TRANSP  :=SA4->A4_MUN            // Municipio
      xEST_TRANSP  :=SA4->A4_EST            // Estado
      xVIA_TRANSP  :=SA4->A4_VIA            // Via de Transporte
      xCGC_TRANSP  :=SA4->A4_CGC            // CGC
      xTEL_TRANSP  :=SA4->A4_TEL            // Fone

      dbSelectArea("SE1")                   // * Contas a Receber
      dbSetOrder(1)
      xPARC_DUP  :={}                       // Parcela
      xVENC_DUP  :={}                       // Vencimento
      xVALOR_DUP :={}                       // Valor
      xDUPLICATAS:=IIF(dbSeek(xFilial()+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas

      while !eof() .and. SE1->E1_NUM==xNUM_DUPLIC .and. xDUPLICATAS==.T.
         If !("NF" $ SE1->E1_TIPO)
            dbSkip()
            Loop
         Endif
         AADD(xPARC_DUP ,SE1->E1_PARCELA)
         AADD(xVENC_DUP ,SE1->E1_VENCTO)
         AADD(xVALOR_DUP,SE1->E1_VALOR)
         dbSkip()
      EndDo

      dbSelectArea("SF4")                   // * Tipos de Entrada e Saida
      DbSetOrder(1)
      dbSeek(xFilial()+xTES[1])
      xNATUREZA:=SF4->F4_TEXTO              // Natureza da Operacao


      Imprime()

      //+--------------------------------------------------------------
      //¦ Termino da Impressao da Nota Fiscal                          ¦
      //+--------------------------------------------------------------+

      IncRegua()                    // Termometro de Impressao

      nLin  := 0
      _lvia :=.T.
      dbSelectArea("SF2")     

	// INCLUIDO EM 27/01/05 By RC
	IF SF2->F2_FIMP # "S"
		RecLock("SF2",.F.)
		SF2->F2_FIMP := "S"
		msUnlock()
	EndIf
      
      dbSkip()                      // passa para a proxima Nota Fiscal

   EndDo
Else

   dbSelectArea("SF1")              // * Cabecalho da Nota Fiscal Entrada

   dbSeek(xFilial()+mv_par01+mv_par03,.t.)

   While !eof() .and. SF1->F1_DOC <= mv_par02 .and. SF1->F1_SERIE == mv_par03 .and. lContinua

      If SF1->F1_SERIE != mv_par03    // Se a Serie do Arquivo for Diferente
         DbSkip()                    // do Parametro Informado !!!
         Loop
      Endif
      //+-----------------------------------------------------------+
      //¦ Inicializa  regua de impressao                            ¦
      //+-----------------------------------------------------------+
	SetRegua(Val(mv_par02)-Val(mv_par01))
	IF lAbortPrint
		@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
	    lContinua := .F.
	    Exit
	Endif
	
    nLinIni:=nLin // Linha Inicial da Impressao

      //+--------------------------------------------------------------+
      //¦ Inicio de Levantamento dos Dados da Nota Fiscal              ¦
      //+--------------------------------------------------------------+

      xNUM_NF     :=SF1->F1_DOC             // Numero
      xSERIE      :=SF1->F1_SERIE           // Serie
      xFORNECE    :=SF1->F1_FORNECE         // Cliente/Fornecedor
      xEMISSAO    :=SF1->F1_EMISSAO         // Data de Emissao
      xTOT_FAT    :=SF1->F1_VALBRUT         // Valor Bruto da Compra
      xLOJA       :=SF1->F1_LOJA            // Loja do Cliente
      xFRETE      :=SF1->F1_FRETE           // Frete
      xSEGURO     :=SF1->F1_DESPESA         // Despesa
      xBASE_ICMS  :=SF1->F1_BASEICM         // Base   do ICMS
      xBASE_IPI   :=SF1->F1_BASEIPI         // Base   do IPI
      xBSICMRET   :=SF1->F1_BRICMS          // Base do ICMS Retido
      xVALOR_ICMS :=SF1->F1_VALICM          // Valor  do ICMS
      xICMS_RET   :=SF1->F1_ICMSRET         // Valor  do ICMS Retido
      xVALOR_IPI  :=SF1->F1_VALIPI          // Valor  do IPI
      xVALOR_MERC :=SF1->F1_VALMERC         // Valor  da Mercadoria
      xNUM_DUPLIC :=SF1->F1_DUPL            // Numero da Duplicata
      xCOND_PAG   :=SF1->F1_COND            // Condicao de Pagamento
      xTIPO       :=SF1->F1_TIPO            // Tipo do Cliente
      xNFORI      :="" //SF1->F1_NFORI           // NF Original
      xPREF_DV    :="" //SF1->F1_SERIORI         // Serie Original

      dbSelectArea("SD1")                   // * Itens da N.F. de Compra
      dbSetOrder(1)
      dbSeek(xFilial()+xNUM_NF+xSERIE+xFORNECE+xLOJA)

      cPedAtu := SD1->D1_PEDIDO
      cItemAtu:= SD1->D1_ITEMPC
      cNFS_ORI:= SD1->D1_NFORI                         // Nota Fiscal de Saida Original 
      xNFS_ORI:= ""

      xPEDIDO  :={}                         // Numero do Pedido de Compra
      xITEM_PED:={}                         // Numero do Item do Pedido de Compra
      xNUM_NFDV:={}                         // Numero quando houver devolucao
      xPREF_DV :={}                         // Serie  quando houver devolucao
      xICMS    :={}                         // Porcentagem do ICMS
      xCOD_PRO :={}                         // Codigo  do Produto
      xQTD_PRO :={}                         // Peso/Quantidade do Produto
      xPRE_UNI :={}                         // Preco Unitario de Compra
      xIPI     :={}                         // Porcentagem do IPI
      xPESOPROD:={}                         // Peso do Produto
      xVAL_IPI :={}                         // Valor do IPI
      xDESC    :={}                         // Desconto por Item
      xVAL_DESC:={}                         // Valor do Desconto
      xVAL_MERC:={}                         // Valor da Mercadoria
      xTES     :={}                         // TES
      xCF      :={}                         // Classificacao quanto natureza da Operacao
      xICMSOL  :={}                         // Base do ICMS Solidario
      xICM_PROD:={}                         // ICMS do Produto
     

      while !eof() .and. SD1->D1_DOC==xNUM_NF
         If SD1->D1_SERIE #mv_par03        // Se a Serie do Arquivo for Diferente
              DbSkip()                      // do Parametro Informado !!!
              Loop
         Endif

         AADD(xPEDIDO ,SD1->D1_PEDIDO)           // Ordem de Compra
         AADD(xITEM_PED ,SD1->D1_ITEMPC)         // Item da O.C.
         AADD(xNUM_NFDV ,IIF(Empty(SD1->D1_NFORI),"",SD1->D1_NFORI))
         AADD(xPREF_DV  ,SD1->D1_SERIORI)        // Serie Original
         AADD(xICMS     ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
         AADD(xCOD_PRO  ,SD1->D1_COD)            // Produto
         AADD(xQTD_PRO  ,SD1->D1_QUANT)          // Guarda as quant. da NF
         AADD(xPRE_UNI  ,SD1->D1_VUNIT)          // Valor Unitario
         AADD(xIPI      ,SD1->D1_IPI)            // % IPI
         AADD(xVAL_IPI  ,SD1->D1_VALIPI)         // Valor do IPI
         AADD(xPESOPROD ,SD1->D1_PESO)           // Peso do Produto
         AADD(xDESC     ,SD1->D1_DESC)           // % Desconto
         AADD(xVAL_MERC ,SD1->D1_TOTAL)          // Valor Total
         AADD(xTES      ,SD1->D1_TES)            // Tipo de Entrada/Saida
         AADD(xCF       ,SD1->D1_CF)             // Codigo Fiscal
         AADD(xICM_PROD ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
         IF cNFS_ORI <> ""            // NF ORIGEM
             if !( cNFS_ORI $ xNFS_ORI) 
             xNFS_ORI := cNFS_ORI+"/"+xNFS_ORI 
             endif       
         ENDIF
         dbskip()
      End

      dbSelectArea("SB1")                     // * Desc. Generica do Produto
      dbSetOrder(1)
      xUNID_PRO:={}                           // Unidade do Produto
      xDESC_PRO:={}                           // Descricao do Produto
      xMEN_POS :={}                           // Mensagem da Posicao IPI
      xDESCRICAO :={}                         // Descricao do Produto
      xCOD_TRIB:={}                           // Codigo de Tributacao
      xMEN_TRIB:={}                           // Mensagens de Tributacao
      xCOD_FIS :={}                           // Cogigo Fiscal
      xCLAS_FIS:={}                           // Classificacao Fiscal
      xISS     :={}                           // Aliquota de ISS
      xTIPO_PRO:={}                           // Tipo do Produto
      xLUCRO   :={}                           // Margem de Lucro p/ ICMS Solidario
      xCLFISCAL   :={}
      xSUFRAMA :=""
      xCALCSUF :=""

      I:=1
      For I:=1 to Len(xCOD_PRO)

         dbSeek(xFilial()+xCOD_PRO[I])
         dbSelectArea("SB1")

         AADD(xDESC_PRO ,Alltrim(SB1->B1_XDESC)+" (Cod.Barra: "+SB1->B1_CODBAR+" )")
         AADD(xUNID_PRO ,SB1->B1_UM)
         AADD(xCOD_TRIB ,SB1->B1_ORIGEM)
         If Ascan(xMEN_TRIB, SB1->B1_ORIGEM)==0
            AADD(xMEN_TRIB ,SB1->B1_ORIGEM)
         Endif
         AADD(xDESCRICAO ,Alltrim(SB1->B1_XDESC)+" (Cod.Barra: "+alltrim(SB1->B1_CODBAR)+" )")
         AADD(xMEN_POS  ,SB1->B1_POSIPI)
         If SB1->B1_ALIQISS > 0
            AADD(xISS,SB1->B1_ALIQISS)
         Endif
         AADD(xTIPO_PRO ,SB1->B1_TIPO)
         AADD(xLUCRO    ,SB1->B1_PICMRET)
         AADD(xCOD_FIS  ,SB1->B1_POSIPI)
     Next    
     //+---------------------------------------------+
      //¦ Pesquisa da Condicao de Pagto               ¦
      //+---------------------------------------------+

      dbSelectArea("SE4")                    // Condicao de Pagamento
      dbSetOrder(1)
      dbSeek(xFilial("SE4")+xCOND_PAG)
      xDESC_PAG := SE4->E4_DESCRI

      If xTIPO == "D"

         dbSelectArea("SA1")                // * Cadastro de Clientes
         dbSetOrder(1)
         dbSeek(xFilial()+xFORNECE)
         xCOD_CLI :=SA1->A1_COD             // Codigo do Cliente
         xNOME_CLI:=SA1->A1_NOME            // Nome
         xEND_CLI :=SA1->A1_END             // Endereco
         xBAIRRO  :=SA1->A1_BAIRRO          // Bairro
         xCEP_CLI :=SA1->A1_CEP             // CEP
         xCOB_CLI :=SA1->A1_ENDCOB          // Endereco de Cobranca
         xREC_CLI :=SA1->A1_ENDENT          // Endereco de Entrega
          xBAI_ENT :=SA1->A1_BAIRROE      // Bairro de entrega
         xMUN_CLI :=SA1->A1_MUN             // Municipio
         xEST_CLI :=SA1->A1_EST             // Estado
         xCGC_CLI :=SA1->A1_CGC             // CGC
         xINSC_CLI:=SA1->A1_INSCR           // Inscricao estadual
         xTRAN_CLI:=SA1->A1_TRANSP          // Transportadora
         xTEL_CLI :=SA1->A1_TEL             // Telefone
         xFAX_CLI :=SA1->A1_FAX             // Fax

      Else

         dbSelectArea("SA2")                // * Cadastro de Fornecedores
         dbSetOrder(1)
         dbSeek(xFilial()+xFORNECE+xLOJA)
         xCOD_CLI :=SA2->A2_COD                // Codigo do Cliente
         xNOME_CLI:=SA2->A2_NOME               // Nome
         xEND_CLI :=SA2->A2_END                // Endereco
         xBAIRRO  :=SA2->A2_BAIRRO             // Bairro
         xCEP_CLI :=SA2->A2_CEP                // CEP
         xCOB_CLI :=""                         // Endereco de Cobranca
         xREC_CLI :=""                         // Endereco de Entrega
         xBAI_ENT  :=""                         // Bairro de entrega.
         xMUN_CLI :=SA2->A2_MUN                // Municipio
         xEST_CLI :=SA2->A2_EST                // Estado
         xCGC_CLI :=SA2->A2_CGC                // CGC
         xINSC_CLI:=SA2->A2_INSCR              // Inscricao estadual
         xTRAN_CLI:=SA2->A2_TRANSP             // Transportadora
         xTEL_CLI :=SA2->A2_TEL                // Telefone
         xFAX     :=SA2->A2_FAX                // Fax
        

      EndIf

      dbSelectArea("SE1")                   // * Contas a Receber
      dbSetOrder(1)
      xPARC_DUP  :={}                       // Parcela
      xVENC_DUP  :={}                       // Vencimento
      xVALOR_DUP :={}                       // Valor
      xDUPLICATAS:=IIF(dbSeek(xFilial()+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas

      while !eof() .and. SE1->E1_NUM==xNUM_DUPLIC .and. xDUPLICATAS==.T.
         AADD(xPARC_DUP ,SE1->E1_PARCELA)
         AADD(xVENC_DUP ,SE1->E1_VENCTO)
         AADD(xVALOR_DUP,SE1->E1_VALOR)
         dbSkip()
      EndDo

      dbSelectArea("SF4")                   // * Tipos de Entrada e Saida
      dbSetOrder(1)
      dbSeek(xFilial()+xTES[1])
      xNATUREZA:=SF4->F4_TEXTO              // Natureza da Operacao

      xNOME_TRANSP :=" "           // Nome Transportadora
      xEND_TRANSP  :=" "           // Endereco
      xMUN_TRANSP  :=" "           // Municipio
      xEST_TRANSP  :=" "           // Estado
      xVIA_TRANSP  :=" "           // Via de Transporte
      xCGC_TRANSP  :=" "           // CGC
      xTEL_TRANSP  :=" "           // Fone
      xTPFRETE     :=" "           // Tipo de Frete
      xVOLUME      := 0            // Volume
      xESPECIE     :=" "           // Especie
      xPESO_LIQ    := 0            // Peso Liquido
      xPESO_BRUTO  := 0            // Peso Bruto
      xCOD_MENS    :=" "           // Codigo da Mensagem
      xMENSAGEM    :=" "           // Mensagem da Nota
      xPESO_LIQUID :=" "


      Imprime()     

      //+--------------------------------------------------------------+
      //¦ Termino da Impressao da Nota Fiscal                          ¦
      //+--------------------------------------------------------------+

      IncRegua()                    // Termometro de Impressao

      nLin := 0
      _lvia:=.T.
      dbSelectArea("SF1")           
      dbSkip()                     // e passa para a proxima Nota Fiscal

   EndDo
Endif
//+--------------------------------------------------------------+
//¦                                                              ¦
//¦                      FIM DA IMPRESSAO                        ¦
//¦                                                              ¦
//+--------------------------------------------------------------+

//+--------------------------------------------------------------+
//¦ Fechamento do Programa da Nota Fiscal                        ¦
//+--------------------------------------------------------------+

dbSelectArea("SF2")
Retindex("SF2")
dbSelectArea("SF1")
Retindex("SF1")
dbSelectArea("SD2")
Retindex("SD2")
dbSelectArea("SD1")
Retindex("SD1")
Set Device To Screen

If aReturn[5] == 1
   Set Printer TO
   dbcommitAll()
   ourspool(wnrel)
Endif

MS_FLUSH()
//+--------------------------------------------------------------+
//¦ Fim do Programa                                              ¦
//+--------------------------------------------------------------+


/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ IMPDET   ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 20/12/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao de Linhas de Detalhe da Nota Fiscal              ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Nfiscal                                                    ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

//+---------------------+
//¦ Inicio da Funcao    ¦
//+---------------------+

Static Function IMPDET()

Local I:=1

nLin := 26

nTamDet :=GetMV("MV_NUMITEN")  // Tamanho da Area de Detalhe

xB_ICMS_SOL:=0                 // Base  do ICMS Solidario
xV_ICMS_SOL:=0                 // Valor do ICMS Solidario

For I:=1 to nTamDet
	IF !_lvia
		_V:=_nOk
	EndIF
	IF !_lvia .and. _V ==_nOk
		I    :=(_V-30)+1
		_lvia:=.T.
	EndIF
    If I<= Len(xCOD_PRO)
     	@ nLin, 006  PSAY xCOD_PRO[I]
      	@ nLin, 032  PSAY xDESCRICAO[I]
      	@ nLin, 135  PSAY xCOD_FIS[I]
     	@ nLin, 156  PSAY xCOD_TRIB[I]
      	@ nLin, 164  PSAY xUNID_PRO[I]
     	@ nLin, 170  PSAY xQTD_PRO[I]               Picture"@E 999,999"
      	@ nLin, 185  PSAY xPRE_UNI[I]               Picture"@E 99,999,999.99"
      	@ nLin, 200  PSAY xVAL_MERC[I]              Picture"@E 99,999,999.99"
      	@ nLin, 227  PSAY xICM_PROD[I]              Picture"99"          
      	@ nLin, 233  PSAY xIPI[I]                   Picture"99"
      	@ nLin, 235  PSAY xVAL_IPI[I]               Picture"@E 9,999,999.99"
      	_V+=1
      	IF I > (_nOk-1) .and. _V > (_nOk-1) .and. _lvia
			_lvia:= .F.
    		_I:=I
    		I :=nTamDet+1
		EndIF
	Endif   	
   	nLin :=nLin+1
Next
IF !_lvia
	_nOk:=_nOk+30
EndIf

Return

//+---------------------+
//¦ Fim da Funcao       ¦
//+---------------------+


/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ CLASFIS  ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 16/11/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao de Array com as Classificacoes Fiscais           ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Nfiscal                                                    ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

//+---------------------+
//¦ Inicio da Funcao    ¦
//+---------------------+

Static Function CLASFIS()

Local nLen := Len(xCLFISCAL)
Local nCont

@ nLin,006 PSAY "Classificacao Fiscal"
nLin := nLin + 1            

If nLen > 12
	nLen := 12
Endif

For nCont := 1 to nLen
   nCol := If(Mod(nCont,2) != 0, 06, 33)
   @ nLin, nCol   PSAY xCLFISCAL[nCont] + "-"
   @ nLin, nCol+ 05 PSAY Transform(xCLAS_FIS[nCont],"@r 99.99.99.99.99")
   nLin := nLin + If(Mod(nCont,2) != 0, 0, 1)
Next

Return


/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ IMPMENP  ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 20/12/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao Mensagem Padrao da Nota Fiscal                   ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Nfiscal                                                    ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

//+---------------------+
//¦ Inicio da Funcao    ¦
//+---------------------+

Static Function IMPMENP()
IF mv_par04 == 2

	nCol:= 05

	If !Empty(xCOD_MENS)
		@ 04, nCol PSAY Substr(FORMULA(xCOD_MENS),1,61)
    	IF !Empty(Substr(FORMULA(xCOD_MENS),31,30))
    		@ 05, nCol PSAY Substr(FORMULA(xCOD_MENS),62,30)
    	EndIF	
	Endif
    _cEntrega:= Alltrim(xREC_CLI)+" "+Alltrim(xBAI_ENT)+" "+Alltrim(xCEP_ENT)+" "+Alltrim(xMUN_ENT)+" "+xEST_ENT
	@ 06, nCol PSAY "End.Entrega: "+Substr(_cEntrega,1,65)
	IF !Empty(Substr(_cEntrega,66,65))
		@ 07, nCol PSAY Substr(_cEntrega,66,65)
	EndIF

	IF xCONDPAG $ "027/028/029/061"
		dbSelectArea("SE4")
		dbSetOrder(1)
		dbSeek(xFilial()+xCONDPAG)
	
		@ 08, nCol PSAY " Pedido NC: "+Alltrim(xNUM)+IIF(!Empty(xPEDCLI)," Seu Pedido: "+Alltrim(xPEDCLI),"")+"   "+ALLTRIM(SE4->E4_DESCRI)
	Else
		@ 08, nCol PSAY " Pedido NC: "+Alltrim(xNUM)+IIF(!Empty(xPEDCLI)," Seu Pedido: "+Alltrim(xPEDCLI),"")	
	EndIF	

ELSE
//Daniel  
If !Empty(xNFS_ORI)
		@ 04, 05 PSAY "Nota Fiscal Origem:"+ xNFS_ORI
ENDIF
EndIF

Return

//+---------------------+
//¦ Fim da Funcao       ¦
//+---------------------+

/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ MENSOBS  ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 20/12/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao Mensagem no Campo Observacao                     ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Nfiscal                                                    ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

//+---------------------+
//¦ Inicio da Funcao    ¦
//+---------------------+
 

Static Function MENSOBS()
If mv_par04 == 2
	nTamObs:=150
	nCol:=05
	@ 10, nCol PSAY UPPER(SUBSTR(xMENNOTA,1,nTamObs))
	@ 11, nCol PSAY UPPER(SUBSTR(xMENNOTA,151,nTamObs))
	
ENDIF
Return

//+---------------------+
//¦ Fim da Funcao       ¦
//+---------------------+

/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ DUPLIC   ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 20/12/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Impressao do Parcelamento das Duplicacatas                 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Nfiscal                                                    ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

//+---------------------+
//¦ Inicio da Funcao    ¦
//+---------------------+

Static Function DUPLIC()

Local BB

nCol := 86
nAjuste := 0
For BB:= 1 to Len(xVALOR_DUP)
   If xDUPLICATAS==.T. .and. BB<=Len(xVALOR_DUP)
   		IF Mod(BB,2) == 1
       		@ nLin, nCol      PSAY xNUM_DUPLIC + " " + xPARC_DUP[BB]
      		@ nLin, nCol + 40 PSAY xVALOR_DUP[BB] Picture("@E 9,999,999.99")
      		@ nLin, nCol + 70 PSAY xVENC_DUP[BB]      
      	Else
      		@ nLin, 175      PSAY xNUM_DUPLIC + " " + xPARC_DUP[BB]
      		@ nLin, 175 + 40 PSAY xVALOR_DUP[BB] Picture("@E 9,999,999.99")
      		@ nLin, 175 + 30 + 40 PSAY xVENC_DUP[BB]      
      		nLin:= nLin+1
      	EndIF	
      	
   Endif
Next

Return

//+---------------------+
//¦ Fim da Funcao       ¦
//+---------------------+
/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ LI       ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 20/12/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Pula 1 linha                                               ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Generico RDMAKE                                            ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

//+---------------------+
//¦ Inicio da Funcao    ¦
//+---------------------+
//+---------------------+
//¦ Fim da Funcao       ¦
//+---------------------+

/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ IMPRIME  ¦ Autor ¦   Marcos Simidu       ¦ Data ¦ 20/12/95 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Imprime a Nota Fiscal de Entrada e de Saida                ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Generico RDMAKE                                            ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/
Static Function Imprime()

//+-------------------------------------+
//¦ Impressao do Cabecalho da N.F.      ¦
//+-------------------------------------+

@ 02, 000 PSAY Chr(15)                // Compressao de Impressao

If mv_par04 == 1
   @ 03, 210 PSAY "X"
Else
   @ 03, 194 PSAY "X"
Endif

_h    :=1
_p    :=30
IF !_lVia
	_nCont  :=_nCont+1
EndIF
For _k:=1 To Len(xCod_PRO)
	IF _k > _p
		_h+=1
		_p:=_p+30
	EndIF
Next

@ 03, 240 PSAY xNUM_NF+" "+IIF(_nCont == 0,"1",Alltrim(Str(_nCont)))+" / "+Alltrim(Str(_h))
//0        10        20        30        40        50        60        70        80        90       100       110       120       130
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

ImpMenp()     // Imprime Mensagem Padrao da Nota Fiscal

If mv_par04 == 2
@ 009, 005 PSAY " Vendedor: "+xCOD_VEND[1]			// Vendedor NC Games
ENDIF  

@ 009, 086 PSAY xNATUREZA               // Texto da Natureza de Operacao

If mv_par04 == 1
    @ 009, 148 PSAY xCF[1] Picture PESQPICT("SD1","D1_CF") // Codigo da Natureza de Operacao
Else
    @ 009, 148 PSAY xCF[1] Picture PESQPICT("SD2","D2_CF") // Codigo da Natureza de Operacao
EndIf


MENSOBS()     //Imprime Mensagem de Observacao


//+-------------------------------------+
//¦ Impressao dos Dados do Cliente      ¦
//+-------------------------------------+

@ 12, 086 PSAY xNOME_CLI              //Nome do Cliente

If !EMPTY(xCGC_CLI)                   // Se o C.G.C. do Cli/Forn nao for Vazio
   @ 12, 196 PSAY xCGC_CLI Picture"@R 99.999.999/9999-99"
Else
   @ 12, 196 PSAY " "                // Caso seja vazio
Endif

@ 12, 240 PSAY xEMISSAO              // Data da Emissao do Documento

If xICMS_RET <> 0
	nCol:=05
    If xEST_CLI == "SP"
	    @ 12, nCol PSAY "Base ICMS : "
	    @ 12, nCol+12 PSAY xBASE_ICMS Picture"@R 99.999.999/9999-99"
	    @ 12, nCol+34 PSAY "Vlr ICMS : "
	    @ 12, nCol+46 PSAY xVALOR_ICMS Picture"@R 99.999.999/9999-99"
	EndIf	    
		@ 13, nCol PSAY "Imposto recolhido por ST conf. Art. 313-M do RICMS"
ENDIF

@ 14, 086 PSAY xEND_CLI                                 // Endereco
@ 14, 175 PSAY xBAIRRO                                  // Bairro
@ 14, 210 PSAY xCEP_CLI Picture"@R 99999-999"           // CEP
@ 14, 218 PSAY " "                                      // Reservado  p/Data Saida/Entrada

@ 16, 086 PSAY xMUN_CLI                               // Municipio
@ 16, 158 PSAY xTEL_CLI                               // Telefone/FAX
@ 16, 185 PSAY xEST_CLI                               // U.F.
@ 16, 194 PSAY xINSC_CLI                              // Insc. Estadual
@ 16, 218 PSAY " "                                    // Reservado p/Hora da Saida

If mv_par04 == 2

   //+-------------------------------------+
   //¦ Impressao da Fatura/Duplicata       ¦
   //+-------------------------------------+
   	IF _lvia
   		nLin:=19
   		BB:=1
   		nCol := 10             //  duplicatas
   		DUPLIC()
   	EndIF	

Endif

//+-------------------------------------+
//¦ Dados dos Produtos Vendidos         ¦
//+-------------------------------------+

ImpDet()                 // Detalhe da NF


//+-------------------------------------+
//¦ Prestacao de Servicos Prestados     ¦
//+-------------------------------------+

If Len(xISS) > 0

  @ 44, 142  PSAY xTOT_FAT  Picture"@E@Z 999,999,999.99"   // Valor do Servico
Endif
//+-------------------------------------+
//¦ Calculo dos Impostos                ¦
//+-------------------------------------+

IF _lvia
	@ 60, 006  PSAY xBASE_ICMS  Picture"@E@Z 999,999,999.99"  // Base do ICMS
	@ 60, 038  PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS
	@ 60, 067  PSAY xBSICMRET   Picture"@E@Z 999,999,999.99"  // Base ICMS Ret.
	@ 60, 106  PSAY xICMS_RET   Picture"@E@Z 999,999,999.99"  // Valor  ICMS Ret.
	@ 60, 142  PSAY xVALOR_MERC Picture"@E@Z 999,999,999.99"  // Valor Tot. Prod.

	@ 62, 010  PSAY xFRETE      Picture"@E@Z 999,999,999.99"  // Valor do Frete
	@ 62, 038  PSAY xSEGURO     Picture"@E@Z 999,999,999.99"  // Valor Seguro
	@ 62, 116  PSAY xVALOR_IPI  Picture"@E@Z 999,999,999.99"  // Valor do IPI
	@ 62, 142  PSAY xTOT_FAT    Picture"@E@Z 999,999,999.99"  // Valor Total NF


   //+------------------------------------+
   //¦ Impressao Dados da Transportadora  ¦
   //+------------------------------------+

	@ 65, 006  PSAY xNOME_TRANSP                       // Nome da Transport.

	If xTPFRETE=='C'                                   // Frete por conta do
	   @ 65, 105 PSAY "1"                              // Emitente (1)
	Else                                               //     ou
   		@ 65, 105 PSAY "2"                              // Destinatario (2)
	Endif

	@ 65, 092 PSAY " "                                  // Res. p/Placa do Veiculo
	@ 65, 112 PSAY " "                                  // Res. p/xEST_TRANSP                          // U.F.

	If !EMPTY(xCGC_TRANSP)                              // Se C.G.C. Transportador nao for Vazio
	   @ 65, 140 PSAY xCGC_TRANSP Picture"@R 99.999.999/9999-99"
	Else
	   @ 65, 120 PSAY " "                               // Caso seja vazio
	Endif

	@ 67, 006 PSAY xEND_TRANSP                          // Endereco Transp.
	@ 67, 094 PSAY xMUN_TRANSP                          // Municipio
	@ 67, 134 PSAY xEST_TRANSP                          // U.F.
	@ 67, 125 PSAY " "                                  // Reservado p/Insc. Estad.


	@ 68, 008 PSAY xVOLUME  Picture"@E@Z 999,999.99"             // Quant. Volumes
	@ 68, 026 PSAY xESPECIE Picture"@!"                          // Especie
	@ 68, 052 PSAY " "                                           // Res para Marca
	@ 68, 075 PSAY " "                                           // Res para Numero
//	@ 68, 113 PSAY xPESO_BRUTO     Picture"@E@Z 999,999.99"      // Res para Peso Bruto
//	@ 68, 128 PSAY xPESO_LIQUID    Picture"@E@Z 999,999.99"      // Res para Peso Liquido
Else
	@ 60, 006  PSAY "-"    // Base do ICMS
	@ 60, 038  PSAY "-"    // Valor do ICMS
	@ 60, 067  PSAY "-"    // Base ICMS Ret.
	@ 60, 106  PSAY "-"    // Valor  ICMS Ret.
	@ 60, 142  PSAY "-"    // Valor Tot. Prod.

	@ 62, 010  PSAY "-"    // Valor do Frete
	@ 62, 038  PSAY "-"    // Valor Seguro
	@ 62, 116  PSAY "-"    // Valor do IPI
	@ 62, 142  PSAY "-"    // Valor Total NF
EndIF	
@ 73, 240 PSAY xNUM_NF+" "+IIF(_nCont == 0,"1",Alltrim(Str(_nCont)))+" / "+Alltrim(Str(_h))

@ 078, 000 PSAY chr(18)                   // Descompressao de Impressao

SetPrc(0,0)                              // (Zera o Formulario)

IF !_lvia
	Imprime()
Endif	

Return .T.

