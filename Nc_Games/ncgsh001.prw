#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "AP5MAIL.CH"

#DEFINE QUEBRA Chr(13) + Chr(10)
#DEFINE PASTALOG GetSrvProfString("STARTPATH","") + "LOG_CATALOGO\"
#DEFINE TAMLOG 5120
#DEFINE EXTLOG ".log"
#DEFINE AGUARDAR .F.
#DEFINE aMyTopErros {			;
{0,"TC_NO_ERROR"}			;
,{-1,"NO_ROUTER_INSTALLED"}	;
,{-2,"NO_CONNECTION"}		;
,{-4,"NO_USER_SECURITY"}	;
,{-5,"PASSTHRU_FAILED"}		;                                                                  
,{-6,"NO_MORE_CONNECTIONS"}	;
,{-8,"INVALID_TOP_KEY"}		;
,{-9,"INVALID_ENVIRONMENT"}	;                                                                                                                                           
,{-10,"INVALID_FILE"}		;
,{-11,"UNKNOWN_FILE"}		;
,{-12,"EXCLUSIVE_REQUIRED"}	;
,{-13,"INVALID_OPERATION"}	;
,{-14,"INVALID_KEY_NUM"}	;
,{-15,"FILE_IN_USE"}		;
,{-16,"TOO_MANY_FILES"}		;
,{-17,"INVALID_NUMRECS"}	;
,{-18,"CALL_FAILED"}		;
,{-19,"COMMAND_FAILED"}		;
,{-20,"OVERRIDE_FAILED"}	;
,{-21,"QUERY_FAILED"}		;
,{-22,"CREATION_FAILED"}	;
,{-23,"OPEN_FAILED"}		;
,{-24,"NOT_OPENED"}			;
,{-25,"NO_RECORD_FOUND"}	;
,{-26,"END_OF_RECORDS"}		;
,{-27,"NO_WRITE_POSIBLE"}	;
,{-28,"NO_RECORD_EQUAL"}	;
,{-29,"UPDATE_FAILED"}		;
,{-30,"DELETE_FAILED"}		;
,{-31,"RECORD_LOCKED"}		;
,{-32,"FILE_LOCKED"}		;
,{-33,"NO_AUTORIZATION"}	;
,{-34,"TOO_MANY_USERS"}		;
,{-35,"NO_DB_CONNECTION"}	;
,{-36,"NO_CONN_ALLOWED"}	;
,{-37,"INTEGRITY_FAILURE"}	;
,{-40,"BUFFER_OVERFLOW"}	;
,{-41,"INVALID_PARAMETERS"}	;
,{-50,"NO_AUDIT_CONNECTION"};
,{-58,"COMM_DOSMEM_ERROR"}	;
,{-67,"COMM_PARTNER_ERROR"}	;
,{-76,"COMM_SNDSTAT_ERROR"}	;
,{-76,"COMM_RCVSTAT_ERROR"}	;
,{-81,"COMM_INITPGM_ERROR"}	;
,{-86,"COMM_PARAM_ERROR"}	;
,{-88,"COMM_PROGRAM_ERROR"}	;
,{-90,"COMM_INSMEM_ERROR"}	;
,{-99,"INVALID_BUILD"}		;
,{-100,"INVALID_TOPAPI"}	;
}
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSH001  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ ROTINA DE EXPORTAวรO DE DADOS PROTHEUS-CATALOGO DE PRODUTOSนฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC GAMES - CATALOGO DE PRODUTOS                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CALLFUN1()

U_NCGSH001({.T.,"01","01",.T.,.F.,""})

Return()

User Function NCGSH001(alParams)
Local llJob			:= .T.
Local alAreaSM0 	:= {}
Local alUsrs		:= {}
Local nHdlSem		:= -1
Local clArqLog		:= ""
Local aNomesArqs	:= {{ "E0001SB1",.T.};
,{"E0001SX5",.T.};
,{"E0001SYD",.T.};
,{"E0001CTT",.T.};
,{"E0001SZ5",.T.};
,{"E0001SF4",.T.};
,{"E0001SZ9",.T.};
,{"E0001SYA",.T.};
,{"E0001SBM",.T.};
,{"E0001SX6",.T.};
,{"E0001CTD",.T.};
,{"E0001SAH",.T.};
,{"E0001CT1",.T.};
,{"E0001SA3",.T.}}
Local lMailSemaforo := .F.

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

Default alParams:={.F.,"","",.F.,.F.,""}

If alParams[1]
	RpcSetType(3)
	RpcSetEnv(alParams[2],alParams[3])
Else
	alAreaSM0 := SM0->(GetArea())
	llJob:=.T.
EndIf

Begin Sequence

lMailSemaforo := U_MyNewSX6("NCG_000013"						,;
.F.														,;
"L"																,;
"Define se envia ou nใo e-mail ao administrador quando a rotina entrar no semaforo vermelho "	,;
"Define se envia ou nใo e-mail ao administrador quando a rotina entrar no semaforo vermelho "	,;
"Define se envia ou nใo e-mail ao administrador quando a rotina entrar no semaforo vermelho "	,;
.F. )

llJob := !llJob

