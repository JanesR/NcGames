#ifdef SPANISH
	#define STR0001 "Rehace Acumulados"
	#define STR0002 "El objetivo de este programa es rehacer Saldos de Pedidos, Solicitudes y Ordenes de Produccion de Productos, basado en sus respectivos movimientos."
	#define STR0005 "¿Confirma Rehace Acumulados?"
	#define STR0006 "Atencion"
	#define STR0007 "Act."
	#define STR0008 "ATENCION - Esta rutina se ejecutara en MODO EXCLUSIVO, por lo tanto solo esta estacion podra estar activa mientras se procese la rutina de Rehacer Acumulado."
	#define STR0009 "Inicio del procesamiento."
	#define STR0010 "Final del procesamiento."
	#define STR0011 "MATA215:No fue posible abrir todas las tablas de manera exclusiva."
#else
	#ifdef ENGLISH
		#define STR0001 "Redo Accumulated"
		#define STR0002 "The purpose of this program is to remake the Order Balances, Requisitions and Production Orders based on their respective movements."
		#define STR0005 "Confirm Redo Accumulated ?"
		#define STR0006 "Attention"
		#define STR0007 "Upd."
		#define STR0008 "WARNING - This routine will run in EXCLUSIVE MODE, therefore only this workstation can be active while the Redo Accrued routine is being processed."
		#define STR0009 "Beginning of processing."
		#define STR0010 "End of processing."
		#define STR0011 "MATA215:It was not possible to open all tables exclusively."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Refazer A Acumulação", "Refaz Acumulados" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Este programa tem como objectivo refazer os saldos de pedidos, solicitações e ordens de produção dos artigos com base nos seus respectivos movimentos.", "Este programa tem como objetivo refazer os Saldos de Pedidos, Solicitacoes e Ordens de Producao dos Produtos com base nos seus respectivos movimentos." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Confirmar a nova operação de acumular       ?", "Confirma Refaz Acumulados       ?" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Atenção", "Atençäo" )
		#define STR0007 "Proc."
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Atenção - este procedimento será executado em modo exclusivo, portanto apenas esta estação poderá estar activa enquanto estiver a processar o procedimento de refazer acumulado.", "ATENÇÃO - Esta rotina será executada em MODO EXCLUSIVO, portanto somente esta estação podera estar ativa enquanto estiver processando a rotina de Refaz Acumulado." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Fim do processamento.", "Início do processamento." )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Fim do processamento.", "Término do processamento." )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "MATA215:Não foi possível abrir todas as tabelas de forma exclusiva.", "MATA215:Não foi possivel abrir todas as tabelas de forma exclusiva." )
	#endif
#endif
