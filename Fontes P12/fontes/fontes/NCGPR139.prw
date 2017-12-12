#include 'protheus.ch'


USER FUNCTION NCGPR139

	Local track := TrackingAdm():new()
	Local bRet := NIL
	
	bRet := track:chamaPergunte()
	
	While  bRet == 'TRUE' .Or. bRet == 'erro'
			
		If bRet == 'TRUE' 
			MsgRun("Capturando numero de registros...","Processando",{||track:montaQueryNumResult()})
			MsgRun("Processando os dados...","Processando",{|| track:MontaExecutaQuery()})
			If track:criaArquivo() == 'TRUE' 
				bRet := NIL
				bRet := track:chamaPergunte()
				LOOP			
			Else 
				bRet := NIL
				bRet := 'FALSE'
				LOOP
			End If
			
		ElseIf bRet == 'erro' 	
			bRet := track:chamaPergunte()
			LOOP	
		EndIf
	EndDo
Return nil
/*/{Protheus.doc} TrackingAdm
(long_description)
@author fbborges
@since 06/12/2016
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
class TrackingAdm 

	Data cQuery
	Data oTableTemp
	Data cPerg
	Data dDataDe
	Data dDataAte
	Data cVend
	Data cCanal
	Data aLinhas
	Data cNumRows
	Data oTabeCount
	Data nNumResul
	Data bDados
	Data nStatFinan
	Data nStatWms

	Method new() constructor 
	Method montaExecutaQuery()
	Method criaPergunte()
	Method chamaPergunte()
	Method corpoXml() 
	Method retornaDataFormatada()
	Method primeiraParteXml()
	Method segundaParteXml()
	Method criaArquivo()
	Method cabecalhoXml()
	Method montaQueryNumResult()
	Method DataComBarra()

Endclass

/*/{Protheus.doc} new
Metodo construtor
@author fbborges
@since 06/12/2016 
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
method new() class TrackingAdm
	Self:cPerg := "TRACKADM"
	
	Self:oTabeCount := GetNextAlias()
	Self:aLinhas := {}
	Self:cNumRows
	Self:nNumResul := 0
	
return

Method chamaPergunte() Class TrackingAdm

	Self:criaPergunte()
	
If Pergunte(Self:cPerg, .T.)

	Self:dDataDe 	:= DtoS(mv_par01)
	Self:dDataAte 	:= DtoS(mv_par02)
	Self:cVend 		:= AllTrim(mv_par03)
	Self:cCanal 	:= AllTrim(mv_par04)
	Self:nStatFinan	:= mv_par05
	Self:nStatWms 	:= mv_par06
	
	If !Empty(AllTrim(Self:dDataDe)) .And. Len(AllTrim(Self:dDataDe)) < 8
		Alert("A data 'DE' esta em formato incorreto")
		Return 'erro'
    ElseIf Empty(AllTrim(Self:dDataDe))
    	Alert("A data 'DE' não pode estar vazia!")
    	Return 'erro'
	ElseIf  !Empty(AllTrim(Self:dDataAte)) .And. Len(AllTrim(Self:dDataAte)) < 8
		Alert("A data 'ATE' esta em formato incorreto")
		Return 'erro'
	ElseIf Empty(AllTrim(Self:dDataAte))
		Alert("A data 'ATE' não pode estar vazia!")
		Return 'erro'
	EndIf
Else
	Return 'FALSE'
EndIf
Return 'TRUE'

Method criaPergunte() Class TrackingAdm
Local aArea := GetArea()
Local aHelpP	:= {}

