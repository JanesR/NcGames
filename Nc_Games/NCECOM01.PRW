#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "TBICONN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  03/17/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ecom01Job(aDados)

Default aDados:={"01","03"}
RpcSetType(3)
RpcSetEnv(aDados[1],aDados[2])

U_NcEcom01()

RpcClearEnv()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNcEcom01  บAutor  ณOctavio A. Estevam  บ Data ณ  25/11/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Integra็ใo Protheus x CiaShop                              บฑฑ
ฑฑบ          ณ Importa os clientes novos ou que sofreram atualizacao na   บฑฑ
ฑฑบ          ณ ferramenta Ciashop.                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCECOM01(cCodId)
Local aArea		:= GetArea()
Local oobj		:= nil
Local oXml		:= nil
Local oXmlExtr	:= nil //JR
Local nContExtr := nil //JR
Local _cxml		:= ""
Local cError	:= ""
Local cWarning := ""
Local aVetor 	:= {}
Local _aStatus	:= {}
Local _cCpf		:= ""
Local _cIE		:= ""
Local i			:= 0
Local _cTipo	:= ""
Local _GrpCli	:= ""
Local _cCodMun	:= ""
Local _cCodPais:= ""
Local _cContrib:= "1"
Local _cRG		:= ""
Local _cMun		:= ""
Local aErro		:= {}
Local _cError	:= ""
Local _cBloqueado:="1"
Local _cSexo	:= ""
Local _cEstCiv	:= ""
Local _dDtNasc	:= Ctod("//")
Local _cNome	:= ""
Local _cGrpVen	:= "999999"
Local nHDL
Local _cDoc		:= ""
Local _cTab		:= ""
Local lJaExiste
Local cEndereco
Local nLenMun	:=AvSx3("CC2_MUN",3)
Local cTabPrc := ""
Local lSimular:=IsIncallStack("U_M01SIMUL")
Local _cVend := "VN9901"
Local _Canal := "990000"
Local _lB2B	:=.T.
PRIVATE lMsErroAuto 		:= .F.
Private lMsHelpAuto		:= .T.
PRIVATE lAutoErrNoFile	:= .T.

Default cCodId:=""

If !lSimular
	If !Semaforo(.T.,@nHDL,"NCECOM01")
		Return()
	EndIf
EndIf

//Cria o Obejto com os M้todos do Portal CiaShop
oobj:=NC_WSWSIntegracao():new()


//chama o metodo do portal
If oobj:compradores(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),"")
	//transforma o xml do resultado em objeto
	oXml := XmlParser( oobj:cxml, "_", @cError, @cWarning )
	oXmlExtr := XmlParser( oobj:cxml, "_", @cError, @cWarning )
Else
	U_NCECOM09(0, "CLIENT","IMPORTA_CLIENTE","Erro de Execu็ใo : "+GetWSCError(),"",.T.)
Endif

If ValType(oXml) != "O" //Verifica se a variavel ้ um objeto, se nใo retorna o Erro
	U_EHtmErro(oobj:cxml)
	Return
EndIf

