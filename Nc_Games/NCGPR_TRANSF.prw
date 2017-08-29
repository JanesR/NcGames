#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 
#Define Enter Chr(13)+Chr(10)

#DEFINE EMP_NF 1
#DEFINE FILIAL_NOTA 2
#DEFINE NOTA 3
#define SERIE_NF 4
#define CLIENTE 5
#define LOJA_CLI 6
#define LOJA_ORI 7
#define LOJA_DEST 8
#define ORI 9
#define DESTINO 10
#define EMP_ORI 11
#define FIL_ORI 12
#define CODMW 13
#define DTEMI 14
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR_TRANSF  บAutor  ณJanes R	       บ Data ณ  03/05/17   บฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
user function NCGPRTRF()

	local aArea := GetArea()	
	private aParamBox:={}
	private aParams  :={}
	private aFilt := {}
	private aFilt2 := {}
	private mv_par01,mv_par02,mv_par03,mv_par04,mv_par05,mv_par06
	private dtIni, dtFim, filIni, filFim ,tpTranf,tpNf
	Private cMark		:= GetMark()
	Private opening := .T.

	u_FiltrBrw()

	opening := .F.

	filIni := mv_par01
	filFim := MV_PAR02
	dtIni := mv_par03
	dtFim := mv_par04
	tpTranf :=  mv_par05
	tpNf :=  mv_par06

	GeraTela() 

	restArea(aArea)	
return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR_TRANSF  บAutor  ณJanes R	       บ Data ณ  03/05/17   บฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
static function GeraTela()
	local aArea := GetArea()
	local cCodEmp := FWCodEmp()
	local cArqTemp, cIndice1, cIndice2,cIndice3
	private cAlias01 := GetNextAlias()
	private cAlias02 := GetNextAlias()
	private aCampos := {}
	private aCamposb := {}
	private aRotina := MenuDef()
	private cMark := GetMark()
	private lInverte := .F.
	private aHeader := {}
	private aCols := {}
	private oTimer 
	private oMark
	
	aCores := {	{"TB_STATUS = 'Autorizada'"  	,"BR_VERDE"		},;
	{"TB_STATUS = 'Nao autorizada'"	,"BR_VERMELHO"	},;
	{"TB_STATUS = 'Transmitida'"	,"BR_LARANJA"	},;
	{"TB_STATUS = 'Gerada'"			,"BR_BRANCO"	},;
	{"TB_STATUS = 'Denegado'"		,"BR_PRETO"	}}
	
	GeraHeader()
	GeraAcols()

	oTimer:= TTimer():New(2,{|| RefrMonitor() }) // Ativa timer
	oTimer:Activate()

	MarkBrow( cAlias01,"TB_OK",,aCamposb,lInverte,cMark,,,,,,,,,aCores)

	oTimer:DeActivate()
	restArea(aArea)
return

user Function FiltrBrw()
Local aArea := GetArea()

	aFilt := {}
	aadd(aFilt,"1=ENTRE LOJAS")
	aadd(aFilt,"2=NC STORE P/LOJA")
	aadd(aFilt,"3=LOJA P/ NC STORE")
	aadd(aFilt,"4=TODAS")
	aFilt2:={}
	aadd(aFilt2,"1=Autorizadas")
	aadd(aFilt2,"2=Geradas")
	aadd(aFilt2,"3=Nใo autorizadas")
	aadd(aFilt2,"4=Todas")
	aParamBox:={}
	aadd(aParamBox,{1,"Filial de:"					,Space(TAMSX3("FT_FILIAL")[1])		,"@!"	,"","SM0","",70,.F.})
	aadd(aParamBox,{1,"Filial at้:"					,Space(TAMSX3("FT_FILIAL")[1])		,"@!"	,"","SM0","",70,.T.})
	aadd(aParamBox,{1,"Data de:"					,CtoD("//")							,"@D"	,"","","",70,.T.})
	aadd(aParamBox,{1,"Data at้:"					,CtoD("//")							,"@D"	,"","","",70,.T.})
	aadd(aParamBox,{2,"Tipo transferencia"						,"1"	, aFilt	, 120,".T."					,.F.})
	aadd(aParamBox,{2,"Notas"						,"1"	, aFilt2	, 120,".T."					,.F.})

	if !ParamBox(aParamBox, "Filtro de Integra็ใo", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/,.T.,.T.)
		return
	else
		mv_par01 := aParams[1]
		mv_par02 := aParams[2]
		mv_par03 := aParams[3]
		mv_par04 := aParams[4]
		mv_par05 := aParams[5]
		mv_par06 := aParams[6]
	endif
	if !opening
		RefrMonitor()
	endif
RestArea(aArea)
return

static function GeraHeader()
Local aArea := GetArea()

