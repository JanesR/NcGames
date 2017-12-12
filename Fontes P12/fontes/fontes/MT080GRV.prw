#INCLUDE "protheus.ch" 

/***********************
/ INCLUSÃO E ALTERAÇÃO DE TES    Z01 e Z02
***********************/
User Function MT080GRV

Local aArea	:= GetArea()
Local aAreaSF4	:= SF4->(GetArea())
Local aDados	:= {}

If INCLUI
	aadd(aDados,"Aviso de inclusão de TES")
	aadd(aDados,"Filial: "+xFilial("SF4"))
	aadd(aDados,"Código: "+M->F4_CODIGO)
	aadd(aDados,"CFOP: "+M->F4_CF)
	aadd(aDados,"Finalidade: "+M->F4_FINALID)
	aadd(aDados,"Incluído por: "+cUsername)
	MEnviaMail("Z01",aDados)
ElseIf ALTERA
	aadd(aDados,"Aviso de alteração de TES")
	aadd(aDados,"Filial: "+xFilial("SF4"))
	aadd(aDados,"Código: "+M->F4_CODIGO)
	aadd(aDados,"CFOP: "+M->F4_CF)
	aadd(aDados,"Finalidade: "+M->F4_FINALID)
	aadd(aDados,"Alterado por: "+cUsername)
	MEnviaMail("Z02",aDados)
EndIf

RestArea(aAreaSF4)
RestArea(aArea)

Return     