If ! ("SB1" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SB1" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[1][1],.T.)		

			If llJob
				StartJob( "U_E0001SB1()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[1][1])
			Else
				U_E0001SB1(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[1][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SB1 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SB1 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SX5" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SX5" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[2][1],.T.)
						
			If llJob
				StartJob( "U_E0001SX5()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[2][1])
			Else
				U_E0001SX5(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[2][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SX5 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SX5 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SYD" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SYD" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[3][1],.T.)
			
			If llJob
				StartJob( "U_E0001SYD()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[3][1])
			Else
				U_E0001SYD(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[3][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SYD jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SX5 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("CTT" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001CTT" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[4][1],.T.)
			
			If llJob
				StartJob( "U_E0001CTT()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[4][1])
			Else
				U_E0001CTT(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[4][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001CTT jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001CTT JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SZ5" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SZ5" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[5][1],.T.)
			
			If llJob
				StartJob( "U_E0001SZ5()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[5][1])
			Else
				U_E0001SZ5(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[5][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SZ5 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SZ5 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SF4" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SF4" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[6][1],.T.)
			
			If llJob
				StartJob( "U_E0001SF4()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[6][1])
			Else
				U_E0001SF4(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[6][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SF4 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SF4 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SZ9" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SZ9" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[7][1],.T.)
			
			If llJob
				StartJob( "U_E0001SZ9()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[7][1])
			Else
				U_E0001SZ9(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[7][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SZ9 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SZ9 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SYA" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SYA" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[8][1],.T.)
			
			If llJob
				StartJob( "U_E0001SYA()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[8][1])
			Else
				U_E0001SYA(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[8][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SYA jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SYA JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf


If ! ("SBM" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SBM" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[9][1],.T.)
			
			If llJob
				StartJob( "U_E0001SBM()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[9][1])
			Else
				U_E0001SBM(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[9][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SBM jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SBM JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf


If ! ("SX6" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SX6" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[10][1],.T.)
			
			If llJob
				StartJob( "U_E0001SX6()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[10][1])
			Else
				U_E0001SX6(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[10][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SX6 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SX6 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("CTD" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001CTD" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[11][1],.T.)
			
			If llJob
				StartJob( "U_E0001CTD()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[11][1])
			Else
				U_E0001CTD(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[11][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001CTD jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001CTD JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf


If ! ("SAH" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SAH" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[12][1],.T.)
			
			If llJob
				StartJob( "U_E0001SAH()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[12][1])
			Else
				U_E0001SAH(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[12][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SAH jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SAH JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("CT1" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001CT1" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[13][1],.T.)
			
			If llJob
				StartJob( "U_E0001CT1()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[13][1])
			Else
				U_E0001CT1(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[13][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001CT1 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001CT1 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If ! ("SA3" $ Upper(Alltrim(alParams[6])) )
	
	alUsrs := GetUserInfoArray()
	
	If aScan(alUsrs, {|x| "E0001SA3" $ x[5] }) <= 0
		
		If !Semaforo(@aNomesArqs[14][1],.T.)
			
			If llJob
				StartJob( "U_E0001SA3()", GetEnvServer(), alParams[4],.T.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[14][1])
			Else
				U_E0001SA3(.F.,SM0->M0_CODIGO,SM0->M0_CODFIL,alParams[5], aNomesArqs[14][1])
			EndIf
			
		EndIf
		
	Else
		
		ConOut("A rotina E0001SA3 jแ estแ sendo executada !")
		
		E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA E0001SA3 JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
		
	EndIf
	
EndIf

If alParams[1]
	RpcClearEnv()
Else
	RestArea(alAreaSM0)
EndIf

End Sequence

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SB1  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE PRODUTO (SB1) PARA A TABELA PRODU- บฑฑ
ฑฑบ          ณ TO - CATALOGO DE PRODUTOS.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC GAMES - CATALOGO DE PRODUTOS                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SB1(llJob, clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "PRODUTO_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local lDelTudo	:= .T.
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob			:= .F.
Default clEmp			:= ""
Default clFil    		:= ""
Default llLog			:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Iniciando rotina de manutencao na tabela PRODUTO - CATALOGO.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql 		:=	"	SELECT "
clSql		+=	"		 (CASE WHEN SB1.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "
clSql		+=	"		,('"+SM0->M0_CODIGO+"') AS EMPRESA	"
clSql		+=	"		,B1_FILIAL "
clSql		+=	"		,B1_BLQVEND "
clSql		+=	"		,B1_DESCCAT "
clSql		+=	"		,B1_DESC "
clSql		+=	"		,B1_PUBLISH "
clSql		+=	"		,B1_ORIGEM "
clSql		+=	"		,B1_ALTCXM "
clSql		+=	"		,B1_LAGCXM "
clSql		+=	"		,B1_PROFCXM "
clSql		+=	"		,B1_PEMASTE "
clSql		+=	"		,B1_QUD "
clSql		+=	"		,B1_MIDIA "
clSql		+=	"		,B1_QTMIDIA "
clSql		+=	"		,B1_DESC_GI "
clSql		+=	"		,B1_POSIPI "
clSql		+=	"		,B1_PICM "
clSql		+=	"		,B1_TIPO "
clSql		+=	"		,B1_XDESC "
clSql		+=	"		,B1_CODGEN "
clSql		+=	"		,B1_PAISPRO "
clSql		+=	"		,B1_IPI "
clSql		+=	"		,B1_TE "
clSql		+=	"		,B1_IMPZFRC "
clSql		+=	"		,B1_GRTRIB "
clSql		+=	"		,B1_CC "
clSql		+=	"		,B1_STACML "
clSql		+=	"		,B1_TECNO "
clSql		+=	"		,B1_TECNOC "
clSql		+=	"		,B5_LANCSIM "
clSql		+=	"		,B5_OUTVER "
clSql		+=	"		,B1_PLATAF "
clSql		+=	"		,B1_PRV1 "
clSql		+=	"		,B1_CONSUMI "
clSql		+=	"		,B5_PREVCHE "    
clSql		+=	"		,B1_CONINI "
clSql		+=	"		,B1_DTLANC "
clSql		+=	"		,B1_LANC "
clSql		+=	"		,B1_XCURABC "
clSql		+=	"		,B1_XSUBCLA "
clSql		+=	"		,B1_XSELSIT "
clSql		+=	"		,B1_XRELEVA "
clSql		+=	"		,B1_MSBLQL "
clSql		+=	"		,B5_DTBUSCA "
clSql		+=	"		,B5_PROMCON "
clSql		+=	"		,B5_PROMREV "
clSql		+=	"		,B1_ALT "
clSql		+=	"		,B1_LARGURA "
clSql		+=	"		,B1_PROF "
clSql		+=	"		,B1_DESCCLA "
clSql		+=	"		,B1_LOCPAD "
clSql		+=	"		,B1_ITEMCC "
clSql		+=	"		,B1_IMPORT "
clSql		+=	"		,B1_CONV "
clSql		+=	"		,B1_UM "
clSql		+=	"		,B1_CONTA "
clSql		+=	"		,B1_DESC_I "
clSql		+=	"		,B1_PLATEXT "
clSql		+=	"		,B1_PESO "
clSql		+=	"		,B1_PESBRU "
clSql		+=	"		,B1_VBUNDLE "
clSql		+=	"		,B1_SBCATEG "
clSql		+=	"		,B1_CATEG "
clSql		+=	"		,B1_COD "
clSql		+=	"		,B1_CODBAR "
clSql		+=	"		,B5_TITULO "
clSql		+=	"		,B1_OLD "
clSql		+=	"		,B1_ECIV "
clSql		+=	"		,B1_APLICAB "
clSql		+=	"		,B5_GENERO1 "
clSql		+=	"		,B5_GENERO2 "
clSql		+=	"		,B5_GENERO3 "
clSql		+=	"		,B5_NUMJOG "
clSql		+=	"		,B5_VREQSIS "
clSql		+=	"		,B5_SINOPS "
clSql		+=	"		,B5_SINOPSE "
clSql		+=	"		,B5_LINKA "
clSql		+=	"		,B5_TAG1 "
clSql		+=	"		,B5_TAG2 "
clSql		+=	"		,B5_TAG3 "
clSql		+=	"		,B5_TAG4 "
clSql		+=	"		,B5_TAG5 "
clSql		+=	"		,B5_TAG6 "
clSql		+=	"		,B5_TAG7 "
clSql		+=	"		,B5_TAG8 "
clSql		+=	"		,B5_TAG9 "
clSql		+=	"		,B5_TAG10 "
clSql		+=	"		,B5_GRPSITE "
clSql		+=	"		,B5_PUBLISH "
clSql		+=	"		,B5_INFCONS "
clSql		+=	"		,B5_FOCO "
clSql		+=	"		,B5_TARGET "
clSql		+=	"		,B5_VSINTIT "
clSql		+=	"		,B5_INFREV "
clSql		+=	"		,B5_NUMVID "
clSql		+=	"		,B1_FABRIC						"
clSql		+=	"		,B1_XPRV07						"
clSql		+=	"		,B1_XPRV12						"
clSql		+=	"		,B1_XPRV18						"
clSql		+=	"		,B1_XGENERO						"
clSql		+=	"		,SB1.R_E_C_N_O_ AS RECNOSB1		"
clSql		+=	"		,SB1.D_E_L_E_T_ AS DELETSB1		"
clSql		+=	"		,SB5.R_E_C_N_O_ AS RECNOSB5		"

clSql		+=	" FROM " +  RetSqlName("SB1") + " SB1 "

clSql		+=	" LEFT JOIN " +  RetSqlName("SB5") + " SB5 "
clSql		+=	" ON B5_FILIAL = B1_FILIAL "
clSql		+=	" AND B5_COD = B1_COD "
clSql		+=	" AND SB5.D_E_L_E_T_ = ' ' "

clSql		+=	"	WHERE B1_MSEXP	=  ' '	"
clSql		+=	"	AND B1_TIPO	=  'PA'	"

clSql		+=	"	ORDER BY 1			"
clSql		+=	"			,SB1.B1_COD "

//  B1_BLQVEND - BLOQUEADO

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Selecionando registros !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos		+=	",B1_BLQVEND "
clCampos		+=	",B1_DESCCAT "
clCampos		+=	",B1_DESC "
clCampos		+=	",B1_PUBLISH "
clCampos		+=	",B1_ORIGEM "
clCampos		+=	",B1_ALTCXM "
clCampos		+=	",B1_LAGCXM "
clCampos		+=	",B1_PROFCXM "
clCampos		+=	",B1_PEMASTE "
clCampos		+=	",B1_QUD "
clCampos		+=	",B1_MIDIA "
clCampos		+=	",B1_QTMIDIA "
clCampos		+=	",B1_DESC_GI "
clCampos		+=	",B1_POSIPI "
clCampos		+=	",B1_PICM "
clCampos		+=	",B1_TIPO "
clCampos		+=	",B1_XDESC "
clCampos		+=	",B1_CODGEN "
clCampos		+=	",B1_PAISPRO "
clCampos		+=	",B1_IPI "
clCampos		+=	",B1_TE "
clCampos		+=	",B1_IMPZFRC "
clCampos		+=	",B1_GRTRIB "
clCampos		+=	",B1_CC "
clCampos		+=	",B1_STACML "
clCampos		+=	",B1_TECNO "
clCampos		+=	",B1_TECNOC "
clCampos		+=	",B5_LANCSIM "
clCampos		+=	",B5_OUTVER "
clCampos		+=	",B1_PLATAF "
clCampos		+=	",B1_PRV1 "
clCampos		+=	",B1_CONSUMI "
clCampos		+=	",B5_PREVCHE "
clCampos		+=	",B1_CONINI "
clCampos		+=	",B1_DTLANC "
clCampos		+=	",B1_LANC "
clCampos		+=	",B1_XCURABC "
clCampos		+=	",B1_XSUBCLA "
clCampos		+=	",B1_XSELSIT "
clCampos		+=	",B1_XRELEVA "
clCampos		+=	",B1_MSBLQL "
clCampos		+=	",B5_DTBUSCA "
clCampos		+=	",B5_PROMCON "
clCampos		+=	",B5_PROMREV "
clCampos		+=	",B1_ALT "
clCampos		+=	",B1_LARGURA "
clCampos		+=	",B1_PROF "
clCampos		+=	",B1_DESCCLA "
clCampos		+=	",B1_LOCPAD "
clCampos		+=	",B1_ITEMCC "
clCampos		+=	",B1_IMPORT "
clCampos		+=	",B1_CONV "
clCampos		+=	",B1_UM "
clCampos		+=	",B1_CONTA "
clCampos		+=	",B1_DESC_I "
clCampos		+=	",B1_PLATEXT "
clCampos		+=	",B1_PESO "
clCampos		+=	",B1_PESBRU "
clCampos		+=	",B1_VBUNDLE "
clCampos		+=	",B1_SBCATEG "
clCampos		+=	",B1_CATEG "
clCampos		+=	",B1_COD "
clCampos		+=	",B1_CODBAR "
clCampos		+=	",B5_TITULO "
clCampos		+=	",B1_OLD "
clCampos		+=	",B1_ECIV "
clCampos		+=	",B1_APLICAB "
clCampos		+=	",B5_GENERO1 "
clCampos		+=	",B5_GENERO2 "
clCampos		+=	",B5_GENERO3 "
clCampos		+=	",B5_NUMJOG "
clCampos		+=	",B5_VREQSIS "
clCampos		+=	",B5_SINOPS "
clCampos		+=	",B5_SINOPSE "
clCampos		+=	",B5_LINKA "
clCampos		+=	",B5_TAG1 "
clCampos		+=	",B5_TAG2 "
clCampos		+=	",B5_TAG3 "
clCampos		+=	",B5_TAG4 "
clCampos		+=	",B5_TAG5 "
clCampos		+=	",B5_TAG6 "
clCampos		+=	",B5_TAG7 "
clCampos		+=	",B5_TAG8 "
clCampos		+=	",B5_TAG9 "
clCampos		+=	",B5_TAG10 "
clCampos		+=	",B5_GRPSITE "
clCampos		+=	",B5_PUBLISH "
clCampos		+=	",B5_INFCONS "
clCampos		+=	",B5_FOCO "
clCampos		+=	",B5_TARGET "
clCampos		+=	",B5_VSINTIT "
clCampos		+=	",B5_INFREV "
clCampos		+=	",B5_NUMVID "
clCampos		+=	",B1_FABRIC "
clCampos		+=	",B1_XPRV07 "
clCampos		+=	",B1_XPRV12 "
clCampos		+=	",B1_XPRV18 "
clCampos		+=	",B1_XGENERO "

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SB1", clAlias , clCampos)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		
		TcSetConn(nlConMain)
		
		SB1->(DbGoTo((clAlias)->RECNOSB1))
		
		SB5->(DbGoTo((clAlias)->RECNOSB5))
		
		If aScan(aRegs,(clAlias)->(EMPRESA + B1_FILIAL + B1_COD)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA + B1_FILIAL + B1_COD) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")
			
			If RecLock("SB1",.F.)
				
				SB1->B1_MSEXP := dTos(MsDate())
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Campo B1_MSEXP atualizado com sucesso ! ")
				
				SB1->(MsUnlock())
				
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA + B1_FILIAL + B1_COD))
			
		EndIf
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO ! Chave: EMPRESA + B1_FILIAL + B1_COD : "  + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) )
			
			If !E0001EXT("PRODUTO", {"EMPRESA","B1_FILIAL","B1_COD"}, {(clAlias)->EMPRESA,(clAlias)->B1_FILIAL,(clAlias)->B1_COD} )
				
				If !Empty((clAlias)->DELETSB1)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")
					
					If RecLock("SB1",.F.)
						
						SB1->B1_MSEXP := dTos(MsDate())
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Campo B1_MSEXP atualizado com sucesso ! ")
						
						SB1->(MsUnlock())
						
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"B1_FILIAL"	)
				aAdd(alCmpVals	,"B1_BLQVEND"	)
				aAdd(alCmpVals	,"B1_DESCCAT"	)
				aAdd(alCmpVals	,"B1_DESC"		)
				aAdd(alCmpVals	,"B1_PUBLISH"	)
				aAdd(alCmpVals	,"B1_ORIGEM"	)
				aAdd(alCmpVals	,"B1_ALTCXM"	)
				aAdd(alCmpVals	,"B1_LAGCXM"	)
				aAdd(alCmpVals	,"B1_PROFCXM"	)
				aAdd(alCmpVals	,"B1_PEMASTE"	)
				aAdd(alCmpVals	,"B1_QUD"		)
				aAdd(alCmpVals	,"B1_MIDIA"		)
				aAdd(alCmpVals	,"B1_QTMIDIA"	)
				aAdd(alCmpVals	,"B1_DESC_GI"	)
				aAdd(alCmpVals	,"B1_POSIPI"	)
				aAdd(alCmpVals	,"B1_PICM"		)
				aAdd(alCmpVals	,"B1_TIPO"		)
				aAdd(alCmpVals	,"B1_XDESC"		)
				aAdd(alCmpVals	,"B1_CODGEN"	)
				aAdd(alCmpVals	,"B1_PAISPRO"	)
				aAdd(alCmpVals	,"B1_IPI"		)
				aAdd(alCmpVals	,"B1_TE"		)
				aAdd(alCmpVals	,"B1_IMPZFRC"	)
				aAdd(alCmpVals	,"B1_GRTRIB"	)
				aAdd(alCmpVals	,"B1_CC"		)
				aAdd(alCmpVals	,"B1_STACML"	)
				aAdd(alCmpVals	,"B1_TECNO"		)
				aAdd(alCmpVals	,"B1_TECNOC"	)
				aAdd(alCmpVals	,"B5_LANCSIM"	)
				aAdd(alCmpVals	,"B5_OUTVER"	)
				aAdd(alCmpVals	,"B1_PLATAF"	)
				aAdd(alCmpVals	,"B1_PRV1"		)
				aAdd(alCmpVals	,"B1_CONSUMI"	)
				aAdd(alCmpVals	,"B5_PREVCHE"	)
				aAdd(alCmpVals	,"B1_CONINI"	)
				aAdd(alCmpVals	,"B1_DTLANC"	)
				aAdd(alCmpVals	,"B1_LANC"		)
				aAdd(alCmpVals	,"B1_XCURABC"	)
				aAdd(alCmpVals	,"B1_XSUBCLA"	)
				aAdd(alCmpVals	,"B1_XSELSIT"	)
				aAdd(alCmpVals	,"B1_XRELEVA"	)
				aAdd(alCmpVals	,"B1_MSBLQL"	)
				aAdd(alCmpVals	,"B5_DTBUSCA"	)
				aAdd(alCmpVals	,"B5_PROMCON"	)
				aAdd(alCmpVals	,"B5_PROMREV"	)
				aAdd(alCmpVals	,"B1_ALT"		)
				aAdd(alCmpVals	,"B1_LARGURA"	)
				aAdd(alCmpVals	,"B1_PROF"		)
				aAdd(alCmpVals	,"B1_DESCCLA"	)
				aAdd(alCmpVals	,"B1_LOCPAD"	)
				aAdd(alCmpVals	,"B1_ITEMCC"	)
				aAdd(alCmpVals	,"B1_IMPORT"	)
				aAdd(alCmpVals	,"B1_CONV"		)
				aAdd(alCmpVals	,"B1_UM"		)
				aAdd(alCmpVals	,"B1_CONTA"		)
				aAdd(alCmpVals	,"B1_DESC_I"	)
				aAdd(alCmpVals	,"B1_PLATEXT"	)
				aAdd(alCmpVals	,"B1_PESO"		)
				aAdd(alCmpVals	,"B1_PESBRU"	)
				aAdd(alCmpVals	,"B1_VBUNDLE"	)
				aAdd(alCmpVals	,"B5_VBUNDLE"	)
				aAdd(alCmpVals	,"B1_SBCATEG"	)
				aAdd(alCmpVals	,"B1_CATEG"		)
				aAdd(alCmpVals	,"B1_COD"		)
				aAdd(alCmpVals	,"B1_CODBAR"	)
				aAdd(alCmpVals	,"B5_TITULO"	)
				aAdd(alCmpVals	,"B1_OLD"		)
				aAdd(alCmpVals	,"B1_ECIV"		)
				aAdd(alCmpVals	,"B1_APLICAB"	)
				aAdd(alCmpVals	,"B5_GENERO1"	)
				aAdd(alCmpVals	,"B5_GENERO2"	)
				aAdd(alCmpVals	,"B5_GENERO3"	)
				aAdd(alCmpVals	,"B5_NUMJOG"	)
				aAdd(alCmpVals	,"B5_VREQSIS"	)
				aAdd(alCmpVals	,"B5_SINOPS"	)
				aAdd(alCmpVals	,"B5_SINOPSE"	)
				aAdd(alCmpVals	,"B5_LINKA"		)
				aAdd(alCmpVals	,"B5_TAG1"		)
				aAdd(alCmpVals	,"B5_TAG2"		)
				aAdd(alCmpVals	,"B5_TAG3"		)
				aAdd(alCmpVals	,"B5_TAG4"		)
				aAdd(alCmpVals	,"B5_TAG5"		)
				aAdd(alCmpVals	,"B5_TAG6"		)
				aAdd(alCmpVals	,"B5_TAG7"		)
				aAdd(alCmpVals	,"B5_TAG8"		)
				aAdd(alCmpVals	,"B5_TAG9"		)
				aAdd(alCmpVals	,"B5_TAG10"		)
				aAdd(alCmpVals	,"B5_GRPSITE"	)
				aAdd(alCmpVals	,"B5_PUBLISH"	)
				aAdd(alCmpVals	,"B5_INFCONS"	)
				aAdd(alCmpVals	,"B5_FOCO"		)
				aAdd(alCmpVals	,"B5_TARGET"	)
				aAdd(alCmpVals	,"B5_VSINTIT"	)
				aAdd(alCmpVals	,"B5_INFREV"	)
				aAdd(alCmpVals	,"B5_NUMVID"	)
				aAdd(alCmpVals	,"B1_FABRIC"	)
				aAdd(alCmpVals	,"B1_XPRV07"	)
				aAdd(alCmpVals	,"B1_XPRV12"	)
				aAdd(alCmpVals	,"B1_XPRV18"	)
				aAdd(alCmpVals	,"B1_XGENERO"	)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->B1_FILIAL	)
				aAdd(alVals	,(clAlias)->B1_BLQVEND	)
				aAdd(alVals	,(clAlias)->B1_DESCCAT	)
				aAdd(alVals	,(clAlias)->B1_DESC		)
				aAdd(alVals	,(clAlias)->B1_PUBLISH	)
				aAdd(alVals	,(clAlias)->B1_ORIGEM	)
				aAdd(alVals	,(clAlias)->B1_ALTCXM	)
				aAdd(alVals	,(clAlias)->B1_LAGCXM	)
				aAdd(alVals	,(clAlias)->B1_PROFCXM	)
				aAdd(alVals	,(clAlias)->B1_PEMASTE	)
				aAdd(alVals	,(clAlias)->B1_QUD		)
				aAdd(alVals	,(clAlias)->B1_MIDIA	)
				aAdd(alVals	,(clAlias)->B1_QTMIDIA	)
				aAdd(alVals	,(clAlias)->B1_DESC_GI	)
				aAdd(alVals	,(clAlias)->B1_POSIPI	)
				aAdd(alVals	,(clAlias)->B1_PICM		)
				aAdd(alVals	,(clAlias)->B1_TIPO		)
				aAdd(alVals	,(clAlias)->B1_XDESC	)
				aAdd(alVals	,(clAlias)->B1_CODGEN	)
				aAdd(alVals	,(clAlias)->B1_PAISPRO	)
				aAdd(alVals	,(clAlias)->B1_IPI		)
				aAdd(alVals	,(clAlias)->B1_TE		)
				aAdd(alVals	,(clAlias)->B1_IMPZFRC	)
				aAdd(alVals	,(clAlias)->B1_GRTRIB	)
				aAdd(alVals	,(clAlias)->B1_CC		)
				aAdd(alVals	,(clAlias)->B1_STACML	)
				aAdd(alVals	,(clAlias)->B1_TECNO	)
				aAdd(alVals	,(clAlias)->B1_TECNOC	)
				aAdd(alVals	,(clAlias)->B5_LANCSIM	)
				aAdd(alVals	,(clAlias)->B5_OUTVER	)
				aAdd(alVals	,(clAlias)->B1_PLATAF	)
				aAdd(alVals	,(clAlias)->B1_PRV1		)
				aAdd(alVals	,(clAlias)->B1_CONSUMI	)
				aAdd(alVals	,(clAlias)->B5_PREVCHE	)
				aAdd(alVals	,(clAlias)->B1_CONINI	)
				aAdd(alVals	,(clAlias)->B1_DTLANC	)
				aAdd(alVals	,(clAlias)->B1_LANC		)
				aAdd(alVals	,(clAlias)->B1_XCURABC	)
				aAdd(alVals	,(clAlias)->B1_XSUBCLA	)
				aAdd(alVals	,(clAlias)->B1_XSELSIT	)
				aAdd(alVals	,(clAlias)->B1_XRELEVA	)
				aAdd(alVals	,(clAlias)->B1_MSBLQL	)
				aAdd(alVals	,(clAlias)->B5_DTBUSCA	)
				aAdd(alVals	,(clAlias)->B5_PROMCON	)
				aAdd(alVals	,(clAlias)->B5_PROMREV	)
				aAdd(alVals	,(clAlias)->B1_ALT		)
				aAdd(alVals	,(clAlias)->B1_LARGURA	)
				aAdd(alVals	,(clAlias)->B1_PROF		)
				aAdd(alVals	,(clAlias)->B1_DESCCLA	)
				aAdd(alVals	,(clAlias)->B1_LOCPAD	)
				aAdd(alVals	,(clAlias)->B1_ITEMCC	)
				aAdd(alVals	,(clAlias)->B1_IMPORT	)
				aAdd(alVals	,(clAlias)->B1_CONV		)
				aAdd(alVals	,(clAlias)->B1_UM		)
				aAdd(alVals	,(clAlias)->B1_CONTA	)
				aAdd(alVals	,(clAlias)->B1_DESC_I	)
				aAdd(alVals	,(clAlias)->B1_PLATEXT	)
				aAdd(alVals	,(clAlias)->B1_PESO		)
				aAdd(alVals	,(clAlias)->B1_PESBRU	)
				aAdd(alVals	,SB1->B1_VBUNDLE		)
				aAdd(alVals	,SB5->B5_VBUNDLE		)
				aAdd(alVals	,(clAlias)->B1_SBCATEG	)
				aAdd(alVals	,(clAlias)->B1_CATEG	)
				aAdd(alVals	,(clAlias)->B1_COD		)
				aAdd(alVals	,(clAlias)->B1_CODBAR	)
				aAdd(alVals	,(clAlias)->B5_TITULO	)
				aAdd(alVals	,(clAlias)->B1_OLD		)
				aAdd(alVals	,(clAlias)->B1_ECIV		)
				aAdd(alVals	,(clAlias)->B1_APLICAB	)
				aAdd(alVals	,(clAlias)->B5_GENERO1	)
				aAdd(alVals	,(clAlias)->B5_GENERO2	)
				aAdd(alVals	,(clAlias)->B5_GENERO3	)
				aAdd(alVals	,(clAlias)->B5_NUMJOG	)
				aAdd(alVals	,SB5->B5_VREQSIS		)
				aAdd(alVals	,(clAlias)->B5_SINOPS	)
				aAdd(alVals	,SB5->B5_SINOPSE	)
				aAdd(alVals	,(clAlias)->B5_LINKA	)
				aAdd(alVals	,(clAlias)->B5_TAG1		)
				aAdd(alVals	,(clAlias)->B5_TAG2		)
				aAdd(alVals	,(clAlias)->B5_TAG3		)
				aAdd(alVals	,(clAlias)->B5_TAG4		)
				aAdd(alVals	,(clAlias)->B5_TAG5		)
				aAdd(alVals	,(clAlias)->B5_TAG6		)
				aAdd(alVals	,(clAlias)->B5_TAG7		)
				aAdd(alVals	,(clAlias)->B5_TAG8		)
				aAdd(alVals	,(clAlias)->B5_TAG9		)
				aAdd(alVals	,(clAlias)->B5_TAG10	)
				aAdd(alVals	,(clAlias)->B5_GRPSITE	)
				aAdd(alVals	,(clAlias)->B5_PUBLISH	)
				aAdd(alVals	,(clAlias)->B5_INFCONS	)
				aAdd(alVals	,(clAlias)->B5_FOCO		)
				aAdd(alVals	,(clAlias)->B5_TARGET	)
				aAdd(alVals	,SB5->B5_VSINTIT	)
				aAdd(alVals	,(clAlias)->B5_INFREV	)
				aAdd(alVals	,(clAlias)->B5_NUMVID	)
				aAdd(alVals	,(clAlias)->B1_FABRIC	)
				aAdd(alVals	,(clAlias)->B1_XPRV07	)
				aAdd(alVals	,(clAlias)->B1_XPRV12	)
				aAdd(alVals	,(clAlias)->B1_XPRV18	)
				aAdd(alVals	,(clAlias)->B1_XGENERO	)
				
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela PRODUTO - CATALOGO")
				
				clInsert	:=	 E0001SQL(1,"PRODUTO", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) ;
						+ " na tabela PRODUTO - CATALOGO. " + TcSqlError(), .T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) + " foi incluido com sucesso na tabela PRODUTO - CATALOGO")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Atualizando campo B1_MSEXP ! ")
						
						
						If RecLock("SB1",.F.)
							
							SB1->B1_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Campo B1_MSEXP atualizado com sucesso ! ")
							
							SB1->(MsUnlock())
							
						EndIf
						
					EndIf
				Else
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela PRODUTO - CATALOGO vazia !",.T.)
					
				EndIf
			Else
				
				If Empty((clAlias)->DELETSB1)
						
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
//					aAdd(alCmpVals	,"B1_BLQVEND"	)
					aAdd(alCmpVals	,"B1_DESCCAT"	)
					aAdd(alCmpVals	,"B1_DESC"		)
					aAdd(alCmpVals	,"B1_PUBLISH"	)
					aAdd(alCmpVals	,"B1_ORIGEM"	)
					aAdd(alCmpVals	,"B1_ALTCXM"	)
					aAdd(alCmpVals	,"B1_LAGCXM"	)
					aAdd(alCmpVals	,"B1_PROFCXM"	)
					aAdd(alCmpVals	,"B1_PEMASTE"	)
					aAdd(alCmpVals	,"B1_QUD"		)
					aAdd(alCmpVals	,"B1_MIDIA"		)
					aAdd(alCmpVals	,"B1_QTMIDIA"	)
					aAdd(alCmpVals	,"B1_DESC_GI"	)
					aAdd(alCmpVals	,"B1_POSIPI"	)
					aAdd(alCmpVals	,"B1_PICM"		)
					aAdd(alCmpVals	,"B1_TIPO"		)
					aAdd(alCmpVals	,"B1_XDESC"		)
					aAdd(alCmpVals	,"B1_CODGEN"	)
					aAdd(alCmpVals	,"B1_PAISPRO"	)
					aAdd(alCmpVals	,"B1_IPI"		)
					aAdd(alCmpVals	,"B1_TE"		)
					aAdd(alCmpVals	,"B1_IMPZFRC"	)
					aAdd(alCmpVals	,"B1_GRTRIB"	)
					aAdd(alCmpVals	,"B1_CC"		)
					aAdd(alCmpVals	,"B1_STACML"	)
					aAdd(alCmpVals	,"B1_TECNO"		)
					aAdd(alCmpVals	,"B1_TECNOC"	)
					aAdd(alCmpVals	,"B5_LANCSIM"	)
					aAdd(alCmpVals	,"B5_OUTVER"	)
					aAdd(alCmpVals	,"B1_PLATAF"	)
					aAdd(alCmpVals	,"B1_PRV1"		)
					aAdd(alCmpVals	,"B1_CONSUMI"	)
					aAdd(alCmpVals	,"B5_PREVCHE"	)
					aAdd(alCmpVals	,"B1_CONINI"	)
					aAdd(alCmpVals	,"B1_DTLANC"	)
					aAdd(alCmpVals	,"B1_LANC"		)
					aAdd(alCmpVals	,"B1_XCURABC"	)
					aAdd(alCmpVals	,"B1_XSUBCLA"	)
					aAdd(alCmpVals	,"B1_XSELSIT"	)
					aAdd(alCmpVals	,"B1_XRELEVA"	)
					aAdd(alCmpVals	,"B1_MSBLQL"	)
					aAdd(alCmpVals	,"B5_DTBUSCA"	)
					aAdd(alCmpVals	,"B5_PROMCON"	)
					aAdd(alCmpVals	,"B5_PROMREV"	)
					aAdd(alCmpVals	,"B1_ALT"		)
					aAdd(alCmpVals	,"B1_LARGURA"	)
					aAdd(alCmpVals	,"B1_PROF"		)
					aAdd(alCmpVals	,"B1_DESCCLA"	)
					aAdd(alCmpVals	,"B1_LOCPAD"	)
					aAdd(alCmpVals	,"B1_ITEMCC"	)
					aAdd(alCmpVals	,"B1_IMPORT"	)
					aAdd(alCmpVals	,"B1_CONV"		)
					aAdd(alCmpVals	,"B1_UM"		)
					aAdd(alCmpVals	,"B1_CONTA"		)
					aAdd(alCmpVals	,"B1_DESC_I"	)
					aAdd(alCmpVals	,"B1_PLATEXT"	)
					aAdd(alCmpVals	,"B1_PESO"		)
					aAdd(alCmpVals	,"B1_PESBRU"	)
					aAdd(alCmpVals	,"B1_VBUNDLE"	)
					aAdd(alCmpVals	,"B5_VBUNDLE"	)
					aAdd(alCmpVals	,"B1_SBCATEG"	)
					aAdd(alCmpVals	,"B1_CATEG"		)
					aAdd(alCmpVals	,"B1_CODBAR"	)
					aAdd(alCmpVals	,"B5_TITULO"	)
					aAdd(alCmpVals	,"B1_OLD"		)
					aAdd(alCmpVals	,"B1_ECIV"		)
					aAdd(alCmpVals	,"B1_APLICAB"	)
					aAdd(alCmpVals	,"B5_GENERO1"	)
					aAdd(alCmpVals	,"B5_GENERO2"	)
					aAdd(alCmpVals	,"B5_GENERO3"	)
					aAdd(alCmpVals	,"B5_NUMJOG"	)
					aAdd(alCmpVals	,"B5_VREQSIS"	)
					aAdd(alCmpVals	,"B5_SINOPS"	)
					aAdd(alCmpVals	,"B5_SINOPSE"	)
					aAdd(alCmpVals	,"B5_LINKA"		)
					aAdd(alCmpVals	,"B5_TAG1"		)
					aAdd(alCmpVals	,"B5_TAG2"		)
					aAdd(alCmpVals	,"B5_TAG3"		)
					aAdd(alCmpVals	,"B5_TAG4"		)
					aAdd(alCmpVals	,"B5_TAG5"		)
					aAdd(alCmpVals	,"B5_TAG6"		)
					aAdd(alCmpVals	,"B5_TAG7"		)
					aAdd(alCmpVals	,"B5_TAG8"		)
					aAdd(alCmpVals	,"B5_TAG9"		)
					aAdd(alCmpVals	,"B5_TAG10"		)
					aAdd(alCmpVals	,"B5_GRPSITE"	)
					aAdd(alCmpVals	,"B5_PUBLISH"	)
					aAdd(alCmpVals	,"B5_INFCONS"	)
					aAdd(alCmpVals	,"B5_FOCO"		)
					aAdd(alCmpVals	,"B5_TARGET"	)
					aAdd(alCmpVals	,"B5_VSINTIT"	)
					aAdd(alCmpVals	,"B5_INFREV"	)
					aAdd(alCmpVals	,"B5_NUMVID"	)
					aAdd(alCmpVals	,"B1_FABRIC"	)
					aAdd(alCmpVals	,"B1_XPRV07"	)
					aAdd(alCmpVals	,"B1_XPRV12"	)
					aAdd(alCmpVals	,"B1_XPRV18"	)
					aAdd(alCmpVals	,"B1_XGENERO"	)
					
//					aAdd(alVals	,(clAlias)->B1_BLQVEND	)
					aAdd(alVals	,(clAlias)->B1_DESCCAT	)
					aAdd(alVals	,(clAlias)->B1_DESC		)
					aAdd(alVals	,(clAlias)->B1_PUBLISH	)
					aAdd(alVals	,(clAlias)->B1_ORIGEM	)
					aAdd(alVals	,(clAlias)->B1_ALTCXM	)
					aAdd(alVals	,(clAlias)->B1_LAGCXM	)
					aAdd(alVals	,(clAlias)->B1_PROFCXM	)
					aAdd(alVals	,(clAlias)->B1_PEMASTE	)
					aAdd(alVals	,(clAlias)->B1_QUD		)
					aAdd(alVals	,(clAlias)->B1_MIDIA	)
					aAdd(alVals	,(clAlias)->B1_QTMIDIA	)
					aAdd(alVals	,(clAlias)->B1_DESC_GI	)
					aAdd(alVals	,(clAlias)->B1_POSIPI	)
					aAdd(alVals	,(clAlias)->B1_PICM		)
					aAdd(alVals	,(clAlias)->B1_TIPO		)
					aAdd(alVals	,(clAlias)->B1_XDESC	)
					aAdd(alVals	,(clAlias)->B1_CODGEN	)
					aAdd(alVals	,(clAlias)->B1_PAISPRO	)
					aAdd(alVals	,(clAlias)->B1_IPI		)
					aAdd(alVals	,(clAlias)->B1_TE		)
					aAdd(alVals	,(clAlias)->B1_IMPZFRC	)
					aAdd(alVals	,(clAlias)->B1_GRTRIB	)
					aAdd(alVals	,(clAlias)->B1_CC		)
					aAdd(alVals	,(clAlias)->B1_STACML	)
					aAdd(alVals	,(clAlias)->B1_TECNO	)
					aAdd(alVals	,(clAlias)->B1_TECNOC	)
					aAdd(alVals	,(clAlias)->B5_LANCSIM	)
					aAdd(alVals	,(clAlias)->B5_OUTVER	)
					aAdd(alVals	,(clAlias)->B1_PLATAF	)
					aAdd(alVals	,(clAlias)->B1_PRV1		)
					aAdd(alVals	,(clAlias)->B1_CONSUMI	)
					aAdd(alVals	,(clAlias)->B5_PREVCHE	)
					aAdd(alVals	,(clAlias)->B1_CONINI	)
					aAdd(alVals	,(clAlias)->B1_DTLANC	)
					aAdd(alVals	,(clAlias)->B1_LANC		)
					aAdd(alVals	,(clAlias)->B1_XCURABC	)
					aAdd(alVals	,(clAlias)->B1_XSUBCLA	)
					aAdd(alVals	,(clAlias)->B1_XSELSIT	)
					aAdd(alVals	,(clAlias)->B1_XRELEVA	)
					aAdd(alVals	,(clAlias)->B1_MSBLQL	)
					aAdd(alVals	,(clAlias)->B5_DTBUSCA	)
					aAdd(alVals	,(clAlias)->B5_PROMCON	)
					aAdd(alVals	,(clAlias)->B5_PROMREV	)
					aAdd(alVals	,(clAlias)->B1_ALT		)
					aAdd(alVals	,(clAlias)->B1_LARGURA	)
					aAdd(alVals	,(clAlias)->B1_PROF		)
					aAdd(alVals	,(clAlias)->B1_DESCCLA	)
					aAdd(alVals	,(clAlias)->B1_LOCPAD	)
					aAdd(alVals	,(clAlias)->B1_ITEMCC	)
					aAdd(alVals	,(clAlias)->B1_IMPORT	)
					aAdd(alVals	,(clAlias)->B1_CONV		)
					aAdd(alVals	,(clAlias)->B1_UM		)
					aAdd(alVals	,(clAlias)->B1_CONTA	)
					aAdd(alVals	,(clAlias)->B1_DESC_I	)
					aAdd(alVals	,(clAlias)->B1_PLATEXT	)
					aAdd(alVals	,(clAlias)->B1_PESO		)
					aAdd(alVals	,(clAlias)->B1_PESBRU	)
					aAdd(alVals	,SB1->B1_VBUNDLE		)
					aAdd(alVals	,SB5->B5_VBUNDLE		)
					aAdd(alVals	,(clAlias)->B1_SBCATEG	)
					aAdd(alVals	,(clAlias)->B1_CATEG	)
					aAdd(alVals	,(clAlias)->B1_CODBAR	)
					aAdd(alVals	,(clAlias)->B5_TITULO	)
					aAdd(alVals	,(clAlias)->B1_OLD		)
					aAdd(alVals	,(clAlias)->B1_ECIV		)
					aAdd(alVals	,(clAlias)->B1_APLICAB	)
					aAdd(alVals	,(clAlias)->B5_GENERO1	)
					aAdd(alVals	,(clAlias)->B5_GENERO2	)
					aAdd(alVals	,(clAlias)->B5_GENERO3	)
					aAdd(alVals	,(clAlias)->B5_NUMJOG	)
					aAdd(alVals	,SB5->B5_VREQSIS		)
					aAdd(alVals	,(clAlias)->B5_SINOPS	)
					aAdd(alVals	,SB5->B5_SINOPSE	)
					aAdd(alVals	,(clAlias)->B5_LINKA	)
					aAdd(alVals	,(clAlias)->B5_TAG1		)
					aAdd(alVals	,(clAlias)->B5_TAG2		)
					aAdd(alVals	,(clAlias)->B5_TAG3		)
					aAdd(alVals	,(clAlias)->B5_TAG4		)
					aAdd(alVals	,(clAlias)->B5_TAG5		)
					aAdd(alVals	,(clAlias)->B5_TAG6		)
					aAdd(alVals	,(clAlias)->B5_TAG7		)
					aAdd(alVals	,(clAlias)->B5_TAG8		)
					aAdd(alVals	,(clAlias)->B5_TAG9		)
					aAdd(alVals	,(clAlias)->B5_TAG10	)
					aAdd(alVals	,(clAlias)->B5_GRPSITE	)
					aAdd(alVals	,(clAlias)->B5_PUBLISH	)
					aAdd(alVals	,(clAlias)->B5_INFCONS	)
					aAdd(alVals	,(clAlias)->B5_FOCO		)
					aAdd(alVals	,(clAlias)->B5_TARGET	)
					aAdd(alVals	,SB5->B5_VSINTIT	)
					aAdd(alVals	,(clAlias)->B5_INFREV	)
					aAdd(alVals	,(clAlias)->B5_NUMVID	)
					aAdd(alVals	,(clAlias)->B1_FABRIC	)
					aAdd(alVals	,(clAlias)->B1_XPRV07	)
					aAdd(alVals	,(clAlias)->B1_XPRV12	)
					aAdd(alVals	,(clAlias)->B1_XPRV18	)
					aAdd(alVals	,(clAlias)->B1_XGENERO	)					
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"B1_FILIAL"		)
					aAdd(alCmpCons	,"B1_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->B1_FILIAL	)
					aAdd(alConds	,(clAlias)->B1_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela PRODUTO - CATALOGO")
					
					clUpdate	:=	 E0001SQL(2,"PRODUTO", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar o registro " + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) ;
							+ " na tabela PRODUTO - CATALOGO. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) + " foi alterado com sucesso na tabela PRODUTO - CATALOGO")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Atualizando campo B1_MSEXP ! ")
							
							
							If RecLock("SB1",.F.)
								
								SB1->B1_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Campo B1_MSEXP atualizado com sucesso ! ")
								
								SB1->(MsUnlock())
								
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela PRODUTO - CATALOGO vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"B1_FILIAL"		)
					aAdd(alCmpCons	,"B1_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->B1_FILIAL	)
					aAdd(alConds	,(clAlias)->B1_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela PRODUTO - CATALOGO")
					
					clDelete	:=	 E0001SQL(3,"PRODUTO", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o produto " + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) ;
							+ " na tabela PRODUTO - CATALOGO. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA + " - " + B1_FILIAL + " - " + B1_COD) + " foi excluido com sucesso na tabela PRODUTO - CATALOGO")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Atualizando campo B1_MSEXP ! ")
							
							
							If RecLock("SB1",.F.)
								
								SB1->B1_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Campo B1_MSEXP atualizado com sucesso ! ")
								
								SB1->(MsUnlock())
								
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela PRODUTO - CATALOGO vazia !", .T.)
						
					EndIf
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Nao ha nenhum registro ser exportado !")
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SB1 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela PRODUTO - CATALOGO ! ")

If llLog
	FClose(nlHandle)
EndIf

End Sequence

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SX5  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE TABELAS GENษRICAS PARA O SISTEMA   บฑฑ
ฑฑบ          ณ CATALOGO                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SX5(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "GENERICA_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob		:= .F.
Default clEmp		:= ""
Default clFil    := ""
Default llLog		:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Iniciando rotina de manutencaos de dados da tabela GENERICA - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SX5.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,X5_FILIAL						"	+	QUEBRA
clSql		+=	"		,X5_TABELA						"	+	QUEBRA
clSql		+=	"		,X5_CHAVE						"	+	QUEBRA
clSql		+=	"		,X5_DESCRI						"	+	QUEBRA
clSql		+=	"		,P0F_SITE						"	+	QUEBRA
clSql		+=	"		,P0F_CATEG						"	+	QUEBRA
clSql		+=	"		,P0F_SCATEG						"	+	QUEBRA
clSql		+=	"		,P0F_GENERO						"	+	QUEBRA
clSql		+=	"		,P0F_SELECA						"	+	QUEBRA
clSql		+=	"		,P0F_FAIXAE						"	+	QUEBRA
clSql		+=	"		,SX5.R_E_C_N_O_ AS RECNOSX5		"	+	QUEBRA
clSql		+=	"		,SX5.D_E_L_E_T_ AS DELETSX5		"	+	QUEBRA
clSql		+=	"		,P0F.R_E_C_N_O_ AS RECNOP0F 	"	+	QUEBRA
clSql		+=	"		,P0F.D_E_L_E_T_ AS DELETP0F		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SX5")	+	"	SX5	"	+	QUEBRA

clSql		+=	"	LEFT JOIN " + RetSqlName("P0F") + " P0F "	+	QUEBRA
clSql		+=	"	ON P0F_FILIAL = '" + xFilial("P0F")+ "' "	+	QUEBRA
clSql		+=	"	AND P0F_X5TAB = X5_TABELA "	+	QUEBRA
clSql		+=	"	AND P0F_X5CHV = X5_CHAVE "	+	QUEBRA

clSql		+=	"	WHERE ( X5_MSEXP	=	' '	OR P0F_MSEXP = ' ' )"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,SX5.X5_CHAVE	"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Selecionando tabelas gen้ricas !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

TcSetField(clAlias,"RECNOSX5","N",0018,0000)
TcSetField(clAlias,"RECNOP0F","N",0018,0000)

clCampos	:=	"X5_CHAVE"
clCampos	+=	"/X5_DESCRI"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SX5", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA + X5_FILIAL + X5_TABELA)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")
			
			If (clAlias)->RECNOSX5 > 0 

				TcSetConn(nlConMain)
			
				SX5->(DbGoTo((clAlias)->RECNOSX5))
				
				If SX5->( !Eof() ) .And. SX5->( !Bof() )
					If RecLock("SX5",.F.)
						
						SX5->X5_MSEXP := dTos(MsDate())
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo X5_MSEXP atualizado com sucesso ! ")
						
						SX5->(MsUnlock())
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
				EndIf
			
			EndIf
			
			If (clAlias)->RECNOP0F > 0

				TcSetConn(nlConMain)
						          
				P0F->(DbGoTo((clAlias)->RECNOP0F))
				
				If P0F->( !Eof() ) .And. P0F->( !Bof() )
					If RecLock("P0F",.F.)
						
						P0F->P0F_MSEXP := dTos(MsDate())
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo P0F_MSEXP atualizado com sucesso ! ")
						
						P0F->(MsUnlock())
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
				EndIf			
			
			EndIf
						
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + FILIAL + CHAVE : : " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) )
			
			If !E0001EXT("GENERICA", {"EMPRESA","X5_FILIAL","X5_TABELA","X5_CHAVE"}, {(clAlias)->EMPRESA,(clAlias)->X5_FILIAL, (clAlias)->X5_TABELA, (clAlias)->X5_CHAVE } )
				
				If !Empty((clAlias)->DELETSX5) .Or. !Empty((clAlias)->DELETP0F)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")
					
					If (clAlias)->RECNOSX5 > 0 

						TcSetConn(nlConMain)
					
						SX5->(DbGoTo((clAlias)->RECNOSX5))
						
						If SX5->( !Eof() ) .And. SX5->( !Bof() )
							If RecLock("SX5",.F.)
								
								SX5->X5_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo X5_MSEXP atualizado com sucesso ! ")
								
								SX5->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
						EndIf					
    				
    				EndIf
    				
    				If (clAlias)->RECNOP0F > 0

						TcSetConn(nlConMain)	
    				
						P0F->(DbGoTo((clAlias)->RECNOP0F))
						
						If P0F->( !Eof() ) .And. P0F->( !Bof() )
							If RecLock("P0F",.F.)
								
								P0F->P0F_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo P0F_MSEXP atualizado com sucesso ! ")
								
								P0F->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
						EndIf
					
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"X5_FILIAL"	)
				aAdd(alCmpVals	,"X5_TABELA"	)
				aAdd(alCmpVals	,"X5_CHAVE"		)
				aAdd(alCmpVals	,"X5_DESCRI"	)
				aAdd(alCmpVals	,"CATALOGO"		)
				aAdd(alCmpVals	,"CATEGORIA"	)
				aAdd(alCmpVals	,"SUBCATEGORIA"	)
				aAdd(alCmpVals	,"GENERO"		)
				aAdd(alCmpVals	,"SELECAO"		)
				aAdd(alCmpVals	,"FAIXAETARIA"	)
				
				aAdd(alVals		,(clAlias)->EMPRESA											)
				aAdd(alVals		,(clAlias)->X5_FILIAL										)
				aAdd(alVals		,(clAlias)->X5_TABELA										)
				aAdd(alVals		,(clAlias)->X5_CHAVE										)
				aAdd(alVals		,(clAlias)->X5_DESCRI										)
				aAdd(alVals		,Iif(Empty((clAlias)->P0F_SITE),"2",(clAlias)->P0F_SITE) 	)
				aAdd(alVals		,(clAlias)->P0F_CATEG										)
				aAdd(alVals		,(clAlias)->P0F_SCATEG										)
				aAdd(alVals		,(clAlias)->P0F_GENERO										)
				aAdd(alVals		,(clAlias)->P0F_SELECA										)
				aAdd(alVals		,(clAlias)->P0F_FAIXAE										)
								
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela GENERICA - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"GENERICA", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) ;
						+ " na tabela GENERICA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) + " foi incluido com sucesso na tabela GENERICA - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Atualizando campo X5_MSEXP ! ")
						
						If (clAlias)->RECNOSX5 > 0
						
							TcSetConn(nlConMain)
							
							SX5->(DbGoTo((clAlias)->RECNOSX5))
							
							If SX5->( !Eof() ) .And. SX5->( !Bof() )
							
								If RecLock("SX5",.F.)
									
									SX5->X5_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo X5_MSEXP atualizado com sucesso ! ")
									
									SX5->(MsUnlock())
								EndIf
								
							Else
							
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
							
							EndIf
						
						EndIf 
						
	    				If (clAlias)->RECNOP0F > 0

							TcSetConn(nlConMain)
	    				
							P0F->(DbGoTo((clAlias)->RECNOP0F))
							
							If P0F->( !Eof() ) .And. P0F->( !Bof() )
							
								If RecLock("P0F",.F.)
									
									P0F->P0F_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo P0F_MSEXP atualizado com sucesso ! ")
									
									P0F->(MsUnlock())
							
								EndIf
								
							Else
							
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)

							EndIf						    
						
						EndIf						
						
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela GENERICA - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSX5) .And. Empty((clAlias)->DELETP0F)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
										
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"X5_FILIAL"	)
					aAdd(alCmpVals	,"X5_TABELA"	)
					aAdd(alCmpVals	,"X5_CHAVE"		)
					aAdd(alCmpVals	,"X5_DESCRI"	)
					aAdd(alCmpVals	,"CATALOGO"		)
					aAdd(alCmpVals	,"CATEGORIA"	)
					aAdd(alCmpVals	,"SUBCATEGORIA"	)
					aAdd(alCmpVals	,"GENERO"		)
					aAdd(alCmpVals	,"SELECAO"		)
					aAdd(alCmpVals	,"FAIXAETARIA"	)
					
					aAdd(alVals		,(clAlias)->EMPRESA											)
					aAdd(alVals		,(clAlias)->X5_FILIAL										)
					aAdd(alVals		,(clAlias)->X5_TABELA	 									)
					aAdd(alVals		,(clAlias)->X5_CHAVE										)
					aAdd(alVals		,(clAlias)->X5_DESCRI										)
					aAdd(alVals		,Iif(Empty((clAlias)->P0F_SITE),"2",(clAlias)->P0F_SITE) 	)
					aAdd(alVals		,(clAlias)->P0F_CATEG										)
					aAdd(alVals		,(clAlias)->P0F_SCATEG										)
					aAdd(alVals		,(clAlias)->P0F_GENERO										)
					aAdd(alVals		,(clAlias)->P0F_SELECA										)
					aAdd(alVals		,(clAlias)->P0F_FAIXAE										)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"X5_FILIAL"		)
					aAdd(alCmpCons	,"X5_TABELA"		)
					aAdd(alCmpCons	,"X5_CHAVE"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->X5_FILIAL	)
					aAdd(alConds	,(clAlias)->X5_TABELA	)
					aAdd(alConds	,(clAlias)->X5_CHAVE	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela GENERICA - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"GENERICA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar o registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) ;
							+ " na tabela GENERICA - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) + " foi alterado com sucesso na tabela GENERICA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Atualizando campo X5_MSEXP ! ")

							If (clAlias)->RECNOSX5 > 0

								TcSetConn(nlConMain)
							
								SX5->(DbGoTo((clAlias)->RECNOSX5))
								
								If SX5->( !Eof() ) .And. SX5->( !Bof() )
									If RecLock("SX5",.F.)
										
										SX5->X5_MSEXP := dTos(MsDate())
										
										E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo X5_MSEXP atualizado com sucesso ! ")
										
										SX5->(MsUnlock())
									EndIf
								Else
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
								EndIf							

							EndIf
							
							If (clAlias)->RECNOP0F > 0

								TcSetConn(nlConMain)
							
								P0F->(DbGoTo((clAlias)->RECNOP0F))
								
								If P0F->( !Eof() ) .And. P0F->( !Bof() )
									If RecLock("P0F",.F.)
										
										P0F->P0F_MSEXP := dTos(MsDate())
										
										E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo P0F_MSEXP atualizado com sucesso ! ")
										
										P0F->(MsUnlock())
									EndIf
									
								Else
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
								EndIf
							
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela GENERICA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"X5_FILIAL"		)
					aAdd(alCmpCons	,"X5_TABELA"		)
					aAdd(alCmpCons	,"X5_CHAVE"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->X5_FILIAL	)
					aAdd(alConds	,(clAlias)->X5_TABELA	)
					aAdd(alConds	,(clAlias)->X5_CHAVE	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela GENERICA - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"GENERICA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) ;
							+ " da tabela GENERICA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + X5_FILIAL + " - " + X5_TABELA) + " foi excluido com sucesso na tabela GENERICA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Atualizando campo X5_MSEXP ! ")

							If (clAlias)->RECNOSX5 > 0

								TcSetConn(nlConMain)
							
								SX5->(DbGoTo((clAlias)->RECNOSX5))
								
								If SX5->( !Eof() ) .And. SX5->( !Bof() )
									If RecLock("SX5",.F.)
										
										SX5->X5_MSEXP := dTos(MsDate())
										
										E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo X5_MSEXP atualizado com sucesso ! ")
										
										SX5->(MsUnlock())
									EndIf
								Else
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
								EndIf
														
							EndIf
							  
							If (clAlias)->RECNOP0F > 0

								TcSetConn(nlConMain)
							
								P0F->(DbGoTo((clAlias)->RECNOP0F))
								
								If P0F->( !Eof() ) .And. P0F->( !Bof() )
									If RecLock("P0F",.F.)
										
										P0F->P0F_MSEXP := dTos(MsDate())
										
										E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Campo P0F_MSEXP atualizado com sucesso ! ")
										
										P0F->(MsUnlock())
									EndIf
									
								Else
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - O registro da tabela SX5, RECNO " + AllTrim(Str((clAlias)->RECNOSX5)) + ", nao foi encontrado ! ", .T.)
								EndIf
							
							EndIf									
																
							If Alltrim((clAlias)->X5_TABELA) == "ZU"
								MyUpdPref((clAlias)->X5_CHAVE)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas gen้ricas - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Nao ha nenhum registro para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX5 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela GENERICA - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

Static Function MyUpdPref(cValor)
Local cDML			:= ""
Local alCmpVals		:= {}
Local alVals		:= {}
Local alCmpCons		:= {}
Local alConds		:= {}

If !Empty(cValor)
	
	aAdd(alCmpVals	,"PFC_SELECAO"	)
	aAdd(alVals		,Space(20)		)
	
	aAdd(alCmpCons	,"PFC_SELECAO"	)
	aAdd(alConds	,cValor			)
	
	cUpdate	:= E0001SQL(2,"PREFERENCIA", alCmpVals, alVals, alCmpCons, alConds)
	
	If TcSqlExec(cUpdate) >= 0
		TcSqlExec("COMMIT")
	EndIf

EndIf

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SYD  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE CำDIGOS DE NCM PARA O SISTEMA CATA-บฑฑ
ฑฑบ          ณ LOGO                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SYD(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "IPINCM_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob		:= .F.
Default clEmp		:= ""
Default clFil    := ""
Default llLog		:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Iniciando rotina de manutencao de dados de IPINCM - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SYD.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,YD_FILIAL						"	+	QUEBRA
clSql		+=	"		,YD_TEC							"	+	QUEBRA
clSql		+=	"		,YD_DESC_P						"	+	QUEBRA
clSql		+=	"		,SYD.R_E_C_N_O_ AS RECNOSYD		"	+	QUEBRA
clSql		+=	"		,SYD.D_E_L_E_T_ AS DELETSYD		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SYD")	+	"	SYD	"	+	QUEBRA

clSql		+=	"	WHERE YD_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,YD_FILIAL		"	+	QUEBRA
clSql		+=	"			,YD_TEC			"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Selecionando registros !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"YD_FILIAL"
clCampos	+=	"/YD_TEC"
clCampos	+=	"/YD_DESC_P"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SYD", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SYD->(DbGoTo((clAlias)->RECNOSYD))
			
			If SYD->( !Eof() ) .And. SYD->( !Bof() )
				If RecLock("SYD",.F.)
					
					SYD->YD_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Campo YD_MSEXP atualizado com sucesso ! ")
					
					SYD->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - O registro da tabela SYD, RECNO " + AllTrim(Str((clAlias)->RECNOSYD)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + YD_FILIAL + YD_TEC : : " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) )
			
			If !E0001EXT("IPINCM", {"EMPRESA","YD_FILIAL","YD_TEC"}, {(clAlias)->EMPRESA,(clAlias)->YD_FILIAL, (clAlias)->YD_TEC } )
				
				If !Empty((clAlias)->DELETSYD)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SYD->(DbGoTo((clAlias)->RECNOSYD))
					
					If SYD->( !Eof() ) .And. SYD->( !Bof() )
						If RecLock("SYD",.F.)
							
							SYD->YD_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Campo YD_MSEXP atualizado com sucesso ! ")
							
							SYD->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - O registro da tabela SYD, RECNO " + AllTrim(Str((clAlias)->RECNOSYD)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"YD_FILIAL"	)
				aAdd(alCmpVals	,"YD_TEC"		)
				aAdd(alCmpVals	,"YD_DESC_P"	)
				
				aAdd(alVals		,(clAlias)->EMPRESA		)
				aAdd(alVals		,(clAlias)->YD_FILIAL	)
				aAdd(alVals		,(clAlias)->YD_TEC		)
				aAdd(alVals		,(clAlias)->YD_DESC_P	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela tabelas gen้ricas - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"IPINCM", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) ;
						+ " na tabela IPINCM - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) + " foi incluido com sucesso na tabela IPINCM - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Atualizando campo YD_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SYD->(DbGoTo((clAlias)->RECNOSYD))
						
						If SYD->( !Eof() ) .And. SYD->( !Bof() )
							If RecLock("SYD",.F.)
								
								SYD->YD_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Campo YD_MSEXP atualizado com sucesso ! ")
								
								SYD->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - O registro da tabela SYD, RECNO " + AllTrim(Str((clAlias)->RECNOSYD)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela IPINCM - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSYD)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"YD_FILIAL"	)
					aAdd(alCmpVals	,"YD_TEC"		)
					aAdd(alCmpVals	,"YD_DESC_P"	)
					
					aAdd(alVals		,(clAlias)->EMPRESA		)
					aAdd(alVals		,(clAlias)->YD_FILIAL	)
					aAdd(alVals		,(clAlias)->YD_TEC		)
					aAdd(alVals		,(clAlias)->YD_DESC_P	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"YD_FILIAL"		)
					aAdd(alCmpCons	,"YD_TEC"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->YD_FILIAL	)
					aAdd(alConds	,(clAlias)->YD_TEC		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela IPINCM - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"IPINCM", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar o registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) ;
							+ " na tabela IPINCM - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) + " foi alterado com sucesso na tabela IPINCM - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Atualizando campo YD_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SYD->(DbGoTo((clAlias)->RECNOSYD))
							
							If SYD->( !Eof() ) .And. SYD->( !Bof() )
								If RecLock("SYD",.F.)
									
									SYD->YD_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Campo YD_MSEXP atualizado com sucesso ! ")
									
									SYD->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - O registro da tabela SYD, RECNO " + AllTrim(Str((clAlias)->RECNOSYD)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela IPINCM - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"YD_FILIAL"		)
					aAdd(alCmpCons	,"YD_TEC"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->YD_FILIAL	)
					aAdd(alConds	,(clAlias)->YD_TEC		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela GENERICA - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"IPINCM", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) ;
							+ " na tabela IPINCM - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YD_FILIAL + " - " + YD_TEC) + " foi excluido com sucesso na tabela IPINCM - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Atualizando campo YD_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SYD->(DbGoTo((clAlias)->RECNOSYD))
							
							If SYD->( !Eof() ) .And. SYD->( !Bof() )
								If RecLock("SYD",.F.)
									
									SYD->YD_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Campo YD_MSEXP atualizado com sucesso ! ")
									
									SYD->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - O registro da tabela SYD, RECNO " + AllTrim(Str((clAlias)->RECNOSYD)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas IPINCM - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Nao ha nenhum registro para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYD ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela IPINCM - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001CTT  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE CENTROS DE CUSTO PARA SISTEMA CATA-บฑฑ
ฑฑบ          ณ LOGO                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001CTT(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "CENTROCUSTO_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob		:= .F.
Default clEmp		:= ""
Default clFil    := ""
Default llLog		:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Iniciando rotina manutencao de dados da tabela CENTROCUSTO - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN CTT.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,CTT_FILIAL						"	+	QUEBRA
clSql		+=	"		,CTT_CUSTO							"	+	QUEBRA
clSql		+=	"		,CTT_DESC01							"	+	QUEBRA
clSql		+=	"		,CTT.R_E_C_N_O_ AS RECNOCTT		"	+	QUEBRA
clSql		+=	"		,CTT.D_E_L_E_T_ AS DELETCTT		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("CTT")	+	"	CTT	"	+	QUEBRA

clSql		+=	"	WHERE CTT_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,CTT_FILIAL		"	+	QUEBRA
clSql		+=	"			,CTT_CUSTO			"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Selecionando centros de custo para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"CTT_FILIAL"
clCampos	+=	"/CTT_CUSTO"
clCampos	+=	"/CTT_DESC01"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "CTT", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			CTT->(DbGoTo((clAlias)->RECNOCTT))
			
			If CTT->( !Eof() ) .And. CTT->( !Bof() )
				If RecLock("CTT",.F.)
					
					CTT->CTT_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Campo CTT_MSEXP atualizado com sucesso ! ")
					
					CTT->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - O registro da tabela CTT, RECNO " + AllTrim(Str((clAlias)->RECNOCTT)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + CTT_FILIAL + CTT_CUSTO: : " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) )
			
			If !E0001EXT("CENTROCUSTO", {"EMPRESA","CTT_FILIAL","CTT_CUSTO"}, {(clAlias)->EMPRESA,(clAlias)->CTT_FILIAL, (clAlias)->CTT_CUSTO } )
				
				If !Empty((clAlias)->DELETCTT)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					CTT->(DbGoTo((clAlias)->RECNOCTT))
					
					If CTT->( !Eof() ) .And. CTT->( !Bof() )
						If RecLock("CTT",.F.)
							
							CTT->CTT_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Campo CTT_MSEXP atualizado com sucesso ! ")
							
							CTT->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - O registro da tabela CTT, RECNO " + AllTrim(Str((clAlias)->RECNOCTT)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"CTT_FILIAL"	)
				aAdd(alCmpVals	,"CTT_CUSTO"	)
				aAdd(alCmpVals	,"CTT_DESC01"	)
				
				aAdd(alVals		,(clAlias)->EMPRESA		)
				aAdd(alVals		,(clAlias)->CTT_FILIAL	)
				aAdd(alVals		,(clAlias)->CTT_CUSTO	)
				aAdd(alVals		,(clAlias)->CTT_DESC01	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela CENTROCUSTO - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"CENTROCUSTO", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o centro de custo " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) ;
						+ " na tabela CENTROCUSTO - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) + " foi incluido com sucesso na tabela CENTROCUSTO - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Atualizando campo CTT_MSEXP ! ")

						TcSetConn(nlConMain)
						
						CTT->(DbGoTo((clAlias)->RECNOCTT))
						
						If CTT->( !Eof() ) .And. CTT->( !Bof() )
							If RecLock("CTT",.F.)
								
								CTT->CTT_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Campo CTT_MSEXP atualizado com sucesso ! ")
								
								CTT->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - O registro da tabela CTT, RECNO " + AllTrim(Str((clAlias)->RECNOCTT)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela CENTROCUSTO - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETCTT)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"CTT_FILIAL"	)
					aAdd(alCmpVals	,"CTT_CUSTO"	)
					aAdd(alCmpVals	,"CTT_DESC01"	)
					
					aAdd(alVals		,(clAlias)->EMPRESA		)
					aAdd(alVals		,(clAlias)->CTT_FILIAL	)
					aAdd(alVals		,(clAlias)->CTT_CUSTO	)
					aAdd(alVals		,(clAlias)->CTT_DESC01	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"CTT_FILIAL"		)
					aAdd(alCmpCons	,"CTT_CUSTO"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->CTT_FILIAL	)
					aAdd(alConds	,(clAlias)->CTT_CUSTO	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela CENTROCUSTO - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"CENTROCUSTO", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela CENTROCUSTO " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) ;
							+ " na tabela CENTROCUSTO - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) + " foi alterado com sucesso na tabela CENTROCUSTO - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Atualizando campo CTT_MSEXP ! ")

							TcSetConn(nlConMain)
							
							CTT->(DbGoTo((clAlias)->RECNOCTT))
							
							If CTT->( !Eof() ) .And. CTT->( !Bof() )
								If RecLock("CTT",.F.)
									
									CTT->CTT_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Campo CTT_MSEXP atualizado com sucesso ! ")
									
									CTT->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - O registro da tabela CTT, RECNO " + AllTrim(Str((clAlias)->RECNOCTT)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela CENTROCUSTO - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"CTT_FILIAL"		)
					aAdd(alCmpCons	,"CTT_CUSTO"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->CTT_FILIAL	)
					aAdd(alConds	,(clAlias)->CTT_CUSTO	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela CENTROCUSTO - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"CENTROCUSTO", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) ;
							+ " na tabela CENTROCUSTO - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTT_FILIAL + " - " + CTT_CUSTO) + " foi excluido com sucesso na tabela CENTROCUSTO - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Atualizando campo CTT_MSEXP ! ")

							TcSetConn(nlConMain)
							
							CTT->(DbGoTo((clAlias)->RECNOCTT))
							
							If CTT->( !Eof() ) .And. CTT->( !Bof() )
								If RecLock("CTT",.F.)
									
									CTT->CTT_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Campo CTT_MSEXP atualizado com sucesso ! ")
									
									CTT->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - O registro da tabela CTT, RECNO " + AllTrim(Str((clAlias)->RECNOCTT)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas CENTROCUSTO - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTT ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela CENTROCUSTO - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SZ5  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE PLATAFORMAS PARA O SISTEMA CATALOGOบฑฑ
ฑฑบ          ณ DE PRODUTOS                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SZ5(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "PLATAFORMA_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob		:= .F.
Default clEmp		:= ""
Default clFil    := ""
Default llLog		:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Iniciando rotina manutencao de dados da tabela PLATAFORMA - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SZ5.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,Z5_FILIAL						"	+	QUEBRA
clSql		+=	"		,Z5_COD							"	+	QUEBRA
clSql		+=	"		,Z5_PLATRED							"	+	QUEBRA
clSql		+=	"		,Z5_PLATEXT							"	+	QUEBRA
clSql		+=	"		,Z5_SITE							"	+	QUEBRA
clSql		+=	"		,SZ5.R_E_C_N_O_ AS RECNOSZ5		"	+	QUEBRA
clSql		+=	"		,SZ5.D_E_L_E_T_ AS DELETSZ5		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SZ5")	+	"	SZ5	"	+	QUEBRA

clSql		+=	"	WHERE Z5_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,Z5_FILIAL		"	+	QUEBRA
clSql		+=	"			,Z5_COD			"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Selecionando centros de custo para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"Z5_FILIAL"
clCampos	+=	"/Z5_COD"
clCampos	+=	"/Z5_PLATRED"
clCampos	+=	"/Z5_PLATEXT"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SZ5", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SZ5->(DbGoTo((clAlias)->RECNOSZ5))
			
			If SZ5->( !Eof() ) .And. SZ5->( !Bof() )
				If RecLock("SZ5",.F.)
					
					SZ5->Z5_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Campo Z5_MSEXP atualizado com sucesso ! ")
					
					SZ5->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ5, RECNO " + AllTrim(Str((clAlias)->RECNOSZ5)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + Z5_FILIAL + Z5_COD: : " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) )
			
			If !E0001EXT("PLATAFORMA", {"EMPRESA","Z5_FILIAL","Z5_COD"}, {(clAlias)->EMPRESA,(clAlias)->Z5_FILIAL, (clAlias)->Z5_COD } )
				
				If !Empty((clAlias)->DELETSZ5)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SZ5->(DbGoTo((clAlias)->RECNOSZ5))
					
					If SZ5->( !Eof() ) .And. SZ5->( !Bof() )
						If RecLock("SZ5",.F.)
							
							SZ5->Z5_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Campo Z5_MSEXP atualizado com sucesso ! ")
							
							SZ5->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ5, RECNO " + AllTrim(Str((clAlias)->RECNOSZ5)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"Z5_FILIAL"	)
				aAdd(alCmpVals	,"Z5_COD"		)
				aAdd(alCmpVals	,"Z5_PLATRED"	)
				aAdd(alCmpVals	,"Z5_PLATEXT"	)
				aAdd(alCmpVals	,"CATALOGO"		)
				
				aAdd(alVals		,(clAlias)->EMPRESA		)
				aAdd(alVals		,(clAlias)->Z5_FILIAL	)
				aAdd(alVals		,(clAlias)->Z5_COD		)
				aAdd(alVals		,(clAlias)->Z5_PLATRED	)
				aAdd(alVals		,(clAlias)->Z5_PLATEXT	)
				aAdd(alVals		,(clAlias)->Z5_SITE		)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela PLATAFORMA - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"PLATAFORMA", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o centro de custo " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) ;
						+ " na tabela PLATAFORMA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) + " foi incluido com sucesso na tabela PLATAFORMA - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SZ5->(DbGoTo((clAlias)->RECNOSZ5))
						
						If SZ5->( !Eof() ) .And. SZ5->( !Bof() )
							If RecLock("SZ5",.F.)
								
								SZ5->Z5_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Campo Z5_MSEXP atualizado com sucesso ! ")
								
								SZ5->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ5, RECNO " + AllTrim(Str((clAlias)->RECNOSZ5)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela PLATAFORMA - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSZ5)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"Z5_FILIAL"	)
					aAdd(alCmpVals	,"Z5_COD"		)
					aAdd(alCmpVals	,"Z5_PLATRED"	)
					aAdd(alCmpVals	,"Z5_PLATEXT"	)
					aAdd(alCmpVals	,"CATALOGO"		)
					
					
					aAdd(alVals		,(clAlias)->EMPRESA		)
					aAdd(alVals		,(clAlias)->Z5_FILIAL	)
					aAdd(alVals		,(clAlias)->Z5_COD		)
					aAdd(alVals		,(clAlias)->Z5_PLATRED	)
					aAdd(alVals		,(clAlias)->Z5_PLATEXT	)
					aAdd(alVals		,(clAlias)->Z5_SITE	)
					
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"Z5_FILIAL"		)
					aAdd(alCmpCons	,"Z5_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->Z5_FILIAL	)
					aAdd(alConds	,(clAlias)->Z5_COD	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela PLATAFORMA - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"PLATAFORMA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela PLATAFORMA " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) ;
							+ " na tabela PLATAFORMA - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) + " foi alterado com sucesso na tabela PLATAFORMA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SZ5->(DbGoTo((clAlias)->RECNOSZ5))
							
							If SZ5->( !Eof() ) .And. SZ5->( !Bof() )
								If RecLock("SZ5",.F.)
									
									SZ5->Z5_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Campo Z5_MSEXP atualizado com sucesso ! ")
									
									SZ5->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ5, RECNO " + AllTrim(Str((clAlias)->RECNOSZ5)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela PLATAFORMA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"Z5_FILIAL"		)
					aAdd(alCmpCons	,"Z5_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->Z5_FILIAL	)
					aAdd(alConds	,(clAlias)->Z5_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela PLATAFORMA - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"PLATAFORMA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) ;
							+ " na tabela PLATAFORMA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z5_FILIAL + " - " + Z5_COD) + " foi excluido com sucesso na tabela PLATAFORMA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SZ5->(DbGoTo((clAlias)->RECNOSZ5))
							
							If SZ5->( !Eof() ) .And. SZ5->( !Bof() )
								If RecLock("SZ5",.F.)
									
									SZ5->Z5_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Campo Z5_MSEXP atualizado com sucesso ! ")
									
									SZ5->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ5, RECNO " + AllTrim(Str((clAlias)->RECNOSZ5)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas PLATAFORMA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ5 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela PLATAFORMA - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SF4  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE TIPOS DE ENTRADA E SAIDA PARA O SISบฑฑ
ฑฑบ          ณ TEMA CATALOGO DE PRODUTOS                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SF4(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "TIPOES_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Iniciando rotina manutencao de dados da tabela TIPOES - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SF4.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,F4_FILIAL						"	+	QUEBRA
clSql		+=	"		,F4_CODIGO						"	+	QUEBRA
clSql		+=	"		,F4_TIPO						"	+	QUEBRA
clSql		+=	"		,F4_DUPLIC						"	+	QUEBRA
clSql		+=	"		,F4_ESTOQUE						"	+	QUEBRA
clSql		+=	"		,F4_CF							"	+	QUEBRA
clSql		+=	"		,F4_ICM							"	+	QUEBRA
clSql		+=	"		,F4_IPI							"	+	QUEBRA
clSql		+=	"		,F4_TEXTO						"	+	QUEBRA
clSql		+=	"		,SF4.R_E_C_N_O_ AS RECNOSF4		"	+	QUEBRA
clSql		+=	"		,SF4.D_E_L_E_T_ AS DELETSF4		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SF4")	+	"	SF4	"	+	QUEBRA

clSql		+=	"	WHERE F4_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,F4_FILIAL		"	+	QUEBRA
clSql		+=	"			,F4_CODIGO		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Selecionando tipos de entrada e saida para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"F4_FILIAL"
clCampos	+=	"/F4_CODIGO"
clCampos	+=	"/F4_TIPO"
clCampos	+=	"/F4_DUPLIC"
clCampos	+=	"/F4_ESTOQUE"
clCampos	+=	"/F4_CF"
clCampos	+=	"/F4_ICM"
clCampos	+=	"/F4_IPI"
clCampos	+=	"/F4_TEXTO"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SF4", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SF4->(DbGoTo((clAlias)->RECNOSF4))
			
			If SF4->( !Eof() ) .And. SF4->( !Bof() )
				If RecLock("SF4",.F.)
					
					SF4->F4_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Campo F4_MSEXP atualizado com sucesso ! ")
					
					SF4->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - O registro da tabela SF4, RECNO " + AllTrim(Str((clAlias)->RECNOSF4)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + F4_FILIAL + F4_CODIGO: : " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) )
			
			If !E0001EXT("TIPOES", {"EMPRESA","F4_FILIAL","F4_CODIGO"}, {(clAlias)->EMPRESA,(clAlias)->F4_FILIAL, (clAlias)->F4_CODIGO } )
				
				If !Empty((clAlias)->DELETSF4)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)			
					
					SF4->(DbGoTo((clAlias)->RECNOSF4))
					
					If SF4->( !Eof() ) .And. SF4->( !Bof() )
						If RecLock("SF4",.F.)
							
							SF4->F4_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Campo F4_MSEXP atualizado com sucesso ! ")
							
							SF4->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - O registro da tabela SF4, RECNO " + AllTrim(Str((clAlias)->RECNOSF4)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"F4_FILIAL"	)
				aAdd(alCmpVals	,"F4_CODIGO"	)
				aAdd(alCmpVals	,"F4_TIPO"		)
				aAdd(alCmpVals	,"F4_DUPLIC"	)
				aAdd(alCmpVals	,"F4_ESTOQUE"	)
				aAdd(alCmpVals	,"F4_CF"		)
				aAdd(alCmpVals	,"F4_ICM"		)
				aAdd(alCmpVals	,"F4_IPI"		)
				aAdd(alCmpVals	,"F4_TEXTO"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->F4_FILIAL	)
				aAdd(alVals	,(clAlias)->F4_CODIGO	)
				aAdd(alVals	,(clAlias)->F4_TIPO		)
				aAdd(alVals	,(clAlias)->F4_DUPLIC	)
				aAdd(alVals	,(clAlias)->F4_ESTOQUE	)
				aAdd(alVals	,(clAlias)->F4_CF		)
				aAdd(alVals	,(clAlias)->F4_ICM		)
				aAdd(alVals	,(clAlias)->F4_IPI		)
				aAdd(alVals	,(clAlias)->F4_TEXTO	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela TIPOES - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"TIPOES", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) ;
						+ " na tabela TIPOES - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) + " foi incluido com sucesso na tabela TIPOES - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Atualizando campo F4_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SF4->(DbGoTo((clAlias)->RECNOSF4))
						
						If SF4->( !Eof() ) .And. SF4->( !Bof() )
							If RecLock("SF4",.F.)
								
								SF4->F4_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Campo F4_MSEXP atualizado com sucesso ! ")
								
								SF4->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - O registro da tabela SF4, RECNO " + AllTrim(Str((clAlias)->RECNOSF4)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela TIPOES - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSF4)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"F4_FILIAL"	)
					aAdd(alCmpVals	,"F4_CODIGO"	)
					aAdd(alCmpVals	,"F4_TIPO"		)
					aAdd(alCmpVals	,"F4_DUPLIC"	)
					aAdd(alCmpVals	,"F4_ESTOQUE"	)
					aAdd(alCmpVals	,"F4_CF"		)
					aAdd(alCmpVals	,"F4_ICM"		)
					aAdd(alCmpVals	,"F4_IPI"		)
					aAdd(alCmpVals	,"F4_TEXTO"		)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->F4_FILIAL	)
					aAdd(alVals	,(clAlias)->F4_CODIGO	)
					aAdd(alVals	,(clAlias)->F4_TIPO		)
					aAdd(alVals	,(clAlias)->F4_DUPLIC	)
					aAdd(alVals	,(clAlias)->F4_ESTOQUE	)
					aAdd(alVals	,(clAlias)->F4_CF		)
					aAdd(alVals	,(clAlias)->F4_ICM		)
					aAdd(alVals	,(clAlias)->F4_IPI		)
					aAdd(alVals	,(clAlias)->F4_TEXTO	)
					
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"F4_FILIAL"		)
					aAdd(alCmpCons	,"F4_CODIGO"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->F4_FILIAL	)
					aAdd(alConds	,(clAlias)->F4_CODIGO	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela TIPOES - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"TIPOES", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela TIPOES " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) ;
							+ " na tabela TIPOES - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) + " foi alterado com sucesso na tabela TIPOES - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Atualizando campo F4_MSEXP ! ")

							TcSetConn(nlConMain)	
							
							SF4->(DbGoTo((clAlias)->RECNOSF4))
							
							If SF4->( !Eof() ) .And. SF4->( !Bof() )
								If RecLock("SF4",.F.)
									
									SF4->F4_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Campo F4_MSEXP atualizado com sucesso ! ")
									
									SF4->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - O registro da tabela SF4, RECNO " + AllTrim(Str((clAlias)->RECNOSF4)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela TIPOES - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"F4_FILIAL"		)
					aAdd(alCmpCons	,"F4_CODIGO"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->F4_FILIAL	)
					aAdd(alConds	,(clAlias)->F4_CODIGO	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela TIPOES - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"TIPOES", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) ;
							+ " na tabela TIPOES - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + F4_FILIAL + " - " + F4_CODIGO) + " foi excluido com sucesso na tabela TIPOES - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)							
							
							SF4->(DbGoTo((clAlias)->RECNOSF4))
							
							If SF4->( !Eof() ) .And. SF4->( !Bof() )
								If RecLock("SF4",.F.)
									
									SF4->F4_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Campo F4_MSEXP atualizado com sucesso ! ")
									
									SF4->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - O registro da tabela SF4, RECNO " + AllTrim(Str((clAlias)->RECNOSF4)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas TIPOES - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SF4 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela TIPOES - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SZ9  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE TECNOLOGIAS PARA O SISTEMA DE CATA-บฑฑ
ฑฑบ          ณ LOGO DE PRODUTOS.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SZ9(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "TECNOLOGIA_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Iniciando rotina manutencao de dados da tabela TECNOLOGIA - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SZ9.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,Z9_FILIAL						"	+	QUEBRA
clSql		+=	"		,Z9_COD							"	+	QUEBRA
clSql		+=	"		,Z9_DESCRI						"	+	QUEBRA
clSql		+=	"		,Z9_SITE						"	+	QUEBRA
clSql		+=	"		,SZ9.R_E_C_N_O_ AS RECNOSZ9		"	+	QUEBRA
clSql		+=	"		,SZ9.D_E_L_E_T_ AS DELETSZ9		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SZ9")	+	"	SZ9	"	+	QUEBRA

clSql		+=	"	WHERE Z9_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,Z9_FILIAL		"	+	QUEBRA
clSql		+=	"			,Z9_COD		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Selecionando tecnologias para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"Z9_FILIAL"
clCampos	+=	"/Z9_COD"
clCampos	+=	"/Z9_DESCRI"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SZ9", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SZ9->(DbGoTo((clAlias)->RECNOSZ9))
			
			If SZ9->( !Eof() ) .And. SZ9->( !Bof() )
				If RecLock("SZ9",.F.)
					
					SZ9->Z9_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Campo Z9_MSEXP atualizado com sucesso ! ")
					
					SZ9->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ9, RECNO " + AllTrim(Str((clAlias)->RECNOSZ9)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + Z9_FILIAL + Z9_COD: : " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) )
			
			If !E0001EXT("TECNOLOGIA", {"EMPRESA","Z9_FILIAL","Z9_COD"}, {(clAlias)->EMPRESA,(clAlias)->Z9_FILIAL, (clAlias)->Z9_COD } )
				
				If !Empty((clAlias)->DELETSZ9)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SZ9->(DbGoTo((clAlias)->RECNOSZ9))
					
					If SZ9->( !Eof() ) .And. SZ9->( !Bof() )
						If RecLock("SZ9",.F.)
							
							SZ9->Z9_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Campo Z9_MSEXP atualizado com sucesso ! ")
							
							SZ9->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ9, RECNO " + AllTrim(Str((clAlias)->RECNOSZ9)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"Z9_FILIAL"	)
				aAdd(alCmpVals	,"Z9_COD"		)
				aAdd(alCmpVals	,"Z9_DESCRI"	)
				aAdd(alCmpVals	,"CATALOGO"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->Z9_FILIAL	)
				aAdd(alVals	,(clAlias)->Z9_COD		)
				aAdd(alVals	,(clAlias)->Z9_DESCRI	)
				aAdd(alVals	,(clAlias)->Z9_SITE		)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela TECNOLOGIA - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"TECNOLOGIA", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) ;
						+ " na tabela TECNOLOGIA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) + " foi incluido com sucesso na tabela TECNOLOGIA - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Atualizando campo Z9_MSEXP ! ")

						TcSetConn(nlConMain)			
						
						SZ9->(DbGoTo((clAlias)->RECNOSZ9))
						
						If SZ9->( !Eof() ) .And. SZ9->( !Bof() )
							If RecLock("SZ9",.F.)
								
								SZ9->Z9_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Campo Z9_MSEXP atualizado com sucesso ! ")
								
								SZ9->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ9, RECNO " + AllTrim(Str((clAlias)->RECNOSZ9)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela TECNOLOGIA - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSZ9)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"Z9_FILIAL"	)
					aAdd(alCmpVals	,"Z9_COD"		)
					aAdd(alCmpVals	,"Z9_DESCRI"	)
					aAdd(alCmpVals	,"CATALOGO"		)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->Z9_FILIAL	)
					aAdd(alVals	,(clAlias)->Z9_COD		)
					aAdd(alVals	,(clAlias)->Z9_DESCRI	)
					aAdd(alVals	,(clAlias)->Z9_SITE	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"Z9_FILIAL"		)
					aAdd(alCmpCons	,"Z9_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->Z9_FILIAL	)
					aAdd(alConds	,(clAlias)->Z9_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela TECNOLOGIA - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"TECNOLOGIA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela TECNOLOGIA " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) ;
							+ " na tabela TECNOLOGIA - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) + " foi alterado com sucesso na tabela TECNOLOGIA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Atualizando campo Z9_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SZ9->(DbGoTo((clAlias)->RECNOSZ9))
							
							If SZ9->( !Eof() ) .And. SZ9->( !Bof() )
								If RecLock("SZ9",.F.)
									
									SZ9->Z9_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Campo Z9_MSEXP atualizado com sucesso ! ")
									
									SZ9->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ9, RECNO " + AllTrim(Str((clAlias)->RECNOSZ9)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela TECNOLOGIA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"Z9_FILIAL"		)
					aAdd(alCmpCons	,"Z9_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->Z9_FILIAL	)
					aAdd(alConds	,(clAlias)->Z9_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela TECNOLOGIA - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"TECNOLOGIA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) ;
							+ " na tabela TECNOLOGIA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + Z9_FILIAL + " - " + Z9_COD) + " foi excluido com sucesso na tabela TECNOLOGIA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SZ9->(DbGoTo((clAlias)->RECNOSZ9))
							
							If SZ9->( !Eof() ) .And. SZ9->( !Bof() )
								If RecLock("SZ9",.F.)
									
									SZ9->Z9_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Campo Z9_MSEXP atualizado com sucesso ! ")
									
									SZ9->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - O registro da tabela SZ9, RECNO " + AllTrim(Str((clAlias)->RECNOSZ9)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas TECNOLOGIA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SZ9 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela TECNOLOGIA - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SYA  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE PAISES PARA O SISTEMA DE CATALOGO -บฑฑ
ฑฑบ          ณ DE PRODUTOS.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SYA(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "PAIS_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Iniciando rotina manutencao de dados da tabela PAIS - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SYA.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,YA_FILIAL						"	+	QUEBRA
clSql		+=	"		,YA_CODGI						"	+	QUEBRA
clSql		+=	"		,YA_DESCR						"	+	QUEBRA
clSql		+=	"		,SYA.R_E_C_N_O_ AS RECNOSYA		"	+	QUEBRA
clSql		+=	"		,SYA.D_E_L_E_T_ AS DELETSYA		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SYA")	+	"	SYA	"	+	QUEBRA

clSql		+=	"	WHERE YA_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,YA_FILIAL		"	+	QUEBRA
clSql		+=	"			,YA_CODGI		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Selecionando PAISs para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"YA_FILIAL"
clCampos	+=	"/YA_CODGI"
clCampos	+=	"/YA_DESCR"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SYA", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SYA->(DbGoTo((clAlias)->RECNOSYA))
			
			If SYA->( !Eof() ) .And. SYA->( !Bof() )
				If RecLock("SYA",.F.)
					
					SYA->YA_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Campo YA_MSEXP atualizado com sucesso ! ")
					
					SYA->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - O registro da tabela SYA, RECNO " + AllTrim(Str((clAlias)->RECNOSYA)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + YA_FILIAL + YA_CODGI: : " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) )
			
			If !E0001EXT("PAIS", {"EMPRESA","YA_FILIAL","YA_CODGI"}, {(clAlias)->EMPRESA,(clAlias)->YA_FILIAL, (clAlias)->YA_CODGI } )
				
				If !Empty((clAlias)->DELETSYA)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SYA->(DbGoTo((clAlias)->RECNOSYA))
					
					If SYA->( !Eof() ) .And. SYA->( !Bof() )
						If RecLock("SYA",.F.)
							
							SYA->YA_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Campo YA_MSEXP atualizado com sucesso ! ")
							
							SYA->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - O registro da tabela SYA, RECNO " + AllTrim(Str((clAlias)->RECNOSYA)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"YA_FILIAL"	)
				aAdd(alCmpVals	,"YA_CODGI"		)
				aAdd(alCmpVals	,"YA_DESCR"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->YA_FILIAL	)
				aAdd(alVals	,(clAlias)->YA_CODGI	)
				aAdd(alVals	,(clAlias)->YA_DESCR	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela PAIS - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"PAIS", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) ;
						+ " na tabela PAIS - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) + " foi incluido com sucesso na tabela PAIS - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Atualizando campo YA_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SYA->(DbGoTo((clAlias)->RECNOSYA))
						
						If SYA->( !Eof() ) .And. SYA->( !Bof() )
							If RecLock("SYA",.F.)
								
								SYA->YA_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Campo YA_MSEXP atualizado com sucesso ! ")
								
								SYA->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - O registro da tabela SYA, RECNO " + AllTrim(Str((clAlias)->RECNOSYA)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela PAIS - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSYA)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"YA_FILIAL"	)
					aAdd(alCmpVals	,"YA_CODGI"		)
					aAdd(alCmpVals	,"YA_DESCR"	)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->YA_FILIAL	)
					aAdd(alVals	,(clAlias)->YA_CODGI	)
					aAdd(alVals	,(clAlias)->YA_DESCR	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"YA_FILIAL"		)
					aAdd(alCmpCons	,"YA_CODGI"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->YA_FILIAL	)
					aAdd(alConds	,(clAlias)->YA_CODGI	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela PAIS - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"PAIS", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela PAIS " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) ;
							+ " na tabela PAIS - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) + " foi alterado com sucesso na tabela PAIS - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Atualizando campo YA_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SYA->(DbGoTo((clAlias)->RECNOSYA))
							
							If SYA->( !Eof() ) .And. SYA->( !Bof() )
								If RecLock("SYA",.F.)
									
									SYA->YA_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Campo YA_MSEXP atualizado com sucesso ! ")
									
									SYA->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - O registro da tabela SYA, RECNO " + AllTrim(Str((clAlias)->RECNOSYA)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela PAIS - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"YA_FILIAL"		)
					aAdd(alCmpCons	,"YA_CODGI"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->YA_FILIAL	)
					aAdd(alConds	,(clAlias)->YA_CODGI	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela PAIS - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"PAIS", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) ;
							+ " na tabela PAIS - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + YA_FILIAL + " - " + YA_CODGI) + " foi excluido com sucesso na tabela PAIS - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SYA->(DbGoTo((clAlias)->RECNOSYA))
							
							If SYA->( !Eof() ) .And. SYA->( !Bof() )
								If RecLock("SYA",.F.)
									
									SYA->YA_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Campo YA_MSEXP atualizado com sucesso ! ")
									
									SYA->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - O registro da tabela SYA, RECNO " + AllTrim(Str((clAlias)->RECNOSYA)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas PAIS - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SYA ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela PAIS - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SBM  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE CATEGORIAS PARA O SISTEMA DE CA-บฑฑ
ฑฑบ          ณ TALOGO DE PRODUTOS.                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SBM(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "CATEGORIA_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Iniciando rotina manutencao de dados da tabela CATEGORIA - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SBM.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,BM_FILIAL						"	+	QUEBRA
clSql		+=	"		,BM_GRUPO						"	+	QUEBRA
clSql		+=	"		,BM_DESC						"	+	QUEBRA
clSql		+=	"		,BM_SITE						"	+	QUEBRA
clSql		+=	"		,SBM.R_E_C_N_O_ AS RECNOSBM		"	+	QUEBRA
clSql		+=	"		,SBM.D_E_L_E_T_ AS DELETSBM		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SBM")	+	"	SBM	"	+	QUEBRA

clSql		+=	"	WHERE BM_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,BM_FILIAL		"	+	QUEBRA
clSql		+=	"			,BM_GRUPO		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Selecionando CATEGORIA para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"BM_FILIAL"
clCampos	+=	"/BM_GRUPO"
clCampos	+=	"/BM_DESC"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SBM", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SBM->(DbGoTo((clAlias)->RECNOSBM))
			
			If SBM->( !Eof() ) .And. SBM->( !Bof() )
				If RecLock("SBM",.F.)
					
					SBM->BM_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Campo BM_MSEXP atualizado com sucesso ! ")
					
					SBM->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - O registro da tabela SBM, RECNO " + AllTrim(Str((clAlias)->RECNOSBM)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		//Abre o TOP do servidor
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			// Verifica se o registro jแ existe para inclusใo ou altera็ใo
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + BM_FILIAL + BM_GRUPO: : " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) )
			
			If !E0001EXT("CATEGORIA", {"EMPRESA","BM_FILIAL","BM_GRUPO"}, {(clAlias)->EMPRESA,(clAlias)->BM_FILIAL, (clAlias)->BM_GRUPO } )
				
				If !Empty((clAlias)->DELETSBM)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SBM->(DbGoTo((clAlias)->RECNOSBM))
					
					If SBM->( !Eof() ) .And. SBM->( !Bof() )
						If RecLock("SBM",.F.)
							
							SBM->BM_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Campo BM_MSEXP atualizado com sucesso ! ")
							
							SBM->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - O registro da tabela SBM, RECNO " + AllTrim(Str((clAlias)->RECNOSBM)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"		)
				aAdd(alCmpVals	,"BM_FILIAL"	)
				aAdd(alCmpVals	,"BM_GRUPO"		)
				aAdd(alCmpVals	,"BM_DESC"		)
				aAdd(alCmpVals	,"CATALOGO"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->BM_FILIAL	)
				aAdd(alVals	,(clAlias)->BM_GRUPO	)
				aAdd(alVals	,(clAlias)->BM_DESC		)
				aAdd(alVals	,(clAlias)->BM_SITE		)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela CATEGORIA - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"CATEGORIA", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) ;
						+ " na tabela CATEGORIA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) + " foi incluido com sucesso na tabela CATEGORIA - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Atualizando campo BM_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SBM->(DbGoTo((clAlias)->RECNOSBM))
						
						If SBM->( !Eof() ) .And. SBM->( !Bof() )
							If RecLock("SBM",.F.)
								
								SBM->BM_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Campo BM_MSEXP atualizado com sucesso ! ")
								
								SBM->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - O registro da tabela SBM, RECNO " + AllTrim(Str((clAlias)->RECNOSBM)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela CATEGORIA - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSBM)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"		)
					aAdd(alCmpVals	,"BM_FILIAL"	)
					aAdd(alCmpVals	,"BM_GRUPO"		)
					aAdd(alCmpVals	,"BM_DESC"		)
					aAdd(alCmpVals	,"CATALOGO"		)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->BM_FILIAL	)
					aAdd(alVals	,(clAlias)->BM_GRUPO	)
					aAdd(alVals	,(clAlias)->BM_DESC		)
					aAdd(alVals	,(clAlias)->BM_SITE		)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"BM_FILIAL"		)
					aAdd(alCmpCons	,"BM_GRUPO"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->BM_FILIAL	)
					aAdd(alConds	,(clAlias)->BM_GRUPO	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela CATEGORIA - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"CATEGORIA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela CATEGORIA " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) ;
							+ " na tabela CATEGORIA - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) + " foi alterado com sucesso na tabela CATEGORIA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Atualizando campo BM_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SBM->(DbGoTo((clAlias)->RECNOSBM))
							
							If SBM->( !Eof() ) .And. SBM->( !Bof() )
								If RecLock("SBM",.F.)
									
									SBM->BM_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Campo BM_MSEXP atualizado com sucesso ! ")
									
									SBM->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - O registro da tabela SBM, RECNO " + AllTrim(Str((clAlias)->RECNOSBM)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela CATEGORIA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"BM_FILIAL"		)
					aAdd(alCmpCons	,"BM_GRUPO"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->BM_FILIAL	)
					aAdd(alConds	,(clAlias)->BM_GRUPO	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela CATEGORIA - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"CATEGORIA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) ;
							+ " na tabela CATEGORIA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + BM_FILIAL + " - " + BM_GRUPO) + " foi excluido com sucesso na tabela CATEGORIA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")
							
							TcSetConn(nlConMain)
							
							SBM->(DbGoTo((clAlias)->RECNOSBM))
							
							If SBM->( !Eof() ) .And. SBM->( !Bof() )
								If RecLock("SBM",.F.)
									
									SBM->BM_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Campo BM_MSEXP atualizado com sucesso ! ")
									
									SBM->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - O registro da tabela SBM, RECNO " + AllTrim(Str((clAlias)->RECNOSBM)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas CATEGORIA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SBM ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela CATEGORIA - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001CTD  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE ITEM DE CONTA CONTABIL PARA O SIS- บฑฑ
ฑฑบ          ณ TEMA DE CATALOGO DE PRODUTOS.                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001CTD(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "ITEMCONTA_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Iniciando rotina de manutencao de dados na tabela ITEMCONTA - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN CTD.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,CTD_FILIAL						"	+	QUEBRA
clSql		+=	"		,CTD_ITEM						"	+	QUEBRA
clSql		+=	"		,CTD_DESC01						"	+	QUEBRA
clSql		+=	"		,CTD.R_E_C_N_O_ AS RECNOCTD		"	+	QUEBRA
clSql		+=	"		,CTD.D_E_L_E_T_ AS DELETCTD		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("CTD")	+	"	CTD	"	+	QUEBRA

clSql		+=	"	WHERE CTD_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,CTD_FILIAL		"	+	QUEBRA
clSql		+=	"			,CTD_ITEM		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Selecionando ITEMCONTA para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"CTD_FILIAL"
clCampos	+=	"/CTD_ITEM"
clCampos	+=	"/CTD_DESC01"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "CTD", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			CTD->(DbGoTo((clAlias)->RECNOCTD))
			
			If CTD->( !Eof() ) .And. CTD->( !Bof() )
				If RecLock("CTD",.F.)
					
					CTD->CTD_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Campo CTD_MSEXP atualizado com sucesso ! ")
					
					CTD->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - O registro da tabela CTD, RECNO " + AllTrim(Str((clAlias)->RECNOCTD)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + CTD_FILIAL + CTD_ITEM: : " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) )
			
			If !E0001EXT("ITEMCONTA", {"EMPRESA","CTD_FILIAL","CTD_ITEM"}, {(clAlias)->EMPRESA,(clAlias)->CTD_FILIAL, (clAlias)->CTD_ITEM } )
				
				If !Empty((clAlias)->DELETCTD)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					CTD->(DbGoTo((clAlias)->RECNOCTD))
					
					If CTD->( !Eof() ) .And. CTD->( !Bof() )
						If RecLock("CTD",.F.)
							
							CTD->CTD_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Campo CTD_MSEXP atualizado com sucesso ! ")
							
							CTD->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - O registro da tabela CTD, RECNO " + AllTrim(Str((clAlias)->RECNOCTD)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"			)
				aAdd(alCmpVals	,"CTD_FILIAL"		)
				aAdd(alCmpVals	,"CTD_ITEM"			)
				aAdd(alCmpVals	,"CTD_DESC01"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->CTD_FILIAL	)
				aAdd(alVals	,(clAlias)->CTD_ITEM	)
				aAdd(alVals	,(clAlias)->CTD_DESC01	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela ITEMCONTA - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"ITEMCONTA", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) ;
						+ " na tabela ITEMCONTA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) + " foi incluido com sucesso na tabela ITEMCONTA - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Atualizando campo CTD_MSEXP ! ")

						TcSetConn(nlConMain)	
						
						CTD->(DbGoTo((clAlias)->RECNOCTD))
						
						If CTD->( !Eof() ) .And. CTD->( !Bof() )
							If RecLock("CTD",.F.)
								
								CTD->CTD_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Campo CTD_MSEXP atualizado com sucesso ! ")
								
								CTD->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - O registro da tabela CTD, RECNO " + AllTrim(Str((clAlias)->RECNOCTD)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela ITEMCONTA - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETCTD)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"			)
					aAdd(alCmpVals	,"CTD_FILIAL"		)
					aAdd(alCmpVals	,"CTD_ITEM"			)
					aAdd(alCmpVals	,"CTD_DESC01"		)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->CTD_FILIAL	)
					aAdd(alVals	,(clAlias)->CTD_ITEM	)
					aAdd(alVals	,(clAlias)->CTD_DESC01	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"CTD_FILIAL"		)
					aAdd(alCmpCons	,"CTD_ITEM"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->CTD_FILIAL	)
					aAdd(alConds	,(clAlias)->CTD_ITEM	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela ITEMCONTA - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"ITEMCONTA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela ITEMCONTA " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) ;
							+ " na tabela ITEMCONTA - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) + " foi alterado com sucesso na tabela ITEMCONTA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Atualizando campo CTD_MSEXP ! ")

							TcSetConn(nlConMain)
							
							CTD->(DbGoTo((clAlias)->RECNOCTD))
							
							If CTD->( !Eof() ) .And. CTD->( !Bof() )
								If RecLock("CTD",.F.)
									
									CTD->CTD_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Campo CTD_MSEXP atualizado com sucesso ! ")
									
									CTD->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - O registro da tabela CTD, RECNO " + AllTrim(Str((clAlias)->RECNOCTD)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela ITEMCONTA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"CTD_FILIAL"		)
					aAdd(alCmpCons	,"CTD_ITEM"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->CTD_FILIAL	)
					aAdd(alConds	,(clAlias)->CTD_ITEM	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela ITEMCONTA - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"ITEMCONTA", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) ;
							+ " na tabela ITEMCONTA - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CTD_FILIAL + " - " + CTD_ITEM) + " foi excluido com sucesso na tabela ITEMCONTA - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")
							
							TcSetConn(nlConMain)							
							
							CTD->(DbGoTo((clAlias)->RECNOCTD))
							
							If CTD->( !Eof() ) .And. CTD->( !Bof() )
								If RecLock("CTD",.F.)
									
									CTD->CTD_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Campo CTD_MSEXP atualizado com sucesso ! ")
									
									CTD->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - O registro da tabela CTD, RECNO " + AllTrim(Str((clAlias)->RECNOCTD)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas ITEMCONTA - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Nao ha nenhum registro para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CTD ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela ITEMCONTA - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SAH  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE TIPOS DE UNIDADES DE MEDIDA PARA O บฑฑ
ฑฑบ          ณ SISTEMA DE CATALOGO DE PRODUTOS.                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SAH(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "TIPOUNIDADE_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Iniciando rotina de manutencao de dados na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SAH.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,AH_FILIAL						"	+	QUEBRA
clSql		+=	"		,AH_UNIMED						"	+	QUEBRA
clSql		+=	"		,AH_UMRES						"	+	QUEBRA
clSql		+=	"		,AH_DESCPO						"	+	QUEBRA
clSql		+=	"		,SAH.R_E_C_N_O_ AS RECNOSAH		"	+	QUEBRA
clSql		+=	"		,SAH.D_E_L_E_T_ AS DELETSAH		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SAH")	+	"	SAH	"	+	QUEBRA

clSql		+=	"	WHERE AH_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,AH_FILIAL		"	+	QUEBRA
clSql		+=	"			,AH_UNIMED		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Selecionando TIPOUNIDADE para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"AH_FILIAL"
clCampos	+=	"/AH_UNIMED"
clCampos	+=	"/AH_UMRES"
clCampos	+=	"/AH_DESCPO"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "SAH", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SAH->(DbGoTo((clAlias)->RECNOSAH))
			
			If SAH->( !Eof() ) .And. SAH->( !Bof() )
				If RecLock("SAH",.F.)
					
					SAH->AH_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Campo AH_MSEXP atualizado com sucesso ! ")
					
					SAH->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - O registro da tabela SAH, RECNO " + AllTrim(Str((clAlias)->RECNOSAH)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + AH_FILIAL + AH_UNIMED: : " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) )
			
			If !E0001EXT("TIPOUNIDADE", {"EMPRESA","AH_FILIAL","AH_UNIMED"}, {(clAlias)->EMPRESA,(clAlias)->AH_FILIAL, (clAlias)->AH_UNIMED } )
				
				If !Empty((clAlias)->DELETSAH)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SAH->(DbGoTo((clAlias)->RECNOSAH))
					
					If SAH->( !Eof() ) .And. SAH->( !Bof() )
						If RecLock("SAH",.F.)
							
							SAH->AH_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Campo AH_MSEXP atualizado com sucesso ! ")
							
							SAH->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - O registro da tabela SAH, RECNO " + AllTrim(Str((clAlias)->RECNOSAH)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"			)
				aAdd(alCmpVals	,"AH_FILIAL"		)
				aAdd(alCmpVals	,"AH_UNIMED"		)
				aAdd(alCmpVals	,"AH_UMRES"			)
				aAdd(alCmpVals	,"AH_DESCPO"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->AH_FILIAL	)
				aAdd(alVals	,(clAlias)->AH_UNIMED	)
				aAdd(alVals	,(clAlias)->AH_UMRES	)
				aAdd(alVals	,(clAlias)->AH_DESCPO	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"TIPOUNIDADE", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) ;
						+ " na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) + " foi incluido com sucesso na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Atualizando campo AH_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SAH->(DbGoTo((clAlias)->RECNOSAH))
						
						If SAH->( !Eof() ) .And. SAH->( !Bof() )
							If RecLock("SAH",.F.)
								
								SAH->AH_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Campo AH_MSEXP atualizado com sucesso ! ")
								
								SAH->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - O registro da tabela SAH, RECNO " + AllTrim(Str((clAlias)->RECNOSAH)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSAH)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"			)
					aAdd(alCmpVals	,"AH_FILIAL"		)
					aAdd(alCmpVals	,"AH_UNIMED"		)
					aAdd(alCmpVals	,"AH_UMRES"			)
					aAdd(alCmpVals	,"AH_DESCPO"		)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->AH_FILIAL	)
					aAdd(alVals	,(clAlias)->AH_UNIMED	)
					aAdd(alVals	,(clAlias)->AH_UMRES	)
					aAdd(alVals	,(clAlias)->AH_DESCPO	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"AH_FILIAL"		)
					aAdd(alCmpCons	,"AH_UNIMED"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->AH_FILIAL	)
					aAdd(alConds	,(clAlias)->AH_UNIMED	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"TIPOUNIDADE", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela TIPOUNIDADE " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) ;
							+ " na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) + " foi alterado com sucesso na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Atualizando campo AH_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SAH->(DbGoTo((clAlias)->RECNOSAH))
							
							If SAH->( !Eof() ) .And. SAH->( !Bof() )
								If RecLock("SAH",.F.)
									
									SAH->AH_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Campo AH_MSEXP atualizado com sucesso ! ")
									
									SAH->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - O registro da tabela SAH, RECNO " + AllTrim(Str((clAlias)->RECNOSAH)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"AH_FILIAL"		)
					aAdd(alCmpCons	,"AH_UNIMED"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->AH_FILIAL	)
					aAdd(alConds	,(clAlias)->AH_UNIMED	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"TIPOUNIDADE", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) ;
							+ " na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + AH_FILIAL + " - " + AH_UNIMED) + " foi excluido com sucesso na tabela TIPOUNIDADE - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SAH->(DbGoTo((clAlias)->RECNOSAH))
							
							If SAH->( !Eof() ) .And. SAH->( !Bof() )
								If RecLock("SAH",.F.)
									
									SAH->AH_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Campo AH_MSEXP atualizado com sucesso ! ")
									
									SAH->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - O registro da tabela SAH, RECNO " + AllTrim(Str((clAlias)->RECNOSAH)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas TIPOUNIDADE - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Nao ha nenhum registro para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SAH ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela TIPOUNIDADE - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001CT1  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE CONTAS CONTมEBEIS PARA O SISTEMA DE ฑฑ
ฑฑบ          ณ CATมLOGO DE PRODUTOS.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001CT1(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "CONTACONTABIL_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Iniciando rotina de manutencao de dados na tabela CONTACONTABIL - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN CT1.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,CT1_FILIAL						"	+	QUEBRA
clSql		+=	"		,CT1_CONTA						"	+	QUEBRA
clSql		+=	"		,CT1_DESC01						"	+	QUEBRA
clSql		+=	"		,CT1.R_E_C_N_O_ AS RECNOCT1		"	+	QUEBRA
clSql		+=	"		,CT1.D_E_L_E_T_ AS DELETCT1		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("CT1")	+	"	CT1	"	+	QUEBRA

clSql		+=	"	WHERE CT1_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,CT1_FILIAL		"	+	QUEBRA
clSql		+=	"			,CT1_CONTA		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Selecionando CONTACONTABIL para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

clCampos	:=	"CT1_FILIAL"
clCampos	+=	"/CT1_CONTA"
clCampos	+=	"/CT1_DESC01"

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "CT1", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			CT1->(DbGoTo((clAlias)->RECNOCT1))
			
			If CT1->( !Eof() ) .And. CT1->( !Bof() )
				If RecLock("CT1",.F.)
					
					CT1->CT1_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Campo CT1_MSEXP atualizado com sucesso ! ")
					
					CT1->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - O registro da tabela CT1, RECNO " + AllTrim(Str((clAlias)->RECNOCT1)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + CT1_FILIAL + CT1_CONTA: : " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) )
			
			If !E0001EXT("CONTACONTABIL", {"EMPRESA","CT1_FILIAL","CT1_CONTA"}, {(clAlias)->EMPRESA,(clAlias)->CT1_FILIAL, (clAlias)->CT1_CONTA } )
				
				If !Empty((clAlias)->DELETCT1)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					CT1->(DbGoTo((clAlias)->RECNOCT1))
					
					If CT1->( !Eof() ) .And. CT1->( !Bof() )
						If RecLock("CT1",.F.)
							
							CT1->CT1_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Campo CT1_MSEXP atualizado com sucesso ! ")
							
							CT1->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - O registro da tabela CT1, RECNO " + AllTrim(Str((clAlias)->RECNOCT1)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"			)
				aAdd(alCmpVals	,"CT1_FILIAL"		)
				aAdd(alCmpVals	,"CT1_CONTA"		)
				aAdd(alCmpVals	,"CT1_DESC01"		)
				
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->CT1_FILIAL	)
				aAdd(alVals	,(clAlias)->CT1_CONTA	)
				aAdd(alVals	,(clAlias)->CT1_DESC01	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela CONTACONTABIL - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"CONTACONTABIL", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) ;
						+ " na tabela CONTACONTABIL - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) + " foi incluido com sucesso na tabela CONTACONTABIL - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Atualizando campo CT1_MSEXP ! ")

						TcSetConn(nlConMain)
						
						CT1->(DbGoTo((clAlias)->RECNOCT1))
						
						If CT1->( !Eof() ) .And. CT1->( !Bof() )
							If RecLock("CT1",.F.)
								
								CT1->CT1_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Campo CT1_MSEXP atualizado com sucesso ! ")
								
								CT1->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - O registro da tabela CT1, RECNO " + AllTrim(Str((clAlias)->RECNOCT1)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela CONTACONTABIL - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETCT1)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpVals	,"EMPRESA"			)
					aAdd(alCmpVals	,"CT1_FILIAL"		)
					aAdd(alCmpVals	,"CT1_CONTA"		)
					aAdd(alCmpVals	,"CT1_DESC01"		)
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->CT1_FILIAL	)
					aAdd(alVals	,(clAlias)->CT1_CONTA	)
					aAdd(alVals	,(clAlias)->CT1_DESC01	)
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"CT1_FILIAL"		)
					aAdd(alCmpCons	,"CT1_CONTA"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->CT1_FILIAL	)
					aAdd(alConds	,(clAlias)->CT1_CONTA	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela CONTACONTABIL - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"CONTACONTABIL", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela CONTACONTABIL " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) ;
							+ " na tabela CONTACONTABIL - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) + " foi alterado com sucesso na tabela CONTACONTABIL - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Atualizando campo CT1_MSEXP ! ")

							TcSetConn(nlConMain)
							
							CT1->(DbGoTo((clAlias)->RECNOCT1))
							
							If CT1->( !Eof() ) .And. CT1->( !Bof() )
								If RecLock("CT1",.F.)
									
									CT1->CT1_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Campo CT1_MSEXP atualizado com sucesso ! ")
									
									CT1->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - O registro da tabela CT1, RECNO " + AllTrim(Str((clAlias)->RECNOCT1)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela CONTACONTABIL - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"CT1_FILIAL"		)
					aAdd(alCmpCons	,"CT1_CONTA"		)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->CT1_FILIAL	)
					aAdd(alConds	,(clAlias)->CT1_CONTA	)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela CONTACONTABIL - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"CONTACONTABIL", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) ;
							+ " na tabela CONTACONTABIL - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + CT1_FILIAL + " - " + CT1_CONTA) + " foi excluido com sucesso na tabela CONTACONTABIL - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							CT1->(DbGoTo((clAlias)->RECNOCT1))
							
							If CT1->( !Eof() ) .And. CT1->( !Bof() )
								If RecLock("CT1",.F.)
									
									CT1->CT1_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Campo CT1_MSEXP atualizado com sucesso ! ")
									
									CT1->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - O registro da tabela CT1, RECNO " + AllTrim(Str((clAlias)->RECNOCT1)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas CONTACONTABIL - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Nao ha nenhum registro para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001CT1 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela CONTACONTABIL - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SA3  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/27/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE VENDEDORES PARA O SISTEMA DE CATมLO ฑฑ
ฑฑบ          ณ GO DE PRODUTOS.                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function E0001SA3(llJob,clEmp, clFil, llLog, cArqSemaforo)
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog
Local nlHandle	
Local nHdlSem	:= -1
Local aRegs		:= {}
Local cVendMail := "" //email vendedor *Altera็ao interna* Felipe 08/08/2013

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

clArqLog	:= "CONTACONTABIL_" + clEmp + clFil
nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Iniciando rotina de manutencao de dados na tabela VENDEDOR - CATALOGO DE PRODUTOS.")

nlConMain	:= AdvConnection()

clAlias		:= GetNextAlias()

clSql		:=	"	SELECT								"	+	QUEBRA
clSql		+=	"		 (CASE WHEN SA3.D_E_L_E_T_ = '' THEN 1 ELSE 2 END) AS IND_DEL "	+	QUEBRA
clSql		+=	"   	,('" + SM0->M0_CODIGO+ "') AS EMPRESA	"	+	QUEBRA
clSql		+=	"		,A3_FILIAL						"	+	QUEBRA
clSql		+=	"		,A3_COD							"	+	QUEBRA
clSql		+=	"		,A3_NOME						"	+	QUEBRA
clSql		+=	"		,A3_EMAIL						"	+	QUEBRA
clSql		+=	"		,A3_CODUSR						"	+	QUEBRA
clSql		+=	"		,SA3.R_E_C_N_O_ AS RECNOSA3		"	+	QUEBRA
clSql		+=	"		,SA3.D_E_L_E_T_ AS DELETSA3		"	+	QUEBRA
clSql		+=	"	FROM	"	+	RetSqlName("SA3")	+	"	SA3	"	+	QUEBRA

clSql		+=	"	WHERE A3_MSEXP	=	' '	"	+	QUEBRA

clSql		+=	"	ORDER BY 1				"	+	QUEBRA
clSql		+=	"			,A3_FILIAL		"	+	QUEBRA
clSql		+=	"			,A3_COD		"	+	QUEBRA

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Selecionando VENDEDOR para inclusao ou alteracao !")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

cVendMail := UsrRetMail((clAlias)->A3_CODUSR)//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013

clCampos	:=	"A3_FILIAL"
clCampos	+=	"/A3_COD"
clCampos	+=	"/A3_NOME"
//clCampos	+=	"/A3_EMAIL"  	//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
clCampos	+=	"/"+cVendMail  	//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - TcSetFields em campos !")

E0001STF( "A3", clAlias , clCampos)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(! Eof()) .And. (clAlias)->(! Bof())
	
	While (clAlias)->(! Eof())
		
		If aScan(aRegs,(clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD)) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) + " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")

			TcSetConn(nlConMain)
			
			SA3->(DbGoTo((clAlias)->RECNOSA3))
			
			If SA3->( !Eof() ) .And. SA3->( !Bof() )
				If RecLock("SA3",.F.)
					
					SA3->A3_MSEXP := dTos(MsDate())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Campo A3_MSEXP atualizado com sucesso ! ")
					
					SA3->(MsUnlock())
				EndIf
				
			Else
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - O registro da tabela SA3, RECNO " + AllTrim(Str((clAlias)->RECNOSA3)) + ", nao foi encontrado ! ", .T.)
			EndIf
			
			(clAlias)->(DbSkip())
			
			Loop
			
		Else
			
			aAdd(aRegs,(clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD))
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + A3_FILIAL + A3_COD: : " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) )
			
			If !E0001EXT("VENDEDOR", {"EMPRESA","A3_FILIAL","A3_COD"}, {(clAlias)->EMPRESA,(clAlias)->A3_FILIAL, (clAlias)->A3_COD } )
				
				If !Empty((clAlias)->DELETSA3)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - O registro esta excluido no Protheus e nao sera exportado !")

					TcSetConn(nlConMain)
					
					SA3->(DbGoTo((clAlias)->RECNOSA3))
					
					If SA3->( !Eof() ) .And. SA3->( !Bof() )
						If RecLock("SA3",.F.)
							
							SA3->A3_MSEXP := dTos(MsDate())
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Campo A3_MSEXP atualizado com sucesso ! ")
							
							SA3->(MsUnlock())
						EndIf
						
					Else
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - O registro da tabela A3, RECNO " + AllTrim(Str((clAlias)->RECNOSA3)) + ", nao foi encontrado ! ", .T.)
					EndIf
					
					(clAlias)->(DbSkip())
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
					
					E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
					
					Loop
					
				EndIf
						                                        
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"			)
				aAdd(alCmpVals	,"A3_FILIAL"		)
				aAdd(alCmpVals	,"A3_COD"			)
				aAdd(alCmpVals	,"A3_NOME"			)
				aAdd(alCmpVals	,"A3_EMAIL"			)  		//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
				
								
				aAdd(alVals	,(clAlias)->EMPRESA		)
				aAdd(alVals	,(clAlias)->A3_FILIAL	)
				aAdd(alVals	,(clAlias)->A3_COD 		)
				aAdd(alVals	,(clAlias)->A3_NOME		)
			   //aAdd(alVals	,(clAlias)->A3_EMAIL)				//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
			    aAdd(alVals	,UsrRetMail((clAlias)->A3_CODUSR))		//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela VENDEDOR - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"VENDEDOR", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) ;
						+ " na tabela VENDEDOR - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) + " foi incluido com sucesso na tabela VENDEDOR - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Atualizando campo A3_MSEXP ! ")

						TcSetConn(nlConMain)
						
						SA3->(DbGoTo((clAlias)->RECNOSA3))
						
						If SA3->( !Eof() ) .And. SA3->( !Bof() )
							If RecLock("SA3",.F.)
								
								SA3->A3_MSEXP := dTos(MsDate())
								
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Campo A3_MSEXP atualizado com sucesso ! ")
								
								SA3->(MsUnlock())
							EndIf
							
						Else
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - O registro da tabela A3, RECNO " + AllTrim(Str((clAlias)->RECNOSA3)) + ", nao foi encontrado ! ", .T.)
						EndIf
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela VENDEDOR - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
			Else
				
				If Empty((clAlias)->DELETSA3)
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
									
					aAdd(alCmpVals	,"EMPRESA"			)
					aAdd(alCmpVals	,"A3_FILIAL"		)
					aAdd(alCmpVals	,"A3_COD"			)
					aAdd(alCmpVals	,"A3_NOME"			)
					aAdd(alCmpVals	,"A3_EMAIL"			)  			//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
									                                     
					cVendMail := UsrRetMail((clAlias)->A3_CODUSR) 	
					
					aAdd(alVals	,(clAlias)->EMPRESA		)
					aAdd(alVals	,(clAlias)->A3_FILIAL	)
					aAdd(alVals	,(clAlias)->A3_COD 		)
					aAdd(alVals	,(clAlias)->A3_NOME		)
					//aAdd(alVals	,(clAlias)->A3_EMAIL	) 		//email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
					aAdd(alVals	,UsrRetMail((clAlias)->A3_CODUSR)) //email vendedor *Altera็ao interna* Lucas Felipe 08/08/2013
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"A3_FILIAL"		)
					aAdd(alCmpCons	,"A3_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->A3_FILIAL	)
					aAdd(alConds	,(clAlias)->A3_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela VENDEDOR - CATALOGO DE PRODUTOS")
					
					clUpdate	:=	 E0001SQL(2,"VENDEDOR", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clUpdate)
						
						If TcSqlExec(clUpdate) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela VENDEDOR " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) ;
							+ " na tabela VENDEDOR - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) + " foi alterado com sucesso na tabela VENDEDOR - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Atualizando campo A3_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SA3->(DbGoTo((clAlias)->RECNOSA3))
							
							If SA3->( !Eof() ) .And. SA3->( !Bof() )
								If RecLock("SA3",.F.)
									
									SA3->A3_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Campo A3_MSEXP atualizado com sucesso ! ")
									
									SA3->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - O registro da tabela A3, RECNO " + AllTrim(Str((clAlias)->RECNOSA3)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela VENDEDOR - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
				Else
					
					alCmpVals	:=	{}
					alVals		:=	{}
					alCmpCons	:=	{}
					alConds		:=	{}
					
					aAdd(alCmpCons	,"EMPRESA"			)
					aAdd(alCmpCons	,"A3_FILIAL"		)
					aAdd(alCmpCons	,"A3_COD"			)
					
					aAdd(alConds	,(clAlias)->EMPRESA		)
					aAdd(alConds	,(clAlias)->A3_FILIAL	)
					aAdd(alConds	,(clAlias)->A3_COD		)
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Criando query para exclusao de dados na tabela VENDEDOR - CATALOGO DE PRODUTOS")
					
					clDelete	:=	 E0001SQL(3,"VENDEDOR", alCmpVals, alVals, alCmpCons, alConds)
					
					If !Empty(clDelete)
						
						If TcSqlExec(clDelete) < 0
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Nao foi possivel excluir o registro " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) ;
							+ " na tabela VENDEDOR - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
							
						Else
							
							TcSqlExec("COMMIT")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - O registro " + (clAlias)->(EMPRESA  + " - " + A3_FILIAL + " - " + A3_COD) + " foi excluido com sucesso na tabela VENDEDOR - CATALOGO DE PRODUTOS")
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
							
							E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
							
							E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Atualizando campo Z5_MSEXP ! ")

							TcSetConn(nlConMain)
							
							SA3->(DbGoTo((clAlias)->RECNOSA3))
							
							If SA3->( !Eof() ) .And. SA3->( !Bof() )
								If RecLock("SA3",.F.)
									
									SA3->A3_MSEXP := dTos(MsDate())
									
									E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Campo A3_MSEXP atualizado com sucesso ! ")
									
									SA3->(MsUnlock())
								EndIf
							Else
								E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - O registro da tabela A3, RECNO " + AllTrim(Str((clAlias)->RECNOSA3)) + ", nao foi encontrado ! ", .T.)
							EndIf
							
						EndIf
						
					Else
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - ERRO - Query para exclusao na tabela tabelas VENDEDOR - CATALOGO DE PRODUTOS vazia !", .T.)
						
					EndIf
					
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	(clAlias)->(DbCloseArea())
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Nao ha nenhum registro para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SA3 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela VENDEDOR - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001SX6  บAutor  ณHermes Ferreira     บ Data ณ  20/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNวรO DE EXPORTAวรO DE ESTADO X ALIQUOTA ICMS PARA        บฑฑ
ฑฑบ          ณ O SISTEMA DE CATALOGO DE PRODUTOS.                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES - CATALOGO DE PRODUTOS                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
//
User Function E0001SX6(llJob,clEmp, clFil, llLog, cArqSemaforo)

Local cEstICM	:= ""
Local nCEst		:= 0
Local aEstAliq	:= {}
Local cAux		:= ""
Local clSql		:= ""
Local clAlias	:= ""
Local clInsert	:= ""
Local clUpdate	:= ""
Local clDelete	:= ""
Local clCampos	:= ""
Local nlConMain := 0
Local nlConAndr	:= -1
Local clTipoBD	:= ""
Local clNomeBd	:= ""
Local clSrvTop	:= ""
Local nlPortTop	:= 0
Local alCmpVals	:=	{}
Local alVals	:=	{}
Local alCmpCons	:=	{}
Local alConds	:=	{}
Local clArqLog	:= "ESTADOXICMS_" + clEmp + clFil
Local nlHandle	:= Iif(llLog,E0001ARQ(clArqLog),-1)
Local nHdlSem	:= -1
Local aRegs		:= {}

Default llJob	:= .F.
Default clEmp	:= ""
Default clFil   := ""
Default llLog	:= .F.
Default cArqSemaforo	:= ""

nHdlSem := FOpen(cArqSemaforo,FO_READ + FO_EXCLUSIVE)

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

If llJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(clEmp,clFil)
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - ERRO - Nao foi possivel iniciar a empresa e filial !", .T.)
		
		FClose(nHdlSem)
		
		Return()
		
	EndIf
	
EndIf

Begin Sequence

E0001GX6(@clTipoBD,@clNomeBd,@clSrvTop,@nlPortTop)

cEstICM	:= Alltrim(GetNewPar("MV_ESTICM","AC17AL17AM17AP17BA17CE17DF17ES17GO17MA17MG18MS17MT17PA17PB17PE17PI17PR18RJ19RN17RO17RR17RS17SC17SE17SP18TO17"))

For nCEst := 1 To Len(cEstICM) Step 4
	
	cAux:= subStr(cEstICM,nCEst,4)
	aadd(aEstAliq,{Left(cAux,2),right(cAux,2)})
	
Next nCEst

If Len(aEstAliq)> 0
	
	For nC := 1 to Len(aEstAliq)
		
		If aScan(aRegs,clEmp+clFil+aEstAliq[nC,1] ) > 0
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - O registro " + aEstAliq[nC,1]+aEstAliq[nC,2]+ " jแ foi atualizado nessa itera็ใo e nใo serแ considerado !")
			
			Loop
			
		Else
			
			aAdd(aRegs,clEmp+clFil+aEstAliq[nC,1])
			
		EndIf
		
		alCmpVals	:=	{}
		alVals		:=	{}
		alCmpCons	:=	{}
		alConds		:=	{}
		
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Abrindo TOPCONNECT CATALOGO DE PRODUTOS ! ")
		
		If E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .T., nlConMain, @nlConAndr)
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Verificando existencia de registro no servidor CATALOGO DE PRODUTOS ! Chave EMPRESA + FILIL + ESTADO : " +  clEmp+"+"+clFil+"+"+aEstAliq[nC,1] )
			
			If !E0001EXT("ESTADOXICMS", {"EMPRESA","FILIAL","ESTADO"}, {clEmp,clFil,aEstAliq[nC,1] } )
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"	)
				aAdd(alCmpVals	,"FILIAL"	)
				aAdd(alCmpVals	,"ESTADO"	)
				aAdd(alCmpVals	,"ALIQUOTA"	)
				
				aAdd(alVals		,clEmp			)
				aAdd(alVals		,clFil 			)
				aAdd(alVals		,aEstAliq[nC,1]	)
				aAdd(alVals		,aEstAliq[nC,2]	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Criando query para inclusao de dados na tabela ESTADOXICMS - CATALOGO DE PRODUTOS")
				
				clInsert	:=	 E0001SQL(1,"ESTADOXICMS", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clInsert)
					
					If TcSqlExec(clInsert) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - ERRO - Nao foi possivel incluir o registro de Estado X Aliquota " + clEmp+"-"+clFil+"-"+aEstAliq[nC,1]+"-"+aEstAliq[nC,2];
						+ " na tabela ESTADOXICMS - CATALOGO DE PRODUTOS. " + TcSqlError() ,.T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - O registro " + clEmp+"-"+clFil+"-"+aEstAliq[nC,1]+"-"+aEstAliq[nC,2] + " foi incluido com sucesso na tabela ESTADOXICMS - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
						
					EndIf
					
				Else
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - ERRO - Query para inclusao na tabela ESTADOXICMS - CATALOGO DE PRODUTOS vazia !", .T.)
				EndIf
				
			Else // Altera็ใo
				
				alCmpVals	:=	{}
				alVals		:=	{}
				alCmpCons	:=	{}
				alConds		:=	{}
				
				aAdd(alCmpVals	,"EMPRESA"	)
				aAdd(alCmpVals	,"FILIAL"	)
				aAdd(alCmpVals	,"ESTADO"	)
				aAdd(alCmpVals	,"ALIQUOTA"	)
				
				aAdd(alVals		,clEmp			)
				aAdd(alVals		,clFil 			)
				aAdd(alVals		,aEstAliq[nC,1]	)
				aAdd(alVals		,aEstAliq[nC,2]	)
				
				aAdd(alCmpCons	,"EMPRESA"		)
				aAdd(alCmpCons	,"FILIAL"		)
				aAdd(alCmpCons	,"ESTADO"		)
				
				aAdd(alConds	,clEmp			)
				aAdd(alConds	,clFil 			)
				aAdd(alConds	,aEstAliq[nC,1]	)
				
				E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Criando query para alteracao de dados na tabela ESTADOXICMS - CATALOGO DE PRODUTOS")
				
				clUpdate	:=	 E0001SQL(2,"ESTADOXICMS", alCmpVals, alVals, alCmpCons, alConds)
				
				If !Empty(clUpdate)
					
					If TcSqlExec(clUpdate) < 0
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - ERRO - Nao foi possivel alterar a tabela ESTADOXICMS " + clEmp+"-"+clFil+"-"+aEstAliq[nC,1];
						+ " na tabela ESTADOXICMS - CATALOGO DE PRODUTOS. " + TcSqlError(), .T.)
						
					Else
						
						TcSqlExec("COMMIT")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - O registro " +  clEmp+"-"+clFil+"-"+aEstAliq[nC,1]+ " foi alterado com sucesso na tabela ESTADOXICMS - CATALOGO DE PRODUTOS")
						
						E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
						
						E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
						
					EndIf
					
				Else
					
					E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - ERRO - Query para alteracao na tabela ESTADOXICMS - CATALOGO DE PRODUTOS vazia !", .T.)
					
				EndIf
				
			EndIf
			
			E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
			
			E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
			
		Else
			
			Exit
			
		EndIf
		
	Next nC
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Fechando TOPCONNECT - CATALOGO DE PRODUTOS ! ")
	
	E0001TPC(clArqLog,llLog,@nlHandle,clTipoBD + "/" + clNomeBd, clSrvTop, nlPortTop, .F., nlConMain, nlConAndr)
	
Else
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Nenhum registro novo ou alterado para ser exportado !")
	
	
EndIf

E0001MSG(clArqLog,llLog,@nlHandle,"E0001SX6 ("+clEmp+clFil+") - Finalizando rotina de manutencao de dados da tabela ESTADOXICMS - CATALOGO DE PRODUTOS.")

If llLog
	FClose(nlHandle)
EndIf

If llJob
	RpcClearEnv()
EndIf

FClose(nHdlSem)

End Sequence

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFUNวรO    ณE0001EXT  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVERIFICA EXISTENCIA DE REGISTRO PELA CHAVE UNICA.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001EXT(clTabela, alCampos, alDados)
Local llExiste		:= .T.
Local clSql	   		:= ""
Local clAlias		:= GetNextAlias()
Local nlCont1		:= 1
Local clAnd			:= " AND "
Local clUserBd		:= Alltrim(U_MyNewSX6("NCG_000003"						,;
""														,;
"C"																,;
"Usuแrio do Banco de Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "	,;
"Usuแrio do Banco de Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "	,;
"Usuแrio do Banco de Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "	,;
.F. ))

clSql += " SELECT EMPRESA FROM " +clUserBd+"."+ UPPER(clTabela)

clSql += " WHERE "

For nlCont1 := 1 To Len(alCampos)
	
	If ValType(alDados[nlCont1]) == "C"
		
		clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = '" +  alDados[nlCont1] + "' "
		
	ElseIf ValType(alDados[nlCont1]) == "N"
		
		clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = " +  AllTrim(Str(alDados[nlCont1]))
		
	ElseIf ValType(alDados[nlCont1]) == "D"
		
		clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = " +  dTos(alDados[nlCont1]) + "' "
		
	EndIf
	
Next nlCont1

TcSqlExec("COMMIT")

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(!Eof()) .And. (clAlias)->(!Bof())
	
	llExiste 	:= .T.
	
Else
	
	llExiste	:= .F.
	
EndIf

(clAlias)->(DbCloseArea())

Return(llExiste)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFUNวรO    ณE0001SQL  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCRIA A QUERY PARA INSERT, UPDATE OU DELETE                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001SQL(nlOpc,clTabela, alCmpVals, alVals, alCmpCond, alConds )
Local clSql		:=	""
Local nlCont1	:= 1
Local clVirgula	:=	","
Local clAnd		:=	" AND "
Local nlCont2
Local clUserBd		:= Alltrim(U_MyNewSX6("NCG_000003"						,;
""														,;
"C"																,;
"Usuแrio do Banco de Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "	,;
"Usuแrio do Banco de Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "	,;
"Usuแrio do Banco de Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "	,;
.F. ))

If nlOpc == 1 //Insert
	
	If Len(alCmpVals) == Len(alVals) .And. Len(alCmpCond) == Len(alConds) .And. Len(alCmpVals) <> 0
		
		clSql	:= " INSERT INTO " +clUserBd+"."+ ALLTRIM(UPPER(clTabela)) + " ( " + CRLF
		
		For nlCont1 := 1 To Len(alCmpVals)
			
			clSql += Iif(nlCont1 > 1 , clVirgula , "") + alCmpVals[nlCont1] + CRLF
			
		Next nlCont1
		
		clSql	+= ") " + CRLF
		
		clSql	+= " VALUES (" + CRLF
		
		For nlCont2 := 1 To Len(alVals)
			clSql	+= Iif(nlCont2 > 1 , clVirgula , "") + E0001VAL(alVals[nlCont2]) + CRLF
		Next nlCont2
		
		clSql	+= ") "
		
		If Len(alCmpCond) > 0
			
			clSql	+=	" WHERE " + CRLF
			
			For nlCont1	:= 1 To Len(alCmpCond)
				clSql	+=	Iif(nlCont1 > 1 , clVirgula , "") + alCmpCond[nlCont1] + " = " + E0001VAL(alConds[nlCont1]) + CRLF
			Next nlCont1
			
		EndIf
		
	EndIF
	
ElseIf nlOpc == 2 //Update
	
	If Len(alCmpVals) == Len(alVals) .And. Len(alCmpCond) == Len(alConds) .And. Len(alCmpVals) <> 0
		
		clSql	:= " UPDATE " +clUserBd+"."+ALLTRIM(UPPER(clTabela)) + " SET " + CRLF
		
		For nlCont1 := 1 To Len(alCmpVals)
			
			clSql	+= 	Iif(nlCont1 > 1 , clVirgula , "") + alCmpVals[nlCont1] + " = " + E0001VAL(alVals[nlCont1]) + CRLF
			
		Next nlCont1
		
		If Len(alCmpCond) > 0
			
			clSql	+=	" WHERE " + CRLF
			
			For nlCont1	:= 1 To Len(alCmpCond)
				clSql	+=	Iif(nlCont1 > 1 , clAnd , "") + alCmpCond[nlCont1] + " = " + E0001VAL(alConds[nlCont1]) + CRLF
			Next nlCont1
			
		EndIf
		
	EndIf
	
ElseIf nlOpc == 3 //Delete
	
	If Len(alCmpCond) == Len(alConds)
		
		clSql	:= " DELETE FROM " +clUserBd+"."+ALLTRIM(UPPER(clTabela)) + CRLF
		
		If Len(alCmpCond) > 0
			
			clSql	+=	" WHERE " + CRLF
			
			For nlCont1	:= 1 To Len(alCmpCond)
				clSql	+=	Iif(nlCont1 > 1 , clAnd , "") + alCmpCond[nlCont1] + " = " + E0001VAL(alConds[nlCont1]) + CRLF
			Next nlCont1
			
		EndIf
		
	EndIf
	
	
EndIf

Return(clSql)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFUNวรO    ณE0001VAL  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTRANSFORMA QUALQUER TIPO PARA CARACTER.                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001VAL(xlVal)
Local xlRet

If ValType(xlVal) == "C"
	xlVal	:= E0001CHR(xlVal)
	xlRet	:=	"'" + Iif(Len(xlVal)==0,Space(1),xlVal)  + "'"
ElseIf ValType(xlVal) == "N"
	xlRet	:=	AllTrim(Str(xlVal))
ElseIf ValType(xlVal) == "D"
	xlRet	:=	"'" + dTos(xlVal) + "'"
EndIf

Return(xlRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFUNวรO    ณE0001CHR  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRETIRA CARACTERES ESPECIAIS PARA CRIAวรO DA QUERY.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


Static Function E0001CHR(clComChar)
Local clSemChar		:=	clComChar

clSemChar	:=	 StrTran(clSemChar,"'","")
clSemChar	:=	 StrTran(clSemChar,'"',"")
clSemChar	:=	 StrTran(clSemChar,"ด","")
clSemChar	:=	 StrTran(clSemChar,"`","")

Return(clSemChar)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFUNวรO    ณE0001GX6  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRECUPERA VALOR DE PARAMETROS PARA CONEXรO EM BANCO DE DADOS บฑฑ
ฑฑบ          ณ CATALOGO.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001GX6(clTipoBD,clNomeBd,clSrvTop,nlPortTop)

clTipoBD	:= U_MyNewSX6("NCG_000006"							,;
""																,;
"C"																,;
"Tipo Banco De Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "		,;
"Tipo Banco De Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "		,;
"Tipo Banco De Dados Para Transfer๊ncia De Dados (Catแlogo de Produto) "		,;
.F. )
clNomeBd	:= U_MyNewSX6("NCG_000007"							,;
""																,;
"C"																,;
"Nome do banco de dados para transferencia de dados (Catแlogo de Produto)    "	,;
"Nome do banco de dados para transferencia de dados (Catแlogo de Produto)    "	,;
"Nome do banco de dados para transferencia de dados (Catแlogo de Produto)    "	,;
.F. )
clSrvTop	:= U_MyNewSX6("NCG_000008"							,;
""																,;
"C"																,;
"Servidor do top connect para transfer๊ncia de dados (Catแlogo de Produto) "	,;
"Servidor do top connect para transfer๊ncia de dados (Catแlogo de Produto) "	,;
"Servidor do top connect para transfer๊ncia de dados (Catแlogo de Produto) "	,;
.F. )
nlPortTop	 := U_MyNewSX6("NCG_000009"							,;
0															,;
"N"																,;
"Porta do top connect para transferencia de dados (Catแlogo de Produto)"		,;
"Porta do top connect para transferencia de dados (Catแlogo de Produto)"		,;
"Porta do top connect para transferencia de dados (Catแlogo de Produto)"		,;
.F. )

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001MSG  บAutor  ณMicrosiga           บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ EXIBE MENSAGEM NO CONSOLE DO SERVER E DO TOPCONNECT        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static FUnction E0001MSG(clArqLog,llLog,nlHandle, clMsg, lErro)
Local cMyAux 	:= ""
Local cMyPilha	:= ""
Local nPilha	:= 0
Local cEmail	:= ""

Default lErro := .F.

Conout(clMsg)
PtInternal(1,clMsg)

If llLog
	
	nlHandle := E0001ARQ(clArqLog, nlHandle)
	
	If FWrite(nlHandle,Dtoc(MsDate()) +" - "+ Time() +" - "+ clMsg + Chr(13) + Chr(10)) < 0
		ConOut("Nao foi possivel escrever no arquivo de log: " + clMsg)
	EndIf
	
EndIf


If lErro
	
	While !Empty(cMyAux:=ProcName(nPilha))
		
		cMyPilha 	+= cMyAux + Chr(13) + Chr(10)
		cMyAux		:= ""
		nPilha++
		
	EndDo
	
	cEmail := "Sr(a) administrador(a),"
	cEmail += "<Br></Br>"
	cEmail += "<Br></Br>"
	cEmail += "<Br></Br>"
	cEmail += "Ocorreu o seguinte erro nas transa็๕es de dados entre o ERP Protheus e o Catแlogo de Produtos:"
	cEmail += "<Br></Br>"
	cEmail += "<Br></Br>"
	cEmail += "<table border='1'> "
	cEmail += "	<tr> "
	cEmail += "		<th>Servidor</th> "
	cEmail += "		<th>Ambiente</th> "
	cEmail += "		<th>Usuแrio</th> "
	cEmail += "		<th>Pilha de chamada</th> "
	cEmail += "		<th>Data/hora</th> "
	cEmail += "		<th>Descri็ใo</th> "
	cEmail += "	</tr>"
	cEmail += "	<tr>"
	cEmail += "		<td>" + GetServerIp() + "</td>"
	cEmail += "		<td>" + GetEnvServer() + "</td>"
	cEmail += "		<td>" + GetWebJob() + "</td>"
	cEmail += "		<td>" + cMyPilha + "</td>"
	cEmail += "		<td>" + Dtoc(MsDate())+ " - " + Time() + "</td>"
	cEmail += "		<td>" + clMsg + "</td>"
	cEmail += "	</tr> "
	cEmail += " </table> "
	cEmail += "<Br></Br>"
	cEmail += "<Br></Br>"
	cEmail += "Departamento de Tecnologia Da Informacao"
	cEmail += "<Br></Br>"
	cEmail += "<Br></Br>"
	cEmail += "At."
	
	llok	:= .F.
	
	U_MySndMail("NC GAMES - CATALOGO DE PRODUTOS ONLINE - SERVIDOR " + GetServerIp() + " - AMBIENTE " + GetEnvServer(), cEmail, Nil, Nil, Nil, Nil)
	
EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001STF  บAutor  ณMicrosiga           บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ EXECUTA TCSETFIELD EM CAMPOS DE QUERY.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001STF( clAlias, clAliasTo , clCampos)

SX3->( dbSeek( clAlias ) )
While SX3->( !Eof() ) .And. SX3->X3_ARQUIVO == clAlias
	If SX3->X3_TIPO $ "ND" .and. SX3->X3_CONTEXT <> "V" .And. Iif(Empty(clCampos),.T.,AllTrim(SX3->X3_CAMPO) $ AllTrim(clCampos))
		TCSetField( clAliasTo, SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL )
	EndIf
	SX3->( DbSkip() )
End

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001TPC  บAutor  ณMicrosiga           บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ ABRE OU FECHA CONEXรO EM TOP DO SERVIDOR CATALOGO.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001TPC(clArqLog,llLog,nlHandle, clTipoNome, clIp, nlPorta, llOpen, nlConPadr, nlConAndr, llUnlink)
Local llok			:= .F.
Local clMsg			:= ""
Local nPilha		:= 0
Local cMyPilha		:= ""
Local cMyAux		:= ""
Local cMyErro		:= ""
Local nLoop			:= 1
Local nTentativas	:= U_MyNewSX6("NCG_000010"						,;
0														,;
"N"																,;
"Quantidade de tentativas que as rotinas de integra็ใo Protheus X Catแlogo de Produtos executarใo em casos em que nใo for possivel a conexao com o TopConnect "	,;
"Quantidade de tentativas que as rotinas de integra็ใo Protheus X Catแlogo de Produtos executarใo em casos em que nใo for possivel a conexao com o TopConnect "	,;
"Quantidade de tentativas que as rotinas de integra็ใo Protheus X Catแlogo de Produtos executarใo em casos em que nใo for possivel a conexao com o TopConnect "	,;
.F. )
Local cPortas	:= U_MyNewSX6("NCG_000005"						,;
""														,;
"C"																,;
"Portas dos TopConnect's para conexใo no servidor Catแlogo de Produtos "	,;
"Portas dos TopConnect's para conexใo no servidor Catแlogo de Produtos "	,;
"Portas dos TopConnect's para conexใo no servidor Catแlogo de Produtos "	,;
.F. )
Local aPortas		:= {}

If !Empty(cPortas)
	aPortas := Separa(cPortas,"|")
EndIf

Default nlHandle  	:= ""
Default clTipoNome  := ""
Default clIp		:= ""
Default nlPorta		:= 0
Default nlConPadr	:= -1
Default nlConAndr	:= -1
Default llUnlink	:= .F.
Default clArqLog	:= ""

If Len(aPortas) == 0 
	aAdd(aPortas,Alltrim(Str(nlPorta)))
EndIf

If nTentativas == 0
	nTentativas := 5
EndIf

If llOpen
	
	If TCIsConnected(nlConAndr)
		
		TcSetConn(nlConAndr)
		TCInternal(5,"*OFF")
		
		llok	:= .T.
		
	Else
		
		For nCont1 := 1 To Len(aPortas)
			
			nlPorta := Val(aPortas[nCont1])
			
			If (nlConAndr := TCLink(clTipoNome,clIp,nlPorta)) < 0
				
				E0001MSG(clArqLog,llLog,@nlHandle,"ERRO - HOUVE ALGUM PROBLEMA NA TENTATIVA DE CONEXAO AO TOPCONNECT...",.T.)
				
				If nTentativas > 0
					
					E0001MSG(clArqLog,llLog,@nlHandle,"Iniciando tentativas de conexใo...")
					
					E0001MSG(clArqLog,llLog,@nlHandle,"Tentativa numero " + Alltrim(Str(nLoop)) + ". ")
					
					While (nlConAndr := TCLink(clTipoNome,clIp,nlPorta)) < 0 .And. nLoop <= nTentativas
						
						If nlConAndr < 0
							E0001MSG(clArqLog,llLog,@nlHandle,"ERRO - O ERRO NA CONEXAO PERSISTE...", .T.)
						EndIf
						
						nLoop++
						
						If nLoop == nTentativas
							Exit
						EndIf
						
						E0001MSG(clArqLog,llLog,@nlHandle,"Aguardando 5 segundos para proxima tentativa...")
						
						Sleep(5000)
						
						E0001MSG(clArqLog,llLog,@nlHandle,"Tentativa numero " + Alltrim(Str(nLoop)) + "... ")
						
					Enddo
					
				EndIf
				
				If nlConAndr >= 0
					
					llok	:= .T.
					
					Exit
					
				EndIf
				
			Else
				
				llok	:= .T.
				
				Exit
				
			EndIf
			
		Next nCont1
		
		If nlConAndr < 0
			
			While !Empty(cMyAux:=ProcName(nPilha))
				
				cMyPilha 	+= cMyAux + Chr(13) + Chr(10)
				cMyAux		:= ""
				nPilha++
				
			EndDo
			
			nPosErro	:= aScan(aMyTopErros,{|x| x[1] == nlConAndr} )
			
			If nPosErro > 0
				cMyErro		:= aMyTopErros[nPosErro][2]
			EndIf
			
			clMsg := "Sr(a) administrador(a),"
			clMsg += "<Br></Br>"
			clMsg += "<Br></Br>"
			clMsg += "<Br></Br>"
			clMsg += "Nใo foi possํvel conectar no TOPCONNECT do servidor CATALOGO DE PRODUTOS:"
			clMsg += "<Br></Br>"
			clMsg += "<Br></Br>"
			clMsg += "<table border='1'> "
			clMsg += "	<tr> "
			clMsg += "		<th>Servidor</th> "
			clMsg += "		<th>Ambiente</th> "
			clMsg += "		<th>Usuแrio</th> "
			clMsg += "		<th>Pilha de chamada</th> "
			clMsg += "		<th>Data/hora</th> "
			clMsg += "		<th>Tipo/Nome</th> "
			clMsg += "		<th>Endere็o</th> "
			clMsg += "		<th>Porta</th> "
			clMsg += "		<th>Erro</th> "
			clMsg += "		<th>Descri็ใo</th> "
			clMsg += "	</tr>"
			clMsg += "	<tr>"
			clMsg += "		<td>" + GetServerIp() + "</td>"
			clMsg += "		<td>" + GetEnvServer() + "</td>"
			clMsg += "		<td>" + GetWebJob() + "</td>"
			clMsg += "		<td>" + cMyPilha + "</td>"
			clMsg += "		<td>" + Dtoc(MsDate())+ " - " + Time() + "</td>"
			clMsg += "		<td>" + clTipoNome + "</td>"
			clMsg += "		<td>" + clIp + "</td>"
			clMsg += "		<td>" + AllTrim(Str(nlPorta)) + "</td>"
			clMsg += "		<td>" + AllTrim(Str(nlConAndr)) + "</td>"
			clMsg += "		<td>" + cMyErro + "</td>"
			clMsg += "	</tr> "
			clMsg += " </table> "
			clMsg += "<Br></Br>"
			clMsg += "<Br></Br>"
			clMsg += "Departamento de Tecnologia Da Informacao"
			clMsg += "<Br></Br>"
			clMsg += "<Br></Br>"
			clMsg += "At."
			
			llok	:= .F.
			
			U_MySndMail("NC GAMES - CATALOGO DE PRODUTOS ONLINE - SERVIDOR " + GetServerIp() + " - AMBIENTE " + GetEnvServer(), clMsg, Nil, Nil, Nil, Nil)
			
		Else
			
			TcSetConn(nlConAndr)
			TCInternal(5,"*OFF")
			
			llok	:= .T.
			
		EndIf
		
	EndIf
	
Else
	
	If llUnlink
		TCUnLink(nlConAndr)
	EndIf
	
	TcSetConn(nlConPadr)
	
EndIf

Return(llok)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณE0001ERR  บAutor  ณMicrosiga           บ Data ณ  04/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ ENVIA O ERRO OCORRIDO PARA O RESPONSมVEL DO SISTEMA CATALOGOบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATALOGO                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


Static Function E0001ERR(nHdlSem,clArqLog,olErro, clEmp, clFil, llLog, nlHandle)

Local clMsg		:= ""
Local cMyAux	:= ""
Local cMyPilha	:= ""
Local nPilha	:= 0

Default nlHandle	:= -1
Default llLog		:= .F.

While !Empty(cMyAux:=ProcName(nPilha))
	
	cMyPilha 	+= cMyAux + Chr(13) + Chr(10)
	cMyAux		:= ""
	nPilha++
	
EndDo

clMsg := "Sr(a) administrador(a),"
clMsg += "<Br></Br>"
clMsg += "<Br></Br>"
clMsg += "<Br></Br>"
clMsg += "Ocorreu um erro na rotina de exporta็ใo de dados para o servidor CATALOGO DE PRODUTOS: "
clMsg += "<Br></Br>"
clMsg += "<Br></Br>"
clMsg += "<table border='1'> "
clMsg += "	<tr> "
clMsg += "		<th>Servidor</th> "
clMsg += "		<th>Ambiente</th> "
clMsg += "		<th>Usuแrio</th> "
clMsg += "		<th>Pilha de chamada</th> "
clMsg += "		<th>Data/hora</th> "
clMsg += "		<th>Erro</th> "
clMsg += "	</tr>"
clMsg += "	<tr>"
clMsg += "		<td>" + GetServerIp() + "</td>"
clMsg += "		<td>" + GetEnvServer() + "</td>"
clMsg += "		<td>" + GetWebJob() + "</td>"
clMsg += "		<td>" + cMyPilha + "</td>"
clMsg += "		<td>" + Dtoc(MsDate())+ " - " + Time() + "</td>"
clMsg += "		<td>" + olErro:ERRORSTACK + "</td>"
clMsg += "	</tr> "
clMsg += " </table> "
clMsg += "<Br></Br>"
clMsg += "<Br></Br>"
clMsg += "Departamento de Tecnologia Da Informacao"
clMsg += "<Br></Br>"
clMsg += "<Br></Br>"
clMsg += "At."

FClose(nHdlSem)

If llLog
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001ERR ("+clEmp+clFil+") - Ocorreu o seguinte erro na rotina de exporta็ใo: " + olErro:ERRORSTACK)
	
	E0001MSG(clArqLog,llLog,@nlHandle,"E0001ERR ("+clEmp+clFil+") - Enviando e-mail informativo para " + clMailCrh)
	
	If U_MySndMail("NC GAMES - CATALOGO DE PRODUTOS ONLINE - SERVIDOR " + GetServerIp() + " - AMBIENTE " + GetEnvServer(), clMsg, Nil, Nil, Nil, Nil)
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001ERR ("+clEmp+clFil+") - E-mail enviado com sucesso !")
	Else
		E0001MSG(clArqLog,llLog,@nlHandle,"E0001ERR ("+clEmp+clFil+") - O E-mail NรO foi enviado com sucesso, pois ocorreu algum erro !")
	EndIf
	
	FClose(nlHandle)
	
Else
	
	U_MySndMail("NC GAMES - CATALOGO DE PRODUTOS ONLINE - SERVIDOR " + GetServerIp() + " - AMBIENTE " + GetEnvServer(), clMsg, Nil, Nil, Nil, Nil)
	
EndIf

Break

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFUNวรO    ณE0001ARQ  บAutor  ณFELIPE V. NAMBARA   บ Data ณ  06/06/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEFETUA A MANIPULAวรO DE ARQUIVOS DE LOG.                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CATUPIRY                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function E0001ARQ(clArquivo, nlHandle2)
Local nlHandle 		:= -1
Local nlTamanho		:= 0
Local clExtensao	:= EXTLOG
Local clDirLog		:= ""
Local nlCont1		:= 1
Local clNewName		:= ""

Default nlHandle2	:= -1
Default clArquivo	:= ""

clDirLog		:= Iif(!Empty(clArquivo),PASTALOG + clArquivo + clExtensao,"")

MakeDir(PASTALOG)

If File(clDirLog) .Or. nlHandle2 >= 0
	
	If nlHandle2 < 0
		
		nlHandle 	:= Fopen(clDirLog,FO_WRITE + FO_COMPAT)
		
	Else
		
		nlHandle	:= nlHandle2
		
	EndIf
	
	nlTamanho 	:= FSeek(nlHandle,0,2)
	
	If nlTamanho/1000 >= TAMLOG
		
		FClose(nlHandle)
		
		While .T.
			
			clNewName	:= PASTALOG + RetFileName(clDirLog)+"_"+AllTrim(Str(nlCont1))+clExtensao
			
			If !File(clNewName)
				
				FRename(clDirLog,clNewName)
				
				nlHandle := FCreate(clDirLog)
				
				Exit
				
			EndIf
			
			nlCont1++
			
		EndDo
		
	EndIf
	
Else
	nlHandle := FCreate(clDirLog)
EndIf

Return(nlHandle)

Static Function Semaforo(cNomeArq,lEmail)
Local lVermelho		:= .T.
Local nHandle		:= -1
Local cEndArq		:= ""
Local cExtArq		:= ".TMP"
Local nContWhile	:= 0
Local clMsg			:= ""
Local lOk			:= .F.
Local cMyAux		:= ""
Local cMyPilha		:= ""
Local nPilha		:= 0
Local lAguardar		:= U_MyNewSX6("NCG_000011"						,;
.F.														,;
"L"																,;
"Define se aguardarแ a execu็ใo das demais instโncias no controle de semแforo das rotinas de exporta็ใo e importa็ใo de dados"	,;
"Define se aguardarแ a execu็ใo das demais instโncias no controle de semแforo das rotinas de exporta็ใo e importa็ใo de dados"	,;
"Define se aguardarแ a execu็ใo das demais instโncias no controle de semแforo das rotinas de exporta็ใo e importa็ใo de dados"	,;
.F. )
Local nTentativas	:= U_MyNewSX6("NCG_000012"						,;
0														,;
"N"																,;
"Define a quantidade de tentativas de execu็ใo no controle de semaf๓ro das rotinas de exporta็ใo e importa็ใo de dados"	,;
"Define a quantidade de tentativas de execu็ใo no controle de semaf๓ro das rotinas de exporta็ใo e importa็ใo de dados"	,;
"Define a quantidade de tentativas de execu็ใo no controle de semaf๓ro das rotinas de exporta็ใo e importa็ใo de dados"	,;
.F. )
Local lMailSemaforo := U_MyNewSX6("NCG_000013"						,;
.F.														,;
"L"																,;
"Define se envia ou nใo e-mail ao administrador quando a rotina entrar no semaforo vermelho "	,;
"Define se envia ou nใo e-mail ao administrador quando a rotina entrar no semaforo vermelho "	,;
"Define se envia ou nใo e-mail ao administrador quando a rotina entrar no semaforo vermelho "	,;
.F. )

Default cNomeArq	:= ""
Default lEmail		:= .T.

cNomeArq := RetFileName(cNomeArq)

MakeDir(PASTALOG)

cEndArq	:= Alltrim(PASTALOG) + AllTrim(cNomeArq) + AllTrim(cExtArq)

cNomeArq := cEndArq

While !Empty(cMyAux:=ProcName(nPilha))
	
	cMyPilha 	+= cMyAux + Chr(13) + Chr(10)
	cMyAux		:= ""
	nPilha++
	
EndDo

If !File(cEndArq)
	FCreate(cEndArq)
EndIf

If ( nHandle := FOpen(cEndArq,FO_READ + FO_EXCLUSIVE) ) > 0
	
	lVermelho := .F.
	
Else
	
	lVermelho := .T.
	
	E0001MSG("",.F.,-1,"SEMAFORO - A ROTINA JA ESTA SENDO EXECUTADA E NAO SERA INICIALIZADA - CATALOGO DE PRODUTOS !",lMailSemaforo)
	
	If lAguardar
		
		While nContWhile <= nTentativas
			
			If ( nHandle := FOpen(cEndArq,FO_READ + FO_EXCLUSIVE) ) > 0
				lVermelho := .F.
				Exit
			Else
				lVermelho := .T.
			EndIf
			
			nContWhile++
			
			Sleep(5000)
			
		EndDo
		
	EndIf
	
EndIf

Return(lVermelho)