PutSx1(Self:cPerg ,"01","Emissão do pedido de ?"  ,"Emissão do pedido de ?","Emissão do pedido de ?","mv_ch1","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)

PutSx1(Self:cPerg ,"02","Emissão do pedido até ?"  ,"Emissão do pedido até ?","Emissão do pedido até ?","mv_ch2","D",8,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)

PutSx1(Self:cPerg ,"03","Qual vendedor ?"  ,"Qual vendedor ?","Qual vendedor ?","mv_ch3","C",6,0,0,"G","","SA3","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP)

PutSx1(Self:cPerg ,"04","De qual canal ?"  ,"De qual canal ?","De qual canal ?","mv_ch4","C",6,0,0,"G","","ACA","","","mv_par04","","","","","","","","","","","","","","","","",aHelpP)

PutSx1(Self:cPerg ,"05","Parados no financeiro ?"  ,"Apenas pedidos parados no financeiro ?","Apenas pedidos parados no financeiro ?","mv_ch5","N",1,0,0,"C","","","","","mv_par05","Todos","Todos","Todos","","Não","Não","Não","Sim","Sim","Sim","","","","","","",aHelpP)

PutSx1(Self:cPerg ,"06","Integrados no WMS ?"  ,"Apenas pedidos integrados no WMS ?","Apenas pedidos integrados no WMS ?","mv_ch6","N",1,0,0,"C","","","","","mv_par06","Todos","Todos","Todos","","Não","Não","Não","Sim","Sim","Sim","","","","","","",aHelpP)

RestArea(aArea)

Return

Method montaExecutaQuery() Class TrackingAdm

Local cC9 		:= RetSQLName("SC9")
Local cA1		:= RetSQLName("SA1")
Local cC5		:= RetSQLName("SC5")
Local cC6		:= RetSQLName("SC6")
Local cFil		:= xFilial("SC5")
Local cF2		:= RetSQLName("SF2")
Local cP0b		:= RetSQLName("P0B")
Local cZ1		:= RetSQLName("SZ1")
Local cP0g		:= RetSQLName("P0G")

Self:oTableTemp := GetNextAlias()
//ProcRegua(RecCount()) 
//IncRegua("Processando dados")

Self:cQuery :="SELECT DISTINCT PROTHEUS_PRINCIPAL.pedido,                                                                                           "
Self:cQuery += "                PROTHEUS_PRINCIPAL.c5sf,                                                                                            "
Self:cQuery += "                PROTHEUS_PRINCIPAL.emissao,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.nomecli,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.codcli,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.lojacli,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.endereco,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.comple,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.municipio,                                                                                       "
Self:cQuery += "                PROTHEUS_PRINCIPAL.estado,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.vendedor,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.vdigitado,                                                                                       "
Self:cQuery += "                PROTHEUS_NF.FATURADO,          			                                                                            "
Self:cQuery += "                PROTHEUS_PRINCIPAL.operacao,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.libcredito,                                                                                      "
Self:cQuery += "                CASE WHEN P0B.LIBMARGEM IS NULL OR P0B.LIBMARGEM=' ' THEN  PROTHEUS_PRINCIPAL.C5MARGEM                              "
Self:cQuery += "                ELSE P0B.LIBMARGEM END LIBMARGEM,                                                                                   "
Self:cQuery += "                PROTHEUS_PRINCIPAL.libadm,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.entrega,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.linhas,                                                                                          "
Self:cQuery += "                PROTHEUS_PRINCIPAL.vendido,                                                                                         "
Self:cQuery += "                PROTHEUS_PRINCIPAL.liberado,                                                                                        "
Self:cQuery += "                PROTHEUS_NF.nota,                                                                                                   "
Self:cQuery += "                PROTHEUS_PRINCIPAL.canal,                                                                                           "
Self:cQuery += "                PROTHEUS_PRINCIPAL.c5transp,                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.wms,                                                                                             "
Self:cQuery += "                P0G.rastro,                					                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.condpag,                                                                                         "
Self:cQuery += "                PROTHEUS_NF.f2transp,                                                                                               "
Self:cQuery += "                PROTHEUS_NF.SERIE,	                                                                                                "
Self:cQuery += "                PROTHEUS_PRINCIPAL.DTSAIDA,	                                                                                        "
Self:cQuery += "                PROTHEUS_PRINCIPAL.DTENTRE	                                                                                        "
Self:cQuery += "FROM   (SELECT C5.c5_num                        AS PEDIDO,                                                                          "
Self:cQuery += "               C5.c5_xstaped                    AS C5SF,                                                                            "
Self:cQuery += "               C5.c5_emissao                    AS EMISSAO,                                                                         "
Self:cQuery += "               C5.c5_client                     AS CODCLI,                                                                          "
Self:cQuery += "               C5.c5_lojacli                    AS LOJACLI,                                                                         "
Self:cQuery += "               C5.c5_vend1                      AS VENDEDOR,                                                                        "
Self:cQuery += "               A1.a1_nome                       AS NOMECLI,                                                                         "
Self:cQuery += "               A1.a1_endent                     AS ENDERECO,                                                                        "
Self:cQuery += "               A1.a1_complem                    AS COMPLE,                                                                          "
Self:cQuery += "               A1.a1_mune                       AS MUNICIPIO,                                                                       "
Self:cQuery += "               A1.a1_este                       AS ESTADO,                                                                          "
Self:cQuery += "               C5.c5_transp                     AS C5TRANSP,                                                                        "
Self:cQuery += "               Sum(C6.c6_qtdven * C6.c6_prcven) AS VDIGITADO,                                                                       "

Self:cQuery += "               Z1.Z1_DTSAIDA                    AS DTSAIDA,                                                                       "
Self:cQuery += "               Z1.Z1_DTENTRE                    AS DTENTRE,                                                                       "

Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                            "
Self:cQuery += "                        AND Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                       "
Self:cQuery += "                        AND Sum(CASE WHEN C9.c9_blwms = '02' THEN 1 ELSE 0 END) > 0 THEN 'LIBERADO NO CREDITO'                      "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blcred ='10' AND C9.c9_blest ='10' AND C9.c9_blwms=' '  THEN 1 ELSE 0 END) > 0  			"
Self:cQuery += "                 THEN   'LIBERADO NO CREDITO'											                                            "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                             "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred = '09' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) = 0 THEN 'REJEITADO NO CREDITO'            "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                             "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred = '01' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) = 0 THEN 'PENDENTE DE APROVAÇÃO'           "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_blest IN ( ' ', '10' ) THEN 1 ELSE 0 END) > 0                                             "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred = '01' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                      AND Sum(CASE WHEN C9.c9_blcred IN ( ' ', '10' ) THEN 1 ELSE 0 END) <> 0 THEN 'EM PROCESSO DE APROVAÇÃO'           "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS LIBCREDITO,                                                                                                   "
Self:cQuery += "          CASE "
Self:cQuery += "   				 WHEN SUM(CASE WHEN C9.C9_BLCRED = '10' THEN 1 ELSE 0 END) > 0 THEN 'FATURADO' "
Self:cQuery += "   				 WHEN DC.STATUS = 'P' THEN 'EM OPERACAO' "
Self:cQuery += "   				 WHEN DC.STATUS <> 'P' AND SUM(CASE WHEN C9.C9_BLWMS = '02' THEN 1 ELSE 0 END) > 0 THEN 'PEDIDO AINDA NÃO ESTA EM WMS' "
Self:cQuery += "   				 ELSE ' ' "
Self:cQuery += "		 END AS OPERACAO, "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN C5.c5_ystatus = '02' THEN 'SUJEITO A APROVAÇÃO'                                                               "
Self:cQuery += "                 WHEN C5.c5_ystatus = '01' THEN 'PEDIDO LIBERADO NA MARGEM'                                                         "
Self:cQuery += "                 WHEN C5.c5_ystatus = '06'  THEN 'MARGEM APROVADA'                                                                  "
Self:cQuery += "                 END AS C5MARGEM,                                                                                                    "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(CASE WHEN C9.c9_datalib <> ' ' THEN 1 ELSE 0 END) > 0                                                     "
Self:cQuery += "                       OR C5.c5_dtlib <> ' ' THEN 'SIM'                                                                             "
Self:cQuery += "                 ELSE 'NÃO'                                                                                                         "
Self:cQuery += "               END AS LIBADM,                                                                                                         "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida = ' '                                                                            "
Self:cQuery += "                                 AND Z1.z1_dtentre = ' '                                                                            "
Self:cQuery += "                                 AND F2.f2_dataag = ' '                                                                             "
Self:cQuery += "                                 AND A1.a1_agend = '1' THEN 1                                                                       "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN                                                                                             "
Self:cQuery += "                 'FATURADO - AGUARDANDO DATA DE AGENDAMENTO'                                                                        "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida = ' '                                                                            "
Self:cQuery += "                                 AND Z1.z1_dtentre = ' '                                                                            "
Self:cQuery += "                                 AND F2.f2_dataag <> ' '                                                                            "
Self:cQuery += "                                 AND A1.a1_agend = '1' THEN 1                                                                       "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN 'FATURADO - AGENDADO'                                                                       "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida <> ' '                                                                           "
Self:cQuery += "                                 AND Z1.z1_dtentre = ' ' THEN 1                                                                     "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN 'FATURADO - EXPEDIDO'                                                                       "
Self:cQuery += "                 WHEN Sum(CASE                                                                                                      "
Self:cQuery += "                            WHEN C9.c9_nfiscal <> ' '                                                                               "
Self:cQuery += "                                 AND Z1.z1_dtsaida <> ' '                                                                           "
Self:cQuery += "                                 AND Z1.z1_dtentre <> ' ' THEN 1                                                                    "
Self:cQuery += "                            ELSE 0                                                                                                  "
Self:cQuery += "                          END) > 0 THEN 'FATURADO - ENTREGUE'                                                                       "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS ENTREGA,                          							                                                "
Self:cQuery += "               Count(C6.c6_produto) AS LINHAS,             				                                                            "
Self:cQuery += "               Sum(C6.c6_qtdven)                VENDIDO,                                                                            "
Self:cQuery += "               CASE                                                                                                                 "
Self:cQuery += "                 WHEN Sum(C9.c9_qtdlib) IS NULL THEN 0                                                                              "
Self:cQuery += "                 ELSE Sum(C9.c9_qtdlib)                                                                                             "
Self:cQuery += "               END AS LIBERADO,                                         							                                "
Self:cQuery += "               C5.c5_ycanal                     AS CANAL,           	                                                            "
Self:cQuery += "CASE "
Self:cQuery += "   WHEN SUM(CASE WHEN DCSE.DT_HOR_DISPONIVEL_CONFERENCIA IS NOT NULL THEN 1 ELSE 0 END) > 0 THEN 'CONFERENCIA FINALIZADA' "
Self:cQuery += "   WHEN SUM(CASE WHEN DCE.DT_HOR_INICIO_SEPARACAO IS NOT NULL THEN 1 ELSE 0 END) > 0 THEN 'SEPARAÇÃO INICIADA' "
Self:cQuery += "   WHEN SUM(CASE WHEN DCE.DT_HOR_DISPONIVEL_SEPARACAO IS NOT NULL THEN 1 ELSE 0 END) > 0 THEN 'DISPONIVEL PARA SEPARAÇÃO' "
Self:cQuery += "   WHEN sum( case when WCES.CES_NUM_DOCUMENTO <> ' ' then 1 else 0 end) > 0 AND DC.STATUS NOT IN ('P', 'NP') "
Self:cQuery += "        AND SUM(CASE WHEN C9.C9_BLWMS = '02' THEN 1 ELSE 0 END) > 0 THEN 'CACELADO NO WMS' "
Self:cQuery += "   WHEN sum( case when WCES.CES_NUM_DOCUMENTO <> ' ' then 1 else 0 end) = 0 "
Self:cQuery += "        AND SUM (CASE WHEN DC.STATUS IN ('P','NP') THEN 1 ELSE 0 END) > 0 "
Self:cQuery += "        AND SUM(CASE WHEN C9.C9_BLWMS = '02' THEN 1 ELSE 0 END) > 0 THEN 'PEDIDO INTEGRADO NO WMS' " 
Self:cQuery += "   WHEN sum( case when WCES.CES_NUM_DOCUMENTO <> ' ' then 1 else 0 end) = 0 "
Self:cQuery += "        AND SUM (CASE WHEN DC.STATUS IN ('P', 'NP') THEN 1 ELSE 0 END) = 0 "
Self:cQuery += "        AND SUM(CASE WHEN C9.C9_BLWMS = '02' THEN 1 ELSE 0 END) > 0 THEN 'PEDIDO NÃO INTEGRADO NO WMS' "
Self:cQuery += "   ELSE ' ' "
Self:cQuery += "END AS WMS, "
Self:cQuery += "               C5.c5_condpag                    AS CONDPAG                                                                          "
Self:cQuery += "        FROM   "+ cC5 +" C5                                                                                                         "
Self:cQuery += "               LEFT JOIN "+ cC6 +" C6                                                                                               "
Self:cQuery += "                      ON C5.c5_num = C6.c6_num                                                                                      "
Self:cQuery += "                         AND C6.c6_filial = C5.c5_filial                                                                            "
Self:cQuery += "                         AND C6.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND C6.c6_cli = C5.c5_client                                                                               "
Self:cQuery += "                         AND C6.c6_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "               LEFT JOIN "+ cC9 +" C9                                                                                               "
Self:cQuery += "                      ON C9.c9_pedido = C5.c5_num                                                                                   "
Self:cQuery += "                         AND C9.c9_filial = C5.c5_filial                                                                            "
Self:cQuery += "                         AND C9.c9_pedido = C6.c6_num                                                                               "
Self:cQuery += "                         AND C9.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND C9.c9_cliente = C5.c5_client                                                                           "
Self:cQuery += "                         AND C9.c9_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "                         AND C9.c9_produto IN (C6.c6_produto)                                                                       "
Self:cQuery += "               LEFT JOIN "+ cF2 +" F2                                                                                               "
Self:cQuery += "                      ON F2.f2_doc = C9.c9_nfiscal                                                                                  "
Self:cQuery += "                         AND F2.f2_filial = C9.c9_filial                                                                            "
Self:cQuery += "                         AND F2.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND F2.f2_client = C9.c9_cliente                                                                           "
Self:cQuery += "                         AND F2.f2_loja = C9.c9_loja                                                                                "
Self:cQuery += "               LEFT JOIN "+ cZ1 +" Z1                                                                                               "
Self:cQuery += "                      ON Z1.z1_doc = F2.f2_doc                                                                                      "
Self:cQuery += "                         AND Z1.z1_filial = F2.f2_filial                                                                            "
Self:cQuery += "                         AND Z1.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "                         AND Z1.z1_cliente = C5.c5_client                                                                           "
Self:cQuery += "                         AND Z1.z1_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "               LEFT JOIN "+ cA1 +" A1                                                                                               "
Self:cQuery += "                      ON A1.a1_cod = C5.c5_client                                                                                   "
Self:cQuery += "                         AND A1.a1_loja = C5.c5_lojacli                                                                             "
Self:cQuery += "                         AND A1.d_e_l_e_t_ = ' '                                                                                    "
Self:cQuery += "               LEFT JOIN wms.tb_wmsinterf_doc_saida DC                                                                              "
Self:cQuery += "                      ON Trim(C5.c5_num) = DC.dpcs_num_documento                                                                    "
Self:cQuery += "               LEFT JOIN wms.viw_doc_separacao_erp DCE                                                                              "
Self:cQuery += "                      ON Substr(DCE.documento_erp, 3, Length(DCE.documento_erp))                                                    "
Self:cQuery += "                         =                                                                                                          "
Self:cQuery += "                         Trim(C5.c5_num)                                                                                            "
Self:cQuery += " 			   LEFT JOIN wms.VIW_DOC_SAIDA_ERP DCSE																					"
Self:cQuery += " 				      ON Substr(DCSE.documento_erp, 3, Length(DCSE.documento_erp)) = Trim(C5.c5_num)								"
Self:cQuery += "               LEFT JOIN wms.tb_wmsinterf_canc_ent_sai WCES                                                                         "
Self:cQuery += "                      ON WCES.ces_num_documento = Trim(C5.c5_num)                                                                   "
Self:cQuery += "        WHERE  C5.c5_filial = '"+cFil+"'                                                                                            "
Self:cQuery += "               AND C5.d_e_l_e_t_ = ' '                                                                                              "
Self:cQuery += "               AND C5.C5_EMISSAO BETWEEN '"+Self:dDataDe+"' AND '"+Self:dDataAte+"'                                      	               "
Self:cQuery += "               AND C5.C5_CONDPAG <> '000'                                                    "
Self:cQuery += "               AND C5.C5_XSTAPED <> '00'                                                      "