//Verifica se ha clientes para cadastrar
If XmlChildCount(oXml:_SHOPPERLIST) > 4
	
	//Pega informa็๕es dos cliente
	If !valtype(oXml:_SHOPPERLIST:_SHOPPER)=="A"
		XmlNode2Arr(oXml:_SHOPPERLIST:_SHOPPER,"_SHOPPER")
	Endif
	nContar:=LEN(oXml:_SHOPPERLIST:_SHOPPER)

	
	For i:=nContar to 1 Step -1
		
		If lSimular .And. !AllTrim(cCodId)==AllTrim(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT)
		
			Loop
		EndIf
		
		if XmlNodeExist(oXml:_SHOPPERLIST:_SHOPPER[i],"_CAMPOS_EXTRAS") 
			
			if valtype( xmlChildEx(oXmlExtr:_SHOPPERLIST:_SHOPPER[i]:_CAMPOS_EXTRAS,"_CAMPO_EXTRA"))=="O"
				If val(oXmlExtr:_SHOPPERLIST:_SHOPPER[i]:_CAMPOS_EXTRAS:_CAMPO_EXTRA:_ENTIDADE_ID:TEXT) == val(oXmlExtr:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT)
					//Nome do campo extra que dirแ a que site o cliente pertence.
					if upper(AllTrim(oXmlExtr:_SHOPPERLIST:_SHOPPER[i]:_CAMPOS_EXTRAS:_CAMPO_EXTRA:_CHAVE:TEXT)) == "LOJA" .And. UPPER(AllTrim(oXmlExtr:_SHOPPERLIST:_SHOPPER[i]:_CAMPOS_EXTRAS:_CAMPO_EXTRA:_VALOR:TEXT)) == "CLIENTEUZGAMES"
						_cBloqueado := "2"
						_cVend := "VN9902"
						_Canal := "990001"
						_lB2B := .F.
						//Loop
					else
						_cBloqueado := "1"
						_cVend := "VN9901"
						_Canal := "990000"
						_lB2B := .T.
					EndIf
				EndIf
			EndIf
		EndIf
		
		If Upper(Alltrim(oXml:_SHOPPERLIST:_SHOPPER[i]:_TIPO:TEXT))=="F"
			
			_cCpf	  		:=oXml:_SHOPPERLIST:_SHOPPER[i]:_CPF:TEXT
			_cRG	  		:=oXml:_SHOPPERLIST:_SHOPPER[i]:_RG_CNPJ:TEXT
			_cIE			:="ISENTO"
			_cTipo		:="F"
			_GrpCli		:="CFIE"
			_cContrib	:="2"
			//_cBloqueado	:="2"
			
			_cTab		:=AchaTab(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT,"F")
			_cEstCiv	:=" "
			_cSexo		:=" "
			
			If ValType( XmlChildEx(oXml:_SHOPPERLIST:_SHOPPER[i], "_SEXO"))=="O"
				_cSexo:=oXml:_SHOPPERLIST:_SHOPPER[i]:_SEXO:TEXT
			Endif
			
			
			If ValType( XmlChildEx(oXml:_SHOPPERLIST:_SHOPPER[i], "_ESTADO_CIVIL"))=="O"
				_cEstCiv:=Upper( Left(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO_CIVIL:TEXT,1))
				If Upper(Substr(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO_CIVIL:TEXT,1,2))=="SE"
					_cEstCiv:="J"
				Endif
			Endif
			_dDtNasc:=Ctod("//")
			
			If ValType( XmlChildEx(oXml:_SHOPPERLIST:_SHOPPER[i], "_NASCIMENTO"))=="O"
				_dDtNasc:=Stod(Substr(oXml:_SHOPPERLIST:_SHOPPER[i]:_NASCIMENTO:TEXT,1,4)+Substr(oXml:_SHOPPERLIST:_SHOPPER[i]:_NASCIMENTO:TEXT,6,2)+Substr(oXml:_SHOPPERLIST:_SHOPPER[i]:_NASCIMENTO:TEXT,9,2))
			Endif
			
		Else
			
			_cCpf	:=oXml:_SHOPPERLIST:_SHOPPER[i]:_RG_CNPJ:TEXT
			_cIE	:=Upper( oXml:_SHOPPERLIST:_SHOPPER[i]:_CPF:TEXT)
			
			If _cIE=="ISENTO" .OR. Empty(_cIE)
				_cIE:="ISENTO"
			Endif
			
			_cContrib:= "1"
			If _cIE== "ISENTO"
				_cContrib:= "2"
				_cTipo	:= "F"
				_GrpCli	:= "CFS" //Consumidor Final Sem Inscri็ใo
				_cTab	:= "030"
				lIsento:= .T.
			Else
				_cTipo	:= "S"
				_GrpCli	:= "SOL"
				_cTab		:= AchaTab(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT,"J")
			Endif
			
			_cRG	:= ""
			//_cBloqueado:="1"
			_cSexo	:= " "
			_cEstCiv	:= " "
			_dDtNasc	:= Ctod("//")
		EndIf
		_cMun		:= PADR( NoAcento(oXml:_SHOPPERLIST:_SHOPPER[i]:_CIDADE:TEXT) , nLenMun)
		cErroAdiconal:=""
		_cCodMun:=""
		
		CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
		If CC2->(DbSeek(xFilial("CC2")+_cMun))
			Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==_cMun
				If CC2->CC2_EST==oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT
					_cCodMun	:= CC2->CC2_CODMUN
				EndIf
				CC2->(DbSkip())
			EndDo
		Else
			cErroAdiconal:="Codigo Municipio nใo encontrado para o Municipio "+_cMun
		EndIf
		
		//Corrige a ordem para as valida็๕es do campo
		CC2->(DBSETORDER(1))
		_cCodpais:= "01058" //Brasil
		_cNome	:= NoAcento(oXml:_SHOPPERLIST:_SHOPPER[i]:_NOME:TEXT)
		_cGrpVen	:= "999999"
		
		//So inclui se nao existir no protheus
		
		SA1->(DbSetOrder(3))
		lJaExiste:= SA1->(DbSeek(xFilial("SA1")+_cCpf))
		
		//If lJaExiste .And. Empty(SA1->A1_ZCODCIA)
		//SA1->(RecLock("SA1",.F.))
		//SA1->A1_ZCODCIA:=Val(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT)
		//SA1->(MsUnLock())
		//EndIf
		
		
		If lJaExiste
			ZC2->(DbSetOrder(5))//ZC2_FILIAL+ZC2_CADAST+ZC2_CNPJ
			If !ZC2->(DbSeek(xFilial("ZC2")+"CLIENTE_EX"+_cCpf))
				SA1->(RecLock("SA1",.F.))
				SA1->A1_ZCODCIA:=Val(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT)
				SA1->(MsUnLock())
				ZC2->(RecLock("ZC2",.T.))
				ZC2->ZC2_FILIAL:=xFilial("ZC2")
				ZC2->ZC2_CADAST	:="CLIENTE_EX"
				ZC2->ZC2_CODCIA	:=AllTrim(Str(SA1->A1_ZCODCIA))
				ZC2->ZC2_NOME	:=SA1->A1_NOME
				ZC2->ZC2_CNPJ	:=SA1->A1_CGC
				ZC2->ZC2_CODERP	:=SA1->A1_COD
				ZC2->ZC2_ERRO	:="N"
				ZC2->(MsUnLock())
				U_EcomHtm7("EXISTENTE")
				Aadd(_aStatus,{oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT,"1"})
			EndIf
			Loop
		Endif
		
		If lJaExiste
			_cDoc := SA1->A1_COD
		Else
			_cDoc := GETSXENUM("SA1","A1_COD")
			SA1->(DbSetOrder(1))
			Do While SA1->(DbSeek(xFilial("SA1") +_cDoc+"01" ))
				ConfirmSX8()
				_cDoc := GETSXENUM("SA1","A1_COD")
			EndDo
		EndIf
		_cNome:=Upper(_cNome)
		

		if _lB2B
			cTabPrc := iif(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT=="SP","018",;
			IIf(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT$"RJ;RS;SC;PR;MG","112","107"))
		else
			cTabPrc := "CON"
		Endif
		

		aVetor:={}
		AADD(aVetor,{"A1_FILIAL" 	,xFilial("SA1") ,Nil})
		AADD(aVetor,{"A1_COD" 		,_cDoc,Nil})
		AADD(aVetor,{"A1_LOJA" 		,"01" ,Nil})
		AADD(aVetor,{"A1_PESSOA" 	,oXml:_SHOPPERLIST:_SHOPPER[i]:_TIPO:TEXT ,Nil})
		AADD(aVetor,{"A1_NOME" 		,_cNome ,Nil})
		AADD(aVetor,{"A1_NREDUZ" 	,_cNome ,Nil})
		AADD(aVetor,{"A1_END" 		,Upper(NoAcento(Alltrim(oXml:_SHOPPERLIST:_SHOPPER[i]:_ENDERECO:TEXT)))+", "+oXml:_SHOPPERLIST:_SHOPPER[i]:_NUMERO:TEXT     ,Nil})
		AADD(aVetor,{"A1_TIPO" 		,_cTipo ,Nil})
		AADD(aVetor,{"A1_EST" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT ,Nil})
		AADD(aVetor,{"A1_NATUREZ" 	,"19101" ,Nil})
		AADD(aVetor,{"A1_COD_MUN" 	,_cCodMun ,Nil})
		AADD(aVetor,{"A1_MUN" 		,Upper(_cMun) ,Nil})
		AADD(aVetor,{"A1_BAIRRO" 	,Upper(NoAcento(oXml:_SHOPPERLIST:_SHOPPER[i]:_BAIRRO:TEXT)) ,Nil})
		AADD(aVetor,{"A1_CEP" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_CEP:TEXT ,Nil})
		AADD(aVetor,{"A1_DDD" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_DDD:TEXT ,Nil})
		AADD(aVetor,{"A1_TEL" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_TELEFONE:TEXT ,Nil})
		AADD(aVetor,{"A1_ENDCOB" 	,Upper(Alltrim(oXml:_SHOPPERLIST:_SHOPPER[i]:_ENDERECO:TEXT))+", "+oXml:_SHOPPERLIST:_SHOPPER[i]:_NUMERO:TEXT ,Nil})
		AADD(aVetor,{"A1_BAIRROC"	,Upper(oXml:_SHOPPERLIST:_SHOPPER[i]:_BAIRRO:TEXT) ,Nil})
		AADD(aVetor,{"A1_CEPC" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_CEP:TEXT ,Nil})
		AADD(aVetor,{"A1_MUNC" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_CIDADE:TEXT ,Nil})
		AADD(aVetor,{"A1_ESTC" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT ,Nil})
		AADD(aVetor,{"A1_ENDENT" 	,Upper(Alltrim(oXml:_SHOPPERLIST:_SHOPPER[i]:_ENDERECO:TEXT))+", "+oXml:_SHOPPERLIST:_SHOPPER[i]:_NUMERO:TEXT ,Nil})
		AADD(aVetor,{"A1_BAIRROE"	,Upper(oXml:_SHOPPERLIST:_SHOPPER[i]:_BAIRRO:TEXT) ,Nil})
		AADD(aVetor,{"A1_CEPE" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_CEP:TEXT ,Nil})
		AADD(aVetor,{"A1_MUNE" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_CIDADE:TEXT ,Nil})
		AADD(aVetor,{"A1_X_LOCZ" 	,"C" ,Nil})
		AADD(aVetor,{"A1_ESTE" 		,oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT ,Nil})
		AADD(aVetor,{"A1_CGC" 		,_cCpf ,Nil})
		AADD(aVetor,{"A1_INSCR" 	,_cIE ,Nil})
		AADD(aVetor,{"A1_PFISICA" 	,_cRG ,Nil})
		AADD(aVetor,{"A1_VEND" 		,"VN9901" ,Nil})
		AADD(aVetor,{"A1_CONTA" 	,"11201010001" ,Nil})
		AADD(aVetor,{"A1_TRANSP" 	,"000002" ,Nil})
		AADD(aVetor,{"A1_TPFRET" 	,"C" ,Nil})
		AADD(aVetor,{"A1_GRPTRIB"	 ,_GrpCli ,Nil})
		AADD(aVetor,{"A1_SATIV1" 	,"000037" ,Nil})
		AADD(aVetor,{"A1_GRPVEN" 	,"990000" ,Nil})
		//AADD(aVetor,{"A1_GRPVEN" 	,CriaGru(aVetor[2][2],_cNome) ,Nil})
		AADD(aVetor,{"A1_CODPAIS"	 ,_cCodpais ,Nil})
		AADD(aVetor,{"A1_FRETE" 	,"1" ,Nil})
		AADD(aVetor,{"A1_TEMODAL" 	,"2" ,Nil})
		AADD(aVetor,{"A1_YCANAL" 	,"990000" ,Nil})
		AADD(aVetor,{"A1_XGRPCOM" 	,"ECOMME" ,Nil})
		AADD(aVetor,{"A1_CONTRIB" 	,_cContrib ,Nil})
		AADD(aVetor,{"A1_TABELA" 	,cTabPrc ,Nil})
		AADD(aVetor,{"A1_COND" 		,"WEB" ,Nil})
		AADD(aVetor,{"A1_XSORTER"	 ,"1" ,Nil})
		AADD(aVetor,{"A1_DTNASC" 	,MsDate() ,Nil})
		AADD(aVetor,{"A1_AGEND" 	,"2" ,Nil})
		AADD(aVetor,{"A1_OPER" 		,"" ,Nil})
		AADD(aVetor,{"A1_ZSEXO" 	,_cSexo ,Nil})
		AADD(aVetor,{"A1_ZESTCIV" ,_cEstCiv ,Nil})
		AADD(aVetor,{"A1_EMAIL" 	,Upper(oXml:_SHOPPERLIST:_SHOPPER[i]:_EMAIL:TEXT) ,Nil})
		
		cEndereco:=""
		If XmlNodeExist(oXml:_SHOPPERLIST:_SHOPPER[i],"_COMPLEMENTO")
			cEndereco:=oXml:_SHOPPERLIST:_SHOPPER[i]:_COMPLEMENTO:TEXT
		EndIf
		
		If XmlNodeExist(oXml:_SHOPPERLIST:_SHOPPER[i],"_REFERENCE")
			cEndereco+=Space(1)+oXml:_SHOPPERLIST:_SHOPPER[i]:_REFERENCE:TEXT
		EndIf
		
		AADD(aVetor,{"A1_COMPLEM" 	,Upper(cEndereco),Nil})
		
		AADD(aVetor,{"A1_REGIAO" 	,u_AchaReg(oXml:_SHOPPERLIST:_SHOPPER[i]:_ESTADO:TEXT) ,Nil})
		AADD(aVetor,{"A1_ZCODTAB" 	,_cTab ,Nil})
		AADD(aVetor,{"A1_ZCODCIA"	,val(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT),Nil})
		AADD(aVetor,{"A1_MSBLQL" 	,_cBloqueado ,Nil})

		If lSimular
			Simular(aVetor)
			Exit
		ElseIf EMPTY(ALLTRIM(cErroAdiconal))
			
			BEGIN TRANSACTION
			                            
			l030Auto:=.T.
			lMsErroAuto:=.F.
			CC2->(DBSETORDER(1))
			MSExecAuto({|x,y| MATA030(x,y)},aVetor, Iif(lJaExiste,4,3))
			_cError:=""
			
			If lMsErroAuto
				_cError := MemoRead(NomeAutoLog())+CRLF+cErroAdiconal+CRLF
				//If Empty(_cError)
				ExecValid(aVetor,@_cError)
				//EndIf
				
				U_COM09CAD(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT,"CLIENTE","IMPORTA_CLIENTE","Erro ao "+Iif(lJaExiste,"Alterar o cliente codigo Protheus:"+SA1->A1_COD,"Incluir")+" Cliente.",Iif(Empty(_cError),"error",_cError),_cNome)
				RollBackSXe()
			Else
				
				//	SA1->(RecLock("SA1",.F.))
				//  SA1->A1_X_LOCZ:=""
				//	SA1->(MsUnLock())
				
				Aadd(_aStatus,{oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT,"1"})
				ConfirmSX8()
				U_COM09CAD(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT,"CLIENTE","IMPORTA_CLIENTE","Cliente c๓digo Protheus:"+SA1->A1_COD+Iif(lJaExiste," alterarado"," incluido")+" com Sucesso.",_cError,_cNome,{SA1->A1_CGC,SA1->A1_COD})
				If !lJaExiste
					U_EcomHtm7("INCLUSAO")
				EndIf
				
			Endif
			
			END TRANSACTION
		Else
			U_COM09CAD(oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT,"CLIENTE","IMPORTA_CLIENTE","Cliente c๓digo Protheus:"+SA1->A1_COD+Iif(lJaExiste," alterarado"," incluido")+" com Sucesso.",cErroAdiconal,_cNome,{SA1->A1_CGC,SA1->A1_COD})
		EndIf
		Aadd(_aStatus,{oXml:_SHOPPERLIST:_SHOPPER[i]:_SHOPPER_ID:TEXT,"1"})
		
	Next i
	
	//Chama a Funcao que ira atualizar os clientes no portal CiaShop
	If Len(_aStatus)>0
		U_NCECOM02(_aStatus)
	EndIf
	
	//oSrv:=RpcConnect( "192.168.0.217",1242,"TOTVSHOM_ECOMMERCE","01","03" )
	//cXML:=(oSrv:callproc("U_NCECOM02",_aStatus))
	//RpcDisconnect (oSrv )
	