//nome_campo + tipo + tamanho + decimais
	aadd(aCampos,{"TB_OK"		,"C",02, 0}) //01
	aadd(aCampos,{"TB_TRANSF"	,"C",30, 0}) //01
	aadd(aCampos,{"TB_ORIGEM"	,"C",30, 0}) //02
	aadd(aCampos,{"TB_LOJAORI"	,"C",04, 0}) //03
	aadd(aCampos,{"TB_EMPORI"	,"C",02, 0}) //04
	aadd(aCampos,{"TB_FILORI"	,"C",02, 0}) //05
	aadd(aCampos,{"TB_DOC"		,"C",10, 0}) //06
	aadd(aCampos,{"TB_DESTI"	,"C",30, 0}) //07
	aadd(aCampos,{"TB_LJDEST"	,"C",04, 0}) //08
	aadd(aCampos,{"TB_EMPDEST"	,"C",02, 0}) //09
	aadd(aCampos,{"TB_FILDEST"	,"C",02, 0}) //10
	aadd(aCampos,{"TB_NFISCAL"	,"C",09, 0}) //11
	aadd(aCampos,{"TB_SERIE"	,"C",03, 0}) //12
	aadd(aCampos,{"TB_EMISS"	,"D",08, 0}) //13
	aadd(aCampos,{"TB_STATUS"	,"C",15, 0}) //14
	aadd(aCampos,{"TB_SAIDA"	,"D",08, 0}) //15
	aadd(aCampos,{"TB_ENTREG"	,"D",08, 0}) //16


	aadd(aCamposb,{"TB_OK"		,"C","OK", "@!"}) //01
	aadd(aCamposb,{"TB_TRANSF"	,"C","Transferencia", "@!"}) //01
	aadd(aCamposb,{"TB_ORIGEM"	,"C","Origem", "@!"}) //02
	aadd(aCamposb,{"TB_LOJAORI"	,"C","Loja", "@!"}) //03
	aadd(aCamposb,{"TB_EMPORI"	,"C","Emp", "@!"}) //04
	aadd(aCamposb,{"TB_FILORI"	,"C","Fil", "@!"}) //05
	aadd(aCamposb,{"TB_DOC"		,"C","Web/Pev", "@!"}) //06
	aadd(aCamposb,{"TB_DESTI"	,"C","Destino", "@!"}) //07
	aadd(aCamposb,{"TB_LJDEST"	,"C","Loja Dest", "@!"}) //08
	aadd(aCamposb,{"TB_EMPDEST"	,"C","Emp Dest", "@!"}) //09
	aadd(aCamposb,{"TB_FILDEST"	,"C","Fil Dest", "@!"}) //10
	aadd(aCamposb,{"TB_NFISCAL"	,"C","Nota", "@!"}) //11
	aadd(aCamposb,{"TB_SERIE"	,"C","Serie", "@!"}) //12
	aadd(aCamposb,{"TB_EMISS"	,"D","Emissao", "@!"}) //13
	aadd(aCamposb,{"TB_STATUS"	,"C","Status", "@!"}) //14
	aadd(aCamposb,{"TB_SAIDA"	,"D","Dt Saida", "@!"}) //15
	aadd(aCamposb,{"TB_ENTREG"	,"D","Dt Entrega", "@!"}) //16

	if ( Select(cAlias01) > 0)
		DbCloseArea(cAlias01)
	endIf

	//cria tabela temporaria
	cArqTemp := CriaTrab(aCampos,.T.)
	//define indices
	cIndice1 := Alltrim(CriaTrab(,.F.))
	cIndice2 := cIndice1
	cIndice3 := cIndice1

	cIndice1 := Left(cIndice1,5)+Right(cIndice1,2)+"A"
	cIndice2 := Left(cIndice2,5)+Right(cIndice2,2)+"B"
	cIndice3 := Left(cIndice3,5)+Right(cIndice3,2)+"C"

	If File(cIndice1+OrdBagExt())
		FErase(cIndice1+OrdBagExt())
	EndIf

	If File(cIndice2+OrdBagExt())
		FErase(cIndice2+OrdBagExt())
	EndIf

	If File(cIndice3+OrdBagExt())
		FErase(cIndice3+OrdBagExt())
	EndIf


	dbUseArea(.T.,,cArqTemp, cAlias01, nil,.F.)

	/*Criar indice*/
	IndRegua(cAlias01, cIndice1, "TB_TRANSF"	,,, "Indice Tranf...")
	IndRegua(cAlias01, cIndice2, "TB_ORIGEM"	,,, "Indice Origem...")
	IndRegua(cAlias01, cIndice3, "TB_DOC"	,,, "Indice Doc...")
	dbClearIndex()
	dbSetIndex(cIndice1+OrdBagExt())
	dbSetIndex(cIndice2+OrdBagExt())
	dbSetIndex(cIndice3+OrdBagExt())

RestArea(aArea)
return

Static Function GeraAcols()

Local aArea := GetArea()
local cQry := ""

if cEmpAnt == "03"

