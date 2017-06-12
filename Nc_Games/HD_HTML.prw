#include "rwmake.ch"

User Function HD_HTML(cNumHD,dDataHD)

Local aArea		:= getarea()
Local aAreaSZY	:= SZY->(getarea())


cHtm	:= ' <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtm	+= ' <!-- saved from url=(0022)http://internet.e-mail -->
cHtm	+= ' <!doctype html>
cHtm	+= ' <html>
cHtm	+= ' <head>
cHtm	+= '  <meta charset="iso-8859-1">
cHtm	+= '  <title>Atendimento Helpdesk</title>
cHtm	+= ' 
cHtm	+= '  <style type="text/css">
cHtm	+= '  .rodape {
cHtm	+= ' 	font-size: 9px;
cHtm	+= ' 	color: #666;
cHtm	+= ' }
cHtm	+= '     .Cabeçalho {
cHtm	+= ' 	font-size: 16px;
cHtm	+= ' 	color: #666;
cHtm	+= ' }
cHtm	+= '  </style>
cHtm	+= '  </head>
cHtm	+= ' <div align="right">
cHtm	+= '  <p>
cHtm	+= '  <!-- TABELA CABEÇALHO --><span style="font-family: '+'Lucida Grande'+', '+'Lucida Sans Unicode'+', '+'Lucida Sans'+', '+'DejaVu Sans'+', Verdana, sans-serif; font-size: 36px; color: #999">Helpdesk Nc Games</span></p>
cHtm	+= '  <p><span class="Cabeçalho">Número de Atendimento:</span>'+cNumHD+'</p>
cHtm	+= ' </div>
cHtm	+= ' <hr style="border:none; border-top: 1px solid #dfdfdf;  width: 100%; margin: 30px auto">
cHtm	+= ' <table width="85%" border="0" align="center" cellpadding="4" cellspacing="1" style=" font-family:Arial, Helvetica, sans-serif; font-size:10px; ">
cHtm	+= ' <tr>
cHtm	+= '    <th width="10%" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Item</th>
cHtm	+= '    <th width="55%" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;"><p>Ocorrência</p></th>
cHtm	+= '    <th width="15%" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Responsável</th>
cHtm	+= '       <th width="20%" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#FFF;">Data/Hora</th>
cHtm	+= '  </tr>

// Preenche o campo MEMO com o historico do chamado
nSeq	:= 0
DBSELECTAREA("SZY")
DBSETORDER(1)
If dDataHD <> nil
	DBSEEK(XFILIAL("SZY")+cNumHD+DtoS(dDataHD),.T.)
Else
	DBSEEK(XFILIAL("SZY")+cNumHD,.T.)
EndIf

DO WHILE !EOF() .AND. cNumHD == SZY->ZY_CHAMADO
	nSeq++
	cHtm	+= '  <tr>
	cHtm	+= '    <td width="10%" bgcolor="#efefef" style="font-family: Tahoma"><div align="center"><font size="2" face="Tahoma">'+strzero(nSeq,3)+'</font></div></td>
	cHtm	+= '    <td width="55%" bgcolor="#efefef" style="font-family: Tahoma"><div align="left"><font size="2"face="Tahoma">'+SZY->ZY_OCORREN+'</font></div></td>
	cHtm	+= '    <td width="15%" bgcolor="#efefef" style="font-family: Tahoma"><div align="center"><font size="2" face="Tahoma">'+SZY->ZY_ANALIST+'</font></div></td>
	cHtm	+= '    <td width="20%" bgcolor="#efefef" style="font-family: Tahoma"><div align="center"><font size="2"face="Tahoma">'+DTOC(SZY->ZY_DATA)+" "+substr(SZY->ZY_HRINI,1,5)+'</font></div></td>
	cHtm	+= '  </tr>

	DBSELECTAREA("SZY")
	DBSKIP()
ENDDO

cHtm	+= '  </table>
cHtm	+= ' <hr style="border:none; border-top: 1px solid #dfdfdf;  width: 100%; margin: 30px auto">
cHtm	+= '  <div align="center"><span style=" font-family: Verdana, Geneva, sans-serif; font-size: 11px; color: #000; ">WORKFLOW PROTHEUS</span></div>
cHtm	+= ' </body>
cHtm	+= '  <p align="center" class="rodape">Esta é uma mensagem automática, por favor não responda. Para melhor acompanhamento da ocorrência, anote o número do seu chamado.</p>
cHtm	+= '  <p align="center" class="rodape">This is an automated message, please do not answer. To better monitor the occurrence, write down the number on your ticket.</p>
cHtm	+= ' </html>

RestArea(aAreaSZY)
RestArea(aArea)

Return cHtm