If !Empty(Self:cVend)
Self:cQuery += "               AND C5.C5_VEND1 = '"+Self:cVend+"'                                                    "
EndIF

If !Empty(Self:cCanal)
Self:cQuery += "               AND C5.C5_YCANAL ='"+Self:cCanal+"'                                                     "
EndIf

Self:cQuery += "        GROUP  BY C5.c5_num,                                                                                                        "
Self:cQuery += "                  C5.c5_xstaped,                                                                                                    "
Self:cQuery += "                  C5.c5_client,                                                                                                     "
Self:cQuery += "                  C5.c5_lojacli,                                                                                                    "
Self:cQuery += "                  C5.c5_dtlib,                                                                                                      "
Self:cQuery += "                  C5.c5_ycanal,                                                                                                     "
Self:cQuery += "                  C5.c5_vend1,                                                                                                      "
Self:cQuery += "                  C5.c5_emissao,                                                                                                    "
Self:cQuery += "                  C5.c5_ystatus,                                                                                                    "
Self:cQuery += "                  A1.a1_nome,                                                                                                       "
Self:cQuery += "                  A1.a1_endent,                                                                                                     "
Self:cQuery += "                  A1.a1_mune,                                                                                                       "
Self:cQuery += "                  A1.a1_este,                                                                                                       "
Self:cQuery += "                  A1.a1_complem,                                                                                                    "
Self:cQuery += "                  C5.c5_transp,                                                                                                     "
Self:cQuery += "                  DC.status,                                                                                                        "
Self:cQuery += "                  DCE.dt_hor_inicio_separacao,                                                                                      "
Self:cQuery += "                  DCE.dt_hor_disponivel_separacao,                                                                                  "
Self:cQuery += "                  WCES.ces_num_documento,                                                                                           "
Self:cQuery += "                  C5.c5_condpag,                                                                                                    "
Self:cQuery += " 				  Z1.Z1_DTSAIDA,																									"
Self:cQuery += " 				  Z1.Z1_DTENTRE																										"	
Self:cQuery += "                  ) PROTHEUS_PRINCIPAL                                                                                              "
Self:cQuery += "       LEFT JOIN (SELECT C9NF.c9_pedido AS PEDIDO,                                                                                  "
Self:cQuery += "                         F2NF.f2_doc    AS NOTA,                                                                                    "
Self:cQuery += "                         F2NF.f2_transp AS F2TRANSP,                                                                                "
Self:cQuery += "                         F2NF.F2_SERIE AS SERIE,                                                                                    "
Self:cQuery += "                         F2NF.F2_VALBRUT AS FATURADO                                                                        	    "
Self:cQuery += "                  FROM   "+ cC9 +" C9NF                                                                                             "
Self:cQuery += "                         LEFT JOIN "+ cF2 +" F2NF                                                                                   "
Self:cQuery += "                                ON C9NF.c9_nfiscal = F2NF.f2_doc                                                                    "
Self:cQuery += "                  WHERE  C9NF.c9_filial = '"+ cFil +"'                                                                              "
Self:cQuery += "                         AND C9NF.d_e_l_e_t_ = ' '                                                                                  "
Self:cQuery += "                         AND F2NF.f2_filial = '"+ cFil +"'                                                                          "
Self:cQuery += "                         AND F2NF.d_e_l_e_t_ = ' '                                                                                  "
Self:cQuery += "                  GROUP  BY C9NF.c9_pedido,                                                                                         "
Self:cQuery += "                            F2NF.f2_doc,                                                                                            "
Self:cQuery += "                            F2NF.f2_SERIE,                                                                                          "
Self:cQuery += "                            F2NF.F2_VALBRUT,                                                                                        "
Self:cQuery += "                            F2NF.f2_transp) PROTHEUS_NF                                                                             "
Self:cQuery += "              ON PROTHEUS_PRINCIPAL.pedido = PROTHEUS_NF.pedido                                                                     "
Self:cQuery += "                 AND PROTHEUS_NF.nota IS NOT NULL                                                                                   "
Self:cQuery += "        LEFT JOIN (                                                                                                                 "
Self:cQuery += "          SELECT                                                                                                                    "
Self:cQuery += "          P0B_PEDIDO AS PEDIDO,                                                                                                     "
Self:cQuery += "          P0B_CODCLI AS CLIENTE,                                                                                                    "
Self:cQuery += "          P0B_LOJA AS LOJA,                                                                                                         "
Self:cQuery += "          CASE                                                                                                                      "
Self:cQuery += "           WHEN Count(p0b_status) = Sum(CASE WHEN p0b_status = '04'THEN 1 ELSE 0 END) THEN 'MARGEM APROVADA'                        "
Self:cQuery += "                 WHEN Count(p0b_status) = Sum(CASE WHEN p0b_status = '05' THEN 1 ELSE 0 END) THEN 'MARGEM REJEITADA'                "
Self:cQuery += "                 WHEN Sum(CASE WHEN p0b_status = '01' THEN 1 ELSE 0 END) > 0                                                        "
Self:cQuery += "                      AND Sum(CASE WHEN p0b_status = ' ' THEN 1 ELSE 0 END) > 0 THEN 'PENDENTE DE APROVAÇÃO DE MARGEM'              "
Self:cQuery += "                 WHEN Count(p0b_status) < Sum(CASE WHEN p0b_status = '03' THEN 1 ELSE 0 END)                                        "
Self:cQuery += "                      AND ( Sum(CASE WHEN p0b_status = '04' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                             OR Sum(CASE WHEN p0b_status = '05' THEN 1 ELSE 0 END) > 0 )                                            "
Self:cQuery += "                      AND Count(p0b_status) < Sum(CASE WHEN p0b_status = '05' THEN 1 ELSE 0 END)                                    "
Self:cQuery += "                       OR ( Sum(CASE WHEN p0b_status = '03' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                            AND Sum(CASE WHEN p0b_status = '02' THEN 1 ELSE 0 END) > 0 )                                            "
Self:cQuery += "                       OR ( Sum(CASE WHEN p0b_status = '03' THEN 1 ELSE 0 END) > 0                                                  "
Self:cQuery += "                            AND Sum(CASE WHEN p0b_status = '01' THEN 1 ELSE 0 END) > 0 ) THEN 'EM PROCESSO DE APROVAÇÃO DE MARGEM'  "
Self:cQuery += "                 ELSE ' '                                                                                                           "
Self:cQuery += "               END AS LIBMARGEM                                                                                                     "
Self:cQuery += "               FROM " + cP0b +"                                                                                                     "
Self:cQuery += "               WHERE D_E_L_E_T_ = ' '                                                                                               "
Self:cQuery += "               GROUP BY P0B_PEDIDO,                                                                                                 "
Self:cQuery += "                P0B_CODCLI ,                                                                                                        "
Self:cQuery += "                P0B_LOJA                                                                                                            "
Self:cQuery += "        )P0B                                                                                                                        "
Self:cQuery += "        ON P0B.PEDIDO = PROTHEUS_PRINCIPAL.pedido                                                                                   "
Self:cQuery += "        AND P0B.CLIENTE = PROTHEUS_PRINCIPAL.codcli                                                                                 "
Self:cQuery += "        AND P0B.LOJA= PROTHEUS_PRINCIPAL.lojacli																					"
Self:cQuery += "               LEFT JOIN (                                                          "
Self:cQuery += "               SELECT P0G_PEDIDO PEDIDO,                                            "
Self:cQuery += "                 CASE WHEN COUNT(P0G_RAST ) = 1 THEN  P0G_RAST ELSE ' ' END RASTRO	"
Self:cQuery += "                 FROM "+ cP0g +"                                                    "
Self:cQuery += "               WHERE D_E_L_E_T_=' '                                                 "
Self:cQuery += "               AND P0G_FILIAL = '" +cFil+ "'                                        "
Self:cQuery += "               GROUP BY P0G_PEDIDO,                                                 "
Self:cQuery += "                         P0G_RAST                                                   "
Self:cQuery += "               )P0G                                                                 "
Self:cQuery += "               ON P0G.PEDIDO =  PROTHEUS_PRINCIPAL.pedido							"

	If Self:nStatFinan == 3
		Self:cQuery += "WHERE PROTHEUS_PRINCIPAL.LIBCREDITO IN ('EM PROCESSO DE APROVAÇÃO', 'PENDENTE DE APROVAÇÃO','REJEITADO NO CREDITO') "
	ElseIf Self:nStatFinan == 2
		Self:cQuery += "WHERE PROTHEUS_PRINCIPAL.LIBCREDITO NOT IN ('EM PROCESSO DE APROVAÇÃO', 'PENDENTE DE APROVAÇÃO','REJEITADO NO CREDITO') "	
			
	EndIf
	
	If Self:nStatWms == 3 .And. Self:nStatFinan != 1
		Self:cQuery += "AND PROTHEUS_PRINCIPAL.WMS IN ('PEDIDO INTEGRADO NO WMS','DISPONIVEL PARA SEPARAÇÃO','SEPARAÇÃO INICIADA','CONFERENCIA FINALIZADA') "
	ElseIf Self:nStatWms == 2 .And. Self:nStatFinan != 1
		Self:cQuery += "AND PROTHEUS_PRINCIPAL.WMS NOT IN ('PEDIDO INTEGRADO NO WMS','DISPONIVEL PARA SEPARAÇÃO','SEPARAÇÃO INICIADA','CONFERENCIA FINALIZADA') "
	ElseIf Self:nStatWms == 3 .And. Self:nStatFinan == 1
		Self:cQuery += "WHERE PROTHEUS_PRINCIPAL.WMS IN ('PEDIDO INTEGRADO NO WMS','DISPONIVEL PARA SEPARAÇÃO','SEPARAÇÃO INICIADA','CONFERENCIA FINALIZADA') "
	ElseIf Self:nStatWms == 2 .And. Self:nStatFinan == 1
		Self:cQuery += "WHERE PROTHEUS_PRINCIPAL.WMS NOT IN ('PEDIDO INTEGRADO NO WMS','DISPONIVEL PARA SEPARAÇÃO','SEPARAÇÃO INICIADA','CONFERENCIA FINALIZADA') "
	EndIf

	Self:cQuery := ChangeQuery(Self:cQuery)
	dbUseArea(.T., 'TOPCONN', TCGenQry(,,Self:cQuery),Self:oTableTemp, .F., .T.)
	
	//IndRegua( 'TRB', cIndArqA,'A1_COD+A1_NOME',,,"Selecionando Registros...")
	
	dbSelectArea(Self:oTableTemp)
	// IncProc()
