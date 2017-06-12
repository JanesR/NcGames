#include "WFHtml.ch"
#include "SIGAWF.CH"

class TWFHtml
	data oFieldDefs
	data cFileName
	data aListValues
	data aListTables
	data aListVal2       
	data cBuffer
	data aPrivWords                  
	data aAttCID              
	data cVersion             
	data lUsaJS
	data aPropertyList
	
	method New( cFile ) CONSTRUCTOR
	method Free()
	method LoadFile( cFile )
	method SaveFile( cFile )
	method LoadStream( cStream )
	method ValByName( cField, uValue)
	method RetByName( cField, uValue, AForce )
	method ExistField( AType, cField )
	method GetPrivWords(cField)
	method HtmlCode() 
	method PrepTB20(AHtml, AItem) 
	method PrepTB20a(AHtml, AItem) 
	method PrepTable(AHtml, AItem) 
	method PrepValues(AHtml, AItem, AIndex) 
	method SaveObj( aObjList )
	method LoadObj( aObjList )
	method FindByName(AType, cField, uValue) 
	method SaveVal(AValList)
	method LoadVal(AValList)
	method NewVersion(lActive)
endclass

method New( cFile ) class TWFHtml
	local oMail := TWFMail():New()
	local cMailBox := WFGetMV( "MV_WFMLBOX", "" )
	local oMailBox := oMail:GetMailBox( cMailBox )
	
	::aPropertyList := { "cFileName", "aListValues", "aListTables", "aListVal2", "cVersion" }
	::lUsaJS := WFGetMV( "MV_WFJAVAS", .f. )
	
	::cVersion := SIGAWF_2_0
	::cFileName := ""
	::aListValues := {{}, {}} // 1-Dados HTML 2-Dados de retorno
	::aListTables := {{}, {}} // 1-Dados HTML 2-Dados de retorno
	::aListVal2   := {{}, {}} // 1-Dados HTML 2-Dados de retorno
	::aPrivWords  := {}
	
	AAdd( ::aPrivWords, { EH_MAILID, { || ::ValByName( EH_MAILID ) }, "%" + EH_MAILID + "%" } )
	AAdd( ::aPrivWords, { "WFMAILTO", iif( oMailBox:lExists, oMailBox:cAddress, "" ), "%WFMailTo%" } )
	AAdd( ::aPrivWords, { "WFVERSION", WFVersion()[6], "!WFVersion!" } )

	::aAttCID := {}							
	::cBuffer := ""
	::cFileName := cFile
	::oFieldDefs := TWFFieldDef():New(Self)

	::LoadFile( cFile )
RETURN

method Free() class TWFHtml
	::oFieldDefs:Free()
	::oFieldDefs := NIL
	::aListValues := NIL
	::aListTables := NIL
	::aListVal2 := NIL
	::aPrivWords := NIL
	::aAttCID := NIL
return

method NewVersion(lActive) class TWFHtml
	local lRet := ::cVersion <> SIGAWF_2_0
	
	if lActive
		::cVersion := SIGAWF_2_0a
	else
		::cVersion := SIGAWF_2_0
	endif           
	
return lRet

method LoadFile( cFile ) class TWFHtml
	if cFile <> nil
		If !File(cFile)
			WFError( STR0003 + ' [' + asString(cFile) + ']', .t. ) // "Nome de arquivo inválido ou inexistente"
		End
		::cFileName := allTrim(cFile)
		::LoadStream( WFLoadFile( ::cFileName, FO_READ + FO_SHARED ) )
	end
return

