User Function PEV043()

Local cParam  := PARAMIXB[1]
Local aReturn  := {}

Do Case
	Case cParam == 1
		aAdd( aReturn, "ORDERID" )
		aAdd( aReturn, "CUSTOMERCODE" )
		aAdd( aReturn, "CUSTOMERUNIT" )
		aAdd( aReturn, "FREIGHTTYPE" )
		aAdd( aReturn, "C5_NOMCLI")
		aAdd( aReturn, "DELIVERYCUSTOMER")
		aAdd( aReturn, "DELIVERYUNITCODE")
		aAdd( aReturn, "PAYMENTPLANCODE" )
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
	Case cParam == 2
		aAdd( aReturn, "ORDERITEM" )
		aAdd( aReturn, "PRODUCTID" )
		aAdd( aReturn, "PRODUCTDESCRIPTION" )
		aAdd( aReturn, "QUANTITY" )
		AAdd( aReturn, { "C6_PRCTAB", "N", 9, .T. } )
		aAdd( aReturn, "NETUNITPRICE" )
		AAdd( aReturn, { "DISCOUNTPERCENTAGE", "N", 3 } )
		AAdd( aReturn, { "C6_VALDESC", "N", 9, .T. } )
		aAdd( aReturn, "NETTOTAL" )
		aAdd( aReturn, "QUANTITYAPPROVED" )
		aAdd( aReturn, "QUANTITYDELIVERED" )
		aAdd( aReturn, "FISCALOPERATION" )
		aAdd( aReturn, "DELIVERYDATE" )
EndCase

Return aReturn
