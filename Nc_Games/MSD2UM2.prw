/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR118  ºAutor  ³Microsiga           º Data ³  01/18/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß#ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MSD2UM2()
Local nItem
IF FWIsInCallStack("U_NCGPR118") .And. SF2->F2_EST<>MaFisRet(,"NF_UFDEST")
	nItem:=VAL(SD2->D2_ITEM)
	MaFisAlt("NF_UFDEST",SF2->F2_EST) 
	MaFisAlt ("IT_ITEM", SD2->D2_ITEM, nItem )
	SF4->(MaFisWrite(2,"SD2",nItem))
	SD2->D2_VALICM   := SF4->(If(SF4->F4_ISS<>"S",MaFisRet(nItem,'IT_VALICM') ,MaFisRet(nItem,'IT_VALISS')))
	SD2->D2_BASEICM  := SF4->(If(SF4->F4_ISS<>"S",MaFisRet(nItem,'IT_BASEICM'),MaFisRet(nItem,'IT_BASEISS')))
	SD2->D2_PICM     := SF4->(If(SF4->F4_ISS=="S",MaFisRet(nItem,'IT_ALIQISS'),MaFisRet(nItem,'IT_ALIQICM')))
	SD2->D2_DESCZFR  := SF4->(MaFisRet(nItem,'IT_DESCZF')) 
ENDIF



Return SD2->D2_QTSEGUM