Endif

Semaforo(.F.,nHDL,"NCECOM01")
RestArea(aArea)
Return

static FUNCTION NoAcento(cString)
Local cChar  := ""
Local nX     := 0
Local nY     := 0
Local cVogal := "aeiouAEIOU"
Local cAgudo := "แ้ํ๓๚"+"มษอำฺ"
Local cCircu := "โ๊๎๔๛"+"ยสฮิÛ"
Local cTrema := "ไ๋๏๖ü"+"ฤหฯึÜ"
Local cCrase := "เ่์๒๙"+"ภศฬาู"
Local cTio   := "ใ๕รี"
Local cCecid := "็ว"
Local cMaior := "&lt;"
Local cMenor := "&gt;"
Local cSimbolo:=Chr(39)

For nX:= 1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
		nY:= At(cChar,cAgudo)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCircu)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTrema)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCrase)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTio)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("aoAO",nY,1))
		EndIf
		nY:= At(cChar,cCecid)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("cC",nY,1))
		EndIf
	Endif
Next

If cMaior$ cString
	cString := strTran( cString, cMaior, "" )
EndIf
If cMenor$ cString
	cString := strTran( cString, cMenor, "" )
EndIf

If cSimbolo$ cString
	cString := strTran( cString, cSimbolo, "" )