method LoadStream( cStream ) class TWFHtml
	LOCAL cText, aAux, nInd
	
	default cStream := ""

	::cBuffer := cStream
	::aListTables := {{}, {}}
	::aListValues := {{}, {}}
	::aListVal2 := {{}, {}}
	::aAttCID := {}

	cText := ::cBuffer

	// Prepara caracteres especiais
	cText := StrTran( cText, "%%", "&#37" )
	cText := StrTran( cText, "@@", "&#64" )
	cText := StrTran( cText, "!!", "&#33" )

	// Localiza Variaveis - identifição entre %
	aAux := BuscaVar(cText, "%")
	aAdd(aAux, EH_MAILID)
	aAdd(aAux, EH_RECNOTIMEOUT)
	aAdd(aAux, EH_EMPRESA )
	aAdd(aAux, EH_FILIAL )

	for nInd := 1 to len(aAux)
		if at(".", aAux[nInd]) == 0
			aadd(::aListValues[1], { upper(aAux[nInd]), NIL , "%" + aAux[nInd] + "%"})
		else
			aadd(::aListTables[1], { upper(aAux[nInd]), { }, "%" + aAux[nInd] + "%"})
		endif
	next
	aAux := BuscaVar(cText, "!")
	for nInd := 1 to len(aAux)
		if at(".", aAux[nInd]) == 0
			aadd(::aListValues[1], { upper(aAux[nInd]), NIL , "!" + aAux[nInd] + "!"})
		else
			aadd(::aListTables[1], { upper(aAux[nInd]), { }, "!" + aAux[nInd] + "!"})
		endif
	next

	// Localiza Constantes - identifição entre @
	aAux := BuscaVar(cText, "@")

	for nInd := 1 to len(aAux)
		aadd(::aListVal2[1], { upper(aAux[nInd]), NIL , "@" + aAux[nInd] + "@"})
	next

	::aListTables[2] := aClone(::aListTables[1])
	::aListValues[2] := aClone(::aListValues[1])
	::aListVal2[2]   := aClone(::aListVal2[1])
	
	// Busca tags de imagens e coloca-as como anexo interno
	if WFGetMV( "MV_WFIMAGE", .f. )
		::aAttCID := GeraAttID(@::cBuffer)
	end
               
	::oFieldDefs:Clear()     
	
	for nInd := 1 to len(::aListTables[1])
		::oFieldDefs:AddField(::aListTables[1][nInd][1])
	next
	
	for nInd := 1 to len(::aListValues[1])
		::oFieldDefs:AddField(::aListValues[1][nInd][1])
	next                             
	
RETURN ::cBuffer

method SaveFile( cFile ) class TWFHtml
	LOCAL Result := .F.
	If cFile == NIL
		WFError( STR0001 ) //"Não foi possivel gravar o arquivo. Nome não identificado"
	Else
		cFile := ChgFileExt( lower( cFile ), ".htm" )
		Result := WFSaveFile(  cFile, ::HtmlCode() )
	End
RETURN Result
                 
method ExistField( AType, cField ) class TWFHtml
	local nPos, Result := .F.
	
	cField := upper(cField)
	
	Do Case
		Case ( nPos := AScan( ::aListTables[AType], {|x| x[1] == cField } ) ) > 0
			Result := .T.
		Case ( nPos := AScan( ::aListValues[AType], {|x| x[1] == cField } ) ) > 0
			Result := .T.
		Case ( nPos := AScan( ::aListVal2[AType],   {|x| x[1] == cField } ) ) > 0
			Result := .T.
	End
return Result
	
method ValByName( cField, uValue ) class TWFHtml
return (::FindByName(1, cField, uValue))

method RetByName( cField, uValue, AForce) class TWFHtml
	local uResult
	default AForce = .f.
	if (uValue != nil) .and. (!AForce)
		WFError( formatStr( STR0005, cField), .t.)
	endif
	if (uResult := ::FindByName(2, cField, uValue)) == nil
		uResult := ::ValByName( cField, uValue )
	end
return uResult
  
