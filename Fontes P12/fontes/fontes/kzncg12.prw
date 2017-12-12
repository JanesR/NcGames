#include "PROTHEUS.CH"

User Function KZNCG12(aEmp)
	
	Local alNfs		:= {}
	Default aEmp	:= {"",""}
	
	Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
	Conout(dtoc( Date() ) + " " + Time() + " " + "|===========       PREPARANDO EMPRESAS       ==========|")
	Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")	
	
	RpcSetType(3)
	RpcSetEnv(aEmp[1], aEmp[2],,,,"FAT")
	
    dbSelectArea("SF2")
    If SF2->(FieldPos("F2_XENVINV")) == 0
    	Conout("A tabela SF2 esta desatualizada, o campo F2_XENVINV não foi criado no dicionario de dados. Executar o compatibilizador UPDNCG12 ou criar o campo manualmente.")
		Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
		Conout(dtoc( Date() ) + " " + Time() + " " + "|===========           FINALIZANDO           ==========|")
		Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
    	Return
    EndIf
	Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
	Conout(dtoc( Date() ) + " " + Time() + " " + "|===========     BUSCANDO PEDIDOS EDI        ==========|")
	Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")	
	
	//Função para gerar invoices dos pedidos EDI
	alNfs :=	U_KZGrInv(,.T.)	
	If Len(alNfs) > 0
		Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
		Conout(dtoc( Date() ) + " " + Time() + " " + "|=========      ATUALIZANDO PEDIDOS EDI       =========|")
		Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
    
	    u_KZAtuEdi(alNfs)
    EndIf
    
	Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
	Conout(dtoc( Date() ) + " " + Time() + " " + "|===========           FINALIZANDO           ==========|")
	Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
Return