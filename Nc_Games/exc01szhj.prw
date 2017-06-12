#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function EXC01SZHJ()
Private _aUser  := PswRet(1)
Private _lRet   := .T.
Private _cOpcao := "VISUALIZAR"
Private _nOpcE  := 2
Private _nOpcG  := 2

Do Case
	Case _cOpcao == "INCLUIR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "ALTERAR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "VISUALIZAR" ; _nOpcE := 2 ; _nOpcG := 2
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("SZJ",(_cOpcao == "INCLUIR"))

Private _cCodigo  := SZJ->ZJ_CODIGO
Private _nI       := 0
Private nUsado    := 0
Private aHeader   := {}
Private aCols     := {}

If SZJ->ZJ_STATUS $ "123"//SZJ->ZJ_STATUS == "2"
    Alert("Tabela Ja Concluida ou com itens aprovados, portanto NAO sera possivel sua exclusao...")
    Return
EndIf

dbSelectArea("SX3")
dbSeek("SZH")
Do While !Eof().And.(x3_arquivo=="SZH")
	If Upper(AllTrim(X3_CAMPO)) == "ZH_CODIGO"
		dbSkip()
		Loop
	EndIf
	If X3USO(x3_usado) .And. cNivel >= x3_nivel
		nUsado:=nUsado+1
		Aadd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,X3_VALID,;
		x3_usado, x3_tipo, x3_arquivo, x3_context } )
	EndIf
	dbSkip()
EndDo

If _cOpcao == "INCLUIR"
	aCols := {Array(nUsado+1)}
	aCols[1,nUsado+1] := .F.
	For _nI:=1 To nUsado
		aCols[1,_nI] := If(AllTrim(Upper(aHeader[_nI,2]))=="ZH_ITEM",StrZero(_nI,4),CriaVar(aHeader[_nI,2]))
	Next
Else
	aCols:={}
	dbSelectArea("SZH")
	dbSetOrder(3)
	dbSeek(xFilial("SZH")+_cCodigo,.T.)
	Do While !Eof() .And. SZH->ZH_CODIGO == _cCodigo
		AADD(aCols,Array(nUsado+1))
		For _nI:=1 to nUsado
			aCols[Len(aCols),_nI]:=FieldGet(FieldPos(aHeader[_nI,2]))
		Next
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()
	EndDo
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de posicionamento no aCols                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private _nPosItem      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_ITEM"    })
Private _nPosProduto   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRODUTO" })
Private _nPosXDesc     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_XDESC"   })
Private _nPosPrv0      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRV0"    })
Private _nPos00Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP00" })
Private _nPos18Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO18" })
Private _nPos18Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP18" })
Private _nPos12Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO12" })
Private _nPos12Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP12" })
Private _nPos07Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO07" })
Private _nPos07Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP07" })
Private _nPosUprc      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_UPRC" })
Private _nPosCM1       := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_CM1" })
Private _nPosMKUP      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP" })
Private _nPosQATU      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_QATU" })
Private _nPosVATU1     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_VATU1" })

Private _nPosMotivo    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MOTIVO"  })
Private _nPDesMot      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_DESMOT"  })
Private _nPosCodigo    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_CODIGO"  })

Private _nIPosDel      := Len(aHeader) + 1

Private cTitulo        := "Tabela Intermediaria - Incluir"
Private cAliasEnchoice := "SZJ"
Private cAliasGetD     := "SZH"
Private cLinOk         := "AllwaysTrue()"      // 'ExecBlock("ESTVLD",.F.,.F.)'
Private cTudOk         := "AllwaysTrue()"
Private cFieldOk       := "AllwaysTrue()"
Private aCpoEnchoice   := {SZH->ZH_CODIGO}
Private aCordW         := {001,005,700,1250}
Private nSizeHeader    := 200

Private nFreeze        := 2
Private aBotao         := {}

_lRet:=Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,,cLinOk,cTudOk,_nOpcE,_nOpcG,cFieldOk,  , ,  ,  ,aBotao,aCordW,nSizeHeader)

If _lRet
	If M->ZJ_STATUS $ "123"//M->ZJ_STATUS == "2"
		Alert("Tabela NAO sera excluida, pois possue Status de tabela concluida/efetivada...")
	Else
		dbSelectArea("SZJ")
		dbSetOrder(1)
		If dbSeek(xFilial("SZJ")+_cCodigo)
			RecLock("SZJ",.F.)
			dbDelete()
			MsUnLock()
		EndIf
		
		dbSelectArea("SZH")
		dbSetOrder(3)
		dbSeek(xFilial("SZH")+_cCodigo,.T.)
		Do While !Eof() .And. ZH_CODIGO == _cCodigo
			RecLock("SZH",.F.)
			dbDelete()
			MsUnLock()
			dbSkip()
		EndDo
	EndIf
EndIf
Return
