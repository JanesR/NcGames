
#DEFINE USADO CHR(0)+CHR(0)+CHR(1)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MC030IDE  �Autor  �Microsiga           � Data �  12/29/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MC030IDE()
Local aStruct:= ParamIXB[1]

//Custo Medio Gerencial Brasil
Aadd(aStruct,{ "CMEDIOGBR", "C",18,0 })
Aadd(aStruct,{ "CTOTALGBR", "C",18,0 })
//Aadd(aStruct,{ "CQUANTBR", "C",18,0 })

Aadd(aHeader, {'',						'FLAGBR',		"", 05,0, ,USADO,'C','SD3', ''}) 
Aadd(aHeader, {'Unit. Gerencial BR',	'CMVUNITBR',	"", 18,0, ,USADO,'C','SD3', ''}) 
Aadd(aHeader, {'Total Gerencial BR',	'CMVTOTBR',	"", 18,0, ,USADO,'C','SD3', ''}) 
//Aadd(aHeader, {'Qde Gerencial BR',		'CMQUANTBR',	"", 18,0, ,USADO,'C','SD3', ''}) 


//Custo medio gerencial Price Protections
Aadd(aStruct,{ "CMEDIOG", "C",18,0 })
Aadd(aStruct,{ "CTOTALG", "C",18,0 })
//Aadd(aStruct,{ "CQUANT", "C",18,0 })

Aadd(aHeader, {'',						'FLAG',		"", 05,0, ,USADO,'C','SD3', ''}) // 'Custo Medio'
Aadd(aHeader, {'Unit�rio Gerencial',	'CMVUNIT',	"", 18,0, ,USADO,'C','SD3', ''}) // 'Custo Medio'
Aadd(aHeader, {'Total Gerencial',		'CMVTOT',	"", 18,0, ,USADO,'C','SD3', ''}) // 'Custo Total'  
//Aadd(aHeader, {'Qde Gerencial',			'CMQUANT',	"", 18,0, ,USADO,'C','SD3', ''}) // 'Custo Total'  
 

Return aStruct