Return

Method corpoXml() Class TrackingAdm
	Local cArquivo
	Local aCabTab := {'<Table ss:ExpandedColumnCount="23" ss:ExpandedRowCount="',1,'" x:FullColumns="1"   x:FullRows="1" ss:DefaultRowHeight="15">'}
	Local cLinhas :=""
	Local cCabecalho 
	Local cLinkRas  := superGetMv("EC_NCG0021",,"http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=")
	Local cLinkDir  := superGetMv("EC_NCG0025",,"https://www.directlog.com.br/tracking/index.asp?cod=28011&tipo=1&valor=")
	Local aStatEntre := {'FATURADO - AGUARDANDO DATA DE AGENDAMENTO', 'FATURADO - AGENDADO', 'FATURADO - EXPEDIDO', 'FATURADO - ENTREGUE'}
	
			
	If Self:nNumResul != 0
		ProcRegua(Self:nNumResul)
		
	while (Self:oTableTemp)->(!EOF())
		IncProc()
		
	If Val((Self:oTableTemp)->(C5SF)) < 10 .Or. AllTrim((Self:oTableTemp)->(CONDPAG)) == "000"
		cLinhas+='<Row ss:AutoFitHeight="0">'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(PEDIDO) +'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(CODCLI)+'/'+(Self:oTableTemp)->(LOJACLI)+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(NOMECLI))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(ENDERECO))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(COMPLE))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(MUNICIPIO))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(ESTADO)+'</Data></Cell>'
		ACA->(DbSelectArea("ACA"))
		ACA->(DbSetOrder(1))
		
		If ACA->(DbSeek(xFilial("ACA")+(Self:oTableTemp)->(CANAL)))
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(ACA->ACA_DESCRI)+'</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(CANAL))+'</Data></Cell>'
		EndIF
		
		//Self:oHtml:ValByName("cTipoPedido","OUTRAS REMESSAS(RMA, MARKETING, ETC...)")
		SA3->(DbSelectArea("SA3"))
		SA3->(DbSetOrder(1))
		
		If SA3->(DbSeek(xFilial("SA3")+(Self:oTableTemp)->(VENDEDOR)))
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(SA3->A3_NOME)+'</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(VENDEDOR))+'</Data></Cell>'
		EndIf
		
		cLinhas+='<Cell ss:StyleID="s66"><Data ss:Type="DateTime">'+Self:retornaDataFormatada((Self:oTableTemp)->(EMISSAO))+'T00:00:00.000</Data></Cell>'

		SA4->(DbSelectArea("SA4"))
		SA4->(DbSetOrder(1))
		
		IF !Empty(AllTrim((Self:oTableTemp)->(F2TRANSP)))
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:oTableTemp)->(F2TRANSP))))
			
			cTransp := EncodeUtf8(SA4->A4_NOME)
		Else
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:oTableTemp)->(C5TRANSP))))			
			cTransp := EncodeUtf8(SA4->A4_NOME)
		EndIf
		

		
		If 	!Empty(AllTrim((Self:oTableTemp)->(RASTRO)))
			If Len(AllTrim((Self:oTableTemp)->(RASTRO))) == 13				
				If !Empty((Self:oTableTemp)->(DTSAIDA))
					cLinhas+='<Cell><Data ss:Type="String">'+cTransp+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
				Else
					cLinhas+='<Cell><Data ss:Type="String">'+cTransp+'</Data></Cell>'
				EndIf
                
					cLinhas+='<Cell ss:StyleID="s63" ss:HRef="'+cLinkRas+AllTrim((Self:oTableTemp)->(RASTRO))+'"><Data ss:Type="String">'+AllTrim((Self:oTableTemp)->(RASTRO))+'</Data></Cell>'

			ElseIf Len(AllTrim((Self:oTableTemp)->(RASTRO))) == 14
			
				If !Empty((Self:oTableTemp)->(DTSAIDA))
					cLinhas+='<Cell><Data ss:Type="String">'+cTransp+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
				Else
					cLinhas+='<Cell><Data ss:Type="String">'+cTransp+'</Data></Cell>'
				EndIf
				
				cLinhas+='<Cell ss:StyleID="s63" ss:HRef="'+cLinkDir+AllTrim((Self:oTableTemp)->(RASTRO))+'"><Data ss:Type="String">'+AllTrim((Self:oTableTemp)->(RASTRO))+'</Data></Cell>'
				
			EndIf
		Else
			If !Empty(AllTrim(cTransp))
			 	If AllTrim(cTransp) != "CORREIOS" && AllTrim(cTransp) != "SEDEX" && AllTrim(cTransp) != "PAC" && AllTrim(cTransp) != "E-SEDEX"
			 		
	                If !Empty((Self:oTableTemp)->(DTSAIDA))
						cLinhas+='<Cell><Data ss:Type="String">'+cTransp+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
					Else
						cLinhas+='<Cell><Data ss:Type="String">'+cTransp+'</Data></Cell>'
					EndIf
						cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+'</Data></Cell>'
			 	EndIf
			Else
				If !Empty((Self:oTableTemp)->(DTSAIDA))
			 		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
			 		
			 	Else
			 		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+'</Data></Cell>'
			 	EndIf
			 	cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+'</Data></Cell>'
			EndIf
		EndIf
		
		
		//cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Moeda">'+TRANSFORM(Round((Self:oTableTemp)->(VDIGITADO),2),"@R 999.999,99")+'</Data></Cell>'
		//cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Moeda">'+AllTrim(TRANSFORM(Round((Self:oTableTemp)->(VDIGITADO),2),"@R 999999999.99"))+'</Data></Cell>'
		If Round((Self:oTableTemp)->(VDIGITADO),2) == 0 .Or. Empty((Self:oTableTemp)->(VDIGITADO))
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">0.00</Data></Cell>'
		Else
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">'+AllTrim(TRANSFORM(Round((Self:oTableTemp)->(VDIGITADO),2),"@R 999999999.99"))+'</Data></Cell>'
		EndIF
		
		cLinhas+='<Cell><Data ss:Type="String">'+AllTrim(STR((Self:oTableTemp)->(VENDIDO)))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String"> </Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String"> </Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String"> </Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String"> </Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String"> </Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(NOTA)+'</Data></Cell>'
		
		If (Self:oTableTemp)->(FATURADO) == 0 .Or. Empty((Self:oTableTemp)->(FATURADO))
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">0.00</Data></Cell>'
		Else
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">'+AllTrim(TRANSFORM(Round((Self:oTableTemp)->(FATURADO),2),"@R 999999999.99"))+'</Data></Cell>'

		EndIf
		cLinhas+='<Cell><Data ss:Type="String"> </Data></Cell>'
		/*Acrescentar a data de entrega*/
		If AllTrim((Self:oTableTemp)->(ENTREGA)) == aStatEntre[4]
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(AllTrim((Self:oTableTemp)->(ENTREGA)))+" - DATA DE ENTREGA: "+Self:DataComBarra((Self:oTableTemp)->(DTENTRE))+'</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(ENTREGA))+'</Data></Cell>'
		EndIf
		
		ACA->(DbCloseArea("ACA"))
		SA4->(DbCloseArea("SA4"))		
		SA3->(DbCloseArea("SA3"))
	Else
	/*************************************************************************/
		//Self:oHtml:ValByName("cTipoPedido","PEDIDO DE VENDA")
		
		cLinhas+='<Row ss:AutoFitHeight="0">'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(PEDIDO)+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(CODCLI)+'/'+(Self:oTableTemp)->(LOJACLI)+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(STRTRAN((Self:oTableTemp)->(NOMECLI),"&",'&amp;'))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(ENDERECO))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(COMPLE))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(MUNICIPIO))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(ESTADO)+'</Data></Cell>'
		
		ACA->(DbSelectArea("ACA"))
		ACA->(DbSetOrder(1))
		
		If ACA->(DbSeek(xFilial("ACA")+(Self:oTableTemp)->(CANAL)))
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(ACA->ACA_DESCRI)+'</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(CANAL))+'</Data></Cell>'
		EndIF
				
		SA3->(DbSelectArea("SA3"))
		SA3->(DbSetOrder(1))
		
		If SA3->(DbSeek(xFilial("SA3")+(Self:oTableTemp)->(VENDEDOR)))
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(SA3->A3_NOME)+'</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(VENDEDOR))+'</Data></Cell>'
		EndIf		
								
		cLinhas+='<Cell ss:StyleID="s66"><Data ss:Type="DateTime">'+Self:retornaDataFormatada((Self:oTableTemp)->(EMISSAO))+'T00:00:00.000</Data></Cell>'
		
		SA4->(DbSelectArea("SA4"))
		SA4->(DbSetOrder(1))
		
		//Verifica se a transportadora da F2 ja existe e insere na variavel cTransp o nome da transportadora
		IF !Empty(AllTrim((Self:oTableTemp)->(F2TRANSP)))
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:oTableTemp)->(F2TRANSP))))
			
			cTransp := SA4->A4_NOME 
		Else
			
			SA4->(DbSeek(xFilial("SA4") + AllTrim((Self:oTableTemp)->(C5TRANSP))))
			
			cTransp := SA4->A4_NOME 
		EndIf
		
		If 	!Empty(AllTrim((Self:oTableTemp)->(RASTRO))) && (AllTrim(cTransp) == "CORREIOS" .Or. AllTrim(cTransp) == "SEDEX" .Or. AllTrim(cTransp) == "PAC" .Or. AllTrim(cTransp) == "E-SEDEX"))
			If Len(AllTrim((Self:oTableTemp)->(RASTRO))) == 13				
				If !Empty((Self:oTableTemp)->(DTSAIDA))
					cLinhas+='<Cell><Data ss:Type="String">'+ EncodeUtf8(cTransp)+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
				Else
					cLinhas+='<Cell><Data ss:Type="String">'+ EncodeUtf8(cTransp) +'</Data></Cell>'
				EndIf  
				cLinhas+='<Cell ss:StyleID="s63" ss:HRef="'+StrTran(cLinkRas+AllTrim((Self:oTableTemp)->(RASTRO)),'&','&amp;')+'"><Data ss:Type="String">'+AllTrim((Self:oTableTemp)->(RASTRO))+'</Data></Cell>'             
			ElseIf Len(AllTrim((Self:oTableTemp)->(RASTRO))) == 14
				
				If !Empty((Self:oTableTemp)->(DTSAIDA))
					cLinhas+='<Cell><Data ss:Type="String">'+ EncodeUtf8(cTransp)+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
				Else
					cLinhas+='<Cell><Data ss:Type="String">'+ EncodeUtf8(cTransp)+'</Data></Cell>'
				EndIf
				cLinhas+='<Cell ss:StyleID="s63" ss:HRef="'+StrTran(cLinkDir+AllTrim((Self:oTableTemp)->(RASTRO)),'&','&amp;')+'"><Data ss:Type="String">'+AllTrim((Self:oTableTemp)->(RASTRO))+'</Data></Cell>'
				
			EndIf
		Else
			If !Empty(AllTrim(cTransp))
			 	If AllTrim(cTransp) != "CORREIOS" && AllTrim(cTransp) != "SEDEX" && AllTrim(cTransp) != "PAC" && AllTrim(cTransp) != "E-SEDEX"
		
	                If !Empty((Self:oTableTemp)->(DTSAIDA))
						cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(cTransp)+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
					Else
						cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(cTransp)+'</Data></Cell>'
					EndIf
					cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+'</Data></Cell>'

			 	EndIf
			Else
				If !Empty((Self:oTableTemp)->(DTSAIDA))
			 		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+" - DATA DE SAIDA: "+ Self:DataComBarra((Self:oTableTemp)->(DTSAIDA)) +'</Data></Cell>'
			 		
			 	Else
			 		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+'</Data></Cell>'
			 	EndIf
			 	cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8('NÃO POSSUI')+'</Data></Cell>'
			EndIf
		EndIf
		
		If Round((Self:oTableTemp)->(VDIGITADO),2) == 0 .Or. Empty((Self:oTableTemp)->(VDIGITADO))
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">0.00</Data></Cell>'
		Else
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">'+AllTrim(TRANSFORM(Round((Self:oTableTemp)->(VDIGITADO),2),"@R 999999999.99"))+'</Data></Cell>'
		End IF
		

		cLinhas+='<Cell><Data ss:Type="String">'+ALLTRIM(STR((Self:oTableTemp)->(VENDIDO)))+'</Data></Cell>'
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(LIBMARGEM))+'</Data></Cell>'	
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(LIBADM))+'</Data></Cell>'	
		
		IF (Self:oTableTemp)->(LIBERADO) == 0
			cLinhas+='<Cell><Data ss:Type="String">0</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+AllTrim(STR((Self:oTableTemp)->(LIBERADO)))+'</Data></Cell>'	
		EndIf
		
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(LIBCREDITO))+'</Data></Cell>'	
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(WMS))+'</Data></Cell>'	
		cLinhas+='<Cell><Data ss:Type="String">'+(Self:oTableTemp)->(NOTA)+'</Data></Cell>'
		
		If (Self:oTableTemp)->(FATURADO) == 0 .Or. Empty((Self:oTableTemp)->(FATURADO))
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">0.00</Data></Cell>'	
		Else
			cLinhas+='<Cell ss:StyleID="s68"><Data ss:Type="Number">'+AllTrim(TRANSFORM(Round((Self:oTableTemp)->(FATURADO),2),"@R 999999999.99"))+'</Data></Cell>'

		EndIf
		
		//Busca o historicodo do agendamento se houver
		SE1->(DbSelectArea("SE1"))
		SE1->(DbSetOrder(29))
		SE1->(DbSeek(xFilial("SE1")+AllTrim((Self:oTableTemp)->(NOTA))+AllTrim((Self:oTableTemp)->(SERIE))))
		
		cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(AllTrim(SE1->E1_HISTWF))+'</Data></Cell>'
		
		If AllTrim((Self:oTableTemp)->(ENTREGA)) == aStatEntre[4]
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8(AllTrim((Self:oTableTemp)->(ENTREGA)))+" - DATA DE ENTREGA: "+Self:DataComBarra((Self:oTableTemp)->(DTENTRE))+'</Data></Cell>'
		Else
			cLinhas+='<Cell><Data ss:Type="String">'+EncodeUtf8((Self:oTableTemp)->(ENTREGA))+'</Data></Cell>'
		EndIf
				
		SE1->(DbCloseArea("SE1"))
		SA4->(DbCloseArea("SA4"))
		SA3->(DbCloseArea("SA3"))
		ACA->(DbCloseArea("ACA"))
	EndIF	
		cLinhas+="</Row>"+CRLF
		aCabTab[2]++
		(Self:oTableTemp)->(DbSkip())
		AADD(Self:aLinhas,cLinhas)
		cLinhas:=""
	EndDo

	
	//cLinhas := self:primeiraParteXml()+ cCabecalho + aCabTab[1] + STR(aCabTab[2]) + aCabTab[3] + cLinhas + self:segundaParteXml()
	  
	  Self:cNumRows := aCabTab[1] + AllTrim(STR(aCabTab[2])) + aCabTab[3]
	  	Self:bDados := "TRUE"
	  Else
	  	Self:bDados := "FALSE"
	  EndIF
	 