method FindByName(AType, cField, uValue) class TWFHtml
	LOCAL Result := NIL
	LOCAL nPos := 0, nMax, nC
	LOCAL aTables, aValues

	cField := Upper( cField )
	If uValue == NIL
		Do Case
			Case ( nPos := AScan( ::aListTables[AType], {|x| x[1] == cField } ) ) > 0
				Result := ::aListTables[AType][ nPos,2 ]
			Case ( nPos := AScan( ::aListValues[AType], {|x| x[1] == cField } ) ) > 0
				Result := ::aListValues[AType][ nPos, 2 ]
			Case ( nPos := AScan( ::aListVal2[AType],   {|x| x[1] == cField } ) ) > 0
				Result := ::aListVal2[AType][ nPos, 2 ]
			Case ( nPos := AScan( ::aPrivWords,  {|x| x[1] == cField } ) ) > 0
				Result := ::aPrivWords[ nPos, 2 ]
			otherwise
				WFError( formatStr( STR0002, { cField, ::cFileName } ), .F.)
		End
	else           
		if valType(uValue) == "B"
		   uValue := eval(uValue)
		endif
			       
		if At( ".", cField ) > 0
		
			if ( nPos := aScan( ::aListTables[AType],{ |x| x[1] == cField } ) ) > 0
				Result := AClone( ::aListTables[AType][nPos, 2] )
				::aListTables[AType][nPos, 2] := AClone(uValue)
			end
			
		else
			do case
				Case (nPos := AScan( ::aListValues[AType],{ |x| x[1] == cField } ) ) > 0
					Result := ::aListValues[AType][ nPos, 2 ]
					::aListValues[AType][ nPos, 2 ] := uValue
				Case (nPos := AScan( ::aListVal2[AType],{ |x| x[1] == cField } ) ) > 0
					Result := ::aListVal2[AType][ nPos,2 ] 
					::aListVal2[AType][ nPos,2 ] := uValue
				otherwise
					WFError(formatStr( STR0002, { cField, ::cFileName }), .F.)
			end
		endif
	endif
RETURN Result

method PrepTB20(AHtml, AItem) class TWFHtml
	local nPosI, nPosF, nInd, cLinhaTR := ""
	         
	nPosI := at(AItem[3], AHtml) 
	if nPosI <> 0 
		for nInd := nPosI to 1 step - 1
			if upper(substr(AHtml, nInd, 3)) == "<TR"
				nPosI := nInd
				nPosF := at("</TR>", upper(substr(AHtml, nPosI))) + 4
				cLinhaTR := substr(AHtml, nPosI, nPosF)
				exit
			endif
		next
	endif
return cLinhaTR

method PrepTB20a(AHtml, AItem) class TWFHtml
	local nPosI, nPosF, nInd,cLinhaTR := ""
	         
	nPosI := at(AItem[3], AHtml) 
	if nPosI <> 0 
		for nInd := nPosI to 1 step - 1
			if upper(substr(AHtml, nInd, 6)) == "<TBODY"
				nPosI := nInd
				nPosF := at("</TBODY>", upper(substr(AHtml, nPosI))) + 3
				while substr(AHtml,nPosI,1) <> ">" 
					nPosI++
				enddo
				nPosI++
				nPosF--
				cLinhaTR := substr(AHtml, nPosI, nPosF)
				exit
			endif
		next
	endif
return cLinhaTR

method PrepTable(AHtml, AItem) class TWFHtml
	if ::cVersion == SIGAWF_2_0
		cLinhaTR := ::PrepTB20(AHtml, AItem)
	else
		cLinhaTR := ::PrepTB20a(AHtml, AItem)
		if empty(cLinhaTR)
			cLinhaTR := ::PrepTB20(AHtml, AItem)
		endif
	endif
return cLinhaTR

static function AddHiddenVar(AHiddenVar, AVarName, AValue)
	AVarName := upper(AVarName)
	if ascan(AHiddenVar, { |x| upper(x[1]) == AVarName }) == 0
		aAdd(AHiddenVar, { AVarName, AValue})
	endif	
return

method HtmlCode() class TWFHtml
	local cHTML, nTables, nRow, aCpos, nTotRows, nPos
	LOCAL nInd, aAux, aLinhas := {}, aHiddenVar := {}
	local cHtmlAux, aAux2, cHiddenVar, cLinha := ""
	local aValues
	
	cHTML := StrTran( ::cBuffer, "%%", "&#37" ) // converte %% para %
	cHTML := StrTran( cHTML, "@@", "&#64" ) // converte @@ para @
	cHTML := StrTran( cHTML, "!!", "&#33" ) // converte @@ para @
	                                   
	// Troca as variaveis/constantes privativas
