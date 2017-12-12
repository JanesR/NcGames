#INCLUDE "protheus.ch" 

/***********************
/ Z03- Inclusão do Portador  (bancos)
***********************/
User Function M070INFC
   
Local aArea	:= GetArea()
Local aAreaSA6	:= SA6->(GetArea())
Local aDados	:= {}

	aadd(aDados,"Aviso de Inclusão de Portador")
	aadd(aDados,"Filial: "+xFilial("SA6"))
	aadd(aDados,"Cod: "+ A6_COD)
	aadd(aDados,"Agencia: "+ A6_AGENCIA)
	aadd(aDados,"Conta: "+ A6_NUMCON) 
	aadd(aDados,"Conta Contabil:"+A6_CONTA)
	aadd(aDados,"Nome: "+ A6_NOME)
	aadd(aDados,"Incluido por: "+cUsername)
	MEnviaMail("Z03",aDados) 
	
	RestArea(aAreaSA6) 
	
RETURN 