Return 

Method retornaDataFormatada(dData) Class TrackingAdm
	If !Empty(dData)
		dData = substr(dData,1,4)+"-"+substr(dData,5,2)+"-"+substr(dData,7,2)
	EndIF
Return dData

Method cabecalhoXml() Class TrackingAdm
	
cCabecalho='<Column ss:Width="36.75"/>'+CRLF
cCabecalho+='<Column ss:Width="62.25"/>'+CRLF
cCabecalho+='<Column ss:Width="63.75" ss:Span="1"/>'+CRLF
cCabecalho+='<Column ss:Index="5" ss:Width="69"/>'+CRLF
cCabecalho+='<Column ss:Width="47.25"/>'+CRLF
cCabecalho+='<Column ss:Width="37.5"/>'+CRLF
cCabecalho+='<Column ss:Width="81"/>'+CRLF
cCabecalho+='<Column ss:Width="47.25"/>'+CRLF
cCabecalho+='<Column ss:Width="42"/>'+CRLF
cCabecalho+='<Column ss:Width="83.25"/>'+CRLF
cCabecalho+='<Column ss:Width="45"/>'+CRLF
cCabecalho+='<Column ss:Width="75"/>'+CRLF
cCabecalho+='<Column ss:Width="82.5"/>'+CRLF
cCabecalho+='<Column ss:Width="77.25"/>'+CRLF
cCabecalho+='<Column ss:Width="45"/>'+CRLF
cCabecalho+='<Column ss:Width="84"/>'+CRLF
cCabecalho+='<Column ss:Width="39.75"/>'+CRLF
cCabecalho+='<Column ss:Width="60"/>'+CRLF
cCabecalho+='<Column ss:Width="59.25"/>'+CRLF
cCabecalho+='<Column ss:Width="48.75"/>'+CRLF
cCabecalho+='<Column ss:Width="102.75"/>'+CRLF
cCabecalho+='<Column ss:Width="91.5"/>'+CRLF
cCabecalho+='<Row ss:AutoFitHeight="0">'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">PEDIDO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">CLIENTE/LOJA</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">NOME CLIENTE</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">ENDEREÇO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">COMPLEMENTO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">MUNICIPIO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">ESTADO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">CANAL DE VENDAS</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">VENDEDOR</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">EMISSÃO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">TRANSPORTADORA</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">RASTREIO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">VALOR DIGITADO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">QTD. UNI. DIGITADO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">MARGEM LIQUIDA</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">LIBERADO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">QTD. UNI. LIBERADO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">CRÉDITO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">STATUS WMS</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">NOTA FISCAL</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">FATURADO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">STATUS AGENDAMENTO</Data></Cell>'+CRLF
cCabecalho+='<Cell ss:StyleID="s63"><Data ss:Type="String">STATUS DA ENTREGA</Data></Cell>'+CRLF
cCabecalho+='</Row>'+CRLF
Return cCabecalho