//	aEval(::aPrivWords, { |x| ::PrepValues(@cHtml, x)})
	aValues := AClone( ::aPrivWords )
	for nInd := 1 to Len( aValues )
		::PrepValues(@cHtml, aValues[ nInd ] )
	next

	// Troca as constantes (não tabulares)
	//	aEval(::aListVal2[1], { |x| cHTML := StrTran(cHTML, x[3], asString(x[2]))})
	aValues := AClone( ::aListVal2[1] )
	for nInd := 1 to Len( aValues )
		cHTML := StrTran( cHTML, aValues[3], asString( aValues[2] ) )
	next
	                          
	// Troca as variaveis (não tabulares)
//		aEval(::aListValues[1], { |x| iif(::PrepValues(@cHtml, x),  AddHiddenVar(aHiddenVar, x[1], x[2]), nil)})
	aValues := AClone( ::aListValues[1] )
	for nInd := 1 to Len( aValues )
		if ::PrepValues( @cHtml, aValues[ nInd ] )
			if at( "!", aValues[ nInd,3 ] ) == 0
				AddHiddenVar( aHiddenVar, aValues[ nInd,1], aValues[ nInd,2] )
			end
		end
	next
    
	// Processa valores tabulares
	aAux := { }           
	aLinha := { "", ""}
	aFinal := {}
	aValues := ::aListTables[1]
	
	for nInd := 1 to len( aValues )
		cTableName := substr( aValues[nInd,1], 1, at(".", aValues[nInd,1] )-1)
		nPos := aScan(aAux, { |x| x[1] == cTableName})
		if nPos == 0
			aAdd(aAux, { cTableName , {}, len( aValues[nInd,2] ) } )
			nPos := len(aAux)
		endif
			
		for nRow := 1 to len( aValues[nInd,2] )
			aAdd(aAux[nPos,2], { aValues[nInd,1], aValues[nInd,2][nRow], aValues[nInd,3], nRow})
		next
	next
	
	if len(aAux) <> 0
		for nTables := 1 to len(aAux)
			nTotRows := aAux[nTables][3]
			if nTotRows == 0
				loop
			endif

			aCpos := aAux[nTables][2]         
			
			cLinha := ::PrepTable(cHtml, aCpos[1])
			aLinhas := {}
			for nRow := 1 to nTotRows
				aAdd(aLinhas, cLinha)
			next

			for nInd := 1 to len(aCpos)
				cAux := aLinhas[aCpos[nInd][4]]
				if ::PrepValues(@cAux, { aCpos[nInd][1], aCpos[nInd][2], aCpos[nInd][3]}, "."+alltrim(str(aCpos[nInd][4])))
					if at( "!", aCpos[ nInd,3 ] ) == 0
						AddHiddenVar(aHiddenVar, aCpos[nInd][1] + "."+alltrim(str(aCpos[nInd][4])), aCpos[nInd][2])
					end
				endif                          
				aLinhas[aCpos[nInd][4]] := cAux
			next
			
			cAux := ""
 
      	aEval(aLinhas, { |x| cAux += x })    
      	cHTML := StrTran(cHTML, cLinha, cAux)
		next
	
	endif                                   
	
	// Insere rotinas espeficias para o controle do HTML
	if ( nPos := at("<FORM", upper(cHtml))) > 0
		nPos := nPos + ( at(">", substr(cHtml, nPos)) -1 )
		cHiddenVar := ""
		aEval(aHiddenVar, { |x| cHiddenVar += ;
					'<input type=hidden name="' + X[1] + '" value="' + asString(X[2]) +'">'+chr(13)+chr(10) })
		cHtml := substr(cHtml, 1, nPos) ;
					 + cHiddenVar + substr(cHtml, nPos+1)
		if ::lUsaJS
			if ( nPos := at("</FORM>", upper(cHtml)) ) > 0
				cHtml := Stuff( cHtml,nPos -1,1,::oFieldDefs:GetJSCode() )
//				cHtml := substr(cHtml, 1, nPos) + ::oFieldDefs:GetJSCode() + substr(cHtml, nPos)	
			end
		endif
	endif
RETURN cHtml

