#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NfatDSC   ºAutor  ³ Rodrigo            º Data ³  28/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para atualizacao dos descontos a partir do campo    º±±
±±º          ³C5_DESC1. Especifico NC Games                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NfatDSC()
Local _aArea := GetArea()
Local I
_nDescont	:= M->C5_DESC1
/*
_nPosProd	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
_nPosPrTab	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCTAB'} )
_nPosPrUnit	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRUNIT'} )
_nPosValor	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VALOR'} )
_nPosPrcVen	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCVEN'} )
_nPosQtd		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_QTDVEN'} )
_nPosTes		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
_nPosPDesc	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_DESCONT'} )
_nPosVDesc	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VALDESC'} )
*/
//FOR I:=1 TO LEN(ACOLS)	                         
    /*
	n:=I
	aCols[n,nPPrcVen] := FtDescItem(FtDescCab(aCols[n,nPPrUnit],{M->C5_DESC1,M->C5_DESC2,M->C5_DESC3,M->C5_DESC4}),@aCols[n,nPPrcVen],aCols[n,nPDescont],@aCols[n,nPValor],@aCols[n,nPDescont],@aCols[n,nPValDes],@aCols[n,nPValDes],1,aCols[n,nPQtdVen],Nil)
	aCols[n,nPValor]   := a410Arred(aCols[n,nPPrcVen] *aCols[n,nPQtdVen],"C6_VALOR")	
	_nPrReal	:= aCols[I,_nPosPrTab] 	
	_cProduto:= aCols[I,_nPosProd]
	_nIpi		:= Posicione("SB1",1,xFilial("SB1")+_cProduto,"B1_IPI")
	_cTes		:= aCols[I,_nPosTES]
	_nQtdVen	:= aCols[I,_nPosQtd]
	_cIPISN	:= getadvfval("SF4","F4_IPI",XFILIAL("SF4")+_cTes,1,"")
	_nPrVenda	:= _nPrReal
	_nPrVenda*=((100-M->C5_DESC1)/100 )* ((100- GdFieldGet("C6_DESCONT") )/100 )
	nValVPC:=0
	U_PR708VPCPV(i,_cProduto,@nValVPC)
	If nValVPC>0 
		nVlrVPCPV:=_nPrVenda*(nValVPC/100 )
		GdFieldPut('C6_YVALVPC',  nVlrVPCPV*_nQtdVen  ,i)
	EndIf                                                                                             
	_nPrVenda*=( (100-nValVPC)/100 )
	aCols[I,_nPosPrcVen]:= Round(_nPrVenda,2)
	aCols[I,_nPosValor]	:= Round(aCols[I,_nPosPrcVen]*_nQtdVen,2)
	aCols[I,_nPosPDesc]	:= 0
	aCols[I,_nPosVDesc]	:= 0
	*/    
//NEXT
           
U_SetExecDesc({.T.,0})  
A410ReCalc()        
U_SetExecDesc({.F.,0})  


If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif


RestArea(_aArea)

Return(_nDescont)
