#Include 'Protheus.ch'
#Include 'Rwmake.ch'
/*
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������ͻ��
���Programa  �F650VAR   �Autor  �Sidney de O. Almeida  � Data �  01/09/2011 ���
���������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para o relatorio do CNAB a Receber - HSBC    ���
���          �                                                              ���
���������������������������������������������������������������������������͹��
���Uso       � Contas a Receber                                             ���
���������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
*/

User Function F650VAR(cBanco)

Local aArea		:= GetArea()
Local aAreaSE1	:= SE1->(GetArea())
Local aValores := PARAMIXB[1]

If mv_par07 == 2 //Contas a receber
	If cTipo == "04" .and. substr(aValores[1],11,3) == "BOL"
		cTipo := "03"
	EndIf
	RestArea(aAreaSE1)
	RestArea(aArea)    
	Return
EndIf

cBanco := MV_PAR03
cPrefixo := substr(aValores[1],1,3)
cNum     := strzero(val(substr(aValores[1],4,6)),9)
cParc    := substr(aValores[1],10,1)

// alterar o numero do titulo de prefixo+num+parcela+tipo para IDCNAB do CNAB a receber HSBC e SRM
If cBanco $ "399/931"
	//if len(alltrim(cNumTit))
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	//		IF DBSEEK(XFILIAL("SE1")+cNumTit,.T.)
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		cNumTit := SE1->E1_IDCNAB
	ENDIF
	//	cNumTit := getadvfval("SE1","E1_IDCNAB",XFILIAL("SE1")+ALLTRIM(cNumTit),1,cNumTit)
	//	endif
	   
EndIf

//BANCO DANIELE
If cBanco=="915"	
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		cNumTit := SE1->E1_IDCNAB
	ENDIF
EndIf
//Para os t�tulos do BCO DANIELE de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "915"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) $ "01/06/02" 
		If SE1->E1_PORTADO <> "915" 
			cOcorr := "01A"
		EndIf
	Endif
EndIf

//SE N�O ENCONTRAR O IDCNAB, BUSCAR� O N�MERO DO T�TULO E REALIZAR A GRAVA��O DO IDCNAB
DBSELECTAREA("SE1")
DBSETORDER(16)   //IDCNAB
IF !DBSEEK(XFILIAL("SE1")+cNumTit,.T.)
	cPrefixo := substr(aValores[14],117,3)
	cNum     := "000"+substr(aValores[14],120,6)
	cParc    := substr(aValores[14],126,1)
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		IF EMPTY(SE1->E1_IDCNAB)
			reclock("SE1",.f.)
			SE1->E1_IDCNAB	:= cNumTit
			msunlock()
		ENDIF
	ENDIF
ENDIF


//Para os t�tulos do NA FOMENTO de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "531"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) == "36" 
		If SE1->E1_PORTADO <> "531" 
			cOcorr := "36A"
		EndIf
	Endif
EndIf

//Para os t�tulos do Citibank de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "745"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) == "06" 
		If SE1->E1_PORTADO <> "745" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//Para os t�tulos do Banpar de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "902"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) == "06" 
		If SE1->E1_PORTADO <> "902" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//Para os t�tulos do RedFactor de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "913"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) == "06" 
		If SE1->E1_PORTADO <> "913" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//Para os t�tulos do ASIA de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "708"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) $ "06/15" 
		If SE1->E1_PORTADO <> "708" 
			cOcorr := substr(aValores[13],1,2)+"A"
		EndIf
	Endif
EndIf

//Para os t�tulos do HSBC de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "399"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,3) == "035"
		If SE1->E1_PORTADO <> "399" 
			cOcorr := "604"
		EndIf
	Endif
EndIf

//Para os t�tulos do Kobold de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "924"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) $ "06/15" 
		If SE1->E1_PORTADO <> "924" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//TRATAMENTO RETORNO UNION
If cBanco=="933"
	//if len(alltrim(cNumTit))
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	//		IF DBSEEK(XFILIAL("SE1")+cNumTit,.T.)
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		cNumTit := SE1->E1_IDCNAB
	ENDIF
	   
EndIf


//Para a correta grava��o da data do cr�dito do banco industrial
If cBanco == "604"
	If substr(aValores[13],1,2) $ "06/08" 
		dCred := datavalida(aValores[12]+1)
	Endif
EndIf
//Para os t�tulos do INDUSTRIAL de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "604"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[13],1,2) $ "06" 
		If SE1->E1_PORTADO <> "604" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

dBaixa	:= datavalida(aValores[2])

RestArea(aAreaSE1)
RestArea(aArea)