cQry := "	select                                                                                                                      "  +CRLF
cQry += "	 distinct CASE WHEN SF2.F2_FILIAL = '01' THEN 'NC STORE P/LOJA'                                                             "  +CRLF
cQry += "	      WHEN SF2.F2_FILIAL != '01' AND SA1.A1_YEMPDES = '03' AND SA1.A1_YFILDES = '01' THEN 'LOJA P/ NC STORE'                "  +CRLF
cQry += "	      ELSE 'ENTRE LOJAS'                                                                                                    "  +CRLF
cQry += "	 END TRANF,                                                                                                                 "  +CRLF
cQry += "	 EMP_ATUAL.DESCRI ORIGEM,                                                                                                   "  +CRLF
cQry += "	 EMP_ATUAL.CHAVE LOJA,                                                                                                      "  +CRLF
cQry += "	 '03' EMPRESA,                                                                                                              "  +CRLF
cQry += "	 SF2.F2_FILIAL FILIAL,                                                                                                      "  +CRLF
cQry += "	 CASE WHEN SF2.F2_YCODMOV = ' ' THEN SZ1.Z1_PEDIDO ELSE SF2.F2_YCODMOV END DOC,                                             "  +CRLF
cQry += "	 SUBSTR(ZX5_DESCRI,7,LENGTH(TRIM(ZX5_DESCRI))-6) DEST,                                                                      "  +CRLF
cQry += "	 sa1.A1_YCODWM,                                                                                                             "  +CRLF
cQry += "	 sa1.A1_YEMPDES,                                                                                                            "  +CRLF
cQry += "	 sa1.A1_YFILDES,                                                                                                            "  +CRLF
cQry += "	 SF2.F2_DOC NF,                                                                                                             "  +CRLF
cQry += "	 SF2.F2_SERIE SERIE,                                                                                                        "  +CRLF
cQry += "	 SF2.F2_EMISSAO EMISSAO,                                                                                                    "  +CRLF
cQry += "	 decode(f2_fimp, ' ','Gerada','S','Autorizada','T','Transmitida','D','Denegado','N','Nao autorizada') SITUACAO,             "  +CRLF
cQry += "	 SZ1.Z1_DTSAIDA SAIDA,                                                                                                      "  +CRLF
cQry += "	 SZ1.Z1_DTENTRE ENTREGA                                                                                                     "  +CRLF
cQry += "	 FROM                                                                                                                       "  +CRLF
cQry += "	 sf2030 SF2 LEFT JOIN sd2030 SD2                                                                                            "  +CRLF
cQry += "	ON SF2.F2_FILIAL = SD2.D2_FILIAL                                                                                            "  +CRLF
cQry += "	 and SF2.F2_doc = sd2.d2_doc                                                                                                "  +CRLF
cQry += "	 and sf2.f2_serie = SD2.D2_SERIE                                                                                            "  +CRLF
cQry += "	 and sf2.f2_emissao = sd2.d2_emissao                                                                                        "  +CRLF
cQry += "	 LEFT JOIN sa1030 SA1 ON                                                                                                    "  +CRLF
cQry += "	 sf2.F2_CLIENTE = sa1.A1_COD                                                                                                "  +CRLF
cQry += "	 AND SF2.F2_LOJA = sa1.A1_LOJA                                                                                              "  +CRLF
cQry += "	 AND SA1.A1_YEMPDES != ' '                                                                                                  "  +CRLF
cQry += "	 AND SA1.A1_YFILDES != ' '                                                                                                  "  +CRLF
cQry += "	 LEFT JOIN  zx5030  ZX5                                                                                                     "  +CRLF
cQry += "	 ON trim(sa1.A1_YCODWM) = trim(ZX5.ZX5_CHAVE)                                                                               "  +CRLF
cQry += "	 LEFT JOIN (                                                                                                                "  +CRLF
cQry += "	 SELECT ZX5_CHAVE CHAVE, SUBSTR(ZX5_DESCRI,0,5) EMPRESA,                                                                    "  +CRLF
cQry += "	 SUBSTR(ZX5_DESCRI,7,LENGTH(TRIM(ZX5_DESCRI))-6) DESCRI  FROM  zx5030                                                       "  +CRLF
cQry += "	 WHERE  zx5_tabela = '00006' AND D_e_l_e_t_ = ' '                                                                           "  +CRLF
cQry += "	 ) EMP_ATUAL                                                                                                                "  +CRLF
cQry += "	 ON trim('03'||';'||SF2.F2_FILIAL) = trim(EMP_ATUAL.EMPRESA)                                                                "  +CRLF
cQry += "	 LEFT JOIN  sz1030  SZ1                                                                                                     "  +CRLF
cQry += "	 ON SF2.F2_FILIAL = SZ1.Z1_FILIAL                                                                                           "  +CRLF
cQry += "	 AND SF2.F2_DOC = SZ1.Z1_DOC                                                                                                "  +CRLF
cQry += "	 AND SF2.F2_SERIE = SZ1.Z1_SERIE                                                                                            "  +CRLF
cQry += " WHERE SF2.F2_FILIAL BETWEEN '"+ filIni +"' AND '"+ filFim +"'                                                             "  +CRLF
cQry += "  and sf2.F2_EMISSAO BETWEEN '"+ DtoS(dtIni) +"' and '"+ DtoS(dtFim) +"'		                                            "  +CRLF
cQry += "	 AND ZX5.ZX5_TABELA = '00006'                                                                                               "  +CRLF
cQry += "	AND sf2.D_E_L_E_T_ = ' '                                                                                                    "  +CRLF
cQry += "	 AND sd2.D_E_L_E_T_ = ' '                                                                                                   "  +CRLF
cQry += "	 AND sA1.D_E_L_E_T_ = ' '                                                                                                   "  +CRLF
cQry += "	 and ZX5.D_E_L_E_T_ = ' '                                                                                                   "  +CRLF
cQry += "  and ZX5_CHAVE != '3090'"  +CRLF

	do case
		case tpTranf == "1" 
		cQry += " and (sf2.f2_filial != '01' and SA1.A1_YFILDES != '01') "  +CRLF
		case tpTranf == "2"
		cQry += " and (sf2.f2_filial = '01') "  +CRLF
		case tpTranf == "3"
		cQry += " AND SA1.A1_YEMPDES = '03' AND SA1.A1_YFILDES = '01' "  +CRLF
	endcase

	do case
		case tpNf == "1" 
		cQry += " AND f2_fimp = 'S' "  +CRLF
		case tpNf == "2"
		cQry += " AND f2_fimp = ' ' "  +CRLF
		case tpNf == "3"
		cQry += " AND f2_fimp in( 'N','T','D' ) "  +CRLF
		case tpNf == "4"
		cQry += " AND f2_fimp in(' ','S', 'N','T','D' ) "  +CRLF
	endcase

//cQry += "     union all                                                                                                                 "  +CRLF

