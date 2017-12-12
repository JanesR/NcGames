#INCLUDE "protheus.ch" 

/***********************
/ Alteração do Cadastro de Fornecedores.
***********************/
User Function M020ALT    

Local aArea	:= GetArea()
Local aAreaSA2	:= SA2->(GetArea())
Local aDados	:= {}     

	aadd(aDados,"Aviso de alteração no cadastro de fornecedores")
	aadd(aDados,"Filial: "+xFilial("SA2"))
	aadd(aDados,"NOME: "+SA2->A2_NOME)
	aadd(aDados,"Código: "+SA2->A2_COD) 
	aadd(aDados,"Loja: "+SA2->A2_LOJA)
	aadd(aDados,"Conta Contabil: "+SA2->A2_CONTA)
	aadd(aDados,"Alterado por: "+cUsername)
	MEnviaMail("Z07",aDados)  
	
	RestArea(aAreaSA2)
RETURN