Return
//�������������������������������Ŀ
//� o array aValores ir� permitir �
//� que qualquer exce��o ou neces-�
//� sidade seja tratado no ponto  �
//� de entrada em PARAMIXB        �
//���������������������������������
// Estrutura de aValores
//	Numero do T�tulo 		- 01
//	data da Baixa			- 02
// 	Tipo do T�tulo			- 03
// 	Nosso Numero			- 04
// 	Valor da Despesa		- 05
// 	Valor do Desconto		- 06
// 	Valor do Abatiment		- 07
// 	Valor Recebido    		- 08
// 	Juros					- 09
// 	Multa					- 10
// 	Valor do Credito		- 11
// 	Data Credito			- 12
// 	Ocorrencia				- 13
// 	Linha Inteira			- 14

/*
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������ͻ��
���Programa  �F200VAR   �Autor  �Sidney de O. Almeida  � Data �  01/09/2011 ���
���������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para a baixa automatica no recebimento       ���
���          �do arquivo retorno HSBC                                       ���
���������������������������������������������������������������������������͹��
���Uso       � Contas a Receber                                             ���
���������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
*/

User Function F200VAR(cBanco)

cBanco := MV_PAR06
aValores := PARAMIXB[1]
cPrefixo := substr(aValores[1],1,3)
cNum     := strzero(val(substr(aValores[1],4,6)),9)
cParc    := substr(aValores[1],10,1)

// alterar o numero do titulo de prefixo+num+parcela+tipo para IDCNAB do CNAB a receber

aArea	:= GetArea()
If	 cBanco $ "399/931"
	
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		cNumTit := SE1->E1_IDCNAB
	ENDIF
EndIf

//Para os t�tulos do NA Fomento de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "531"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) == "36"
		If SE1->E1_PORTADO <> "531"
			cOcorr := "36A"
		EndIf
	Endif
EndIf

//Para os t�tulos do Citibank de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "745"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) == "06"
		If SE1->E1_PORTADO <> "745"
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//Para os t�tulos do Banpar de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "902"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) == "06"
		If SE1->E1_PORTADO <> "902"
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//Para os t�tulos do RedFactor de desconto que j� tiverem sido transferidos para outro banco
If cBanco == "913"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB	DBSETORDER(18) 
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) == "06"
		If SE1->E1_PORTADO <> "913"
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//Para os t�tulos do ASIA de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "708"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) $ "06/15"
		If SE1->E1_PORTADO <> "708"
			cOcorr := substr(aValores[14],1,2)+"A"
		EndIf
	Endif
EndIf

//Para os t�tulos do HSBC de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "399"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,3) == "035"
		If SE1->E1_PORTADO <> "399" 
			cOcorr := "604"
		EndIf
	Endif
EndIf

//Para os t�tulos do Kobold de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "924"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) $ "06/15" 
		If SE1->E1_PORTADO <> "924" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

//BANCO DANIELE
If cBanco=="915"
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		cNumTit := SE1->E1_IDCNAB
	ENDIF
EndIf
//Para os t�tulos do BCO DANIELE de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "915"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) $ "01/06/02" 
		If SE1->E1_PORTADO <> "915" 
			cOcorr := "01A"
		EndIf
	Endif
EndIf


//TRATAMENTO RETORNO UNION
If cBanco=="933"
	//if len(alltrim(cNumTit))
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	DBGOTOP()
	//		IF DBSEEK(XFILIAL("SE1")+cNumTit,.T.)
	IF DBSEEK(XFILIAL("SE1")+cPrefixo+cNum+Cparc,.T.)
		cNumTit := SE1->E1_IDCNAB
	ENDIF
	   
EndIf


//Para a correta grava��o da data do cr�dito do banco industrial
If cBanco == "604"
	If substr(aValores[14],1,2) $ "06/08" 
		dDataCred := datavalida(aValores[13]+1)
	Endif
EndIf
//Para os t�tulos do BCO DANIELE de desconto que j� tiverm sido transferidos para outro banco
If cBanco == "604"
	DBSELECTAREA("SE1")
	DBSETORDER(16)   //IDCNAB
	If DbSeek(XFILIAL("SE1")+cNumTit,.T.) .and. substr(aValores[14],1,2) $ "06" 
		If SE1->E1_PORTADO <> "604" 
			cOcorr := "06A"
		EndIf
	Endif
EndIf

dBaixa	:= datavalida(aValores[2])

RestArea(aArea)

// Estrutura de aValores
//	Numero do T�tulo	- 01
//	data da Baixa		- 02
// Tipo do T�tulo		- 03
// Nosso Numero		- 04
// Valor da Despesa	- 05
// Valor do Desconto	- 06
// Valor do Abatiment- 07
// Valor Recebido    - 08
// Juros					- 09
// Multa					- 10
// Outras Despesas	- 11
// Valor do Credito	- 12
// Data Credito		- 13
// Ocorrencia			- 14
// Motivo da Baixa 	- 15
// Linha Inteira		- 16
// Data de Vencto	   - 17


Return