method GetPrivWords(cField) class TWFHtml 
	LOCAL Result := NIL
	LOCAL nPos := 0
	
	cField := Upper( cField )
	If ( nPos := aScan( ::aPrivWords, { |x| upper( x[1] ) == cField } ) ) > 0
		Result := ::aPrivWords[ nPos,2 ]
	Else
		Result := NIL
	End
RETURN Result

method PrepValues(AHtml, AItem, AIndex) class TWFHtml
	Local nPos1, nPos2, nC1, nC2
	Local cAux, cVal, cAlias, lHidden, cValDef := "", lBuscaName
	
	lHidden := .T.
  	default AIndex = ""
  	
	while .t.
		if ( nPos1 := at(upper(AItem[3]), upper(AHtml)) ) == 0
			exit
		endif
		if valType(AItem[2]) == "A"
			for nC1 := nPos1 to 1 step - 1              
				cAux := upper(substr(AHtml, nC1, 7))
				if cAux == "<OPTION"           
					nPos2 := nC1 + at('</OPTION>', upper(substr(AHtml, nC1)))
					AHtml := substr(AHtml, 1, nC1 - 1) + AItem[3] + substr(AHtml, nPos2+8)
					cVal := ""         
					cValDef := ""
					for nC2 := 1 to len(AItem[2])
						if left(AItem[2, nC2], 1) = '*'
							cValDef := substr(AItem[2,nC2], 2)
							cVal += "<option>" + cValDef + "</option>"
						else
							cVal += "<option>" + AItem[2,nC2] + "</option>"
						endif
					next							
					AItem[2] := cValDef
					exit
				elseif left(cAux, 1) == "<" 
					exit
				endif
			next             

			for nC1 := nC1 to 1 step - 1              
				cAux := upper(substr(AHtml, nC1, 4))
				if cAux == "NAME"				    
					//Tratamento para a duplicidade da propriedade name, quando é informado o name no template. 
					AHtml := substr(AHtml, 1, nC1 - 1) + ;
								'name="' + AItem[1] + AIndex + '" TEMPLATE_' + ;
								substr(AHtml, nC1)                                 
					
					lHidden := .F.					
					exit                               
				endif
			next
		elseif left(AItem[3], 1) == "%" // não é uma constante 
			lBuscaName := .F.
			cVal := AItem[2]                   
			for nC1 := nPos1 to 1 step - 1              
				cAux := upper(substr(AHtml, nC1, 4))
				if cAux == "NAME"
					//Tratamento para a duplicidade da propriedade name, quando é informado o name no template. 
					AHtml := substr(AHtml, 1, nC1 - 1) + ;
								'name="' + AItem[1] + AIndex + '" TEMPLATE_' + substr(AHtml, nC1 )
					lHidden := .F.
							
					exit
				elseif cAux == "<OPT"
				   lBuscaName := .T.
				elseif !lBuscaName .and. left(cAux, 1) == "<" 
					exit
				endif
			next
		elseif left(AItem[3], 1) == "!" // não é uma constante 
			lHidden := .T.
			cVal := AItem[2]                   
		elseif left(AItem[3], 1) == "@"
			lHidden := .F.
			cVal := AItem[2]                   
		endif	
                 
		if empty(cVal)
			cField := strTran(left(AItem[3], 1), "")
			if ( nPos1 := at("_", cField) ) > 0
				cAlias := left(cField, nPos1 - 1)
				if len(cAlias) <> 3
					cAlias := "S" + cAlias
				endif
				if (select(cAlias) != 0) .and. (&cAlias.->(FieldPos(cField)) != 0)
					cVal := cAlias + "->" + cField
					cVal := &(cVal)
				else
					cVal := ""
				endif	
			endif
		end
		
		cVal := asString(cVal)

		if( nPos1 := at(upper(AItem[3]), upper(AHtml)) ) > 0
			AHTML := stuff(AHTML, nPos1, len(AItem[3]), cVal)
			// Tratamento do checkbox
			cVal := Upper( AllTrim( cVal ) )
			if ( cVal == "ON" ) .or. ( cVal == "OFF" )
				// Extrai os delimitadores: "<input" e ">"
				cInput := Left( AHTML,nPos1 )
				nPos1 := Rat( "<input",Lower(cInput) )
				cInput := SubStr( AHTML,nPos1 )
				nPos2 := At( ">",cInput )
				cInput := SubStr( AHTML,nPos1,nPos2 )
				if At( "checkbox", Lower( cInput ) ) > 0
					do case
					case cVal == "ON"
						if At( " checked", Lower( cInput ) ) == 0
							cInput := Left( cInput, Len( cInput ) -1 ) + " checked>"
						end
					case cVal == "OFF"
						if At( " checked", Lower( cInput ) ) > 0
							cInput := Stuff( cInput, At( " checked", Lower( cInput ) ), 8, "" )
						end
					end
					AHTML := Stuff( AHTML, nPos1, nPos2, cInput )
				end
			end
		end
	enddo