Method primeiraParteXml() Class TrackingAdm
	Local cXml := ""
cXml='<?xml version="1.0"?>'+CRLF
cXml+='<?mso-application progid="Excel.Sheet"?>'+CRLF
cXml+='<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" '
 cXml+='xmlns:o="urn:schemas-microsoft-com:office:office" '
 cXml+='xmlns:x="urn:schemas-microsoft-com:office:excel" '
 cXml+='xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" '
 cXml+='xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
 cXml+='<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
  cXml+='<Author>Flavio Borges</Author>'+CRLF
  cXml+='<LastAuthor>Flavio Borges</LastAuthor>'+CRLF
  cXml+='<Created>2016-12-07T15:42:36Z</Created>'+CRLF
  cXml+='<LastSaved>2016-12-07T15:45:47Z</LastSaved>'+CRLF
  cXml+='<Version>15.00</Version>'+CRLF
 cXml+='</DocumentProperties>'+CRLF
 cXml+='<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
  cXml+='<AllowPNG/>'+CRLF
 cXml+='</OfficeDocumentSettings>'+CRLF
 cXml+='<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
  cXml+='<WindowHeight>5160</WindowHeight>'+CRLF
  cXml+='<WindowWidth>11940</WindowWidth>'+CRLF
  cXml+='<WindowTopX>0</WindowTopX>'+CRLF
  cXml+='<WindowTopY>0</WindowTopY>'+CRLF
  cXml+='<ProtectStructure>False</ProtectStructure>'+CRLF
  cXml+='<ProtectWindows>False</ProtectWindows>'+CRLF
 cXml+='</ExcelWorkbook>'+CRLF
 cXml+='<Styles>'+CRLF
  cXml+='<Style ss:ID="Default" ss:Name="Normal">'+CRLF
   cXml+='<Alignment ss:Vertical="Bottom"/>'+CRLF
   cXml+='<Borders/>'+CRLF
   cXml+='<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
   cXml+='<Interior/>'+CRLF
   cXml+='<NumberFormat/>'+CRLF
   cXml+='<Protection/>'+CRLF
  cXml+='</Style>'+CRLF
  cXml+='<Style ss:ID="s62" ss:Name="Hiperlink">'+CRLF
   cXml+='<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#0066CC" '+CRLF
    cXml+='ss:Underline="Single"/>'+CRLF
  cXml+='</Style>'+CRLF
  cXml+='<Style ss:ID="s18" ss:Name="Moeda">'+CRLF
   cXml+='<NumberFormat '+CRLF
    cXml+='ss:Format="_-&quot;R$&quot;\ * #,##0.00_-;\-&quot;R$&quot;\ * #,##0.00_-;_-&quot;R$&quot;\ * &quot;-&quot;??_-;_-@_-"/>'+CRLF
  cXml+='</Style>'+CRLF
  cXml+='<Style ss:ID="s63">'+CRLF
   cXml+='<Font ss:FontName="Arial" x:Family="Swiss" ss:Size="11" ss:Color="#000000" '+CRLF
    cXml+='ss:Bold="1"/>'+CRLF
  cXml+='</Style>'+CRLF
  cXml+='<Style ss:ID="s66">'+CRLF
   cXml+='<NumberFormat ss:Format="Short Date"/>'+CRLF
  cXml+='</Style>'+CRLF
  cXml+='<Style ss:ID="s67" >'+CRLF
   cXml+='<NumberFormat ss:Format="&quot;R$&quot;\ #,##0.00;[Red]&quot;R$&quot;\ #,##0.00"/>'+CRLF
  cXml+='</Style>'+CRLF
  cXml+='<Style ss:ID="s68" ss:Parent="s18">'+CRLF
   cXml+='<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
  cXml+='</Style>'+CRLF
 cXml+='</Styles>'+CRLF
 cXml+='<Worksheet ss:Name="Tracking Adm">'+CRLF
