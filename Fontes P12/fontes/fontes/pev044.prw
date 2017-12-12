User Function PEV044()

Local nParam	:= PARAMIXB[1]
Local aReturn 	:= {}

Do Case
	Case nParam == 1
		AAdd( aReturn, { "ORDERID", "D" } )
		AAdd( aReturn, { "CUSTOMERCODE", "N", 	{ "BRWCUSTOMER", ;
												{ "CCUSTOMERCODE", "CCODE" }, ;
												{ "CCUSTOMERUNIT", "CUNIT" } ;
												}, ;
												{ "CCODE", "CUNIT", "CDESCRIPTION" } } )
		AAdd( aReturn, "CUSTOMERUNIT" )
		AAdd( aReturn, "FREIGHTTYPE" )                                                                   	    
		AAdd( aReturn, "C5_NOMCLI" ) 
		AAdd( aReturn, { "DELIVERYCUSTOMER", "N", 	{ "BRWCUSTOMER", ;
													{ "CDELIVERYCUSTOMER", "CCODE" }, ;
													{ "CDELIVERYUNITCODE", "CUNIT" } ;
													}, ;
													{ "CCODE", "CUNIT", "CDESCRIPTION" } } )
		AAdd( aReturn, "DELIVERYUNITCODE" )
		AAdd( aReturn, { "PAYMENTPLANCODE", "N", 	{ "BRWPAYMENTPLAN", ;
													{ "CPAYMENTPLANCODE", "CPAYMENTPLANCODE" } ;
													}, ;
													{ "CPAYMENTPLANCODE", "CDESCRIPTIONPAYMENTPLAN" } } )
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
	Case nParam == 2
		AAdd( aReturn, { "ORDERITEM", "D", 2 } )
		AAdd( aReturn, { "PRODUCTID", "N", 	{ "GETCATALOG", ;
											{ "CPRODUCTID", "CPRODUCTCODE" } ;
											}, ;
											{ "CPRODUCTCODE", "CDESCRIPTION" }, 13 } )
		AAdd( aReturn, { "PRODUCTDESCRIPTION", "N", 0, .F. } )
		AAdd( aReturn, { "QUANTITY", "N", 3 } )
		AAdd( aReturn, { "C6_PRCTAB", "N", 9, .T. } )
		AAdd( aReturn, { "NETUNITPRICE", "N", 9, .T. } )
		AAdd( aReturn, { "DISCOUNTPERCENTAGE", "N", 3 } )
		AAdd( aReturn, { "C6_VALDESC", "N", 9, .T. } )
		AAdd( aReturn, { "NETTOTAL", "N", 0, .F. } )
EndCase

Return aReturn