return (lHidden)

// *--< Método SaveObj - Salva as propriedades do objeto >----------------------------*
method SaveObj( aObjList ) class TWFHtml
return WFSaveObj( self, ::aPropertyList, aObjList )

// *--< Método LoadObj - Carga das propriedades do objeto >---------------------------*
method LoadObj( aObjList ) class TWFHtml
return WFLoadObj( self, aObjList )

// *--< Método SaveVal - Salva as variaveis do HTML >---------------------------------*
method SaveVal(AValList) class TWFHtml
	WFSaveObj(Self,  { 'aListValues', 'aListTables', 'aListVal2'}, AValList)
return .t.

// *--< Método LoadVal - Restaura os valores do HTML >--------------------------------*
method LoadVal(AValList) class TWFHtml
	local aAux, nInd
	
	if len(AValList) <> 0
		aAux := AValList[1][3][1]
		for nInd := 1 to len(aAux)
			if ::ExistField(1, aAux[nInd, 1])
				::ValByName( aAux[nInd, 1], aAux[nInd, 2])
			endif
		next	
		aAux := AValList[2][3][1]
		for nInd := 1 to len(aAux)
			if ::ExistField(1, aAux[nInd, 1])
				::ValByName( aAux[nInd, 1], aAux[nInd, 2])
			endif
		next	
	endif
return

//--< Busca variaveeis no AText, delimitadas pelo ASeparador >-----------------------
static function BuscaVar(AText, ASeparador)
	local nPos, aResult := {}, cIdent, lConcat, cAuxAnt, cAuxPos, lIgnorar

	if at(ASeparador, AText) > 0
		lConcat := .f. 
		lIgnorar := .f.
		cIdent := ''      
//MsgStop('Buscando: ' + ASeparador)
		for nPos := 1 to len(AText)
			if lConcat
				if substr(AText, nPos, 1) == ASeparador
					if ascan(aResult, { |x| upper(cIdent) == upper(x) }) == 0
						AAdd(aResult, cIdent)
//	msgStop(cIdent)
					endif
					lConcat := .f.
					cIdent := ''
				else
					cIdent := cIdent + substr(AText, nPos, 1)
				endif       
			elseif lIgnorar
				if upper(substr(AText, nPos, 9)) == '</SCRIPT>'
					lIgnorar := .f.
				endif
			elseif upper(substr(AText, nPos, 7)) == '<SCRIPT'
					lIgnorar := .t.
			elseif substr(AText, nPos, 1) == ASeparador
				cAuxAnt := substr(AText, nPos - 1, 1)
				cAuxPos := substr(AText, nPos + 1, 1)
			
				if cAuxAnt == '<'        .or. IsDigit(cAuxAnt) .or. ;
					upper(cAuxPos) < 'A'  .or. upper(cAuxPos) > 'Z'
				else
					lConcat := .t.
				endif
			endif
		next
	endif
return aResult

//--< Efetua a soma da variavel especificada em AVarName >----------------------
static function WFSoma(AHtml, AVarName)
	local nRet := 0, uValue

	uValue := AHtml:ValByName(AVarName)
	if valType(uValue) == "A"
		aEval(uValue, { |x| nRet := nRet + x } )
	else
		nRet := uValue
	endif
