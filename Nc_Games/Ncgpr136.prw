#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NcgPr132 �Autor  �Microsiga           � Data �  04/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MudaDataFF(dDataFin,dDataFis)

Local dRetFin
Local dRetFis
Local bChave := .F.
Local nMaximo := U_MyNewSx6('NCG_200000','60','N','Quantidade maxima de dias para retroceder fechamento fiscal e financeiro.','','', .F. )
Local dDataAtual:= Date()

dDataFin  := DtoC(dDataFin)
dDataFis  := DtoC(dDataFis)

if(Len(dDataFin)<8 .Or. Len(dDataFis)>8 )
	
	Alert ("Data fiscal informa � invalida")
	
ElseIf (Len(dDataFin)<8 .Or. Len(dDataFis)>8)
	
	Alert ("Data Financeira informa � invalida")
	
Else
	
	dRetFin:= GetMv('MV_DATAFIN')
	dRetFin:= DtoC(dRetFin)
	
	dRetFis:= GetMv('MV_DATAFIS')
	dRetFis:= DtoC(dRetFis)
	
	If(dRetFin!=dDataFin)
		If DateDiffDay(CtoD(dDataFin),dDataAtual) > nMaximo
			Alert("A diferen�a da data financeira atual para a nova data de fechamento n�o pode ser maior que " + CValToChar(nMaximo) +" dias!")
		Else
			PutMv("MV_DATAFIN",dDataFin)
			dRetFin:=GetMv('MV_DATAFIN')
			dRetFin:= DtoC(dRetFin)
			
			If(dRetFin==dDataFin)
				MsgInfo ("Data financeira atualizada com sucesso","Atualizado")
				bChave := .T.
			Else
				Alert ("A atualiza��o da data financeira n�o foi bem sucedida")
			EndIf
		End If
	EndIf
	
	If (dRetFis!=dDataFis)
		If DateDiffDay(CtoD(dDataFis),dDataAtual) > nMaximo
			Alert("A diferen�a da data fiscal atual para a nova data de fechamento n�o pode ser maior que " + CValToChar(nMaximo) +" dias!")
		Else
			PutMv("MV_DATAFIS",dDataFis)
			dRetFis:=GetMv('MV_DATAFIS')
			dRetFis:= DtoC(dRetFis)
			
			If(dRetFis==dDataFis)
				MsgInfo ("Data Fiscal atualizada com sucesso","Atualizado")
				bChave :=  .T.
			Else
				Alert ("A atualiza��o da data fiscal n�o foi bem sucedida")
			EndIf
		End If
	EndIf
	
	If bChave == .F.
		Alert("Nenhuma data foi alterada!")
	EndIf
EndIf

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  fAltDataFF  �Autor  �Flavio Borges      � Data �  09/06/2015 ���
�������������������������������������������������������������������������͹��
���Descri��o �Cria a tela para altera��o dos parametros MV_DATAFIN        ���
���e MV_DATAFIS        													  ���
�������������������������������������������������������������������������͹��
���Uso       �NC GAMES - TECNOLOGIA DA INFORMA��O                         ���
�������������������������������������������������������������������������͹��*/
User Function AltDataFF()

Local oPanel
Local bBtnOk
Local dDataFin  := CtoD("00/00/0000")
Local dDataFis  := CtoD("00/00/0000")
Local cCurrentUset := Alltrim(UsrRetName(__CUSERID))
Local cUsuarios:= U_MyNewSx6('NCG_200001', 'bcosta;rzanatto', 'C', 'Usuarios com permiss�o para usar a rotina de fechamento mensal pelo browser', '', '', .F. )

dDataFin := GetMv('MV_DATAFIN')
dDataFis := GetMv('MV_DATAFIS')

//bBtnOk:= {if(Len(dDatafis)<8 .Or. Len(dDatafis)>8 ) Alert ("Data fiscal informa � invalida") ElseIf (Len(dDatafin)<8 .Or. Len(dDatafin)>8) Alert ("Data Financeira informa � invalida") Else aprtDataFis(dDataFin,dDataFis)EndIf}

SetPrvt("oDlg1","oPanel","oSay1","oSay2","oBtnOk","oBtnCancelar","oDataFis","oDataFin")

oDlg1      := MSDialog():New( 091,232,318,557,"Altera��o de datas de fechamento",,,.F.,,,,,,.T.,,,.T. )
oPanel    := TPanel():New( 004,004,"Altera��o de datas de fechamento",oDlg1,,.F.,.F.,,,148,096,.T.,.F. )
oSay1      := TSay():New( 020,016,{||"Data Fiscal:"},oPanel,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 040,008,{||"Data Financeiro:"},oPanel,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)

oBtnOk      := TButton():New( 060,028,"OK",oPanel,{ ||U_MudaDataFF(dDataFin,dDataFis) },037,012,,,,.T.,,"",,,,.F. )

oBtnCancelar      := TButton():New( 060,076,"Cancelar",oPanel,{ || oDlg1:End() },037,012,,,,.T.,,"",,,,.F. )

oDataFis      := TGet():New( 020,052,{|u| If(PCount()>0,dDataFis:=u,dDataFis)},oPanel,060,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,{|| cCurrentUser $ cUsuarios},.F.,.F.,,.F.,.F.,"","dDataFis",,)
oDataFin      := TGet():New( 040,052,{|u| If(PCount()>0,dDataFin:=u,dDataFin)},oPanel,060,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,{|| cCurrentUser $ cUsuarios},.F.,.F.,,.F.,.F.,"","dDataFin",,)


oDlg1:Activate(,,,.T.)

Return