EndIf


For nX:=1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	If (Asc(cChar) < 32 .Or. Asc(cChar) > 123) .and. !cChar $ '|'
		cString:=StrTran(cString,cChar,".")
	Endif
Next nX
cString:=upper(cString)
Return cString


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  03/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AchaReg(_cEst)
Local _cReg:=""
//Norte
If _cEst$"AM/AP/AC/RR/PA/RO/TO"
	_cReg:="001"
ElseIf _cEst$"MA/PI/CE/RN/PE/PB/SE/AL/BA"
	_cReg:="007"
ElseIf _cEst$"GO/MT/MS"
	_cReg:="006"
ElseIf _cEst$"SP/RJ/MG/ES"
	_cReg:="008"
Else
	_cReg:="002"
Endif
Return _cReg
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  03/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaGru(_cCod,_cNome)

ACY->(DbSetOrder(3))

IF ACY->(DbSeek(xFilial("ACY")+_cNome))
	_cCod := ACY->ACY_GRPVEN
Else
	ACY->(Reclock("ACY",.T.))
	
	ACY_FILIAL := xFilial("ACY")
	ACY_GRPVEN := _cCod
	ACY_DESCRI := _cNome
	
	ACY->(MsUnlock())
Endif

Return _cCod
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+".LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  02/27/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AchaTab(_cEst,_cTipo)
Local aAreaAtu	:=GetArea()
Local cAliasQry:=GetNextAlias()
Local _cTab		:=""
Local _cQuery	:=" SELECT * FROM "+RetSqlName("ZC4")+" WHERE ZC4_FILIAL='"+xFilial("ZC4") +"' And D_E_L_E_T_=' ' AND ZC4_FLAG='1' AND ZC4_EST='"+_cEst+"'"

