#INCLUDE "rwmake.ch"

//Khalil

User Function CADMVZZ6

	Private cCadastro := "Manutenção Metas Vendedores"
    private nCount
    PRIVATE cNome
    PRIVATE nCOD
    PRIVATE mMeta
    PRIVATE aMeta 
    PRIVATE qMeta
    PRIVATE MsgSender:= "Usuário sem permissão de acesso à rotina, favor entrar em contato com o departamento de T.I"
	
	Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
	             {"Visualizar","AxVisual",0,2} ,;
	             {"Incluir","U_REVISAOVEF",0,3} ,;
	             {"Revisão","U_REVISAOVEF",0,4} ,;
	             {"Excluir","MSGINFO(MsgSender)",9,5} }// AxDeleta
	             //{"Excluir","AxDeleta",0,5} }   //remover função posteriormente
	            
	Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBloc
	Private cString := "ZZ6"
	dbSelectArea("ZZ6")
	dbSetOrder(3) // ZZ6_FILIAL+ZZ6_COD+ZZ6_MES+ZZ6_ANO
	

	
	dbSelectArea(cString)
	mBrowse( 6,1,22,75,cString)

Return

//====================================================================  
USER FUNCTION REVISAOVEF(cAlias,nReg,nOpc) 
	Local aAreaZZ6:=ZZ6->(GetArea()) 
	Local cRevisao
	Local nRecZZ6

		cNome := ZZ6->ZZ6_NOME             //ATRIBUI OS VALORES PARA AS FUNçõES APARTIR DA LINHA 85
		nCOD  := ZZ6->ZZ6_COD   
		mMeta := ZZ6->ZZ6_MMESTA
		aMeta := ZZ6->ZZ6_AMETA
		qMeta := ZZ6->ZZ6_QMETA 
	
    if nOpc == 4 
      //AxInclui( <cAlias>, <nReg>, <nOpc>, <aAcho>, <cFunc>, <aCpos>, <cTudoOk>, <lF3>, <cTransact>, <aButtons>, <aParam>, <aAuto>, <lVirtual>, <lMaximized>)
      //return "99" //STRZERO(VAL(ALLTRIM(str(nCount))),2,0)   
      	private cChave := ZZ6->(ZZ6_FILIAL + ZZ6_COD + ZZ6_MMESTA + ZZ6_AMETA)  
      	//alert(cChave)
		private nCount := 1
		
		DBSETORDER(3)
        dbseek(xFilial("ZZ6"))
		WHILE !EOF()     // Executa enquanto o cursor da área de trabalho ativa não indicar fim de arquivo
		       //ALERT(cChave + "  " + ZZ6->(ZZ6_FILIAL + ZZ6_COD + ZZ6_MMESTA + ZZ6_AMETA ))
		       if cChave == ZZ6->(ZZ6_FILIAL + ZZ6_COD + ZZ6_MMESTA + ZZ6_AMETA)
			      nCount = nCount + 1  
		       endif
		      
		      
		     ZZ6->(dbskip() )
		ENDDO    
		  
      	nCountR := nCOunt
     
      	
		
    	AxInclui(cAlias,nRecZZ6,nOpc,,,,"U_CADMVTOK('A',nCount)") 
    	
    	
    	ELSE 
    	
    	AxInclui(cAlias,nRecZZ6,nOpc,,,,"U_INCLUIAX('A',nCount)")// Função para avaliar os campos
    	   	
    endif    
//====================================================================    
USER FUNCTION CADMVTOK(cOpcao, nCount)
	Local lReturn :=.T.  
	
	If  cOpcao=="A" //CONDIÇÃO
	   //alert(str(nCount)) 
	   M->ZZ6_REV:= STRZERO(VAL(ALLTRIM(str(nCount))),2,0)
	   //alert("teste")
	EndIf	
Return lReturn
//====================================================================   

USER FUNCTION COTINI  //RETORNA O NUMERO DE REVISõES 
RETURN STRZERO(VAL(ALLTRIM(str(nCountR))),2,0) 
//---------------------------------------------
USER FUNCTION RETCOD //RETORNA O CÓDIGO DO VENDEDOR NA TELA DE REVISÃO 
RETURN nCOD 
//---------------------------------------------
USER FUNCTION RETNOME//RETORNA O NOME DO VENDEDOR NA TELA DE REVISÃO
RETURN cNome 
//---------------------------------------------
USER FUNCTION RETMMETA//RETORNA O MES META NA TELA DE REVISÃO
RETURN mMeta
//---------------------------------------------
USER FUNCTION RETAMETA   //RETORNA O ANO META NA TELA DE REVISÃO
RETURN aMeta
 
USER FUNCTION RETQMETA   ////RETORNA O QMETA NO FORMATO Q + "TRIMESTRE"  NA TELA DE REVISÃO  Ex.Q1, Q2, Q3 E Q4
RETURN qMeta
//---------------------------------------------


USER FUNCTION VALIDQMETA() //Retorna QM
	LOCAL QM
	QM := IIF(INCLUI,"Q"+iif(STRZERO(MONTH(MSDATE()),2)$"01.02.03","1",iif(STRZERO(MONTH(MSDATE()),2)$"04.05.06","2",iif(STRZERO(MONTH(MSDATE()),2)$"07.08.09","3","4"))),U_RETQMETA())
	return QM   	 
 
//---------------------------------------------

USER FUNCTION INCLUIAX(cOpcao, nCount)
	Local Returnt :=.T.  
	Local ChaveV := "" 
	Local ChaveR := ""
	DBSETORDER(3) 
	
		ChaveV = ZZ6->(xfilial("ZZ6") + M->ZZ6_COD + M->ZZ6_MMESTA + M->ZZ6_AMETA)
        dbseek(xFilial("ZZ6"))
		WHILE !EOF()     // Executa enquanto o cursor da área de trabalho ativa não indicar fim de arquivo
		       //ALERT(cChave + "  " + ZZ6->(ZZ6_FILIAL + ZZ6_COD + ZZ6_MMESTA + ZZ6_AMETA )) 
		       ChaveR := ZZ6->(ZZ6_FILIAL + ZZ6_COD + ZZ6_MMESTA + ZZ6_AMETA) 
		      
		       if ChaveV == ChaveR
			      MSGALERT("O vendedor com essas informações já está em uso, favor mudar os dados digitados") 
			      Returnt := .F. 
			      Return Returnt 
		       endif
				ZZ6->(dbskip() )
		ENDDO                      



Return Returnt






