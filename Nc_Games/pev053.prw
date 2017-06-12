User Function PEV053()

Local aReturn  := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Campos a serem mostrados                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aAdd( aReturn, 'ORDERID' )
aAdd( aReturn, 'CUSTOMERCODE' )
aAdd( aReturn, 'CUSTOMERUNIT' )
AAdd( aReturn, "FREIGHTTYPE" )
AAdd( aReturn, "C5_NOMCLI" )
AAdd( aReturn, "DELIVERYCUSTOMER" )
AAdd( aReturn, "DELIVERYUNITCODE" )
AAdd( aReturn, "PAYMENTPLANCODE")
AAdd( aReturn, "PRICELISTCODE" )
AAdd( aReturn, "DISCOUNT1" )
AAdd( aReturn, { "REGISTERDATE", "D" } )
AAdd( aReturn, { "FREIGHTVALUE", "D" } )
AAdd( aReturn, { "INSURANCEVALUE", "D" } )
AAdd( aReturn, { "NETWEIGHT", "D" } )
AAdd( aReturn, { "GROSSWEIGHT", "D" } )
AAdd( aReturn, "C5_MENSINT")
AAdd( aReturn, "C5_PEDCLI" )
AAdd( aReturn, "C5_XSTAPED" )

aAdd( aReturn, 'ORDERITEM' )
aAdd( aReturn, 'PRODUCTID' )
AAdd( aReturn, { "PRODUCTDESCRIPTION", "N", 0, .F. } )
AAdd( aReturn, { "QUANTITY", "N", 3 } )
AAdd( aReturn, { "C6_PRCTAB", "N", 9, .T. } )
AAdd( aReturn, { "NETUNITPRICE", "N", 9, .T. } )
AAdd( aReturn, { "DISCOUNTPERCENTAGE", "N", 3 } )
AAdd( aReturn, { "C6_VALDESC", "N", 9, .T. } )
AAdd( aReturn, { "NETTOTAL", "N", 0, .F. } )
aAdd( aReturn, 'QUANTITYAPPROVED' )
aAdd( aReturn, 'STATUS' )


Return aReturn