Return cXml

Method segundaParteXml() Class TrackingAdm
	Local cXml := ""
	
	cXml := '</Table>'+CRLF
  cXml += '<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
   cXml += '<PageSetup>'+CRLF
    cXml += '<Header x:Margin="0.31496062000000002"/>'+CRLF
    cXml += '<Footer x:Margin="0.31496062000000002"/>'+CRLF
    cXml += '<PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024" '+CRLF
     cXml += 'x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
   cXml += '</PageSetup>'+CRLF
   cXml += '<Unsynced/>'+CRLF
   cXml += '<Print>'+CRLF
    cXml += '<ValidPrinterInfo/>'+CRLF
    cXml += '<PaperSizeIndex>9</PaperSizeIndex>'+CRLF
    cXml += '<HorizontalResolution>600</HorizontalResolution>'+CRLF
    cXml += '<VerticalResolution>600</VerticalResolution>'+CRLF
   cXml += '</Print>'+CRLF
   cXml += '<Selected/>'+CRLF
   cXml += '<Panes>'+CRLF
    cXml += '<Pane>'+CRLF
     cXml += '<Number>3</Number>'+CRLF
     cXml += '<ActiveRow>2</ActiveRow>'+CRLF
    cXml += '</Pane>'+CRLF
   cXml += '</Panes>'+CRLF
   cXml += '<ProtectObjects>False</ProtectObjects>'+CRLF
   cXml += '<ProtectScenarios>False</ProtectScenarios>'+CRLF
  cXml += '</WorksheetOptions>'+CRLF
 cXml += '</Worksheet>'+CRLF
