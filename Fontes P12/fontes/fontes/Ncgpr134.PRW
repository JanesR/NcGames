#include 'protheus.ch'


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Pr134Jb1	�Autor  �Microsiga           � Data �  04/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function Pr134Jb1(aDados)
      
Default aDados := {"01","03"}   

RpcSetEnv(aDados[1],aDados[2])

U_Pr134P0G()

RpcClearEnv()

Return  


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Pr134Jb2	�Autor  �Microsiga           � Data �  04/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function Pr134Jb2(aDados)
      
Default aDados := {"01","03"}   

RpcSetEnv(aDados[1],aDados[2])

U_Pr134Trac()
U_Pr134SZ1()

RpcClearEnv()

Return 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Pr134P0G	�Autor  �Microsiga     		 � Data �  04/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Pr134P0G()
	
	Local oConsulta
	
	oConsulta := ConsultaRastreios():New()
		
	oConsulta:VerificaPedidos() //busca pedidos com rastreios j� no sistema    
	oConsulta := nil
	
	oConsulta := ConsultaRastreios():New()
	oConsulta:BuscaRastMotoBoy() //busca c�digo de rastreio dos pedido motoboy 
	oConsulta := nil 
	
return 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Pr134Trac	�Autor  �Microsiga     � Data �  04/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Pr134Trac()
	
	Local oConsulta
	
	oConsulta := ConsultaRastreios():New()	 
		
	oConsulta:BuscaRastreiosCorreios()  //busca retorno de status Correios 
	oConsulta:ConsultaRastMoto()   // busca retorno de status motoboy

return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Pr134SZ1	�Autor  �Microsiga     � Data �  04/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Pr134SZ1()
	
	Local oConsulta
	
	oConsulta := ConsultaRastreios():New()	 
		
	oConsulta:AtaulizaZ1()
	oConsulta := nil
		
return