elseif cEmpAnt == "40"
cQry += "                                                                                                                               "  +CRLF
cQry += "     select                                                                                                                    "  +CRLF
cQry += "	 distinct CASE WHEN SA1.A1_YEMPDES = '03' AND SA1.A1_YFILDES = '01' THEN 'LOJA P/ NC STORE'                                 "  +CRLF
cQry += "	      ELSE 'ENTRE LOJAS'                                                                                                    "  +CRLF
cQry += "	 END TRANF,                                                                                                                 "  +CRLF
cQry += "	 EMP_ATUAL.DESCRI ORIGEM,                                                                                                   "  +CRLF
cQry += "	 EMP_ATUAL.CHAVE LOJA,                                                                                                      "  +CRLF
cQry += "	 '40' EMPRESA,                                                                                                              "  +CRLF
cQry += "	 SF2.F2_FILIAL FILIAL,                                                                                                      "  +CRLF
cQry += "	 CASE WHEN SF2.F2_YCODMOV = ' ' THEN SZ1.Z1_PEDIDO ELSE SF2.F2_YCODMOV END DOC,                                             "  +CRLF
cQry += "	 SUBSTR(ZX5_DESCRI,7,LENGTH(TRIM(ZX5_DESCRI))-6) DEST,                                                                      "  +CRLF
cQry += "	 sa1.A1_YCODWM,                                                                                                             "  +CRLF
cQry += "	 sa1.A1_YEMPDES,                                                                                                            "  +CRLF
cQry += "	 sa1.A1_YFILDES,                                                                                                            "  +CRLF
cQry += "	 SF2.F2_DOC NF,                                                                                                             "  +CRLF
cQry += "	 SF2.F2_SERIE SERIE,                                                                                                        "  +CRLF
cQry += "	 SF2.F2_EMISSAO EMISSAO,                                                                                                    "  +CRLF
cQry += "	 decode(f2_fimp, ' ','Gerada','S','Autorizada','T','Transmitida','D','Denegado','N','Nao autorizada') SITUACAO,             "  +CRLF
cQry += "	 SZ1.Z1_DTSAIDA SAIDA,                                                                                                      "  +CRLF
cQry += "	 SZ1.Z1_DTENTRE ENTREGA                                                                                                     "  +CRLF
cQry += "	 FROM                                                                                                                       "  +CRLF
cQry += "	 sf2400 SF2 LEFT JOIN sd2400 SD2                                                                                            "  +CRLF
cQry += "	ON SF2.F2_FILIAL = SD2.D2_FILIAL                                                                                            "  +CRLF
cQry += "	 and SF2.F2_doc = sd2.d2_doc                                                                                                "  +CRLF
cQry += "	 and sf2.f2_serie = SD2.D2_SERIE                                                                                            "  +CRLF
cQry += "	 and sf2.f2_emissao = sd2.d2_emissao                                                                                        "  +CRLF
cQry += "	 LEFT JOIN sa1400 SA1 ON                                                                                                    "  +CRLF
cQry += "	 sf2.F2_CLIENTE = sa1.A1_COD                                                                                                "  +CRLF
cQry += "	 AND SF2.F2_LOJA = sa1.A1_LOJA                                                                                              "  +CRLF
cQry += "	 AND SA1.A1_YEMPDES != ' '                                                                                                  "  +CRLF
cQry += "	 AND SA1.A1_YFILDES != ' '                                                                                                  "  +CRLF
cQry += "	 LEFT JOIN  zx5400  ZX5                                                                                                     "  +CRLF
cQry += "	 ON trim(sa1.A1_YCODWM) = trim(ZX5.ZX5_CHAVE)                                                                               "  +CRLF
cQry += "	 LEFT JOIN (                                                                                                                "  +CRLF
cQry += "	 SELECT ZX5_CHAVE CHAVE, SUBSTR(ZX5_DESCRI,0,5) EMPRESA,                                                                    "  +CRLF
cQry += "	 SUBSTR(ZX5_DESCRI,7,LENGTH(TRIM(ZX5_DESCRI))-6) DESCRI  FROM  zx5400                                                       "  +CRLF
cQry += "	 WHERE  zx5_tabela = '00006' AND D_e_l_e_t_ = ' '                                                                           "  +CRLF
cQry += "	 ) EMP_ATUAL                                                                                                                "  +CRLF
cQry += "	 ON trim('40'||';'||SF2.F2_FILIAL) = trim(EMP_ATUAL.EMPRESA)                                                                "  +CRLF
cQry += "	 LEFT JOIN  sz1400  SZ1                                                                                                     "  +CRLF
cQry += "	 ON SF2.F2_FILIAL = SZ1.Z1_FILIAL                                                                                           "  +CRLF
cQry += "	 AND SF2.F2_DOC = SZ1.Z1_DOC                                                                                                "  +CRLF
cQry += "	 AND SF2.F2_SERIE = SZ1.Z1_SERIE                                                                                            "  +CRLF
cQry += " WHERE SF2.F2_FILIAL BETWEEN '"+ filIni +"' AND '"+ filFim +"'		                                                        "  +CRLF
cQry += "  and sf2.F2_EMISSAO BETWEEN '"+ DtoS(dtIni) +"' and '"+ DtoS(dtFim) +"'			                                        "  +CRLF
cQry += "	 AND ZX5.ZX5_TABELA = '00006'                                                                                               "  +CRLF
cQry += "	AND sf2.D_E_L_E_T_ = ' '                                                                                                    "  +CRLF
cQry += "	 AND sd2.D_E_L_E_T_ = ' '                                                                                                   "  +CRLF
cQry += "	 AND sA1.D_E_L_E_T_ = ' '                                                                                                   "  +CRLF
cQry += "	 and ZX5.D_E_L_E_T_ = ' '																									"  +CRLF
cQry += "  and ZX5_CHAVE != '3090'"  +CRLF

	do case
		case tpTranf == "1" 
		cQry += " and (sf2.f2_filial != '01' and SA1.A1_YFILDES != '01') "  +CRLF
		case tpTranf == "2"
		cQry += " and (sf2.f2_filial = '01') "  +CRLF
		case tpTranf == "3"
		cQry += " AND SA1.A1_YEMPDES = '03' AND SA1.A1_YFILDES = '01' "  +CRLF
	endcase

	do case
		case tpNf == "1" 
		cQry += " AND f2_fimp = 'S' "  +CRLF
		case tpNf == "2"
		cQry += " AND f2_fimp = ' ' "  +CRLF
		case tpNf == "3"
		cQry += " AND f2_fimp in( 'N','T','D' ) "  +CRLF
		case tpNf == "4"
		cQry += " AND f2_fimp in(' ','S', 'N','T','D' ) "  +CRLF
	endcase