return nRet

//--< Efetua calcula da média especificada em AVarName >-----------------------------
static function WFMedia(AHtml, AVarName, AIgnoreZero)
	local nRet := 0, uValue, nCount := 0

	default AIgnoreZero := .T.
	
	uValue := AHtml:ValByName(AVarName)
	if valType(uValue) == "A"
		aEval(uValue, { |x| nRet := nRet + x , nCount := nCount + iif((AIgnoreZero .and. x == 0), 0, 1) } )
		nRet := nRet / nCount
	else
		nRet := uValue
	endif
return nRet

//--< Retorna um array preenchido com a mesma qtde de elementos de AVarBase >----
static function WFPreenche(Ahtml, AVarBase, AValue)
	local uValue, uRet := {} , nInd

	uValue := AHtml:ValByName(AVarBase)
	aEval(uValue, { || aAdd(uRet, AValue) } )
	
return uRet
	

//--< Efetua contagem especificada em AVarName >---------------------------------
static function WFConta(AHtml, AVarName, AIgnoreZero)
	local uValue, nCount := 0

	default AIgnoreZero := .T.
	
	uValue := AHtml:ValByName(AVarName)
	if valType(uValue) == "A"
		aEval(uValue, { |x| nCount := nCount + iif((AIgnoreZero .and. x == 0), 0, 1) } )
	else
		nCount := 1
	endif
return nCount

//--< Gera sequencia >-----------------------------------------------------------
static function WFSequencia(AHtml, AVarName, AValIni, AValFinal, APasso)
	local aAux := {}

	default APasso := 1
	
	if valType(uValue) == "A"
		while AValIni <= AValFinal
			aAdd(aAux, AValIni)
			AValIni += APasso
		end    
		AHtml:ValByName(AVarName, aAux)
	endif
return 

//--< Busca tags de imganes e gera o CID para elas >---------------------------------
static function ProcTag(AText, ATagName, AIndex)
	local cAux := upper(AText), aResult := {}, nPos, nPosI
	local cAttFile 

	while .t.
		nPosI := at(upper(ATagName), cAux)
		if nPosI != 0
			cAux := substr(cAux, nPosI)
			nPos := at('=', cAux)
			if !( upper(aTagName) == AllTrim( Left( cAux, nPos -1 ) ) )
				cAux := substr( cAux,nPos +1 )
				loop
			end
			cAttFile := cAux
			nPosI += nPos + 1
			cAttFile := substr(cAttFile, nPos+1)
			nPos := at('>', cAttFile)
			cAttFile := substr(cAttFile, 1, nPos)
			if (nPos := at(' ', cAttFile)) != 0
				cAttFile := substr(cAttFile, 1, nPos)
			endif

			cAttFile := StrTran(StrTran(cAttFile, '"', ""),"'","")
			cAttFile := StrTran(StrTran(cAttFile,">",""), chr(13),"")
			cAttFile := StrTran(cAttFile,chr(10),"")
			aAdd(aResult, allTrim(cAttFile))
			aAdd(aResult, "SIGAWF$CIDATT$" + int2Hex(seconds(), 6) + "$" + int2Hex(AIndex,2))
		endif              
		exit
	end
return aResult

static function GeraAttID(AText)
	local cAux := AText, aResult := {}, nPos, aAux

	aAux := ProcTag(cAux, 'BACKGROUND', len(aResult))

	if len(aAux) != 0
		aAdd(aResult, { aAux[1], aAux[2] })
		nPos := at(aAux[1], upper(AText))
		cAux := substr(AText, nPos + len(aAux[1]))
		AText := substr(AText, 1, nPos - 1) + 'cid:' + aTail(aResult)[2] + cAux
	endif

	aAux := ProcTag(cAux, 'SRC', len(aResult))

	if len(aAux) != 0
		aAdd(aResult, { aAux[1], aAux[2] })
		nPos := at(aAux[1], upper(AText))
		cAux := substr(AText, nPos + len(aAux[1]))
		AText := substr(AText, 1, nPos - 1) + 'cid:' + aTail(aResult)[2] + cAux
	end

return aResult