If _cTipo=="F"
	_cTab:="018"
Else
	dbUseArea(.T., "TOPCONN", TCGenQry(,,_cQuery), cAliasQry, .T., .F.)
	If !(cAliasQry)->(Eof())
		_cTab:=(cAliasQry)->ZC4_CODTAB
	Endif
	(cAliasQry)->(dbCloseArea())
Endif

RestArea(aAreaAtu)
Return _cTab

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  04/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExecValid(aVetor,_cError)
Local nInd


RegToMemory("SA1",.F.,.F.)
For nInd:=1 To Len(aVetor)
	
	Eval ( MemVarBlock(aVetor[nInd][1]),aVetor[nInd][2])
	__READVAR := "M->"+aVetor[nInd][1]
	cReadVar := &(__READVAR)
	&(__READVAR) := aVetor[nInd][2]
	
	bValid:=AvSx3(aVetor[nInd][1],7)
	If !Eval( bValid )
		xConteudo:=aVetor[nInd][2]
		If ValType(xConteudo)=="N"
			xConteudo:=AllTrim(Str(xConteudo))
		ElseIf ValType(xConteudo)=="D"
			xConteudo:=DTOC(xConteudo)
		EndIf
		
		
		_cError+="Erro campo "+aVetor[nInd][1]+" conteudo "+xConteudo+CRLF
	EndIf
	
	