else
	MsgInfo("Nใo ้ possivel acessar as transferencias pelo Nc Games. Acesse a empresa correta!")
	return
endif

	cQry := ChangeQuery(cQry)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAlias02,.F.,.F.)
	
	while (cAlias02)->(!EOF())
		if RecLock(cAlias01,.T.)
			(cAlias01)->TB_OK 		:= ' '//01
			(cAlias01)->TB_TRANSF 	:= (cAlias02)->TRANF		//01
			(cAlias01)->TB_ORIGEM 	:= (cAlias02)->ORIGEM		//02
			(cAlias01)->TB_LOJAORI 	:= (cAlias02)->LOJA			//03
			(cAlias01)->TB_EMPORI 	:= (cAlias02)->EMPRESA		//04
			(cAlias01)->TB_FILORI 	:= (cAlias02)->FILIAL		//05
			(cAlias01)->TB_DOC 		:= (cAlias02)->DOC			//06
			(cAlias01)->TB_DESTI 	:= (cAlias02)->DEST			//07
			(cAlias01)->TB_LJDEST 	:= (cAlias02)->A1_YCODWM	//08
			(cAlias01)->TB_EMPDEST 	:= (cAlias02)->A1_YEMPDES	//09
			(cAlias01)->TB_FILDEST 	:= (cAlias02)->A1_YFILDES	//10
			(cAlias01)->TB_NFISCAL	:= (cAlias02)->NF			//11
			(cAlias01)->TB_SERIE 	:= (cAlias02)->SERIE		//12
			(cAlias01)->TB_EMISS 	:= StoD((cAlias02)->EMISSAO)//13
			(cAlias01)->TB_STATUS 	:= (cAlias02)->SITUACAO		//14
			(cAlias01)->TB_SAIDA 	:= StoD((cAlias02)->SAIDA)	//15
			(cAlias01)->TB_ENTREG 	:= StoD((cAlias02)->ENTREGA)//16
			MsUnLock()
		endif
		(cAlias02)->(DbSkip())
	enddo
	(cAlias02)->(dbCloseArea())

	DBSelectArea(cAlias01)
	(cAlias01)->(DbGoTop())

RestArea(aArea)
Return (cAlias01)

Static Function RefrMonitor()

Local aArea := GetArea()

oMark := GetMarkBrow()

DbSelectArea(cAlias01)
(cAlias01)->(dbGotop())
 While !Eof()
    Reclock(cAlias01)
    (cAlias01)->(dbdelete())
    (cAlias01)->(MsUnlock())
    (cAlias01)->(dbskip())
 End

MarkBRefresh() 
GeraAcols()
MarkBRefresh() 
oMark:oBrowse:Gotop()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR_TRANSF  บAutor  ณJanes R	       บ Data ณ  03/05/17   บฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
static function MenuDef()
	local aArea := GetArea()
	Local alRotina := {}

	aAdd(alRotina, {"Pesquisar"	,"AxPesqui"									,0,1})
	aAdd(alRotina, {"Desmarcar todos"	,"u_trfCLIFLG()"					,0,2})
	aAdd(alRotina, {"Marcar todos"	,"u_trfMRKFLG()"						,0,3})
	aAdd(alRotina, {"DANFE"		,"U_TRFDanfe01()"							,0,4})
	aAdd(alRotina, {"Refresh"		,"u_atBrw()"							,0,5})
	aAdd(alRotina, {"NFe-SEFAZ","U_trDocSaida((cAlias01)->TB_FILORI)"		,0,6})
	aAdd(alRotina, {"Legenda"	,"U_PRTRANSFLG()"							,0,7})
//aAdd(alRotina, {"Consulta Sefaz	"		,"u_ConNfTrf()"						,0,6})
	restArea(aArea)
return alRotina
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR_TRANSF  บAutor  ณJanes R	       บ Data ณ  03/05/17   บฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PRTRANSFLG()
	Local aArea := GetArea()
	Local aCor := {}

	aAdd(aCor,{"BR_VERDE"	,"Nota autorizada"   				})
	aAdd(aCor,{"BR_VERMELHO","Nota nใo autorizada"				})
	aAdd(aCor,{"BR_PRETO"	,"Nota denegada"					})
	aAdd(aCor,{"BR_LARANJA"	,"Nota transmitida"			})
	aAdd(aCor,{"BR_BRANCO"	,"Nota Gerada"			})	


	BrwLegenda(,"Status",aCor)

	RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR_TRANSF  บAutor  ณJanes R	       บ Data ณ  03/05/17   บฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
