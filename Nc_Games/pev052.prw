//acompanhamento de pedidos - resultado resumido

User Function PEV052()

Local aReturn  := {}  
 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 //³ Campos a serem mostrados                      ³
 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ               
             
	aAdd( aReturn, "ORDERID" ) 
	aAdd( aReturn, "CUSTOMERCODE" )
	aAdd( aReturn, "CUSTOMERUNIT" )
	aAdd( aReturn, "C5_NOMCLI" )
	aAdd( aReturn, "DELIVERYUNITCODE")
	AAdd( aReturn, "C5_MENSINT")
	AAdd( aReturn, "C5_PEDCLI" )
	aAdd( aReturn, "REGISTERDATE" )
	AAdd( aReturn, "C5_NOTA" )
	AAdd( aReturn, "C5_SERIE" ) 
	AAdd( aReturn, "C5_XSTAPED" )


Return aReturn