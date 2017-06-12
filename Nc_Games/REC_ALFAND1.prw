//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGames
//|Funcao....: U_REC_ALFAND1()
//|Autor.....: Norival Júnior
//|Data......: 07 de Agosto de 2013
//|Uso.......: SIGAEIC
//|Versao....: Protheus - 11
//|Descricao.: Função para preenchimento automático do Recinto Alfandegario SIGAEIC
//|Observação:
//------------------------------------------------------------------------------------// 

User Function REC_ALFAND1()

Local cOrigem 		:= M->W6_ORIGEM
Local cDestino 	:= M->W6_DEST

dbSelectArea("SW6")
DO CASE
	CASE cOrigem == "MIA" .and. cDestino == "GRU"
		M->W6_REC_ALF := "8911101"
		M->W6_VM_RECA := Posicione("SJA", 1, xFilial("SJA") + M->W6_REC_ALF, "JA_DESCR")
		M->W6_URF_DES := "0817600"
		M->W6_VM_UDES := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_DES, "J0_DESC")
		M->W6_URF_ENT := "0817600"
		M->W6_VM_UENT := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_ENT, "J0_DESC")
		
		
	CASE cOrigem == "MIA" .and. cDestino == "VCP"
		M->W6_REC_ALF := "8921101"
		M->W6_VM_RECA := Posicione("SJA", 1, xFilial("SJA") + M->W6_REC_ALF, "JA_DESCR")
		M->W6_URF_DES := "0817700"
		M->W6_VM_UDES := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_DES, "J0_DESC")
		M->W6_URF_ENT := "0817700"
		M->W6_VM_UENT := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_ENT, "J0_DESC")
		
	CASE cOrigem == "MIA" .and. cDestino == "CWB"
		M->W6_REC_ALF := "9121101"
		M->W6_VM_RECA := Posicione("SJA", 1, xFilial("SJA") + M->W6_REC_ALF, "JA_DESCR")
		M->W6_URF_DES := "0910100"
		M->W6_VM_UDES := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_DES, "J0_DESC")
		M->W6_URF_ENT := "0910100"
		M->W6_VM_UENT := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_ENT, "J0_DESC")
		
		
	CASE cOrigem == "MIA" .and. cDestino == "SSZ"
		M->W6_REC_ALF := "8931301"
		M->W6_VM_RECA := Posicione("SJA", 1, xFilial("SJA") + M->W6_REC_ALF, "JA_DESCR")
		M->W6_URF_DES := "0817800"
		M->W6_VM_UDES := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_DES, "J0_DESC")
		M->W6_URF_ENT := "0817800"
		M->W6_VM_UENT := Posicione("SJ0", 1, xFilial("SJ0") + M->W6_URF_ENT, "J0_DESC")
		
	OTHERWISE
		M->W6_REC_ALF := ""
		M->W6_VM_RECA := ""
		M->W6_URF_DES := ""
		M->W6_VM_UDES := ""
		M->W6_URF_ENT := ""
		M->W6_VM_UENT := ""
ENDCASE
RETURN M->W6_REC_ALF