user function TRFDanfe01()

	local aArea := GetArea()
	local infTransf
	local cCodEmp := FWCodEmp()
	local cEmpNota,cFilNota, cNota,cSerie,cClient,cLoja,cNome
	local cFilAtu := cFilAnt
	local aNotasPrt := {}
	local notasSel := .F.
	Local aParamBx:={}
	Local aParams  :={}
	local aFiltr := {}
	local aFiltr2 := {}
	local cPrint := ""
	local cArqEnv :=""
	local cPARA := ""
	local cASSUNTO := ""
	local _MSG:=""
	local aFiles := {}
	local cErro :=""
	local clDir := "\DANFE_TRANSF\"
	local existAnex := .F.
	local cLog := ""
	
	aFiltr:= {}
	aadd(aFiltr,"1=DANFE EM PDF")
	aadd(aFiltr,"2=NOTA IMPRESSA")
	aadd(aFiltr,"3=DANFE EM PDF E NOTA IMPRESSA")
	aFiltr2:={}
	aadd(aFiltr2,"1=Enviar por e-mail.")
	aadd(aFiltr2,"2=Nใo enviar e-mail.")
	aParamBx:={}
	aadd(aParamBx,{2,"Emitir DANFE Como"						,"1"	, aFiltr	, 120,".T."					,.F.})
	aadd(aParamBx,{2,"Enviar por E-mail?"						,"1"	, aFiltr2	, 120,".T."					,.F.})

	if !ParamBox(aParamBx, "Filtro de Integra็ใo", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/,.T.,.T.)
		return
	endIf

	DbSelectArea(cAlias01)
	DbGoTop()

	while (cAlias01)->(!EOF())


		if !(empty(alltrim((cAlias01)->TB_OK)))	.And. (upper(alltrim((cAlias01)->TB_STATUS)) == upper('Autorizada'))
			notasSel := .T.
			cEmpNota := (cAlias01)->TB_EMPORI
			cFilNota := (cAlias01)->TB_FILORI
			cNota := (cAlias01)->TB_NFISCAL
			cSerie := (cAlias01)->TB_SERIE

			DbSelectArea("ZX5")
			DbSetOrder(1)
			DbSeek(xFilial("ZX5")+ "00009" + padr( (cAlias01)->TB_LJDEST , 4))

			infTransf := StrTokArr(ZX5->ZX5_DESCRI,';')
			ZX5->(DbCloseArea())


			if LEN(infTransf) > 2
				cClient := infTransf[1]
				cLoja:= infTransf[2]
				aadd(aNotasPrt,{cEmpNota,cFilNota,cNota,cSerie,cClient,cLoja,(cAlias01)->TB_LOJAORI,(cAlias01)->TB_LJDEST,(cAlias01)->TB_ORIGEM,(cAlias01)->TB_DESTI,(cAlias01)->TB_EMPORI,(cAlias01)->TB_FILORI,(cAlias01)->TB_DOC,(cAlias01)->TB_EMISS})
			endif
		elseif !(empty(alltrim((cAlias01)->TB_OK)))
			MsgInfo("A Nota "+ alltrim((cAlias01)->TB_NFISCAL) + " nใo poderแ ser impressa, poํs nใo estแ autorizada."+CRLF+"O sistema passarแ para a proxima nota selecionada.","Nota nใo autorizada!")
		endIF
		DbSelectArea(cAlias01)
		(cAlias01)->(DbSkip())
	endDo

	if !notasSel
		MsgAlert("Nenhuma nota selecionada!")
		restArea(aArea)
		return
	endif

	if aParams[1] == '2' .or. aParams[1] == '3'
		cPrint := getImpre()
	endif

	If !EXISTDIR(clDir)
		If MakeDir( clDir ) < 0
			lRet := .F.
			Conout("Erro na cria็ใo do diretorio")

			Return lRet
		Else
			lRet := .T.
		EndIf
	EndIf

	for nxTCount := 1 to len(aNotasPrt)

		cNome := "NF_"+aNotasPrt[nxTCount][NOTA] + " LOJA " + aNotasPrt[nxTCount][LOJA_ORI] + " para " + aNotasPrt[nxTCount][LOJA_DEST]

		U_PrTRFDanf(aNotasPrt[nxTCount][EMP_NF],aNotasPrt[nxTCount][FILIAL_NOTA],aNotasPrt[nxTCount][NOTA],aNotasPrt[nxTCount][SERIE_NF],aNotasPrt[nxTCount][CLIENTE],aNotasPrt[nxTCount][LOJA_CLI],cNome,aParams[1],cPrint,.F.,.T.)
		cLog += "Nota fiscal "+aNotasPrt[nxTCount][2] + " LOJA " + aNotasPrt[nxTCount][6] + " - " + aNotasPrt[nxTCount][8] + " PARA LOJA " + aNotasPrt[nxTCount][7] + " - " + aNotasPrt[nxTCount][9] +CRLF 

		if aParams[2] == "1"

			_MSG := "Nota fiscal de transferencia emitida."   +CRLF+CRLF
			
			if aNotasPrt[nxTCount][LOJA_ORI] == "3000" .or. aNotasPrt[nxTCount][LOJA_ORI] == "3001"
				_MSG += aNotasPrt[nxTCount][ORI] +CRLF 
				_MSG += "Para " + aNotasPrt[nxTCount][LOJA_DEST] + " - " +aNotasPrt[nxTCount][DESTINO] +CRLF
			elseif aNotasPrt[nxTCount][LOJA_DEST] == "3000" .or. aNotasPrt[nxTCount][LOJA_DEST] == "3001"
				_MSG += "Da loja:" + aNotasPrt[nxTCount][LOJA_ORI] + " - " + aNotasPrt[nxTCount][ORI] +CRLF 
				_MSG += "Para:" + aNotasPrt[nxTCount][DESTINO] +CRLF
			else
				_MSG += "Da loja:" + aNotasPrt[nxTCount][LOJA_ORI] + " - " + aNotasPrt[nxTCount][ORI] +CRLF 
				_MSG += "Para loja:" + aNotasPrt[nxTCount][LOJA_DEST] + " - " + aNotasPrt[nxTCount][DESTINO] +CRLF
			endif
			

			//cAssunto:= "Transfer๊ncia Mov Web " +aNotasPrt[nxTCount][CODMW]+ " - Nota fiscal:"+aNotasPrt[nxTCount][NOTA] + " enviada em " + DtoC(Date()) +" - " + time()

			if aNotasPrt[nxTCount][LOJA_DEST] == "3000"
				
				cAssunto := "TRANSF. DA LOJA "+ aNotasPrt[nxTCount][LOJA_ORI] + " - " + aNotasPrt[nxTCount][ORI] +" P/ NC STORE - WM " + aNotasPrt[nxTCount][CODMW] + " NF " + aNotasPrt[nxTCount][NOTA]+" EMITIDA EM " + DtoC( aNotasPrt[nxTCount][DTEMI] )

			elseif aNotasPrt[nxTCount][LOJA_DEST] == "3001"
				
				cAssunto := "TRANSF. DA LOJA "+ aNotasPrt[nxTCount][LOJA_ORI] + " - " + aNotasPrt[nxTCount][ORI] +" P/ NC STORE - WM " + aNotasPrt[nxTCount][CODMW] + " NF " + aNotasPrt[nxTCount][NOTA]+" EMITIDA EM " +  DtoC( aNotasPrt[nxTCount][DTEMI] )

			elseif aNotasPrt[nxTCount][EMP_NF] == "03" .and. aNotasPrt[nxTCount][FILIAL_NOTA] == "01"
				
				cAssunto := "TRANSF.  NC STORE P/ "+  aNotasPrt[nxTCount][LOJA_DEST] + " - " + aNotasPrt[nxTCount][DESTINO]  + " NF "+aNotasPrt[nxTCount][NOTA]+" EMITIDA EM " + DtoC( aNotasPrt[nxTCount][DTEMI] )

			elseif  aNotasPrt[nxTCount][FILIAL_NOTA] != "01"

				cAssunto := "TRANSF. ENTRE LOJAS - WM " + aNotasPrt[nxTCount][CODMW] + " NF " + aNotasPrt[nxTCount][NOTA]+" EMITIDA EM " + DtoC( aNotasPrt[nxTCount][DTEMI] )
			endif

			cArqEnv := "C:\relatorios\DANFE\"+cNome+".PDF"

			if file(cArqEnv)
				CpyT2S(cArqEnv,clDir,.T.)

				cPARA :=Alltrim( getEmailTo(aNotasPrt[nxTCount][EMP_ORI], aNotasPrt[nxTCount][FIL_ORI]) )

				if cPARA != ""
					aadd(aFiles,{cAssunto,clDir+cNome+".PDF","jisidoro@ncgames.com.br;rciambarella@ncgames.com.br",_MSG}) 
				    //aadd(aFiles,{cAssunto,clDir+cNome+".PDF",cPARA,_MSG}) 
				EndIf
			endIF
		endIf

	next nxTCount

	for nxtrf:= 1 to len(aFiles)
		if aParams[2] == "1"
			U_ENVIAEMAIL(aFiles[nxtrf][3], "", "", aFiles[nxtrf][1],  aFiles[nxtrf][4], {aFiles[nxtrf][2]})
		endif
	next nxtrf


	MsgInfo("Processo de impressใo finalizado!","Processo Finalizado!")

	LogNotas(cLog)
	u_trfCLIFLG()
	
	restArea(aArea)