Next


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  06/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Simular(aVetor)

Local nInd
For nInd:=1 To Len(aVetor)
	
	Eval ( MemVarBlock(aVetor[nInd][1]),aVetor[nInd][2])
	__READVAR := "M->"+aVetor[nInd][1]
	cReadVar := &(__READVAR)
	&(__READVAR) := aVetor[nInd][2]
Next

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  06/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function M01SIMUL()
Local cNumID:=""
Local cPerg:="M01SIMUL"
Local mvpar01:=mv_par01

PutSx1(cPerg,"01","Id Cliente Web ?" ,"","","mv_ch1","C",6,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
If Pergunte(cPerg)
	U_NCECOM01(AllTrim(mv_par01))
EndIf
mv_par01:=mvpar01

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  02/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ECOM01PROD(cMensagem)
Local aAreaAtu	:=GetArea()
Local aAreaSB5	:=SB5->(GetArea())
Local oApiSite
Local cBody:=""
Local cProduto:=AllTrim(SB1->B1_COD)

cMensagem:=""

oApiSite:= ApiCiaShop():New()
oApiSite:cUrl:='products?erpId='+cProduto
oApiSite:HttpGet()

If At(cProduto,oApiSite:cResponse)==0
	
	SB5->(DbSetOrder(1))
	SB5->(MsSeek(xFilial("SB5")+SB1->B1_COD))
	
	cBody+='{
	cBody+='  "name": "'+AllTrim(SB1->B1_XDESC)+' ",
	cBody+='  "shortDescription": "'+StrTran(Left(AllTrim(SB5->B5_VSINTIT),255),'"','')+'", 
	cBody+='  "blocked": true,
	cBody+='  "sortOrder": 888888,
	cBody+='  "erpId": "'+cProduto+'",
	cBody+='  "mainDepartmentId": 4,
	cBody+='  "quantityOfInstallmentsNoInterest": 1,
	cBody+='  "quantityOfInstallmentsWithInterest": 1,
	cBody+='  "variants": [
	cBody+='   {
	cBody+='      "erpId": "'+cProduto+'",
	cBody+='      "quantity": 0,
	cBody+='      "visible": true,
	cBody+='      "weight": '+AllTrim(Str(SB1->B1_PESO*1000))+',
	cBody+='      "length": '+M01Trans(SB1->B1_PROF)+',
	cBody+='      "width": '+M01Trans(SB1->B1_LARGURA)+',
	cBody+='      "height": '+M01Trans(SB1->B1_ALT)+',
	cBody+='      "price": 1,
	cBody+='      "ean"	 : "'+AllTrim(SB1->B1_CODBAR)+' ",
	cBody+='      "urlKey": "'+AllTrim(SB1->B1_CODBAR)+' ",
	cBody+='      "mainVariant": true
	cBody+='    }
	cBody+='  ],
	cBody+='}
	oApiSite:cBody:=EnCodeUtf8(cBody)
	oApiSite:cUrl:='products'
	oApiSite:HttpPost()
	
	If valtype(oApiSite:cResponse)=="U" //At("errors",oApiSite:cResponse)>0
		cMensagem:="Erro na grava็ao do Produto."
	elseif At("errors",oApiSite:cResponse)>0
		cMensagem:="Erro na grava็ao do Produto."
	Else
		cMensagem:="Produto gravado com sucesso."
	EndIf
	RestArea(aAreaSB5)
Else
	cMensagem+="Produto jแ cadastrado."
EndIf

RestArea(aAreaAtu)



Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM01  บAutor  ณMicrosiga           บ Data ณ  02/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function M01Trans(nParam)
cRetorno:=AllTrim(Str(nParam,0))
Return cRetorno