cXml += '</Workbook>'+CRLF
Return cXml

Method criaArquivo() Class TrackingAdm

Local cDir	:= "C:\Relatorios\"
Local clLocal := ""
Local nlHandle
Local cNameArq := "TrackingVendedor.xls"
Local cDados :=""
Local aCabeca := {"PEDIDO","CLIENTE/LOJA","NOME CLIENTE","ENDERECO","COMPLEMENTO","MUNICIPIO","ESTADO","CANAL DE VENDAS","VENDEDOR","EMISSAO","TRANSPORTADORA","RASTREIO","VALOR DIGITADO","QTD. UNI. DIGITADO","MARGEM LIQUIDA","LIBERADO","QTD. UNI. LIBERADO","CREDITO","STATUS WMS","NOTA FISCAL","FATURADO","STATUS AGENDAMENTO","STATUS DA ENTREGA"}

If !EXISTDIR(cDir)
	If MakeDir( cDir ) < 0
		
		Alert("Erro na criação do diretorio para salvar o arquivo!")
		
		Return "FALSE"
	EndIf

EndIf
 Processa({||Self:corpoXml()},"Gerando arquivo","O arquivo Excel está sendo gerado, por favor, aguarde!")

		If Self:bDados != nil .And. Self:bDados != "FALSE"
			clLocal := cDir + cNameArq
			nlHandle  := FCREATE(clLocal)
				If nlHandle == -1
					Alert("Não foi possível criar o arquivo em: " + CRLF + clLocal)
			Return "FALSE"
			Endif
				//Grava a parte inicial do XML	
			FWRITE(nlHandle, EncodeUtf8(self:primeiraParteXml()))
				
				//Grava a quatidade de linhas que vai existir no XML 
			//FWRITE(nlHandle, EncodeUtf8(self:cNumRows))
			 FWRITE(nlHandle, self:cNumRows) 
				
				//Grava o cabeçalho do XML 
			FWRITE(nlHandle, EncodeUtf8(self:cabecalhoXml()))
			//FWRITE(nlHandle, self:cabecalhoXml())

				//Grava as linhas no XML
			AEVAL(self:aLinhas,{|x|FWRITE(nlHandle, x)}) 
				
				//Grava a ultima parte do XML
			FWRITE(nlHandle, self:segundaParteXml()) 
			FCLOSE(nlHandle) 
								
				MsgAlert("Relatorio gerado!")
			return "TRUE" 
		Else
			alert("Não existem dados para gravação!") 
			return "FALSE"
		Endif

				(Self:oTableTemp)->(DbCloseArea())
Return

Method montaQueryNumResult() Class TrackingAdm

Local cC9 		:= RetSQLName("SC9")
Local cA1		:= RetSQLName("SA1")
Local cC5		:= RetSQLName("SC5")
Local cC6		:= RetSQLName("SC6")
Local cFil		:= xFilial("SC5")
Local cF2		:= RetSQLName("SF2")
Local cP0b		:= RetSQLName("P0B")
Local cZ1		:= RetSQLName("SZ1")
Local cP0g		:= RetSQLName("P0G")


//ProcRegua(RecCount()) 
//IncRegua("Processando dados")

Self:cQuery :="SELECT count(DISTINCT c5_num) NUMRESULT                                                                                           "
Self:cQuery += "FROM  " + cC5+ " 
Self:cQuery += "        WHERE  c5_filial = '"+cFil+"'                                                                                            "
Self:cQuery += "        AND d_e_l_e_t_ = ' '                                                                                                     "
Self:cQuery += "               AND C5_CONDPAG <> '000'                                                    "
Self:cQuery += "               AND C5_XSTAPED <> '00'                                                      "
Self:cQuery += "        AND C5_EMISSAO BETWEEN '"+Self:dDataDe+"' AND '"+Self:dDataAte+"'                                      	                 "

If !Empty(Self:cVend)
Self:cQuery += "               AND C5_VEND1 = '"+Self:cVend+"'                                                                                   "
EndIF

If !Empty(Self:cCanal)
Self:cQuery += "               AND C5_YCANAL ='"+Self:cCanal+"'                                                                                   "
EndIf

	Self:cQuery := ChangeQuery(Self:cQuery)
	dbUseArea(.T., 'TOPCONN', TCGenQry(,,Self:cQuery),Self:oTabeCount, .F., .T.)
	
	//IndRegua( 'TRB', cIndArqA,'A1_COD+A1_NOME',,,"Selecionando Registros...")
	
	dbSelectArea(Self:oTabeCount)
	// IncProc()
	Self:nNumResul:=(Self:oTabeCount)->(NUMRESULT)
	(Self:oTabeCount)->(DbCloseArea())
	
Return

Method DataComBarra(dData) Class TrackingAdm
	If !Empty(dData)
		dData = substr(dData,7,2)+"/"+substr(dData,5,2)+"/"+substr(dData,1,4)
	EndIF
Return dData