return

static function getImpre()
	local aArea := GetArea()
	Local aPrinters :=RetImpWin(.F.)
	local cPrinter := ""
	Local aParamBox	:={}
	Local aRet		:={}


	aAdd(aParamBox,{2,"Selecione Impressora DANFE",1,aPrinters,100,"",.T.})
	If !ParamBox(aParamBox,"Selecionar Impressora",@aRet,,,,,,,,.F.)
		msgAlert("Nenhuma Impressora selecionada, nใo serแ gerado DANFE impresso.")
		return cPrinter
	EndIf

	If ValType(aRet[1])=="N"
		cPrinter:=aPrinters[ aRet[1] ]
	Else
		cPrinter:= aRet[1]
	EndIf

	restArea(aArea)
return cPrinter

Static Function LogNotas(texto)
	Local aArea := GetArea()
	Private cTexto1 := texto

	/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
	ฑฑ Declara็ใo de Variaveis Private dos Objetos                             ฑฑ
	ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
	SetPrvt("oDlgp","oSay1","oMGet1","okBTN")

	/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
	ฑฑ Definicao do Dialog e todos os seus componentes.                        ฑฑ
	ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
	oDlgp      := MSDialog():New( 091,232,600,818,"Notas Impressas",,,.F.,,,,,,.T.,,,.T. )
	oSay1      := TSay():New( 008,012,{||"Foram Impressas as seguintes notas fiscais"},oDlgp,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
	oMGet1     := TMultiGet():New( 020,004,{|u| If(PCount()>0,cTexto1:=u,cTexto1)},oDlgp,290,200,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
	okBTN      := TButton():New( 230,190,"Ok",oDlgp,{|| oDlgp:END()},037,012,,,,.T.,,"",,,,.F. )

	oDlgp:Activate(,,,.T.)

	RestArea(aArea)
Return


static function getEmailTo(cEmp, cFil)
Local aArea := GetArea()
Local cQry := ""
Local cAliasEnv := GetNextAlias()
Local cRet := ""

cQry := "select A1_EMAIL from "+ RetSqlName("SA1") +"  where A1_YEMPDES = '"+cEmp+"' and A1_YFILDES ='"+cFil+"'"

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasEnv,.F.,.F.)

while (cAliasEnv)->(!EOF())
	cRet := (cAliasEnv)->A1_EMAIL
	(cAliasEnv)->(DbSkip())
endDo

(cAliasEnv)->(dbCloseArea())

RestArea(aArea)
return cRet

user function trfCLIFLG()

	local aArea := GetArea()

	DbSelectArea(cAlias01)
	DbGoTop()

	while (cAlias01)->(!EOF())
		If IsMark( 'TB_OK', cMark )
			RecLock( (cAlias01), .F. )
			Replace TB_OK With Space(2)
			MsUnLock()
		endIf
		(cAlias01)->(DbSkip())
	enddo
	MarkBRefresh()
	restArea(aArea)
return

user function trfMRKFLG()


	while (cAlias01)->(!Eof())
		If !IsMark( 'TB_OK', cMark )
			RecLock( (cAlias01), .F. )
			Replace TB_OK With cMark
			MsUnLock()
		EndIf
		(cAlias01)->(DbSkip())
	endDo
	Return
return


User Function trDocSaida(cFilNota)

	Local cFilAtu := cFilAnt
	local cCodEmp := FWCodEmp()
	Local aAreaSF2:=SF2->(GetArea())
	

	cEmpAnt := cCodEmp
	cFilAnt := cFilNota
	cNumEmp := cCodEmp+cFilNota
	cModulo := "FAT"
	nModulo := 5
	OpenSM0(cEmpAnt+cFilAnt)
	OpenFile(cEmpAnt+cFilAnt)

	SpedNFe()

	cEmpAnt := cCodEmp
	cFilAnt := cFilAtu
	cNumEmp := cCodEmp+cFilAtu
	cModulo := "FAT"
	nModulo := 5
	OpenSM0(cEmpAnt+cFilAtu)
	OpenFile(cEmpAnt+cFilAtu)
	RestArea(aAreaSF2)
	RefrMonitor()
Return

user Function atBrw()
Local aArea := GetArea()

	RefrMonitor()

RestArea(aArea)
return

user Function ConNfTrf()
Local aArea := GetArea()
Local cFilNota := ""
Local cNota := ""
Local cSerie := ""
	DbSelectArea(cAlias01)
	DbGoTop()

	Do while (cAlias01)->(!EOF())
		
		if !(empty(alltrim((cAlias01)->TB_OK)))
			cFilNota := (cAlias01)->TB_FILORI
			cNota := (cAlias01)->TB_NFISCAL
			cSerie := (cAlias01)->TB_SERIE

			nctransfCN(cFilNota, cNota, cSerie)
		endif
		(cAlias01)->(DbSkip())
	
	endDo

RefrMonitor()

RestArea(aArea)
return

static function nctransfCN(cFilNf,cNota,cSerieNf)
Local aArea := GetArea()
Local aAreaSF2	:= SF2->(GetArea())
Local nContar := 1
Local nTentativa:= 3
Local cDirSystem:= GetTempPath()

Local lOKWebService
Local cModalidade
Local cVersao
Local cVersaoDpec

Local lAdjustToLegacy
Local oWS
Private lPrinter := .f.
Private cIdEnt
Private cUrl	:= AllTrim(PadR(GetNewPar("MV_SPEDURL","http://"),250))

If !Empty(cNota)

	If Empty( cIdEnt:= GetIdEnt() )
		Return
	EndIf

	If !Empty(cIdEnt)

		oWS := WsSpedCfgNFe():New()
		oWS:cUSERTOKEN 		:= "TOTVS"
		oWS:cID_ENT    		:= cIdEnt
		oWS:nAmbiente  		:= 0
		oWS:_URL       		:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
		lOKWebService 		:= oWS:CFGAMBIENTE()
		cAmbiente 			:= oWS:cCfgAmbienteResult
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem a modalidade de execucao do Totvs Services SPED                   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:nModalidade	:= 0
			oWS:cModelo	   	:= "55"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService 	:= oWS:CFGModalidade()
			cModalidade    	:= oWS:cCfgModalidadeResult
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem a versao de trabalho da NFe do Totvs Services SPED                ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:cVersao    	:= "0.00"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService  	:= oWS:CFGVersao()
			cVersao        	:= oWS:cCfgVersaoResult
		EndIf
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:cVersao    	:= "0.00"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService	:= oWS:CFGVersaoDpec()
			cVersaoDpec	   	:= oWS:cCfgVersaoDpecResult
		EndIf

	endif

	SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	If SF2->(MsSeek(cFilNf+cNota+cSerieNf))
		oWS:= WSNFeSBRA():New()
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:_URL       := AllTrim(cURL)+"/NFeSBRA.apw"

		If lOKWebService
			IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )

			oWS:cIdInicial := SF2->F2_SERIE+SF2->F2_DOC
			oWS:cIdFinal   := SF2->F2_SERIE+SF2->F2_DOC

			//Do While ++nContar<nTentativa
				IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
				
				lOk 		:= oWS:MONITORFAIXA()
				oRetorno 	:= oWS:oWsMonitorFaixaResult
				cStatus		:= GetStatus(oRetorno)
				
				If Left(cStatus,3)=="001"
					lPrinter:=.T.//;//Exit
				ElseIf Left(cStatus,3)=="014" //014 - NFe nใo autorizada
					lPrinter:=.F.//;Exit
				ElseIf "029 - Falha no Schema do XML"$cStatus
					lPrinter:=.F.//;Exit
				ElseIf Left(cStatus,4)=="ERRO"
					lPrinter:=.F.//;Exit
				EndIf
				//Sleep(1000)
			//enddo

			if lPrinter
				if RecLock("SF2",.f.)
					SF2->f2_fimp := "S"
					SF2->(MsUnlock())
				EndIf
			ELSE
				if RecLock("SF2",.f.)
					SF2->f2_fimp := "N"
					SF2->(MsUnlock())
				EndIf
			endif

		endIF
	else
		MsgAlert("Nota fiscal:" + cNota +" nใo encontrada!")
	endif

endif

RestArea(aArea)
return

Static Function GetIdEnt(lHelp)
Local aArea  := GetArea()
Local cIdEnt := ""
Local oWs
Default lHelp:=.F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem o codigo da entidade                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""
oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
ElseIf lHelp
	//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
EndIf

RestArea(aArea)
Return(cIdEnt)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  02/12/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStatus(oRetorno)
Local cRecomendacao:="ERRO. Nใo foi possivel identificar o erro. Verifque via Monitor NFE"

For nX := 1 To Len(oRetorno:oWSMONITORNFE)
	oXml := oRetorno:oWSMONITORNFE[nX]
	cRecomendacao:=oXml:CRECOMENDACAO
Next nX

Return cRecomendacao