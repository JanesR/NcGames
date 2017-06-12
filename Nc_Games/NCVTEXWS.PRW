#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

//Valores para cUrlWS
//"http://webservice-proximogames.vtexcommerce.com.br
//"http://webservice-uzgames.vtexcommerce.com.br
/* ===============================================================================
WSDL Location    \system\Service.xml
Gerado em        02/05/15 19:08:31
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _JQUYRHV ; Return  // "dummy" function - Internal Use 

/* ====================== SERVICE WARNING MESSAGES ======================
Definition for guid as element FOUND AS [tns:guid]. This Object COULD NOT HAVE RETURN.
====================================================================== */

/* -------------------------------------------------------------------------------
WSDL Service WSVtex
------------------------------------------------------------------------------- */

WSCLIENT WSVtex

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD StockKeepingUnitImageRemove
	WSMETHOD StockKeepingUnitImageRemoveByName
	WSMETHOD StockKeepingUnitEspecificationListBySkuId
	WSMETHOD ProductEspecificationListByProductId
	WSMETHOD StockKeepingUnitComplementInsertUpdate
	WSMETHOD ProductEspecificationInsert
	WSMETHOD ProductEspecificationInsertByList
	WSMETHOD ProductEspecificationInsertByFieldId
	WSMETHOD ProductEspecificationInsertByListFieldIds
	WSMETHOD ProductEspecificationTextInsertByFieldId
	WSMETHOD StockKeepingUnitEspecificationInsertByList
	WSMETHOD StockKeepingUnitEspecificationInsert
	WSMETHOD ProductSupplierGetCNPJ
	WSMETHOD ProductSetSimilarCategory
	WSMETHOD StockKeepingUnitEspecificationInsertByListFieldId
	WSMETHOD StoreList
	WSMETHOD StoreGet
	WSMETHOD StockKeepingUnitEspecificationInsertByFieldId
	WSMETHOD GiftCardInsertUpdate
	WSMETHOD GiftCardTransactionItemSetStatus
	WSMETHOD GiftCardTransactionItemInsert
	WSMETHOD GiftListGet
	WSMETHOD GiftListGetByClientEmail
	WSMETHOD GiftListGetByClientCpf
	WSMETHOD GiftListGetType
	WSMETHOD GiftListGetByCreatedDate
	WSMETHOD GiftListGetAllFromCreatedDateAndId
	WSMETHOD GiftListGetAllBetweenEventDateIntervalAndId
	WSMETHOD GiftListGetByModifiedDate
	WSMETHOD GiftListGetAllFromModifiedDateAndId
	WSMETHOD GiftListGetByGifted
	WSMETHOD GiftListInsertUpdate
	WSMETHOD GiftListV2Filters
	WSMETHOD GiftListSearch
	WSMETHOD GiftListSearchWithSurname
	WSMETHOD GiftListMemberInsertUpdate
	WSMETHOD GiftListMemberDelete
	WSMETHOD GiftListSkuInsert
	WSMETHOD GiftListSkuGet
	WSMETHOD GiftListSkuSetPurchased
	WSMETHOD GiftListSkuDeleteByList
	WSMETHOD GiftListSkuDelete
	WSMETHOD GiftCardGet
	WSMETHOD GiftCardGetByRedeptionCode
	WSMETHOD EmailQueueNotSendedByType
	WSMETHOD EmailQueueGetAllBetweenTimeIntervalAndEmailTypeId
	WSMETHOD EmailQueueConfirmSending
	WSMETHOD IntegrationLogError
	WSMETHOD IntegrationLog
	WSMETHOD IntegrationErrorGetAllByErrorTypeAndId
	WSMETHOD IntegrationLogEvent
	WSMETHOD IntegrationInterfaceGetAll
	WSMETHOD IntegrationLogErrorInsertUpdate
	WSMETHOD IntegrationErrorCheckInstanceExists
	WSMETHOD CollectionGet
	WSMETHOD CollectionInsertUpdate
	WSMETHOD ShippingNotificationInsertUpdate
	WSMETHOD ShippingNotificationInsertUpdateParameters
	WSMETHOD UpdateNotifyShipping
	WSMETHOD WareHouseIStockableUpdate
	WSMETHOD WareHouseIStockableUpdateV3
	WSMETHOD WareHouseIStockableGetByStockKeepingUnit
	WSMETHOD WareHouseIStockableGetByStockKeepingUnitV3
	WSMETHOD NewsletterGet
	WSMETHOD NewsletterGetAll
	WSMETHOD NewsletterGetPaged
	WSMETHOD NewsletterGetAllByDate
	WSMETHOD StockKeepingUnitInsertUpdate
	WSMETHOD StockKeepingUnitPriceUpdate
	WSMETHOD StockKeepingUnitPriceUpdateByRefId
	WSMETHOD StockKeepingUnitGet
	WSMETHOD StockKeepingUnitGetByManufacturerCode
	WSMETHOD StockKeepingUnitGetByRefId
	WSMETHOD ProductInsertUpdate
	WSMETHOD ProductGet
	WSMETHOD ProductGetByRefId
	WSMETHOD ProductGetSimilarCategory
	WSMETHOD ProductGetAllFromUpdatedDateAndId
	WSMETHOD ProductActive
	WSMETHOD StockKeepingUnitKitListByParent
	WSMETHOD StockKeepingUnitKitListBySkuId
	WSMETHOD IntegrationSettings
	WSMETHOD ClientCandidateInsert
	WSMETHOD ClientCandidateDeleteByCpfOrEmail
	WSMETHOD ClientCandidateGet
	WSMETHOD ClientCandidateDeleteById
	WSMETHOD StockKeepingUnitKitDeleteByParent
	WSMETHOD StockKeepingUnitKitInsertUpdate
	WSMETHOD StockKeepingUnitActive
	WSMETHOD StockKeepingUnitGetAllByProduct
	WSMETHOD StockKeepingUnitGetAllFromUpdatedDate
	WSMETHOD StockKeepingUnitGetAllFromUpdatedDateAndId
	WSMETHOD StockKeepingUnitGetByEan
	WSMETHOD OrderGet
	WSMETHOD OrderGetV3
	WSMETHOD OrderGetByClient
	WSMETHOD OrderGetByClientCpf
	WSMETHOD OrderGetByClientEmail
	WSMETHOD OrderGetByDeliveryId
	WSMETHOD OrderGetByManagementId
	WSMETHOD OrderDeliveryUpdateManagementId
	WSMETHOD OrderDeliveryChangeStatusByManagementId
	WSMETHOD OrderGetByStatus
	WSMETHOD OrderGetByStatusAndPaymentId
	WSMETHOD OrderPayPalGetStatus
	WSMETHOD OrderGetNext50FromId
	WSMETHOD OrderGetNext50FromIdV3
	WSMETHOD OrderGetNext50FromIdAndDate
	WSMETHOD OrderGetNext50FromIdAndDateStatusChanged
	WSMETHOD OrderGetInteractions
	WSMETHOD OrderGetNewV2
	WSMETHOD OrderChangeStatusV2
	WSMETHOD OrderGetV2
	WSMETHOD OrderGetByStatusV2
	WSMETHOD OrderAcknowledge
	WSMETHOD OrderChangeTrackingNumberV2
	WSMETHOD OrderSetSellerMapping
	WSMETHOD OrderGetByStatusByQuantity
	WSMETHOD OrderChangeStatus
	WSMETHOD OrderDeliveryChangeStatus
	WSMETHOD OrderStatusGetAll
	WSMETHOD OrderPaymentGetAll
	WSMETHOD OrderDeliveryBlankRemoveByDTO
	WSMETHOD OrderItemUpdateOrderDeliveryId
	WSMETHOD OrderDeliveryInsertUpdate
	WSMETHOD OrderDeliveryInvoiceNumberInsertUpdate
	WSMETHOD OrderChangeStatusById
	WSMETHOD OrderChangeTrackingNumber
	WSMETHOD OrderDeliveryChangeTrackingNumber
	WSMETHOD ClientGet
	WSMETHOD ClientGetV3
	WSMETHOD ClientGetByCPF
	WSMETHOD ClientGetByEmail
	WSMETHOD ClientGetByEmailV3
	WSMETHOD ClientGetByGuid
	WSMETHOD ClientGetByGuidV3
	WSMETHOD ClientGetExtendedInfo
	WSMETHOD ClientGetExtendedInfoByCPF
	WSMETHOD ClientGetAllFromCreatedDateAndId
	WSMETHOD ClientRewardGet
	WSMETHOD ClientRewardGetByCPF
	WSMETHOD ClientRewardUpdate
	WSMETHOD ClientRewardUpdateByCPF
	WSMETHOD ClientInsertUpdate
	WSMETHOD ClientInsertUpdateV3
	WSMETHOD DistributionCenterGet
	WSMETHOD DistributionCenterGetByTaxId
	WSMETHOD FreightCalculate
	WSMETHOD FreightCalculateV3
	WSMETHOD ZipCodeGet
	WSMETHOD FreightGet
	WSMETHOD FreightGetAll
	WSMETHOD FreightInsertUpdate
	WSMETHOD FreightValueInsertUpdate
	WSMETHOD FreightValueInsertUpdateByList
	WSMETHOD FreightValueDeleteByFreight
	WSMETHOD AddressByAddressClient
	WSMETHOD AddressGetByClientId
	WSMETHOD AddressGetByClientIdV3
	WSMETHOD AddressGetByClientIdV2
	WSMETHOD AddressInsertByClientId
	WSMETHOD AddressInsertUpdateV3
	WSMETHOD AddressInsertByCpfCnpj
	WSMETHOD BuyTogetherInsertUpdate
	WSMETHOD BuyTogetherBuyGainInsertUpdate
	WSMETHOD BuyTogethertakeXPayYInsertUpdate
	WSMETHOD BuyTogetherDeleteById
	WSMETHOD BuyTogetherSkuListInsertUpdate
	WSMETHOD ServiceGet
	WSMETHOD ServicePriceGet
	WSMETHOD ServicePriceList
	WSMETHOD ServiceInsertUpdate
	WSMETHOD ServicePriceInsertUpdate
	WSMETHOD StockKeepingUnitServiceGet
	WSMETHOD StockKeepingUnitServiceList
	WSMETHOD StockKeepingUnitServiceInsertUpdate
	WSMETHOD BrandGet
	WSMETHOD BrandGetByName
	WSMETHOD BrandInsertUpdate
	WSMETHOD CategoryGet
	WSMETHOD CategoryGetByName
	WSMETHOD CategoryInsertUpdate
	WSMETHOD ImageServiceCopyAllImagesFromSkuToSku
	WSMETHOD ImageServiceInsertUpdate
	WSMETHOD ImageInsertUpdate
	WSMETHOD ImageListByStockKeepingUnitId
	WSMETHOD ProductImageRemove

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   nstockKeepingUnitId       AS int
	WSDATA   cimageName                AS string
	WSDATA   nskuId                    AS int
	WSDATA   oWSStockKeepingUnitEspecificationListBySkuIdResult AS Service_ArrayOfFieldDTO
	WSDATA   nproductId                AS int
	WSDATA   oWSProductEspecificationListByProductIdResult AS Service_ArrayOfFieldDTO
	WSDATA   oWSobjStockKeepingUnitComplementDTO AS Service_StockKeepingUnitComplementDTO
	WSDATA   nidProduct                AS int
	WSDATA   cfieldName                AS string
	WSDATA   oWSfieldValues            AS Service_ArrayOfstring
	WSDATA   oWSlistProductFieldName   AS Service_ArrayOfProductFieldNameDTO
	WSDATA   nfieldId                  AS int
	WSDATA   oWSlistStockKeepingUnitEspecificationFieldId AS Service_ArrayOfProductFieldIdDTO
	WSDATA   cDescription              AS string
	WSDATA   oWSlistStockKeepingUnitName AS Service_ArrayOfStockKeepingUnitFieldNameDTO
	WSDATA   nidSku                    AS int
	WSDATA   cProductSupplierGetCNPJResult AS string
	WSDATA   ncategoryId               AS int
	WSDATA   oWSlistStockKeepingUnitdId AS Service_ArrayOfStockKeepingUnitFieldIdDTO
	WSDATA   oWSStoreListResult        AS Service_ArrayOfStoreDTO
	WSDATA   nstoreId                  AS int
	WSDATA   oWSStoreGetResult         AS Service_StoreDTO
	WSDATA   oWSgiftcard               AS Service_GiftCardDTO
	WSDATA   oWSGiftCardInsertUpdateResult AS Service_GiftCardDTO
	WSDATA   nOrderId                  AS int
	WSDATA   nQuantity                 AS int
	WSDATA   lIsActive                 AS boolean
	WSDATA   lGiftCardTransactionItemSetStatusResult AS boolean
	WSDATA   oWSgiftCardTransactionItem AS Service_GiftCardTransactionItemDTO
	WSDATA   lGiftCardTransactionItemInsertResult AS boolean
	WSDATA   nidGiftList               AS int
	WSDATA   oWSGiftListGetResult      AS Service_GiftListDTO
	WSDATA   cclientEmail              AS string
	WSDATA   oWSGiftListGetByClientEmailResult AS Service_ArrayOfGiftListDTO
	WSDATA   cclientCpfCnpj            AS string
	WSDATA   oWSGiftListGetByClientCpfResult AS Service_ArrayOfGiftListDTO
	WSDATA   ngiftListTypeId           AS int
	WSDATA   oWSGiftListGetTypeResult  AS Service_GiftListTypeDTO
	WSDATA   ccreatedDate              AS dateTime
	WSDATA   oWSGiftListGetByCreatedDateResult AS Service_ArrayOfGiftListDTO
	WSDATA   nstartingGiftListId       AS int
	WSDATA   ntopRows                  AS int
	WSDATA   oWSGiftListGetAllFromCreatedDateAndIdResult AS Service_ArrayOfGiftListDTO
	WSDATA   ceventDateBegin           AS dateTime
	WSDATA   ceventDateEnd             AS dateTime
	WSDATA   oWSGiftListGetAllBetweenEventDateIntervalAndIdResult AS Service_ArrayOfGiftListDTO
	WSDATA   cmodifiedDate             AS dateTime
	WSDATA   oWSGiftListGetByModifiedDateResult AS Service_ArrayOfGiftListDTO
	WSDATA   oWSGiftListGetAllFromModifiedDateAndIdResult AS Service_ArrayOfGiftListDTO
	WSDATA   cgifted                   AS string
	WSDATA   oWSGiftListGetByGiftedResult AS Service_ArrayOfGiftListDTO
	WSDATA   oWSgiftList               AS Service_GiftListDTO
	WSDATA   oWSGiftListInsertUpdateResult AS Service_GiftListDTO
	WSDATA   ngiftListId               AS int
	WSDATA   nclientId                 AS int
	WSDATA   ceventDateSince           AS dateTime
	WSDATA   ceventDateUntil           AS dateTime
	WSDATA   oWSGiftListV2FiltersResult AS Service_ArrayOfGiftListDTO
	WSDATA   cclientName               AS string
	WSDATA   ceventLocation            AS string
	WSDATA   ceventCity                AS string
	WSDATA   ceventDate                AS dateTime
	WSDATA   oWSGiftListSearchResult   AS Service_ArrayOfGiftListDTO
	WSDATA   cclientSurname            AS string
	WSDATA   oWSGiftListSearchWithSurnameResult AS Service_ArrayOfGiftListDTO
	WSDATA   oWSgiftListMember         AS Service_ArrayOfGiftListMemberDTO
	WSDATA   oWSGiftListMemberInsertUpdateResult AS Service_ArrayOfGiftListMemberDTO
	WSDATA   nGiftListMemberId         AS int
	WSDATA   oWSgiftListSku            AS Service_GiftListStockKeepingUnitDTO
	WSDATA   oWSGiftListSkuInsertResult AS Service_GiftListStockKeepingUnitDTO
	WSDATA   oWSGiftListSkuGetResult   AS Service_ArrayOfGiftListStockKeepingUnitDTO
	WSDATA   oWSskuQuantity            AS Service_ArrayOfStockKeepingUnitQuantityDTO
	WSDATA   nId                       AS int
	WSDATA   oWSGiftCardGetResult      AS Service_GiftCardDTO
	WSDATA   credeptionCode            AS string
	WSDATA   oWSGiftCardGetByRedeptionCodeResult AS Service_GiftCardDTO
	WSDATA   nEmailQueueTypeId         AS int
	WSDATA   oWSEmailQueueNotSendedByTypeResult AS Service_ArrayOfEmailQueueDTO
	WSDATA   cinitialTime              AS dateTime
	WSDATA   cfinalTime                AS dateTime
	WSDATA   ninitialId                AS int
	WSDATA   nemailTypeId              AS int
	WSDATA   oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult AS Service_ArrayOfEmailQueueDTO
	WSDATA   nEmailQueueId             AS int
	WSDATA   cEmailQueueConfirmSendingResult AS dateTime
	WSDATA   oWSerrorType              AS Service_ErrorType
	WSDATA   cerror                    AS string
	WSDATA   nintegrationErrorId       AS int
	WSDATA   oWSIntegrationErrorGetAllByErrorTypeAndIdResult AS Service_ArrayOfIntegrationErrorDTO
	WSDATA   cmessage                  AS string
	WSDATA   oWSIntegrationInterfaceGetAllResult AS Service_ArrayOfIntegrationInterfaceDTO
	WSDATA   cinstance                 AS string
	WSDATA   cerrorDetail              AS string
	WSDATA   lIntegrationErrorCheckInstanceExistsResult AS boolean
	WSDATA   oWSCollectionGetResult    AS Service_CollectionDTO
	WSDATA   oWScollection             AS Service_CollectionDTO
	WSDATA   oWSCollectionInsertUpdateResult AS Service_CollectionDTO
	WSDATA   oWSshippingNotification   AS Service_ShippingNotificationDTO
	WSDATA   oWSpackageTracking        AS Service_PackageTrackingDTO
	WSDATA   cfiscalInvoiceXML         AS string
	WSDATA   oWSOrderInvoice           AS Service_OrderInvoiceDTO
	WSDATA   nIdEstoque                AS int
	WSDATA   nQuantidade               AS int
	WSDATA   cdateOfAvailability       AS dateTime
	WSDATA   cwareHouseId              AS string
	WSDATA   nitemId                   AS int
	WSDATA   navailableQuantity        AS int
	WSDATA   oWSWareHouseIStockableGetByStockKeepingUnitResult AS Service_WareHouseIStockableDTO
	WSDATA   oWSWareHouseIStockableGetByStockKeepingUnitV3Result AS Service_ArrayOfWareHouseIStockableDTO
	WSDATA   nNewsId                   AS int
	WSDATA   oWSNewsletterGetResult    AS Service_NewsletterDTO
	WSDATA   oWSNewsletterGetAllResult AS Service_ArrayOfNewsletterDTO
	WSDATA   npage                     AS int
	WSDATA   oWSNewsletterGetPagedResult AS Service_ArrayOfNewsletterDTO
	WSDATA   cBeginDate                AS dateTime
	WSDATA   cEndDate                  AS dateTime
	WSDATA   oWSNewsletterGetAllByDateResult AS Service_ArrayOfNewsletterDTO
	WSDATA   oWSstockKeepingUnitVO     AS Service_StockKeepingUnitDTO
	WSDATA   oWSStockKeepingUnitInsertUpdateResult AS Service_StockKeepingUnitDTO
	WSDATA   nstockKeepintUnitId       AS int
	WSDATA   nprice                    AS decimal
	WSDATA   nlistPrice                AS decimal
	WSDATA   ncostPrice                AS decimal
	WSDATA   cstockKeepintUnitRefId    AS string
	WSDATA   oWSStockKeepingUnitGetResult AS Service_StockKeepingUnitDTO
	WSDATA   cmanufacturer             AS string
	WSDATA   oWSStockKeepingUnitGetByManufacturerCodeResult AS Service_ArrayOfStockKeepingUnitDTO
	WSDATA   crefId                    AS string
	WSDATA   oWSStockKeepingUnitGetByRefIdResult AS Service_StockKeepingUnitDTO
	WSDATA   oWSproductVO              AS Service_ProductDTO
	WSDATA   oWSProductInsertUpdateResult AS Service_ProductDTO
	WSDATA   oWSProductGetResult       AS Service_ProductDTO
	WSDATA   oWSProductGetByRefIdResult AS Service_ProductDTO
	WSDATA   oWSProductGetSimilarCategoryResult AS Service_ArrayOfint
	WSDATA   cdateUpdated              AS dateTime
	WSDATA   oWSProductGetAllFromUpdatedDateAndIdResult AS Service_ArrayOfProductDTO
	WSDATA   nidSkuParent              AS int
	WSDATA   oWSStockKeepingUnitKitListByParentResult AS Service_ArrayOfStockKeepingUnitKitDTO
	WSDATA   oWSStockKeepingUnitKitListBySkuIdResult AS Service_ArrayOfStockKeepingUnitKitDTO
	WSDATA   oWSIntegrationSettingsResult AS Service_IntegrationDTO
	WSDATA   oWSClienteCandidato       AS Service_ClientCandidateDTO
	WSDATA   oWSClientCandidateInsertResult AS Service_ClientCandidateDTO
	WSDATA   nidClusterGrupoClienteCandidato AS int
	WSDATA   oWSClientCandidateGetResult AS Service_ClientCandidateDTO
	WSDATA   nidClientCandidate        AS int
	WSDATA   oWSstockKeepingUnitKit    AS Service_StockKeepingUnitKitDTO
	WSDATA   oWSStockKeepingUnitKitInsertUpdateResult AS Service_StockKeepingUnitKitDTO
	WSDATA   nstockKeepingUnitKitId    AS int
	WSDATA   nidStockKeepingUnit       AS int
	WSDATA   oWSStockKeepingUnitGetAllByProductResult AS Service_ArrayOfStockKeepingUnitDTO
	WSDATA   oWSStockKeepingUnitGetAllFromUpdatedDateResult AS Service_ArrayOfStockKeepingUnitDTO
	WSDATA   nstartingStockKeepingUnitId AS int
	WSDATA   oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult AS Service_ArrayOfStockKeepingUnitDTO
	WSDATA   cEAN13                    AS string
	WSDATA   oWSStockKeepingUnitGetByEanResult AS Service_StockKeepingUnitDTO
	WSDATA   oWSOrderGetResult         AS Service_OrderDTO
	WSDATA   oWSOrderGetV3Result       AS Service_OrderDTO
	WSDATA   oWSOrderGetByClientResult AS Service_ArrayOfOrderDTO
	WSDATA   ccpfCnpj                  AS string
	WSDATA   oWSOrderGetByClientCpfResult AS Service_ArrayOfOrderDTO
	WSDATA   cemail                    AS string
	WSDATA   oWSOrderGetByClientEmailResult AS Service_ArrayOfOrderDTO
	WSDATA   norderDeliveryId          AS int
	WSDATA   oWSOrderGetByDeliveryIdResult AS Service_OrderDTO
	WSDATA   nmanagementId             AS int
	WSDATA   oWSOrderGetByManagementIdResult AS Service_OrderDTO
	WSDATA   oWSorder                  AS Service_OrderDTO
	WSDATA   cstatusOrder              AS string
	WSDATA   oWSOrderGetByStatusResult AS Service_ArrayOfOrderDTO
	WSDATA   oWSpaymentIds             AS Service_ArrayOfint
	WSDATA   oWSOrderGetByStatusAndPaymentIdResult AS Service_ArrayOfOrderDTO
	WSDATA   cTransactionId            AS string
	WSDATA   cOrderPayPalGetStatusResult AS string
	WSDATA   oWSOrderGetNext50FromIdResult AS Service_ArrayOfOrderDTO
	WSDATA   nsequence                 AS int
	WSDATA   oWSOrderGetNext50FromIdV3Result AS Service_ArrayOfOrderDTO
	WSDATA   clastDate                 AS dateTime
	WSDATA   oWSOrderGetNext50FromIdAndDateResult AS Service_ArrayOfOrderDTO
	WSDATA   oWSOrderGetNext50FromIdAndDateStatusChangedResult AS Service_ArrayOfOrderDTO
	WSDATA   oWSOrderGetInteractionsResult AS Service_ArrayOfOrderInteractionDTO
	WSDATA   oWSOrderGetNewV2Result    AS Service_ArrayOfOrderDTO
	WSDATA   oWSintegrationStatus      AS Service_IntegrationStatus
	WSDATA   oWSOrderGetV2Result       AS Service_OrderDTO
	WSDATA   oWSOrderGetByStatusV2Result AS Service_ArrayOfOrderDTO
	WSDATA   ctrackingNumber           AS string
	WSDATA   csellerId                 AS string
	WSDATA   csellerOrderId            AS string
	WSDATA   oWSitemsMapping           AS Service_ArrayOfKeyValueOfstringstring
	WSDATA   oWSOrderGetByStatusByQuantityResult AS Service_ArrayOfOrderDTO
	WSDATA   nidOrder                  AS int
	WSDATA   nAdministratorId          AS int
	WSDATA   oWSitems                  AS Service_ArrayOfOrderItem
	WSDATA   oWSOrderStatusGetAllResult AS Service_ArrayOfOrderStatusDTO
	WSDATA   oWSOrderPaymentGetAllResult AS Service_ArrayOfPaymentDTO
	WSDATA   oWSorderDTO               AS Service_OrderDTO
	WSDATA   oWSorderItemDTO           AS Service_OrderItemDTO
	WSDATA   oWSorderDeliveryDTO       AS Service_OrderDeliveryDTO
	WSDATA   oWSOrderDeliveryInsertUpdateResult AS Service_OrderDeliveryDTO
	WSDATA   cinvoiceNumber            AS string
	WSDATA   oWSOrderDeliveryInvoiceNumberInsertUpdateResult AS Service_OrderDeliveryDTO
	WSDATA   nidOrderDelivery          AS int
	WSDATA   nidClient                 AS int
	WSDATA   oWSClientGetResult        AS Service_ClientDTO
	WSDATA   cidClientV3               AS string
	WSDATA   oWSClientGetV3Result      AS Service_ClientDTO
	WSDATA   oWSClientGetByCPFResult   AS Service_ClientDTO
	WSDATA   oWSClientGetByEmailResult AS Service_ClientDTO
	WSDATA   oWSClientGetByEmailV3Result AS Service_ClientDTO
	WSDATA   cguid                     AS string
	WSDATA   oWSClientGetByGuidResult  AS Service_ClientDTO
	WSDATA   oWSClientGetByGuidV3Result AS Service_ClientDTO
	WSDATA   oWSClientGetExtendedInfoResult AS Service_ClientExtendedDTO
	WSDATA   oWSClientGetExtendedInfoByCPFResult AS Service_ClientExtendedDTO
	WSDATA   cdateCreated              AS dateTime
	WSDATA   nstartingClientId         AS int
	WSDATA   oWSClientGetAllFromCreatedDateAndIdResult AS Service_ArrayOfClientDTO
	WSDATA   nClientRewardGetResult    AS decimal
	WSDATA   nClientRewardGetByCPFResult AS decimal
	WSDATA   ntotalReward              AS decimal
	WSDATA   oWStransactionAction      AS Service_TransactionAction
	WSDATA   oWSclient                 AS Service_ClientDTO
	WSDATA   oWSaddress                AS Service_AddressDTO
	WSDATA   naddressId                AS int
	WSDATA   oWSClientInsertUpdateV3Result AS Service_ClientDTO
	WSDATA   nidDistributionCenter     AS int
	WSDATA   oWSDistributionCenterGetResult AS Service_DistributionCenterDTO
	WSDATA   ctaxId                    AS string
	WSDATA   oWSDistributionCenterGetByTaxIdResult AS Service_DistributionCenterDTO
	WSDATA   czipCode                  AS string
	WSDATA   ndistributionCenterId     AS int
	WSDATA   nfreightTypeId            AS int
	WSDATA   oWSFreightCalculateResult AS Service_FreightValueDTO
	WSDATA   oWSfreightSkuContext      AS Service_ArrayOfFreightStockKeepingUnitContextDTO
	WSDATA   oWSFreightCalculateV3Result AS Service_ArrayOfFreightStockKeepingUnitDTO
	WSDATA   oWSZipCodeGetResult       AS Service_ZipCodeDTO
	WSDATA   nidFreight                AS int
	WSDATA   oWSFreightGetResult       AS Service_FreightDTO
	WSDATA   oWSFreightGetAllResult    AS Service_ArrayOfFreightDTO
	WSDATA   oWSfreight                AS Service_FreightDTO
	WSDATA   oWSFreightInsertUpdateResult AS Service_FreightDTO
	WSDATA   oWSfreightValue           AS Service_FreightValueDTO
	WSDATA   oWSFreightValueInsertUpdateResult AS Service_FreightValueDTO
	WSDATA   oWSlstFreightValue        AS Service_ArrayOfFreightValueDTO
	WSDATA   naddressClientId          AS int
	WSDATA   oWSAddressByAddressClientResult AS Service_AddressDTO
	WSDATA   oWSAddressGetByClientIdResult AS Service_ArrayOfAddressDTO
	WSDATA   cclientIdV3               AS string
	WSDATA   oWSAddressGetByClientIdV3Result AS Service_ArrayOfAddressDTO
	WSDATA   cclientIdV2               AS string
	WSDATA   oWSAddressGetByClientIdV2Result AS Service_ArrayOfAddressDTO2
	WSDATA   oWSClientAddress          AS Service_AddressDTO
	WSDATA   oWSAddressInsertByClientIdResult AS Service_AddressDTO
	WSDATA   oWSAddressInsertUpdateV3Result AS Service_AddressDTO
	WSDATA   oWSAddressInsertByCpfCnpjResult AS Service_AddressDTO
	WSDATA   oWSobjBuyTogether         AS Service_BuyTogetherDTO
	WSDATA   oWSBuyTogetherInsertUpdateResult AS Service_BuyTogetherDTO
	WSDATA   oWSobjBuyTogetherBuyGainDTO AS Service_BuyTogetherBuyGainDTO
	WSDATA   oWSBuyTogetherBuyGainInsertUpdateResult AS Service_BuyTogetherBuyGainDTO
	WSDATA   oWSobjBuyTogetherTakeXPayYDTO AS Service_BuyTogetherTakeXPayYDTO
	WSDATA   oWSBuyTogethertakeXPayYInsertUpdateResult AS Service_BuyTogetherTakeXPayYDTO
	WSDATA   nbuyTogetherId            AS int
	WSDATA   oWSfirstListStockKeepingUnit AS Service_ArrayOfint
	WSDATA   oWSsecondListStockKeepingUnit AS Service_ArrayOfint
	WSDATA   nidService                AS int
	WSDATA   oWSVtexGetResult       AS Service_ServiceDTO
	WSDATA   nidServicePrice           AS int
	WSDATA   oWSVtexPriceGetResult  AS Service_ServicePriceDTO
	WSDATA   oWSVtexPriceListResult AS Service_ArrayOfServicePriceDTO
	WSDATA   oWSVtex                AS Service_ServiceDTO
	WSDATA   oWSVtexInsertUpdateResult AS Service_ServiceDTO
	WSDATA   nserviceId                AS int
	WSDATA   oWSVtexPrice           AS Service_ServicePriceDTO
	WSDATA   oWSVtexPriceInsertUpdateResult AS Service_ServicePriceDTO
	WSDATA   nservicePriceId           AS int
	WSDATA   nidStockKeepingUnitService AS int
	WSDATA   oWSStockKeepingUnitServiceGetResult AS Service_StockKeepingUnitServiceDTO
	WSDATA   oWSStockKeepingUnitServiceListResult AS Service_ArrayOfStockKeepingUnitServiceDTO
	WSDATA   oWSstockKeepingUnitService AS Service_StockKeepingUnitServiceDTO
	WSDATA   oWSStockKeepingUnitServiceInsertUpdateResult AS Service_StockKeepingUnitServiceDTO
	WSDATA   nstockKeepingUnitServiceId AS int
	WSDATA   nidBrand                  AS int
	WSDATA   oWSBrandGetResult         AS Service_BrandDTO
	WSDATA   cnameBrand                AS string
	WSDATA   oWSBrandGetByNameResult   AS Service_BrandDTO
	WSDATA   oWSbrand                  AS Service_BrandDTO
	WSDATA   oWSBrandInsertUpdateResult AS Service_BrandDTO
	WSDATA   nidCategory               AS int
	WSDATA   oWSCategoryGetResult      AS Service_CategoryDTO
	WSDATA   cnameCategory             AS string
	WSDATA   oWSCategoryGetByNameResult AS Service_CategoryDTO
	WSDATA   oWScategory               AS Service_CategoryDTO
	WSDATA   oWSCategoryInsertUpdateResult AS Service_CategoryDTO
	WSDATA   nstockKeepingUnitIdFrom   AS int
	WSDATA   nstockKeepingUnitIdTo     AS int
	WSDATA   curlImage                 AS string
	WSDATA   nfileId                   AS int
	WSDATA   oWSimage                  AS Service_ImageDTO
	WSDATA   nArchiveTypeId            AS int
	WSDATA   oWSImageListByStockKeepingUnitIdResult AS Service_ArrayOfImageDTO
	WSDATA   cUrlWS                 AS string	
	WSDATA   cSoap                  AS string	

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSVtex
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.121227P-20131106] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
If val(right(GetWSCVer(),8)) < 1.040504
	UserException("O Código-Fonte Client atual requer a versão de Lib para WebServices igual ou superior a ADVPL WSDL Client 1.040504. Atualize o repositório ou gere o Código-Fonte novamente utilizando o repositório atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSVtex
	::oWSStockKeepingUnitEspecificationListBySkuIdResult := Service_ARRAYOFFIELDDTO():New()
	::oWSProductEspecificationListByProductIdResult := Service_ARRAYOFFIELDDTO():New()
	::oWSobjStockKeepingUnitComplementDTO := Service_STOCKKEEPINGUNITCOMPLEMENTDTO():New()
	::oWSfieldValues     := Service_ARRAYOFSTRING():New()
	::oWSlistProductFieldName := Service_ARRAYOFPRODUCTFIELDNAMEDTO():New()
	::oWSlistStockKeepingUnitEspecificationFieldId := Service_ARRAYOFPRODUCTFIELDIDDTO():New()
	::oWSlistStockKeepingUnitName := Service_ARRAYOFSTOCKKEEPINGUNITFIELDNAMEDTO():New()
	::oWSlistStockKeepingUnitdId := Service_ARRAYOFSTOCKKEEPINGUNITFIELDIDDTO():New()
	::oWSStoreListResult := Service_ARRAYOFSTOREDTO():New()
	::oWSStoreGetResult  := Service_STOREDTO():New()
	::oWSgiftcard        := Service_GIFTCARDDTO():New()
	::oWSGiftCardInsertUpdateResult := Service_GIFTCARDDTO():New()
	::oWSgiftCardTransactionItem := Service_GIFTCARDTRANSACTIONITEMDTO():New()
	::oWSGiftListGetResult := Service_GIFTLISTDTO():New()
	::oWSGiftListGetByClientEmailResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetByClientCpfResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetTypeResult := Service_GIFTLISTTYPEDTO():New()
	::oWSGiftListGetByCreatedDateResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetAllFromCreatedDateAndIdResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetAllBetweenEventDateIntervalAndIdResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetByModifiedDateResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetAllFromModifiedDateAndIdResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListGetByGiftedResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSgiftList        := Service_GIFTLISTDTO():New()
	::oWSGiftListInsertUpdateResult := Service_GIFTLISTDTO():New()
	::oWSGiftListV2FiltersResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListSearchResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSGiftListSearchWithSurnameResult := Service_ARRAYOFGIFTLISTDTO():New()
	::oWSgiftListMember  := Service_ARRAYOFGIFTLISTMEMBERDTO():New()
	::oWSGiftListMemberInsertUpdateResult := Service_ARRAYOFGIFTLISTMEMBERDTO():New()
	::oWSgiftListSku     := Service_GIFTLISTSTOCKKEEPINGUNITDTO():New()
	::oWSGiftListSkuInsertResult := Service_GIFTLISTSTOCKKEEPINGUNITDTO():New()
	::oWSGiftListSkuGetResult := Service_ARRAYOFGIFTLISTSTOCKKEEPINGUNITDTO():New()
	::oWSskuQuantity     := Service_ARRAYOFSTOCKKEEPINGUNITQUANTITYDTO():New()
	::oWSGiftCardGetResult := Service_GIFTCARDDTO():New()
	::oWSGiftCardGetByRedeptionCodeResult := Service_GIFTCARDDTO():New()
	::oWSEmailQueueNotSendedByTypeResult := Service_ARRAYOFEMAILQUEUEDTO():New()
	::oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult := Service_ARRAYOFEMAILQUEUEDTO():New()
	::oWSerrorType       := Service_ERRORTYPE():New()
	::oWSIntegrationErrorGetAllByErrorTypeAndIdResult := Service_ARRAYOFINTEGRATIONERRORDTO():New()
	::oWSIntegrationInterfaceGetAllResult := Service_ARRAYOFINTEGRATIONINTERFACEDTO():New()
	::oWSCollectionGetResult := Service_COLLECTIONDTO():New()
	::oWScollection      := Service_COLLECTIONDTO():New()
	::oWSCollectionInsertUpdateResult := Service_COLLECTIONDTO():New()
	::oWSshippingNotification := Service_SHIPPINGNOTIFICATIONDTO():New()
	::oWSpackageTracking := Service_PACKAGETRACKINGDTO():New()
	::oWSOrderInvoice    := Service_ORDERINVOICEDTO():New()
	::oWSWareHouseIStockableGetByStockKeepingUnitResult := Service_WAREHOUSEISTOCKABLEDTO():New()
	::oWSWareHouseIStockableGetByStockKeepingUnitV3Result := Service_ARRAYOFWAREHOUSEISTOCKABLEDTO():New()
	::oWSNewsletterGetResult := Service_NEWSLETTERDTO():New()
	::oWSNewsletterGetAllResult := Service_ARRAYOFNEWSLETTERDTO():New()
	::oWSNewsletterGetPagedResult := Service_ARRAYOFNEWSLETTERDTO():New()
	::oWSNewsletterGetAllByDateResult := Service_ARRAYOFNEWSLETTERDTO():New()
	::oWSstockKeepingUnitVO := Service_STOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitInsertUpdateResult := Service_STOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitGetResult := Service_STOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitGetByManufacturerCodeResult := Service_ARRAYOFSTOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitGetByRefIdResult := Service_STOCKKEEPINGUNITDTO():New()
	::oWSproductVO       := Service_PRODUCTDTO():New()
	::oWSProductInsertUpdateResult := Service_PRODUCTDTO():New()
	::oWSProductGetResult := Service_PRODUCTDTO():New()
	::oWSProductGetByRefIdResult := Service_PRODUCTDTO():New()
	::oWSProductGetSimilarCategoryResult := Service_ARRAYOFINT():New()
	::oWSProductGetAllFromUpdatedDateAndIdResult := Service_ARRAYOFPRODUCTDTO():New()
	::oWSStockKeepingUnitKitListByParentResult := Service_ARRAYOFSTOCKKEEPINGUNITKITDTO():New()
	::oWSStockKeepingUnitKitListBySkuIdResult := Service_ARRAYOFSTOCKKEEPINGUNITKITDTO():New()
	::oWSIntegrationSettingsResult := Service_INTEGRATIONDTO():New()
	::oWSClienteCandidato := Service_CLIENTCANDIDATEDTO():New()
	::oWSClientCandidateInsertResult := Service_CLIENTCANDIDATEDTO():New()
	::oWSClientCandidateGetResult := Service_CLIENTCANDIDATEDTO():New()
	::oWSstockKeepingUnitKit := Service_STOCKKEEPINGUNITKITDTO():New()
	::oWSStockKeepingUnitKitInsertUpdateResult := Service_STOCKKEEPINGUNITKITDTO():New()
	::oWSStockKeepingUnitGetAllByProductResult := Service_ARRAYOFSTOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitGetAllFromUpdatedDateResult := Service_ARRAYOFSTOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult := Service_ARRAYOFSTOCKKEEPINGUNITDTO():New()
	::oWSStockKeepingUnitGetByEanResult := Service_STOCKKEEPINGUNITDTO():New()
	::oWSOrderGetResult  := Service_ORDERDTO():New()
	::oWSOrderGetV3Result := Service_ORDERDTO():New()
	::oWSOrderGetByClientResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetByClientCpfResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetByClientEmailResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetByDeliveryIdResult := Service_ORDERDTO():New()
	::oWSOrderGetByManagementIdResult := Service_ORDERDTO():New()
	::oWSorder           := Service_ORDERDTO():New()
	::oWSOrderGetByStatusResult := Service_ARRAYOFORDERDTO():New()
	::oWSpaymentIds      := Service_ARRAYOFINT():New()
	::oWSOrderGetByStatusAndPaymentIdResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetNext50FromIdResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetNext50FromIdV3Result := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetNext50FromIdAndDateResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetNext50FromIdAndDateStatusChangedResult := Service_ARRAYOFORDERDTO():New()
	::oWSOrderGetInteractionsResult := Service_ARRAYOFORDERINTERACTIONDTO():New()
	::oWSOrderGetNewV2Result := Service_ARRAYOFORDERDTO():New()
	::oWSintegrationStatus := Service_INTEGRATIONSTATUS():New()
	::oWSOrderGetV2Result := Service_ORDERDTO():New()
	::oWSOrderGetByStatusV2Result := Service_ARRAYOFORDERDTO():New()
	::oWSitemsMapping    := Service_ARRAYOFKEYVALUEOFSTRINGSTRING():New()
	::oWSOrderGetByStatusByQuantityResult := Service_ARRAYOFORDERDTO():New()
	::oWSitems           := Service_ARRAYOFORDERITEM():New()
	::oWSOrderStatusGetAllResult := Service_ARRAYOFORDERSTATUSDTO():New()
	::oWSOrderPaymentGetAllResult := Service_ARRAYOFPAYMENTDTO():New()
	::oWSorderDTO        := Service_ORDERDTO():New()
	::oWSorderItemDTO    := Service_ORDERITEMDTO():New()
	::oWSorderDeliveryDTO := Service_ORDERDELIVERYDTO():New()
	::oWSOrderDeliveryInsertUpdateResult := Service_ORDERDELIVERYDTO():New()
	::oWSOrderDeliveryInvoiceNumberInsertUpdateResult := Service_ORDERDELIVERYDTO():New()
	::oWSClientGetResult := Service_CLIENTDTO():New()
	::oWSClientGetV3Result := Service_CLIENTDTO():New()
	::oWSClientGetByCPFResult := Service_CLIENTDTO():New()
	::oWSClientGetByEmailResult := Service_CLIENTDTO():New()
	::oWSClientGetByEmailV3Result := Service_CLIENTDTO():New()
	::oWSClientGetByGuidResult := Service_CLIENTDTO():New()
	::oWSClientGetByGuidV3Result := Service_CLIENTDTO():New()
	::oWSClientGetExtendedInfoResult := Service_CLIENTEXTENDEDDTO():New()
	::oWSClientGetExtendedInfoByCPFResult := Service_CLIENTEXTENDEDDTO():New()
	::oWSClientGetAllFromCreatedDateAndIdResult := Service_ARRAYOFCLIENTDTO():New()
	::oWStransactionAction := Service_TRANSACTIONACTION():New()
	::oWSclient          := Service_CLIENTDTO():New()
	::oWSaddress         := Service_ADDRESSDTO():New()
	::oWSClientInsertUpdateV3Result := Service_CLIENTDTO():New()
	::oWSDistributionCenterGetResult := Service_DISTRIBUTIONCENTERDTO():New()
	::oWSDistributionCenterGetByTaxIdResult := Service_DISTRIBUTIONCENTERDTO():New()
	::oWSFreightCalculateResult := Service_FREIGHTVALUEDTO():New()
	::oWSfreightSkuContext := Service_ARRAYOFFREIGHTSTOCKKEEPINGUNITCONTEXTDTO():New()
	::oWSFreightCalculateV3Result := Service_ARRAYOFFREIGHTSTOCKKEEPINGUNITDTO():New()
	::oWSZipCodeGetResult := Service_ZIPCODEDTO():New()
	::oWSFreightGetResult := Service_FREIGHTDTO():New()
	::oWSFreightGetAllResult := Service_ARRAYOFFREIGHTDTO():New()
	::oWSfreight         := Service_FREIGHTDTO():New()
	::oWSFreightInsertUpdateResult := Service_FREIGHTDTO():New()
	::oWSfreightValue    := Service_FREIGHTVALUEDTO():New()
	::oWSFreightValueInsertUpdateResult := Service_FREIGHTVALUEDTO():New()
	::oWSlstFreightValue := Service_ARRAYOFFREIGHTVALUEDTO():New()
	::oWSAddressByAddressClientResult := Service_ADDRESSDTO():New()
	::oWSAddressGetByClientIdResult := Service_ARRAYOFADDRESSDTO():New()
	::oWSAddressGetByClientIdV3Result := Service_ARRAYOFADDRESSDTO():New()
	::oWSAddressGetByClientIdV2Result := Service_ARRAYOFADDRESSDTO2():New()
	::oWSClientAddress   := Service_ADDRESSDTO():New()
	::oWSAddressInsertByClientIdResult := Service_ADDRESSDTO():New()
	::oWSAddressInsertUpdateV3Result := Service_ADDRESSDTO():New()
	::oWSAddressInsertByCpfCnpjResult := Service_ADDRESSDTO():New()
	::oWSobjBuyTogether  := Service_BUYTOGETHERDTO():New()
	::oWSBuyTogetherInsertUpdateResult := Service_BUYTOGETHERDTO():New()
	::oWSobjBuyTogetherBuyGainDTO := Service_BUYTOGETHERBUYGAINDTO():New()
	::oWSBuyTogetherBuyGainInsertUpdateResult := Service_BUYTOGETHERBUYGAINDTO():New()
	::oWSobjBuyTogetherTakeXPayYDTO := Service_BUYTOGETHERTAKEXPAYYDTO():New()
	::oWSBuyTogethertakeXPayYInsertUpdateResult := Service_BUYTOGETHERTAKEXPAYYDTO():New()
	::oWSfirstListStockKeepingUnit := Service_ARRAYOFINT():New()
	::oWSsecondListStockKeepingUnit := Service_ARRAYOFINT():New()
	::oWSVtexGetResult := Service_SERVICEDTO():New()
	::oWSVtexPriceGetResult := Service_SERVICEPRICEDTO():New()
	::oWSVtexPriceListResult := Service_ARRAYOFSERVICEPRICEDTO():New()
	::oWSVtex         := Service_SERVICEDTO():New()
	::oWSVtexInsertUpdateResult := Service_SERVICEDTO():New()
	::oWSVtexPrice    := Service_SERVICEPRICEDTO():New()
	::oWSVtexPriceInsertUpdateResult := Service_SERVICEPRICEDTO():New()
	::oWSStockKeepingUnitServiceGetResult := Service_STOCKKEEPINGUNITSERVICEDTO():New()
	::oWSStockKeepingUnitServiceListResult := Service_ARRAYOFSTOCKKEEPINGUNITSERVICEDTO():New()
	::oWSstockKeepingUnitService := Service_STOCKKEEPINGUNITSERVICEDTO():New()
	::oWSStockKeepingUnitServiceInsertUpdateResult := Service_STOCKKEEPINGUNITSERVICEDTO():New()
	::oWSBrandGetResult  := Service_BRANDDTO():New()
	::oWSBrandGetByNameResult := Service_BRANDDTO():New()
	::oWSbrand           := Service_BRANDDTO():New()
	::oWSBrandInsertUpdateResult := Service_BRANDDTO():New()
	::oWSCategoryGetResult := Service_CATEGORYDTO():New()
	::oWSCategoryGetByNameResult := Service_CATEGORYDTO():New()
	::oWScategory        := Service_CATEGORYDTO():New()
	::oWSCategoryInsertUpdateResult := Service_CATEGORYDTO():New()
	::oWSimage           := Service_IMAGEDTO():New()
	::oWSImageListByStockKeepingUnitIdResult := Service_ARRAYOFIMAGEDTO():New()
Return

WSMETHOD RESET WSCLIENT WSVtex
	::nstockKeepingUnitId := NIL 
	::cimageName         := NIL 
	::nskuId             := NIL 
	::oWSStockKeepingUnitEspecificationListBySkuIdResult := NIL 
	::nproductId         := NIL 
	::oWSProductEspecificationListByProductIdResult := NIL 
	::oWSobjStockKeepingUnitComplementDTO := NIL 
	::nidProduct         := NIL 
	::cfieldName         := NIL 
	::oWSfieldValues     := NIL 
	::oWSlistProductFieldName := NIL 
	::nfieldId           := NIL 
	::oWSlistStockKeepingUnitEspecificationFieldId := NIL 
	::cDescription       := NIL 
	::oWSlistStockKeepingUnitName := NIL 
	::nidSku             := NIL 
	::cProductSupplierGetCNPJResult := NIL 
	::ncategoryId        := NIL 
	::oWSlistStockKeepingUnitdId := NIL 
	::oWSStoreListResult := NIL 
	::nstoreId           := NIL 
	::oWSStoreGetResult  := NIL 
	::oWSgiftcard        := NIL 
	::oWSGiftCardInsertUpdateResult := NIL 
	::nOrderId           := NIL 
	::nQuantity          := NIL 
	::lIsActive          := NIL 
	::lGiftCardTransactionItemSetStatusResult := NIL 
	::oWSgiftCardTransactionItem := NIL 
	::lGiftCardTransactionItemInsertResult := NIL 
	::nidGiftList        := NIL 
	::oWSGiftListGetResult := NIL 
	::cclientEmail       := NIL 
	::oWSGiftListGetByClientEmailResult := NIL 
	::cclientCpfCnpj     := NIL 
	::oWSGiftListGetByClientCpfResult := NIL 
	::ngiftListTypeId    := NIL 
	::oWSGiftListGetTypeResult := NIL 
	::ccreatedDate       := NIL 
	::oWSGiftListGetByCreatedDateResult := NIL 
	::nstartingGiftListId := NIL 
	::ntopRows           := NIL 
	::oWSGiftListGetAllFromCreatedDateAndIdResult := NIL 
	::ceventDateBegin    := NIL 
	::ceventDateEnd      := NIL 
	::oWSGiftListGetAllBetweenEventDateIntervalAndIdResult := NIL 
	::cmodifiedDate      := NIL 
	::oWSGiftListGetByModifiedDateResult := NIL 
	::oWSGiftListGetAllFromModifiedDateAndIdResult := NIL 
	::cgifted            := NIL 
	::oWSGiftListGetByGiftedResult := NIL 
	::oWSgiftList        := NIL 
	::oWSGiftListInsertUpdateResult := NIL 
	::ngiftListId        := NIL 
	::nclientId          := NIL 
	::ceventDateSince    := NIL 
	::ceventDateUntil    := NIL 
	::oWSGiftListV2FiltersResult := NIL 
	::cclientName        := NIL 
	::ceventLocation     := NIL 
	::ceventCity         := NIL 
	::ceventDate         := NIL 
	::oWSGiftListSearchResult := NIL 
	::cclientSurname     := NIL 
	::oWSGiftListSearchWithSurnameResult := NIL 
	::oWSgiftListMember  := NIL 
	::oWSGiftListMemberInsertUpdateResult := NIL 
	::nGiftListMemberId  := NIL 
	::oWSgiftListSku     := NIL 
	::oWSGiftListSkuInsertResult := NIL 
	::oWSGiftListSkuGetResult := NIL 
	::oWSskuQuantity     := NIL 
	::nId                := NIL 
	::oWSGiftCardGetResult := NIL 
	::credeptionCode     := NIL 
	::oWSGiftCardGetByRedeptionCodeResult := NIL 
	::nEmailQueueTypeId  := NIL 
	::oWSEmailQueueNotSendedByTypeResult := NIL 
	::cinitialTime       := NIL 
	::cfinalTime         := NIL 
	::ninitialId         := NIL 
	::nemailTypeId       := NIL 
	::oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult := NIL 
	::nEmailQueueId      := NIL 
	::cEmailQueueConfirmSendingResult := NIL 
	::oWSerrorType       := NIL 
	::cerror             := NIL 
	::nintegrationErrorId := NIL 
	::oWSIntegrationErrorGetAllByErrorTypeAndIdResult := NIL 
	::cmessage           := NIL 
	::oWSIntegrationInterfaceGetAllResult := NIL 
	::cinstance          := NIL 
	::cerrorDetail       := NIL 
	::lIntegrationErrorCheckInstanceExistsResult := NIL 
	::oWSCollectionGetResult := NIL 
	::oWScollection      := NIL 
	::oWSCollectionInsertUpdateResult := NIL 
	::oWSshippingNotification := NIL 
	::oWSpackageTracking := NIL 
	::cfiscalInvoiceXML  := NIL 
	::oWSOrderInvoice    := NIL 
	::nIdEstoque         := NIL 
	::nQuantidade        := NIL 
	::cdateOfAvailability := NIL 
	::cwareHouseId       := NIL 
	::nitemId            := NIL 
	::navailableQuantity := NIL 
	::oWSWareHouseIStockableGetByStockKeepingUnitResult := NIL 
	::oWSWareHouseIStockableGetByStockKeepingUnitV3Result := NIL 
	::nNewsId            := NIL 
	::oWSNewsletterGetResult := NIL 
	::oWSNewsletterGetAllResult := NIL 
	::npage              := NIL 
	::oWSNewsletterGetPagedResult := NIL 
	::cBeginDate         := NIL 
	::cEndDate           := NIL 
	::oWSNewsletterGetAllByDateResult := NIL 
	::oWSstockKeepingUnitVO := NIL 
	::oWSStockKeepingUnitInsertUpdateResult := NIL 
	::nstockKeepintUnitId := NIL 
	::nprice             := NIL 
	::nlistPrice         := NIL 
	::ncostPrice         := NIL 
	::cstockKeepintUnitRefId := NIL 
	::oWSStockKeepingUnitGetResult := NIL 
	::cmanufacturer      := NIL 
	::oWSStockKeepingUnitGetByManufacturerCodeResult := NIL 
	::crefId             := NIL 
	::oWSStockKeepingUnitGetByRefIdResult := NIL 
	::oWSproductVO       := NIL 
	::oWSProductInsertUpdateResult := NIL 
	::oWSProductGetResult := NIL 
	::oWSProductGetByRefIdResult := NIL 
	::oWSProductGetSimilarCategoryResult := NIL 
	::cdateUpdated       := NIL 
	::oWSProductGetAllFromUpdatedDateAndIdResult := NIL 
	::nidSkuParent       := NIL 
	::oWSStockKeepingUnitKitListByParentResult := NIL 
	::oWSStockKeepingUnitKitListBySkuIdResult := NIL 
	::oWSIntegrationSettingsResult := NIL 
	::oWSClienteCandidato := NIL 
	::oWSClientCandidateInsertResult := NIL 
	::nidClusterGrupoClienteCandidato := NIL 
	::oWSClientCandidateGetResult := NIL 
	::nidClientCandidate := NIL 
	::oWSstockKeepingUnitKit := NIL 
	::oWSStockKeepingUnitKitInsertUpdateResult := NIL 
	::nstockKeepingUnitKitId := NIL 
	::nidStockKeepingUnit := NIL 
	::oWSStockKeepingUnitGetAllByProductResult := NIL 
	::oWSStockKeepingUnitGetAllFromUpdatedDateResult := NIL 
	::nstartingStockKeepingUnitId := NIL 
	::oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult := NIL 
	::cEAN13             := NIL 
	::oWSStockKeepingUnitGetByEanResult := NIL 
	::oWSOrderGetResult  := NIL 
	::oWSOrderGetV3Result := NIL 
	::oWSOrderGetByClientResult := NIL 
	::ccpfCnpj           := NIL 
	::oWSOrderGetByClientCpfResult := NIL 
	::cemail             := NIL 
	::oWSOrderGetByClientEmailResult := NIL 
	::norderDeliveryId   := NIL 
	::oWSOrderGetByDeliveryIdResult := NIL 
	::nmanagementId      := NIL 
	::oWSOrderGetByManagementIdResult := NIL 
	::oWSorder           := NIL 
	::cstatusOrder       := NIL 
	::oWSOrderGetByStatusResult := NIL 
	::oWSpaymentIds      := NIL 
	::oWSOrderGetByStatusAndPaymentIdResult := NIL 
	::cTransactionId     := NIL 
	::cOrderPayPalGetStatusResult := NIL 
	::oWSOrderGetNext50FromIdResult := NIL 
	::nsequence          := NIL 
	::oWSOrderGetNext50FromIdV3Result := NIL 
	::clastDate          := NIL 
	::oWSOrderGetNext50FromIdAndDateResult := NIL 
	::oWSOrderGetNext50FromIdAndDateStatusChangedResult := NIL 
	::oWSOrderGetInteractionsResult := NIL 
	::oWSOrderGetNewV2Result := NIL 
	::oWSintegrationStatus := NIL 
	::oWSOrderGetV2Result := NIL 
	::oWSOrderGetByStatusV2Result := NIL 
	::ctrackingNumber    := NIL 
	::csellerId          := NIL 
	::csellerOrderId     := NIL 
	::oWSitemsMapping    := NIL 
	::oWSOrderGetByStatusByQuantityResult := NIL 
	::nidOrder           := NIL 
	::nAdministratorId   := NIL 
	::oWSitems           := NIL 
	::oWSOrderStatusGetAllResult := NIL 
	::oWSOrderPaymentGetAllResult := NIL 
	::oWSorderDTO        := NIL 
	::oWSorderItemDTO    := NIL 
	::oWSorderDeliveryDTO := NIL 
	::oWSOrderDeliveryInsertUpdateResult := NIL 
	::cinvoiceNumber     := NIL 
	::oWSOrderDeliveryInvoiceNumberInsertUpdateResult := NIL 
	::nidOrderDelivery   := NIL 
	::nidClient          := NIL 
	::oWSClientGetResult := NIL 
	::cidClientV3        := NIL 
	::oWSClientGetV3Result := NIL 
	::oWSClientGetByCPFResult := NIL 
	::oWSClientGetByEmailResult := NIL 
	::oWSClientGetByEmailV3Result := NIL 
	::cguid              := NIL 
	::oWSClientGetByGuidResult := NIL 
	::oWSClientGetByGuidV3Result := NIL 
	::oWSClientGetExtendedInfoResult := NIL 
	::oWSClientGetExtendedInfoByCPFResult := NIL 
	::cdateCreated       := NIL 
	::nstartingClientId  := NIL 
	::oWSClientGetAllFromCreatedDateAndIdResult := NIL 
	::nClientRewardGetResult := NIL 
	::nClientRewardGetByCPFResult := NIL 
	::ntotalReward       := NIL 
	::oWStransactionAction := NIL 
	::oWSclient          := NIL 
	::oWSaddress         := NIL 
	::naddressId         := NIL 
	::oWSClientInsertUpdateV3Result := NIL 
	::nidDistributionCenter := NIL 
	::oWSDistributionCenterGetResult := NIL 
	::ctaxId             := NIL 
	::oWSDistributionCenterGetByTaxIdResult := NIL 
	::czipCode           := NIL 
	::ndistributionCenterId := NIL 
	::nfreightTypeId     := NIL 
	::oWSFreightCalculateResult := NIL 
	::oWSfreightSkuContext := NIL 
	::oWSFreightCalculateV3Result := NIL 
	::oWSZipCodeGetResult := NIL 
	::nidFreight         := NIL 
	::oWSFreightGetResult := NIL 
	::oWSFreightGetAllResult := NIL 
	::oWSfreight         := NIL 
	::oWSFreightInsertUpdateResult := NIL 
	::oWSfreightValue    := NIL 
	::oWSFreightValueInsertUpdateResult := NIL 
	::oWSlstFreightValue := NIL 
	::naddressClientId   := NIL 
	::oWSAddressByAddressClientResult := NIL 
	::oWSAddressGetByClientIdResult := NIL 
	::cclientIdV3        := NIL 
	::oWSAddressGetByClientIdV3Result := NIL 
	::cclientIdV2        := NIL 
	::oWSAddressGetByClientIdV2Result := NIL 
	::oWSClientAddress   := NIL 
	::oWSAddressInsertByClientIdResult := NIL 
	::oWSAddressInsertUpdateV3Result := NIL 
	::oWSAddressInsertByCpfCnpjResult := NIL 
	::oWSobjBuyTogether  := NIL 
	::oWSBuyTogetherInsertUpdateResult := NIL 
	::oWSobjBuyTogetherBuyGainDTO := NIL 
	::oWSBuyTogetherBuyGainInsertUpdateResult := NIL 
	::oWSobjBuyTogetherTakeXPayYDTO := NIL 
	::oWSBuyTogethertakeXPayYInsertUpdateResult := NIL 
	::nbuyTogetherId     := NIL 
	::oWSfirstListStockKeepingUnit := NIL 
	::oWSsecondListStockKeepingUnit := NIL 
	::nidService         := NIL 
	::oWSVtexGetResult := NIL 
	::nidServicePrice    := NIL 
	::oWSVtexPriceGetResult := NIL 
	::oWSVtexPriceListResult := NIL 
	::oWSVtex         := NIL 
	::oWSVtexInsertUpdateResult := NIL 
	::nserviceId         := NIL 
	::oWSVtexPrice    := NIL 
	::oWSVtexPriceInsertUpdateResult := NIL 
	::nservicePriceId    := NIL 
	::nidStockKeepingUnitService := NIL 
	::oWSStockKeepingUnitServiceGetResult := NIL 
	::oWSStockKeepingUnitServiceListResult := NIL 
	::oWSstockKeepingUnitService := NIL 
	::oWSStockKeepingUnitServiceInsertUpdateResult := NIL 
	::nstockKeepingUnitServiceId := NIL 
	::nidBrand           := NIL 
	::oWSBrandGetResult  := NIL 
	::cnameBrand         := NIL 
	::oWSBrandGetByNameResult := NIL 
	::oWSbrand           := NIL 
	::oWSBrandInsertUpdateResult := NIL 
	::nidCategory        := NIL 
	::oWSCategoryGetResult := NIL 
	::cnameCategory      := NIL 
	::oWSCategoryGetByNameResult := NIL 
	::oWScategory        := NIL 
	::oWSCategoryInsertUpdateResult := NIL 
	::nstockKeepingUnitIdFrom := NIL 
	::nstockKeepingUnitIdTo := NIL 
	::curlImage          := NIL 
	::nfileId            := NIL 
	::oWSimage           := NIL 
	::nArchiveTypeId     := NIL 
	::oWSImageListByStockKeepingUnitIdResult := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSVtex
Local oClone := WSVtex():New()
	oClone:_URL          := ::_URL 
	oClone:nstockKeepingUnitId := ::nstockKeepingUnitId
	oClone:cimageName    := ::cimageName
	oClone:nskuId        := ::nskuId
	oClone:oWSStockKeepingUnitEspecificationListBySkuIdResult :=  IIF(::oWSStockKeepingUnitEspecificationListBySkuIdResult = NIL , NIL ,::oWSStockKeepingUnitEspecificationListBySkuIdResult:Clone() )
	oClone:nproductId    := ::nproductId
	oClone:oWSProductEspecificationListByProductIdResult :=  IIF(::oWSProductEspecificationListByProductIdResult = NIL , NIL ,::oWSProductEspecificationListByProductIdResult:Clone() )
	oClone:oWSobjStockKeepingUnitComplementDTO :=  IIF(::oWSobjStockKeepingUnitComplementDTO = NIL , NIL ,::oWSobjStockKeepingUnitComplementDTO:Clone() )
	oClone:nidProduct    := ::nidProduct
	oClone:cfieldName    := ::cfieldName
	oClone:oWSfieldValues :=  IIF(::oWSfieldValues = NIL , NIL ,::oWSfieldValues:Clone() )
	oClone:oWSlistProductFieldName :=  IIF(::oWSlistProductFieldName = NIL , NIL ,::oWSlistProductFieldName:Clone() )
	oClone:nfieldId      := ::nfieldId
	oClone:oWSlistStockKeepingUnitEspecificationFieldId :=  IIF(::oWSlistStockKeepingUnitEspecificationFieldId = NIL , NIL ,::oWSlistStockKeepingUnitEspecificationFieldId:Clone() )
	oClone:cDescription  := ::cDescription
	oClone:oWSlistStockKeepingUnitName :=  IIF(::oWSlistStockKeepingUnitName = NIL , NIL ,::oWSlistStockKeepingUnitName:Clone() )
	oClone:nidSku        := ::nidSku
	oClone:cProductSupplierGetCNPJResult := ::cProductSupplierGetCNPJResult
	oClone:ncategoryId   := ::ncategoryId
	oClone:oWSlistStockKeepingUnitdId :=  IIF(::oWSlistStockKeepingUnitdId = NIL , NIL ,::oWSlistStockKeepingUnitdId:Clone() )
	oClone:oWSStoreListResult :=  IIF(::oWSStoreListResult = NIL , NIL ,::oWSStoreListResult:Clone() )
	oClone:nstoreId      := ::nstoreId
	oClone:oWSStoreGetResult :=  IIF(::oWSStoreGetResult = NIL , NIL ,::oWSStoreGetResult:Clone() )
	oClone:oWSgiftcard   :=  IIF(::oWSgiftcard = NIL , NIL ,::oWSgiftcard:Clone() )
	oClone:oWSGiftCardInsertUpdateResult :=  IIF(::oWSGiftCardInsertUpdateResult = NIL , NIL ,::oWSGiftCardInsertUpdateResult:Clone() )
	oClone:nOrderId      := ::nOrderId
	oClone:nQuantity     := ::nQuantity
	oClone:lIsActive     := ::lIsActive
	oClone:lGiftCardTransactionItemSetStatusResult := ::lGiftCardTransactionItemSetStatusResult
	oClone:oWSgiftCardTransactionItem :=  IIF(::oWSgiftCardTransactionItem = NIL , NIL ,::oWSgiftCardTransactionItem:Clone() )
	oClone:lGiftCardTransactionItemInsertResult := ::lGiftCardTransactionItemInsertResult
	oClone:nidGiftList   := ::nidGiftList
	oClone:oWSGiftListGetResult :=  IIF(::oWSGiftListGetResult = NIL , NIL ,::oWSGiftListGetResult:Clone() )
	oClone:cclientEmail  := ::cclientEmail
	oClone:oWSGiftListGetByClientEmailResult :=  IIF(::oWSGiftListGetByClientEmailResult = NIL , NIL ,::oWSGiftListGetByClientEmailResult:Clone() )
	oClone:cclientCpfCnpj := ::cclientCpfCnpj
	oClone:oWSGiftListGetByClientCpfResult :=  IIF(::oWSGiftListGetByClientCpfResult = NIL , NIL ,::oWSGiftListGetByClientCpfResult:Clone() )
	oClone:ngiftListTypeId := ::ngiftListTypeId
	oClone:oWSGiftListGetTypeResult :=  IIF(::oWSGiftListGetTypeResult = NIL , NIL ,::oWSGiftListGetTypeResult:Clone() )
	oClone:ccreatedDate  := ::ccreatedDate
	oClone:oWSGiftListGetByCreatedDateResult :=  IIF(::oWSGiftListGetByCreatedDateResult = NIL , NIL ,::oWSGiftListGetByCreatedDateResult:Clone() )
	oClone:nstartingGiftListId := ::nstartingGiftListId
	oClone:ntopRows      := ::ntopRows
	oClone:oWSGiftListGetAllFromCreatedDateAndIdResult :=  IIF(::oWSGiftListGetAllFromCreatedDateAndIdResult = NIL , NIL ,::oWSGiftListGetAllFromCreatedDateAndIdResult:Clone() )
	oClone:ceventDateBegin := ::ceventDateBegin
	oClone:ceventDateEnd := ::ceventDateEnd
	oClone:oWSGiftListGetAllBetweenEventDateIntervalAndIdResult :=  IIF(::oWSGiftListGetAllBetweenEventDateIntervalAndIdResult = NIL , NIL ,::oWSGiftListGetAllBetweenEventDateIntervalAndIdResult:Clone() )
	oClone:cmodifiedDate := ::cmodifiedDate
	oClone:oWSGiftListGetByModifiedDateResult :=  IIF(::oWSGiftListGetByModifiedDateResult = NIL , NIL ,::oWSGiftListGetByModifiedDateResult:Clone() )
	oClone:oWSGiftListGetAllFromModifiedDateAndIdResult :=  IIF(::oWSGiftListGetAllFromModifiedDateAndIdResult = NIL , NIL ,::oWSGiftListGetAllFromModifiedDateAndIdResult:Clone() )
	oClone:cgifted       := ::cgifted
	oClone:oWSGiftListGetByGiftedResult :=  IIF(::oWSGiftListGetByGiftedResult = NIL , NIL ,::oWSGiftListGetByGiftedResult:Clone() )
	oClone:oWSgiftList   :=  IIF(::oWSgiftList = NIL , NIL ,::oWSgiftList:Clone() )
	oClone:oWSGiftListInsertUpdateResult :=  IIF(::oWSGiftListInsertUpdateResult = NIL , NIL ,::oWSGiftListInsertUpdateResult:Clone() )
	oClone:ngiftListId   := ::ngiftListId
	oClone:nclientId     := ::nclientId
	oClone:ceventDateSince := ::ceventDateSince
	oClone:ceventDateUntil := ::ceventDateUntil
	oClone:oWSGiftListV2FiltersResult :=  IIF(::oWSGiftListV2FiltersResult = NIL , NIL ,::oWSGiftListV2FiltersResult:Clone() )
	oClone:cclientName   := ::cclientName
	oClone:ceventLocation := ::ceventLocation
	oClone:ceventCity    := ::ceventCity
	oClone:ceventDate    := ::ceventDate
	oClone:oWSGiftListSearchResult :=  IIF(::oWSGiftListSearchResult = NIL , NIL ,::oWSGiftListSearchResult:Clone() )
	oClone:cclientSurname := ::cclientSurname
	oClone:oWSGiftListSearchWithSurnameResult :=  IIF(::oWSGiftListSearchWithSurnameResult = NIL , NIL ,::oWSGiftListSearchWithSurnameResult:Clone() )
	oClone:oWSgiftListMember :=  IIF(::oWSgiftListMember = NIL , NIL ,::oWSgiftListMember:Clone() )
	oClone:oWSGiftListMemberInsertUpdateResult :=  IIF(::oWSGiftListMemberInsertUpdateResult = NIL , NIL ,::oWSGiftListMemberInsertUpdateResult:Clone() )
	oClone:nGiftListMemberId := ::nGiftListMemberId
	oClone:oWSgiftListSku :=  IIF(::oWSgiftListSku = NIL , NIL ,::oWSgiftListSku:Clone() )
	oClone:oWSGiftListSkuInsertResult :=  IIF(::oWSGiftListSkuInsertResult = NIL , NIL ,::oWSGiftListSkuInsertResult:Clone() )
	oClone:oWSGiftListSkuGetResult :=  IIF(::oWSGiftListSkuGetResult = NIL , NIL ,::oWSGiftListSkuGetResult:Clone() )
	oClone:oWSskuQuantity :=  IIF(::oWSskuQuantity = NIL , NIL ,::oWSskuQuantity:Clone() )
	oClone:nId           := ::nId
	oClone:oWSGiftCardGetResult :=  IIF(::oWSGiftCardGetResult = NIL , NIL ,::oWSGiftCardGetResult:Clone() )
	oClone:credeptionCode := ::credeptionCode
	oClone:oWSGiftCardGetByRedeptionCodeResult :=  IIF(::oWSGiftCardGetByRedeptionCodeResult = NIL , NIL ,::oWSGiftCardGetByRedeptionCodeResult:Clone() )
	oClone:nEmailQueueTypeId := ::nEmailQueueTypeId
	oClone:oWSEmailQueueNotSendedByTypeResult :=  IIF(::oWSEmailQueueNotSendedByTypeResult = NIL , NIL ,::oWSEmailQueueNotSendedByTypeResult:Clone() )
	oClone:cinitialTime  := ::cinitialTime
	oClone:cfinalTime    := ::cfinalTime
	oClone:ninitialId    := ::ninitialId
	oClone:nemailTypeId  := ::nemailTypeId
	oClone:oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult :=  IIF(::oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult = NIL , NIL ,::oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult:Clone() )
	oClone:nEmailQueueId := ::nEmailQueueId
	oClone:cEmailQueueConfirmSendingResult := ::cEmailQueueConfirmSendingResult
	oClone:oWSerrorType  :=  IIF(::oWSerrorType = NIL , NIL ,::oWSerrorType:Clone() )
	oClone:cerror        := ::cerror
	oClone:nintegrationErrorId := ::nintegrationErrorId
	oClone:oWSIntegrationErrorGetAllByErrorTypeAndIdResult :=  IIF(::oWSIntegrationErrorGetAllByErrorTypeAndIdResult = NIL , NIL ,::oWSIntegrationErrorGetAllByErrorTypeAndIdResult:Clone() )
	oClone:cmessage      := ::cmessage
	oClone:oWSIntegrationInterfaceGetAllResult :=  IIF(::oWSIntegrationInterfaceGetAllResult = NIL , NIL ,::oWSIntegrationInterfaceGetAllResult:Clone() )
	oClone:cinstance     := ::cinstance
	oClone:cerrorDetail  := ::cerrorDetail
	oClone:lIntegrationErrorCheckInstanceExistsResult := ::lIntegrationErrorCheckInstanceExistsResult
	oClone:oWSCollectionGetResult :=  IIF(::oWSCollectionGetResult = NIL , NIL ,::oWSCollectionGetResult:Clone() )
	oClone:oWScollection :=  IIF(::oWScollection = NIL , NIL ,::oWScollection:Clone() )
	oClone:oWSCollectionInsertUpdateResult :=  IIF(::oWSCollectionInsertUpdateResult = NIL , NIL ,::oWSCollectionInsertUpdateResult:Clone() )
	oClone:oWSshippingNotification :=  IIF(::oWSshippingNotification = NIL , NIL ,::oWSshippingNotification:Clone() )
	oClone:oWSpackageTracking :=  IIF(::oWSpackageTracking = NIL , NIL ,::oWSpackageTracking:Clone() )
	oClone:cfiscalInvoiceXML := ::cfiscalInvoiceXML
	oClone:oWSOrderInvoice :=  IIF(::oWSOrderInvoice = NIL , NIL ,::oWSOrderInvoice:Clone() )
	oClone:nIdEstoque    := ::nIdEstoque
	oClone:nQuantidade   := ::nQuantidade
	oClone:cdateOfAvailability := ::cdateOfAvailability
	oClone:cwareHouseId  := ::cwareHouseId
	oClone:nitemId       := ::nitemId
	oClone:navailableQuantity := ::navailableQuantity
	oClone:oWSWareHouseIStockableGetByStockKeepingUnitResult :=  IIF(::oWSWareHouseIStockableGetByStockKeepingUnitResult = NIL , NIL ,::oWSWareHouseIStockableGetByStockKeepingUnitResult:Clone() )
	oClone:oWSWareHouseIStockableGetByStockKeepingUnitV3Result :=  IIF(::oWSWareHouseIStockableGetByStockKeepingUnitV3Result = NIL , NIL ,::oWSWareHouseIStockableGetByStockKeepingUnitV3Result:Clone() )
	oClone:nNewsId       := ::nNewsId
	oClone:oWSNewsletterGetResult :=  IIF(::oWSNewsletterGetResult = NIL , NIL ,::oWSNewsletterGetResult:Clone() )
	oClone:oWSNewsletterGetAllResult :=  IIF(::oWSNewsletterGetAllResult = NIL , NIL ,::oWSNewsletterGetAllResult:Clone() )
	oClone:npage         := ::npage
	oClone:oWSNewsletterGetPagedResult :=  IIF(::oWSNewsletterGetPagedResult = NIL , NIL ,::oWSNewsletterGetPagedResult:Clone() )
	oClone:cBeginDate    := ::cBeginDate
	oClone:cEndDate      := ::cEndDate
	oClone:oWSNewsletterGetAllByDateResult :=  IIF(::oWSNewsletterGetAllByDateResult = NIL , NIL ,::oWSNewsletterGetAllByDateResult:Clone() )
	oClone:oWSstockKeepingUnitVO :=  IIF(::oWSstockKeepingUnitVO = NIL , NIL ,::oWSstockKeepingUnitVO:Clone() )
	oClone:oWSStockKeepingUnitInsertUpdateResult :=  IIF(::oWSStockKeepingUnitInsertUpdateResult = NIL , NIL ,::oWSStockKeepingUnitInsertUpdateResult:Clone() )
	oClone:nstockKeepintUnitId := ::nstockKeepintUnitId
	oClone:nprice        := ::nprice
	oClone:nlistPrice    := ::nlistPrice
	oClone:ncostPrice    := ::ncostPrice
	oClone:cstockKeepintUnitRefId := ::cstockKeepintUnitRefId
	oClone:oWSStockKeepingUnitGetResult :=  IIF(::oWSStockKeepingUnitGetResult = NIL , NIL ,::oWSStockKeepingUnitGetResult:Clone() )
	oClone:cmanufacturer := ::cmanufacturer
	oClone:oWSStockKeepingUnitGetByManufacturerCodeResult :=  IIF(::oWSStockKeepingUnitGetByManufacturerCodeResult = NIL , NIL ,::oWSStockKeepingUnitGetByManufacturerCodeResult:Clone() )
	oClone:crefId        := ::crefId
	oClone:oWSStockKeepingUnitGetByRefIdResult :=  IIF(::oWSStockKeepingUnitGetByRefIdResult = NIL , NIL ,::oWSStockKeepingUnitGetByRefIdResult:Clone() )
	oClone:oWSproductVO  :=  IIF(::oWSproductVO = NIL , NIL ,::oWSproductVO:Clone() )
	oClone:oWSProductInsertUpdateResult :=  IIF(::oWSProductInsertUpdateResult = NIL , NIL ,::oWSProductInsertUpdateResult:Clone() )
	oClone:oWSProductGetResult :=  IIF(::oWSProductGetResult = NIL , NIL ,::oWSProductGetResult:Clone() )
	oClone:oWSProductGetByRefIdResult :=  IIF(::oWSProductGetByRefIdResult = NIL , NIL ,::oWSProductGetByRefIdResult:Clone() )
	oClone:oWSProductGetSimilarCategoryResult :=  IIF(::oWSProductGetSimilarCategoryResult = NIL , NIL ,::oWSProductGetSimilarCategoryResult:Clone() )
	oClone:cdateUpdated  := ::cdateUpdated
	oClone:oWSProductGetAllFromUpdatedDateAndIdResult :=  IIF(::oWSProductGetAllFromUpdatedDateAndIdResult = NIL , NIL ,::oWSProductGetAllFromUpdatedDateAndIdResult:Clone() )
	oClone:nidSkuParent  := ::nidSkuParent
	oClone:oWSStockKeepingUnitKitListByParentResult :=  IIF(::oWSStockKeepingUnitKitListByParentResult = NIL , NIL ,::oWSStockKeepingUnitKitListByParentResult:Clone() )
	oClone:oWSStockKeepingUnitKitListBySkuIdResult :=  IIF(::oWSStockKeepingUnitKitListBySkuIdResult = NIL , NIL ,::oWSStockKeepingUnitKitListBySkuIdResult:Clone() )
	oClone:oWSIntegrationSettingsResult :=  IIF(::oWSIntegrationSettingsResult = NIL , NIL ,::oWSIntegrationSettingsResult:Clone() )
	oClone:oWSClienteCandidato :=  IIF(::oWSClienteCandidato = NIL , NIL ,::oWSClienteCandidato:Clone() )
	oClone:oWSClientCandidateInsertResult :=  IIF(::oWSClientCandidateInsertResult = NIL , NIL ,::oWSClientCandidateInsertResult:Clone() )
	oClone:nidClusterGrupoClienteCandidato := ::nidClusterGrupoClienteCandidato
	oClone:oWSClientCandidateGetResult :=  IIF(::oWSClientCandidateGetResult = NIL , NIL ,::oWSClientCandidateGetResult:Clone() )
	oClone:nidClientCandidate := ::nidClientCandidate
	oClone:oWSstockKeepingUnitKit :=  IIF(::oWSstockKeepingUnitKit = NIL , NIL ,::oWSstockKeepingUnitKit:Clone() )
	oClone:oWSStockKeepingUnitKitInsertUpdateResult :=  IIF(::oWSStockKeepingUnitKitInsertUpdateResult = NIL , NIL ,::oWSStockKeepingUnitKitInsertUpdateResult:Clone() )
	oClone:nstockKeepingUnitKitId := ::nstockKeepingUnitKitId
	oClone:nidStockKeepingUnit := ::nidStockKeepingUnit
	oClone:oWSStockKeepingUnitGetAllByProductResult :=  IIF(::oWSStockKeepingUnitGetAllByProductResult = NIL , NIL ,::oWSStockKeepingUnitGetAllByProductResult:Clone() )
	oClone:oWSStockKeepingUnitGetAllFromUpdatedDateResult :=  IIF(::oWSStockKeepingUnitGetAllFromUpdatedDateResult = NIL , NIL ,::oWSStockKeepingUnitGetAllFromUpdatedDateResult:Clone() )
	oClone:nstartingStockKeepingUnitId := ::nstartingStockKeepingUnitId
	oClone:oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult :=  IIF(::oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult = NIL , NIL ,::oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult:Clone() )
	oClone:cEAN13        := ::cEAN13
	oClone:oWSStockKeepingUnitGetByEanResult :=  IIF(::oWSStockKeepingUnitGetByEanResult = NIL , NIL ,::oWSStockKeepingUnitGetByEanResult:Clone() )
	oClone:oWSOrderGetResult :=  IIF(::oWSOrderGetResult = NIL , NIL ,::oWSOrderGetResult:Clone() )
	oClone:oWSOrderGetV3Result :=  IIF(::oWSOrderGetV3Result = NIL , NIL ,::oWSOrderGetV3Result:Clone() )
	oClone:oWSOrderGetByClientResult :=  IIF(::oWSOrderGetByClientResult = NIL , NIL ,::oWSOrderGetByClientResult:Clone() )
	oClone:ccpfCnpj      := ::ccpfCnpj
	oClone:oWSOrderGetByClientCpfResult :=  IIF(::oWSOrderGetByClientCpfResult = NIL , NIL ,::oWSOrderGetByClientCpfResult:Clone() )
	oClone:cemail        := ::cemail
	oClone:oWSOrderGetByClientEmailResult :=  IIF(::oWSOrderGetByClientEmailResult = NIL , NIL ,::oWSOrderGetByClientEmailResult:Clone() )
	oClone:norderDeliveryId := ::norderDeliveryId
	oClone:oWSOrderGetByDeliveryIdResult :=  IIF(::oWSOrderGetByDeliveryIdResult = NIL , NIL ,::oWSOrderGetByDeliveryIdResult:Clone() )
	oClone:nmanagementId := ::nmanagementId
	oClone:oWSOrderGetByManagementIdResult :=  IIF(::oWSOrderGetByManagementIdResult = NIL , NIL ,::oWSOrderGetByManagementIdResult:Clone() )
	oClone:oWSorder      :=  IIF(::oWSorder = NIL , NIL ,::oWSorder:Clone() )
	oClone:cstatusOrder  := ::cstatusOrder
	oClone:oWSOrderGetByStatusResult :=  IIF(::oWSOrderGetByStatusResult = NIL , NIL ,::oWSOrderGetByStatusResult:Clone() )
	oClone:oWSpaymentIds :=  IIF(::oWSpaymentIds = NIL , NIL ,::oWSpaymentIds:Clone() )
	oClone:oWSOrderGetByStatusAndPaymentIdResult :=  IIF(::oWSOrderGetByStatusAndPaymentIdResult = NIL , NIL ,::oWSOrderGetByStatusAndPaymentIdResult:Clone() )
	oClone:cTransactionId := ::cTransactionId
	oClone:cOrderPayPalGetStatusResult := ::cOrderPayPalGetStatusResult
	oClone:oWSOrderGetNext50FromIdResult :=  IIF(::oWSOrderGetNext50FromIdResult = NIL , NIL ,::oWSOrderGetNext50FromIdResult:Clone() )
	oClone:nsequence     := ::nsequence
	oClone:oWSOrderGetNext50FromIdV3Result :=  IIF(::oWSOrderGetNext50FromIdV3Result = NIL , NIL ,::oWSOrderGetNext50FromIdV3Result:Clone() )
	oClone:clastDate     := ::clastDate
	oClone:oWSOrderGetNext50FromIdAndDateResult :=  IIF(::oWSOrderGetNext50FromIdAndDateResult = NIL , NIL ,::oWSOrderGetNext50FromIdAndDateResult:Clone() )
	oClone:oWSOrderGetNext50FromIdAndDateStatusChangedResult :=  IIF(::oWSOrderGetNext50FromIdAndDateStatusChangedResult = NIL , NIL ,::oWSOrderGetNext50FromIdAndDateStatusChangedResult:Clone() )
	oClone:oWSOrderGetInteractionsResult :=  IIF(::oWSOrderGetInteractionsResult = NIL , NIL ,::oWSOrderGetInteractionsResult:Clone() )
	oClone:oWSOrderGetNewV2Result :=  IIF(::oWSOrderGetNewV2Result = NIL , NIL ,::oWSOrderGetNewV2Result:Clone() )
	oClone:oWSintegrationStatus :=  IIF(::oWSintegrationStatus = NIL , NIL ,::oWSintegrationStatus:Clone() )
	oClone:oWSOrderGetV2Result :=  IIF(::oWSOrderGetV2Result = NIL , NIL ,::oWSOrderGetV2Result:Clone() )
	oClone:oWSOrderGetByStatusV2Result :=  IIF(::oWSOrderGetByStatusV2Result = NIL , NIL ,::oWSOrderGetByStatusV2Result:Clone() )
	oClone:ctrackingNumber := ::ctrackingNumber
	oClone:csellerId     := ::csellerId
	oClone:csellerOrderId := ::csellerOrderId
	oClone:oWSitemsMapping :=  IIF(::oWSitemsMapping = NIL , NIL ,::oWSitemsMapping:Clone() )
	oClone:oWSOrderGetByStatusByQuantityResult :=  IIF(::oWSOrderGetByStatusByQuantityResult = NIL , NIL ,::oWSOrderGetByStatusByQuantityResult:Clone() )
	oClone:nidOrder      := ::nidOrder
	oClone:nAdministratorId := ::nAdministratorId
	oClone:oWSitems      :=  IIF(::oWSitems = NIL , NIL ,::oWSitems:Clone() )
	oClone:oWSOrderStatusGetAllResult :=  IIF(::oWSOrderStatusGetAllResult = NIL , NIL ,::oWSOrderStatusGetAllResult:Clone() )
	oClone:oWSOrderPaymentGetAllResult :=  IIF(::oWSOrderPaymentGetAllResult = NIL , NIL ,::oWSOrderPaymentGetAllResult:Clone() )
	oClone:oWSorderDTO   :=  IIF(::oWSorderDTO = NIL , NIL ,::oWSorderDTO:Clone() )
	oClone:oWSorderItemDTO :=  IIF(::oWSorderItemDTO = NIL , NIL ,::oWSorderItemDTO:Clone() )
	oClone:oWSorderDeliveryDTO :=  IIF(::oWSorderDeliveryDTO = NIL , NIL ,::oWSorderDeliveryDTO:Clone() )
	oClone:oWSOrderDeliveryInsertUpdateResult :=  IIF(::oWSOrderDeliveryInsertUpdateResult = NIL , NIL ,::oWSOrderDeliveryInsertUpdateResult:Clone() )
	oClone:cinvoiceNumber := ::cinvoiceNumber
	oClone:oWSOrderDeliveryInvoiceNumberInsertUpdateResult :=  IIF(::oWSOrderDeliveryInvoiceNumberInsertUpdateResult = NIL , NIL ,::oWSOrderDeliveryInvoiceNumberInsertUpdateResult:Clone() )
	oClone:nidOrderDelivery := ::nidOrderDelivery
	oClone:nidClient     := ::nidClient
	oClone:oWSClientGetResult :=  IIF(::oWSClientGetResult = NIL , NIL ,::oWSClientGetResult:Clone() )
	oClone:cidClientV3   := ::cidClientV3
	oClone:oWSClientGetV3Result :=  IIF(::oWSClientGetV3Result = NIL , NIL ,::oWSClientGetV3Result:Clone() )
	oClone:oWSClientGetByCPFResult :=  IIF(::oWSClientGetByCPFResult = NIL , NIL ,::oWSClientGetByCPFResult:Clone() )
	oClone:oWSClientGetByEmailResult :=  IIF(::oWSClientGetByEmailResult = NIL , NIL ,::oWSClientGetByEmailResult:Clone() )
	oClone:oWSClientGetByEmailV3Result :=  IIF(::oWSClientGetByEmailV3Result = NIL , NIL ,::oWSClientGetByEmailV3Result:Clone() )
	oClone:cguid         := ::cguid
	oClone:oWSClientGetByGuidResult :=  IIF(::oWSClientGetByGuidResult = NIL , NIL ,::oWSClientGetByGuidResult:Clone() )
	oClone:oWSClientGetByGuidV3Result :=  IIF(::oWSClientGetByGuidV3Result = NIL , NIL ,::oWSClientGetByGuidV3Result:Clone() )
	oClone:oWSClientGetExtendedInfoResult :=  IIF(::oWSClientGetExtendedInfoResult = NIL , NIL ,::oWSClientGetExtendedInfoResult:Clone() )
	oClone:oWSClientGetExtendedInfoByCPFResult :=  IIF(::oWSClientGetExtendedInfoByCPFResult = NIL , NIL ,::oWSClientGetExtendedInfoByCPFResult:Clone() )
	oClone:cdateCreated  := ::cdateCreated
	oClone:nstartingClientId := ::nstartingClientId
	oClone:oWSClientGetAllFromCreatedDateAndIdResult :=  IIF(::oWSClientGetAllFromCreatedDateAndIdResult = NIL , NIL ,::oWSClientGetAllFromCreatedDateAndIdResult:Clone() )
	oClone:nClientRewardGetResult := ::nClientRewardGetResult
	oClone:nClientRewardGetByCPFResult := ::nClientRewardGetByCPFResult
	oClone:ntotalReward  := ::ntotalReward
	oClone:oWStransactionAction :=  IIF(::oWStransactionAction = NIL , NIL ,::oWStransactionAction:Clone() )
	oClone:oWSclient     :=  IIF(::oWSclient = NIL , NIL ,::oWSclient:Clone() )
	oClone:oWSaddress    :=  IIF(::oWSaddress = NIL , NIL ,::oWSaddress:Clone() )
	oClone:naddressId    := ::naddressId
	oClone:oWSClientInsertUpdateV3Result :=  IIF(::oWSClientInsertUpdateV3Result = NIL , NIL ,::oWSClientInsertUpdateV3Result:Clone() )
	oClone:nidDistributionCenter := ::nidDistributionCenter
	oClone:oWSDistributionCenterGetResult :=  IIF(::oWSDistributionCenterGetResult = NIL , NIL ,::oWSDistributionCenterGetResult:Clone() )
	oClone:ctaxId        := ::ctaxId
	oClone:oWSDistributionCenterGetByTaxIdResult :=  IIF(::oWSDistributionCenterGetByTaxIdResult = NIL , NIL ,::oWSDistributionCenterGetByTaxIdResult:Clone() )
	oClone:czipCode      := ::czipCode
	oClone:ndistributionCenterId := ::ndistributionCenterId
	oClone:nfreightTypeId := ::nfreightTypeId
	oClone:oWSFreightCalculateResult :=  IIF(::oWSFreightCalculateResult = NIL , NIL ,::oWSFreightCalculateResult:Clone() )
	oClone:oWSfreightSkuContext :=  IIF(::oWSfreightSkuContext = NIL , NIL ,::oWSfreightSkuContext:Clone() )
	oClone:oWSFreightCalculateV3Result :=  IIF(::oWSFreightCalculateV3Result = NIL , NIL ,::oWSFreightCalculateV3Result:Clone() )
	oClone:oWSZipCodeGetResult :=  IIF(::oWSZipCodeGetResult = NIL , NIL ,::oWSZipCodeGetResult:Clone() )
	oClone:nidFreight    := ::nidFreight
	oClone:oWSFreightGetResult :=  IIF(::oWSFreightGetResult = NIL , NIL ,::oWSFreightGetResult:Clone() )
	oClone:oWSFreightGetAllResult :=  IIF(::oWSFreightGetAllResult = NIL , NIL ,::oWSFreightGetAllResult:Clone() )
	oClone:oWSfreight    :=  IIF(::oWSfreight = NIL , NIL ,::oWSfreight:Clone() )
	oClone:oWSFreightInsertUpdateResult :=  IIF(::oWSFreightInsertUpdateResult = NIL , NIL ,::oWSFreightInsertUpdateResult:Clone() )
	oClone:oWSfreightValue :=  IIF(::oWSfreightValue = NIL , NIL ,::oWSfreightValue:Clone() )
	oClone:oWSFreightValueInsertUpdateResult :=  IIF(::oWSFreightValueInsertUpdateResult = NIL , NIL ,::oWSFreightValueInsertUpdateResult:Clone() )
	oClone:oWSlstFreightValue :=  IIF(::oWSlstFreightValue = NIL , NIL ,::oWSlstFreightValue:Clone() )
	oClone:naddressClientId := ::naddressClientId
	oClone:oWSAddressByAddressClientResult :=  IIF(::oWSAddressByAddressClientResult = NIL , NIL ,::oWSAddressByAddressClientResult:Clone() )
	oClone:oWSAddressGetByClientIdResult :=  IIF(::oWSAddressGetByClientIdResult = NIL , NIL ,::oWSAddressGetByClientIdResult:Clone() )
	oClone:cclientIdV3   := ::cclientIdV3
	oClone:oWSAddressGetByClientIdV3Result :=  IIF(::oWSAddressGetByClientIdV3Result = NIL , NIL ,::oWSAddressGetByClientIdV3Result:Clone() )
	oClone:cclientIdV2   := ::cclientIdV2
	oClone:oWSAddressGetByClientIdV2Result :=  IIF(::oWSAddressGetByClientIdV2Result = NIL , NIL ,::oWSAddressGetByClientIdV2Result:Clone() )
	oClone:oWSClientAddress :=  IIF(::oWSClientAddress = NIL , NIL ,::oWSClientAddress:Clone() )
	oClone:oWSAddressInsertByClientIdResult :=  IIF(::oWSAddressInsertByClientIdResult = NIL , NIL ,::oWSAddressInsertByClientIdResult:Clone() )
	oClone:oWSAddressInsertUpdateV3Result :=  IIF(::oWSAddressInsertUpdateV3Result = NIL , NIL ,::oWSAddressInsertUpdateV3Result:Clone() )
	oClone:oWSAddressInsertByCpfCnpjResult :=  IIF(::oWSAddressInsertByCpfCnpjResult = NIL , NIL ,::oWSAddressInsertByCpfCnpjResult:Clone() )
	oClone:oWSobjBuyTogether :=  IIF(::oWSobjBuyTogether = NIL , NIL ,::oWSobjBuyTogether:Clone() )
	oClone:oWSBuyTogetherInsertUpdateResult :=  IIF(::oWSBuyTogetherInsertUpdateResult = NIL , NIL ,::oWSBuyTogetherInsertUpdateResult:Clone() )
	oClone:oWSobjBuyTogetherBuyGainDTO :=  IIF(::oWSobjBuyTogetherBuyGainDTO = NIL , NIL ,::oWSobjBuyTogetherBuyGainDTO:Clone() )
	oClone:oWSBuyTogetherBuyGainInsertUpdateResult :=  IIF(::oWSBuyTogetherBuyGainInsertUpdateResult = NIL , NIL ,::oWSBuyTogetherBuyGainInsertUpdateResult:Clone() )
	oClone:oWSobjBuyTogetherTakeXPayYDTO :=  IIF(::oWSobjBuyTogetherTakeXPayYDTO = NIL , NIL ,::oWSobjBuyTogetherTakeXPayYDTO:Clone() )
	oClone:oWSBuyTogethertakeXPayYInsertUpdateResult :=  IIF(::oWSBuyTogethertakeXPayYInsertUpdateResult = NIL , NIL ,::oWSBuyTogethertakeXPayYInsertUpdateResult:Clone() )
	oClone:nbuyTogetherId := ::nbuyTogetherId
	oClone:oWSfirstListStockKeepingUnit :=  IIF(::oWSfirstListStockKeepingUnit = NIL , NIL ,::oWSfirstListStockKeepingUnit:Clone() )
	oClone:oWSsecondListStockKeepingUnit :=  IIF(::oWSsecondListStockKeepingUnit = NIL , NIL ,::oWSsecondListStockKeepingUnit:Clone() )
	oClone:nidService    := ::nidService
	oClone:oWSVtexGetResult :=  IIF(::oWSVtexGetResult = NIL , NIL ,::oWSVtexGetResult:Clone() )
	oClone:nidServicePrice := ::nidServicePrice
	oClone:oWSVtexPriceGetResult :=  IIF(::oWSVtexPriceGetResult = NIL , NIL ,::oWSVtexPriceGetResult:Clone() )
	oClone:oWSVtexPriceListResult :=  IIF(::oWSVtexPriceListResult = NIL , NIL ,::oWSVtexPriceListResult:Clone() )
	oClone:oWSVtex    :=  IIF(::oWSVtex = NIL , NIL ,::oWSVtex:Clone() )
	oClone:oWSVtexInsertUpdateResult :=  IIF(::oWSVtexInsertUpdateResult = NIL , NIL ,::oWSVtexInsertUpdateResult:Clone() )
	oClone:nserviceId    := ::nserviceId
	oClone:oWSVtexPrice :=  IIF(::oWSVtexPrice = NIL , NIL ,::oWSVtexPrice:Clone() )
	oClone:oWSVtexPriceInsertUpdateResult :=  IIF(::oWSVtexPriceInsertUpdateResult = NIL , NIL ,::oWSVtexPriceInsertUpdateResult:Clone() )
	oClone:nservicePriceId := ::nservicePriceId
	oClone:nidStockKeepingUnitService := ::nidStockKeepingUnitService
	oClone:oWSStockKeepingUnitServiceGetResult :=  IIF(::oWSStockKeepingUnitServiceGetResult = NIL , NIL ,::oWSStockKeepingUnitServiceGetResult:Clone() )
	oClone:oWSStockKeepingUnitServiceListResult :=  IIF(::oWSStockKeepingUnitServiceListResult = NIL , NIL ,::oWSStockKeepingUnitServiceListResult:Clone() )
	oClone:oWSstockKeepingUnitService :=  IIF(::oWSstockKeepingUnitService = NIL , NIL ,::oWSstockKeepingUnitService:Clone() )
	oClone:oWSStockKeepingUnitServiceInsertUpdateResult :=  IIF(::oWSStockKeepingUnitServiceInsertUpdateResult = NIL , NIL ,::oWSStockKeepingUnitServiceInsertUpdateResult:Clone() )
	oClone:nstockKeepingUnitServiceId := ::nstockKeepingUnitServiceId
	oClone:nidBrand      := ::nidBrand
	oClone:oWSBrandGetResult :=  IIF(::oWSBrandGetResult = NIL , NIL ,::oWSBrandGetResult:Clone() )
	oClone:cnameBrand    := ::cnameBrand
	oClone:oWSBrandGetByNameResult :=  IIF(::oWSBrandGetByNameResult = NIL , NIL ,::oWSBrandGetByNameResult:Clone() )
	oClone:oWSbrand      :=  IIF(::oWSbrand = NIL , NIL ,::oWSbrand:Clone() )
	oClone:oWSBrandInsertUpdateResult :=  IIF(::oWSBrandInsertUpdateResult = NIL , NIL ,::oWSBrandInsertUpdateResult:Clone() )
	oClone:nidCategory   := ::nidCategory
	oClone:oWSCategoryGetResult :=  IIF(::oWSCategoryGetResult = NIL , NIL ,::oWSCategoryGetResult:Clone() )
	oClone:cnameCategory := ::cnameCategory
	oClone:oWSCategoryGetByNameResult :=  IIF(::oWSCategoryGetByNameResult = NIL , NIL ,::oWSCategoryGetByNameResult:Clone() )
	oClone:oWScategory   :=  IIF(::oWScategory = NIL , NIL ,::oWScategory:Clone() )
	oClone:oWSCategoryInsertUpdateResult :=  IIF(::oWSCategoryInsertUpdateResult = NIL , NIL ,::oWSCategoryInsertUpdateResult:Clone() )
	oClone:nstockKeepingUnitIdFrom := ::nstockKeepingUnitIdFrom
	oClone:nstockKeepingUnitIdTo := ::nstockKeepingUnitIdTo
	oClone:curlImage     := ::curlImage
	oClone:nfileId       := ::nfileId
	oClone:oWSimage      :=  IIF(::oWSimage = NIL , NIL ,::oWSimage:Clone() )
	oClone:nArchiveTypeId := ::nArchiveTypeId
	oClone:oWSImageListByStockKeepingUnitIdResult :=  IIF(::oWSImageListByStockKeepingUnitIdResult = NIL , NIL ,::oWSImageListByStockKeepingUnitIdResult:Clone() )
Return oClone

// WSDL Method StockKeepingUnitImageRemove of Service WSVtex

WSMETHOD StockKeepingUnitImageRemove WSSEND nstockKeepingUnitId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitImageRemove xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepingUnitId", ::nstockKeepingUnitId, nstockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitImageRemove>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitImageRemove",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitImageRemoveByName of Service WSVtex

WSMETHOD StockKeepingUnitImageRemoveByName WSSEND cimageName WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitImageRemoveByName xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("imageName", ::cimageName, cimageName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitImageRemoveByName>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitImageRemoveByName",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitEspecificationListBySkuId of Service WSVtex

WSMETHOD StockKeepingUnitEspecificationListBySkuId WSSEND nskuId WSRECEIVE oWSStockKeepingUnitEspecificationListBySkuIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitEspecificationListBySkuId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("skuId", ::nskuId, nskuId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitEspecificationListBySkuId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitEspecificationListBySkuId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitEspecificationListBySkuIdResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITESPECIFICATIONLISTBYSKUIDRESPONSE:_STOCKKEEPINGUNITESPECIFICATIONLISTBYSKUIDRESULT","ArrayOfFieldDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductEspecificationListByProductId of Service WSVtex

WSMETHOD ProductEspecificationListByProductId WSSEND nproductId WSRECEIVE oWSProductEspecificationListByProductIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductEspecificationListByProductId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("productId", ::nproductId, nproductId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductEspecificationListByProductId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductEspecificationListByProductId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSProductEspecificationListByProductIdResult:SoapRecv( WSAdvValue( oXmlRet,"_PRODUCTESPECIFICATIONLISTBYPRODUCTIDRESPONSE:_PRODUCTESPECIFICATIONLISTBYPRODUCTIDRESULT","ArrayOfFieldDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitComplementInsertUpdate of Service WSVtex

WSMETHOD StockKeepingUnitComplementInsertUpdate WSSEND oWSobjStockKeepingUnitComplementDTO WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitComplementInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("objStockKeepingUnitComplementDTO", ::oWSobjStockKeepingUnitComplementDTO, oWSobjStockKeepingUnitComplementDTO , "StockKeepingUnitComplementDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitComplementInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitComplementInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductEspecificationInsert of Service WSVtex

WSMETHOD ProductEspecificationInsert WSSEND nidProduct,cfieldName,oWSfieldValues WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductEspecificationInsert xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idProduct", ::nidProduct, nidProduct , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldName", ::cfieldName, cfieldName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductEspecificationInsert>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductEspecificationInsert",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductEspecificationInsertByList of Service WSVtex

WSMETHOD ProductEspecificationInsertByList WSSEND oWSlistProductFieldName WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductEspecificationInsertByList xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("listProductFieldName", ::oWSlistProductFieldName, oWSlistProductFieldName , "ArrayOfProductFieldNameDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductEspecificationInsertByList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductEspecificationInsertByList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductEspecificationInsertByFieldId of Service WSVtex

WSMETHOD ProductEspecificationInsertByFieldId WSSEND nidProduct,nfieldId,oWSfieldValues WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductEspecificationInsertByFieldId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idProduct", ::nidProduct, nidProduct , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldId", ::nfieldId, nfieldId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductEspecificationInsertByFieldId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductEspecificationInsertByFieldId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductEspecificationInsertByListFieldIds of Service WSVtex

WSMETHOD ProductEspecificationInsertByListFieldIds WSSEND oWSlistStockKeepingUnitEspecificationFieldId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductEspecificationInsertByListFieldIds xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("listStockKeepingUnitEspecificationFieldId", ::oWSlistStockKeepingUnitEspecificationFieldId, oWSlistStockKeepingUnitEspecificationFieldId , "ArrayOfProductFieldIdDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductEspecificationInsertByListFieldIds>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductEspecificationInsertByListFieldIds",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductEspecificationTextInsertByFieldId of Service WSVtex

WSMETHOD ProductEspecificationTextInsertByFieldId WSSEND nidProduct,nfieldId,cDescription WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductEspecificationTextInsertByFieldId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idProduct", ::nidProduct, nidProduct , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldId", ::nfieldId, nfieldId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("Description", ::cDescription, cDescription , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductEspecificationTextInsertByFieldId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductEspecificationTextInsertByFieldId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitEspecificationInsertByList of Service WSVtex

WSMETHOD StockKeepingUnitEspecificationInsertByList WSSEND oWSlistStockKeepingUnitName WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitEspecificationInsertByList xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("listStockKeepingUnitName", ::oWSlistStockKeepingUnitName, oWSlistStockKeepingUnitName , "ArrayOfStockKeepingUnitFieldNameDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitEspecificationInsertByList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitEspecificationInsertByList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitEspecificationInsert of Service WSVtex

WSMETHOD StockKeepingUnitEspecificationInsert WSSEND nidSku,cfieldName,oWSfieldValues WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitEspecificationInsert xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idSku", ::nidSku, nidSku , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldName", ::cfieldName, cfieldName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitEspecificationInsert>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitEspecificationInsert",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductSupplierGetCNPJ of Service WSVtex

WSMETHOD ProductSupplierGetCNPJ WSSEND nproductId WSRECEIVE cProductSupplierGetCNPJResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductSupplierGetCNPJ xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("productId", ::nproductId, nproductId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductSupplierGetCNPJ>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductSupplierGetCNPJ",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::cProductSupplierGetCNPJResult :=  WSAdvValue( oXmlRet,"_PRODUCTSUPPLIERGETCNPJRESPONSE:_PRODUCTSUPPLIERGETCNPJRESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductSetSimilarCategory of Service WSVtex

WSMETHOD ProductSetSimilarCategory WSSEND nproductId,ncategoryId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductSetSimilarCategory xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("productId", ::nproductId, nproductId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("categoryId", ::ncategoryId, ncategoryId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductSetSimilarCategory>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductSetSimilarCategory",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitEspecificationInsertByListFieldId of Service WSVtex

WSMETHOD StockKeepingUnitEspecificationInsertByListFieldId WSSEND oWSlistStockKeepingUnitdId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitEspecificationInsertByListFieldId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("listStockKeepingUnitdId", ::oWSlistStockKeepingUnitdId, oWSlistStockKeepingUnitdId , "ArrayOfStockKeepingUnitFieldIdDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitEspecificationInsertByListFieldId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitEspecificationInsertByListFieldId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StoreList of Service WSVtex

WSMETHOD StoreList WSSEND NULLPARAM WSRECEIVE oWSStoreListResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StoreList xmlns="http://tempuri.org/">'
cSoap += "</StoreList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StoreList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStoreListResult:SoapRecv( WSAdvValue( oXmlRet,"_STORELISTRESPONSE:_STORELISTRESULT","ArrayOfStoreDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StoreGet of Service WSVtex

WSMETHOD StoreGet WSSEND nstoreId WSRECEIVE oWSStoreGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StoreGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("storeId", ::nstoreId, nstoreId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StoreGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StoreGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStoreGetResult:SoapRecv( WSAdvValue( oXmlRet,"_STOREGETRESPONSE:_STOREGETRESULT","StoreDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitEspecificationInsertByFieldId of Service WSVtex

WSMETHOD StockKeepingUnitEspecificationInsertByFieldId WSSEND nidSku,nfieldId,oWSfieldValues WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitEspecificationInsertByFieldId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idSku", ::nidSku, nidSku , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldId", ::nfieldId, nfieldId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitEspecificationInsertByFieldId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitEspecificationInsertByFieldId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftCardInsertUpdate of Service WSVtex

WSMETHOD GiftCardInsertUpdate WSSEND oWSgiftcard WSRECEIVE oWSGiftCardInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftCardInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftcard", ::oWSgiftcard, oWSgiftcard , "GiftCardDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftCardInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftCardInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftCardInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTCARDINSERTUPDATERESPONSE:_GIFTCARDINSERTUPDATERESULT","GiftCardDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftCardTransactionItemSetStatus of Service WSVtex

WSMETHOD GiftCardTransactionItemSetStatus WSSEND nOrderId,nStockKeepingUnitId,nQuantity,lIsActive WSRECEIVE lGiftCardTransactionItemSetStatusResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftCardTransactionItemSetStatus xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("OrderId", ::nOrderId, nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("Quantity", ::nQuantity, nQuantity , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("IsActive", ::lIsActive, lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftCardTransactionItemSetStatus>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftCardTransactionItemSetStatus",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::lGiftCardTransactionItemSetStatusResult :=  WSAdvValue( oXmlRet,"_GIFTCARDTRANSACTIONITEMSETSTATUSRESPONSE:_GIFTCARDTRANSACTIONITEMSETSTATUSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftCardTransactionItemInsert of Service WSVtex

WSMETHOD GiftCardTransactionItemInsert WSSEND oWSgiftCardTransactionItem WSRECEIVE lGiftCardTransactionItemInsertResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftCardTransactionItemInsert xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftCardTransactionItem", ::oWSgiftCardTransactionItem, oWSgiftCardTransactionItem , "GiftCardTransactionItemDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftCardTransactionItemInsert>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftCardTransactionItemInsert",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::lGiftCardTransactionItemInsertResult :=  WSAdvValue( oXmlRet,"_GIFTCARDTRANSACTIONITEMINSERTRESPONSE:_GIFTCARDTRANSACTIONITEMINSERTRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGet of Service WSVtex

WSMETHOD GiftListGet WSSEND nidGiftList WSRECEIVE oWSGiftListGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idGiftList", ::nidGiftList, nidGiftList , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETRESPONSE:_GIFTLISTGETRESULT","GiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetByClientEmail of Service WSVtex

WSMETHOD GiftListGetByClientEmail WSSEND cclientEmail WSRECEIVE oWSGiftListGetByClientEmailResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetByClientEmail xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientEmail", ::cclientEmail, cclientEmail , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetByClientEmail>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetByClientEmail",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetByClientEmailResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETBYCLIENTEMAILRESPONSE:_GIFTLISTGETBYCLIENTEMAILRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetByClientCpf of Service WSVtex

WSMETHOD GiftListGetByClientCpf WSSEND cclientCpfCnpj WSRECEIVE oWSGiftListGetByClientCpfResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetByClientCpf xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientCpfCnpj", ::cclientCpfCnpj, cclientCpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetByClientCpf>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetByClientCpf",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetByClientCpfResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETBYCLIENTCPFRESPONSE:_GIFTLISTGETBYCLIENTCPFRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetType of Service WSVtex

WSMETHOD GiftListGetType WSSEND ngiftListTypeId WSRECEIVE oWSGiftListGetTypeResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetType xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListTypeId", ::ngiftListTypeId, ngiftListTypeId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetType>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetType",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetTypeResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETTYPERESPONSE:_GIFTLISTGETTYPERESULT","GiftListTypeDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetByCreatedDate of Service WSVtex

WSMETHOD GiftListGetByCreatedDate WSSEND ccreatedDate WSRECEIVE oWSGiftListGetByCreatedDateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetByCreatedDate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("createdDate", ::ccreatedDate, ccreatedDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetByCreatedDate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetByCreatedDate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetByCreatedDateResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETBYCREATEDDATERESPONSE:_GIFTLISTGETBYCREATEDDATERESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetAllFromCreatedDateAndId of Service WSVtex

WSMETHOD GiftListGetAllFromCreatedDateAndId WSSEND ccreatedDate,nstartingGiftListId,ntopRows WSRECEIVE oWSGiftListGetAllFromCreatedDateAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetAllFromCreatedDateAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("createdDate", ::ccreatedDate, ccreatedDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("startingGiftListId", ::nstartingGiftListId, nstartingGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetAllFromCreatedDateAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetAllFromCreatedDateAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetAllFromCreatedDateAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETALLFROMCREATEDDATEANDIDRESPONSE:_GIFTLISTGETALLFROMCREATEDDATEANDIDRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetAllBetweenEventDateIntervalAndId of Service WSVtex

WSMETHOD GiftListGetAllBetweenEventDateIntervalAndId WSSEND ceventDateBegin,ceventDateEnd,nstartingGiftListId,ntopRows WSRECEIVE oWSGiftListGetAllBetweenEventDateIntervalAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetAllBetweenEventDateIntervalAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("eventDateBegin", ::ceventDateBegin, ceventDateBegin , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventDateEnd", ::ceventDateEnd, ceventDateEnd , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("startingGiftListId", ::nstartingGiftListId, nstartingGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetAllBetweenEventDateIntervalAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetAllBetweenEventDateIntervalAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetAllBetweenEventDateIntervalAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETALLBETWEENEVENTDATEINTERVALANDIDRESPONSE:_GIFTLISTGETALLBETWEENEVENTDATEINTERVALANDIDRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetByModifiedDate of Service WSVtex

WSMETHOD GiftListGetByModifiedDate WSSEND cmodifiedDate WSRECEIVE oWSGiftListGetByModifiedDateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetByModifiedDate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("modifiedDate", ::cmodifiedDate, cmodifiedDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetByModifiedDate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetByModifiedDate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetByModifiedDateResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETBYMODIFIEDDATERESPONSE:_GIFTLISTGETBYMODIFIEDDATERESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetAllFromModifiedDateAndId of Service WSVtex

WSMETHOD GiftListGetAllFromModifiedDateAndId WSSEND cmodifiedDate,nstartingGiftListId,ntopRows WSRECEIVE oWSGiftListGetAllFromModifiedDateAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetAllFromModifiedDateAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("modifiedDate", ::cmodifiedDate, cmodifiedDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("startingGiftListId", ::nstartingGiftListId, nstartingGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetAllFromModifiedDateAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetAllFromModifiedDateAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetAllFromModifiedDateAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETALLFROMMODIFIEDDATEANDIDRESPONSE:_GIFTLISTGETALLFROMMODIFIEDDATEANDIDRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListGetByGifted of Service WSVtex

WSMETHOD GiftListGetByGifted WSSEND cgifted WSRECEIVE oWSGiftListGetByGiftedResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListGetByGifted xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("gifted", ::cgifted, cgifted , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListGetByGifted>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListGetByGifted",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListGetByGiftedResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTGETBYGIFTEDRESPONSE:_GIFTLISTGETBYGIFTEDRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListInsertUpdate of Service WSVtex

WSMETHOD GiftListInsertUpdate WSSEND oWSgiftList WSRECEIVE oWSGiftListInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftList", ::oWSgiftList, oWSgiftList , "GiftListDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTINSERTUPDATERESPONSE:_GIFTLISTINSERTUPDATERESULT","GiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListV2Filters of Service WSVtex

WSMETHOD GiftListV2Filters WSSEND ngiftListTypeId,ngiftListId,nclientId,ceventDateSince,ceventDateUntil,lisActive WSRECEIVE oWSGiftListV2FiltersResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListV2Filters xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListTypeId", ::ngiftListTypeId, ngiftListTypeId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("giftListId", ::ngiftListId, ngiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("clientId", ::nclientId, nclientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventDateSince", ::ceventDateSince, ceventDateSince , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventDateUntil", ::ceventDateUntil, ceventDateUntil , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("isActive", ::lisActive, lisActive , "boolean", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListV2Filters>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListV2Filters",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListV2FiltersResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTV2FILTERSRESPONSE:_GIFTLISTV2FILTERSRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSearch of Service WSVtex

WSMETHOD GiftListSearch WSSEND cclientName,ceventLocation,ceventCity,ceventDate WSRECEIVE oWSGiftListSearchResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSearch xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientName", ::cclientName, cclientName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventLocation", ::ceventLocation, ceventLocation , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventCity", ::ceventCity, ceventCity , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventDate", ::ceventDate, ceventDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSearch>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSearch",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListSearchResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTSEARCHRESPONSE:_GIFTLISTSEARCHRESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSearchWithSurname of Service WSVtex

WSMETHOD GiftListSearchWithSurname WSSEND cclientName,cclientSurname,ceventLocation,ceventCity,ceventDate WSRECEIVE oWSGiftListSearchWithSurnameResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSearchWithSurname xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientName", ::cclientName, cclientName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("clientSurname", ::cclientSurname, cclientSurname , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventLocation", ::ceventLocation, ceventLocation , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventCity", ::ceventCity, ceventCity , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("eventDate", ::ceventDate, ceventDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSearchWithSurname>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSearchWithSurname",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListSearchWithSurnameResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTSEARCHWITHSURNAMERESPONSE:_GIFTLISTSEARCHWITHSURNAMERESULT","ArrayOfGiftListDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListMemberInsertUpdate of Service WSVtex

WSMETHOD GiftListMemberInsertUpdate WSSEND oWSgiftListMember WSRECEIVE oWSGiftListMemberInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListMemberInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListMember", ::oWSgiftListMember, oWSgiftListMember , "ArrayOfGiftListMemberDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListMemberInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListMemberInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListMemberInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTMEMBERINSERTUPDATERESPONSE:_GIFTLISTMEMBERINSERTUPDATERESULT","ArrayOfGiftListMemberDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListMemberDelete of Service WSVtex

WSMETHOD GiftListMemberDelete WSSEND nGiftListMemberId,nGiftListId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListMemberDelete xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("GiftListMemberId", ::nGiftListMemberId, nGiftListMemberId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("GiftListId", ::nGiftListId, nGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListMemberDelete>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListMemberDelete",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSkuInsert of Service WSVtex

WSMETHOD GiftListSkuInsert WSSEND oWSgiftListSku WSRECEIVE oWSGiftListSkuInsertResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSkuInsert xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListSku", ::oWSgiftListSku, oWSgiftListSku , "GiftListStockKeepingUnitDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSkuInsert>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSkuInsert",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListSkuInsertResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTSKUINSERTRESPONSE:_GIFTLISTSKUINSERTRESULT","GiftListStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSkuGet of Service WSVtex

WSMETHOD GiftListSkuGet WSSEND nidGiftList WSRECEIVE oWSGiftListSkuGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSkuGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idGiftList", ::nidGiftList, nidGiftList , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSkuGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSkuGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftListSkuGetResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTLISTSKUGETRESPONSE:_GIFTLISTSKUGETRESULT","ArrayOfGiftListStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSkuSetPurchased of Service WSVtex

WSMETHOD GiftListSkuSetPurchased WSSEND ngiftListId,nskuId,nQuantity,norderId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSkuSetPurchased xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListId", ::ngiftListId, ngiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("skuId", ::nskuId, nskuId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("Quantity", ::nQuantity, nQuantity , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSkuSetPurchased>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSkuSetPurchased",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSkuDeleteByList of Service WSVtex

WSMETHOD GiftListSkuDeleteByList WSSEND ngiftListId,oWSskuQuantity WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSkuDeleteByList xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListId", ::ngiftListId, ngiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("skuQuantity", ::oWSskuQuantity, oWSskuQuantity , "ArrayOfStockKeepingUnitQuantityDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSkuDeleteByList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSkuDeleteByList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftListSkuDelete of Service WSVtex

WSMETHOD GiftListSkuDelete WSSEND ngiftListId,nskuId,nQuantity WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftListSkuDelete xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("giftListId", ::ngiftListId, ngiftListId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("skuId", ::nskuId, nskuId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("Quantity", ::nQuantity, nQuantity , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftListSkuDelete>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftListSkuDelete",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftCardGet of Service WSVtex

WSMETHOD GiftCardGet WSSEND nId WSRECEIVE oWSGiftCardGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftCardGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("Id", ::nId, nId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftCardGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftCardGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftCardGetResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTCARDGETRESPONSE:_GIFTCARDGETRESULT","GiftCardDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GiftCardGetByRedeptionCode of Service WSVtex

WSMETHOD GiftCardGetByRedeptionCode WSSEND credeptionCode WSRECEIVE oWSGiftCardGetByRedeptionCodeResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GiftCardGetByRedeptionCode xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("redeptionCode", ::credeptionCode, credeptionCode , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GiftCardGetByRedeptionCode>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/GiftCardGetByRedeptionCode",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSGiftCardGetByRedeptionCodeResult:SoapRecv( WSAdvValue( oXmlRet,"_GIFTCARDGETBYREDEPTIONCODERESPONSE:_GIFTCARDGETBYREDEPTIONCODERESULT","GiftCardDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method EmailQueueNotSendedByType of Service WSVtex

WSMETHOD EmailQueueNotSendedByType WSSEND nEmailQueueTypeId WSRECEIVE oWSEmailQueueNotSendedByTypeResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<EmailQueueNotSendedByType xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("EmailQueueTypeId", ::nEmailQueueTypeId, nEmailQueueTypeId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</EmailQueueNotSendedByType>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/EmailQueueNotSendedByType",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSEmailQueueNotSendedByTypeResult:SoapRecv( WSAdvValue( oXmlRet,"_EMAILQUEUENOTSENDEDBYTYPERESPONSE:_EMAILQUEUENOTSENDEDBYTYPERESULT","ArrayOfEmailQueueDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method EmailQueueGetAllBetweenTimeIntervalAndEmailTypeId of Service WSVtex

WSMETHOD EmailQueueGetAllBetweenTimeIntervalAndEmailTypeId WSSEND cinitialTime,cfinalTime,ninitialId,ntopRows,nemailTypeId WSRECEIVE oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<EmailQueueGetAllBetweenTimeIntervalAndEmailTypeId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("initialTime", ::cinitialTime, cinitialTime , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("finalTime", ::cfinalTime, cfinalTime , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("initialId", ::ninitialId, ninitialId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("emailTypeId", ::nemailTypeId, nemailTypeId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</EmailQueueGetAllBetweenTimeIntervalAndEmailTypeId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/EmailQueueGetAllBetweenTimeIntervalAndEmailTypeId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSEmailQueueGetAllBetweenTimeIntervalAndEmailTypeIdResult:SoapRecv( WSAdvValue( oXmlRet,"_EMAILQUEUEGETALLBETWEENTIMEINTERVALANDEMAILTYPEIDRESPONSE:_EMAILQUEUEGETALLBETWEENTIMEINTERVALANDEMAILTYPEIDRESULT","ArrayOfEmailQueueDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method EmailQueueConfirmSending of Service WSVtex

WSMETHOD EmailQueueConfirmSending WSSEND nEmailQueueId WSRECEIVE cEmailQueueConfirmSendingResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<EmailQueueConfirmSending xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("EmailQueueId", ::nEmailQueueId, nEmailQueueId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</EmailQueueConfirmSending>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/EmailQueueConfirmSending",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::cEmailQueueConfirmSendingResult :=  WSAdvValue( oXmlRet,"_EMAILQUEUECONFIRMSENDINGRESPONSE:_EMAILQUEUECONFIRMSENDINGRESULT:TEXT","dateTime",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationLogError of Service WSVtex

WSMETHOD IntegrationLogError WSSEND oWSerrorType,cerror WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationLogError xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("errorType", ::oWSerrorType, oWSerrorType , "ErrorType", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("error", ::cerror, cerror , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationLogError>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationLogError",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationLog of Service WSVtex

WSMETHOD IntegrationLog WSSEND oWSerrorType WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationLog xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("errorType", ::oWSerrorType, oWSerrorType , "ErrorType", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationLog>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationLog",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationErrorGetAllByErrorTypeAndId of Service WSVtex

WSMETHOD IntegrationErrorGetAllByErrorTypeAndId WSSEND oWSerrorType,nintegrationErrorId,ntopRows WSRECEIVE oWSIntegrationErrorGetAllByErrorTypeAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationErrorGetAllByErrorTypeAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("errorType", ::oWSerrorType, oWSerrorType , "ErrorType", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("integrationErrorId", ::nintegrationErrorId, nintegrationErrorId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationErrorGetAllByErrorTypeAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationErrorGetAllByErrorTypeAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSIntegrationErrorGetAllByErrorTypeAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_INTEGRATIONERRORGETALLBYERRORTYPEANDIDRESPONSE:_INTEGRATIONERRORGETALLBYERRORTYPEANDIDRESULT","ArrayOfIntegrationErrorDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationLogEvent of Service WSVtex

WSMETHOD IntegrationLogEvent WSSEND oWSerrorType,cmessage,norderId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationLogEvent xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("errorType", ::oWSerrorType, oWSerrorType , "ErrorType", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("message", ::cmessage, cmessage , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationLogEvent>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationLogEvent",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationInterfaceGetAll of Service WSVtex

WSMETHOD IntegrationInterfaceGetAll WSSEND NULLPARAM WSRECEIVE oWSIntegrationInterfaceGetAllResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationInterfaceGetAll xmlns="http://tempuri.org/">'
cSoap += "</IntegrationInterfaceGetAll>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationInterfaceGetAll",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSIntegrationInterfaceGetAllResult:SoapRecv( WSAdvValue( oXmlRet,"_INTEGRATIONINTERFACEGETALLRESPONSE:_INTEGRATIONINTERFACEGETALLRESULT","ArrayOfIntegrationInterfaceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationLogErrorInsertUpdate of Service WSVtex

WSMETHOD IntegrationLogErrorInsertUpdate WSSEND oWSerrorType,cinstance,cerror,cerrorDetail WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationLogErrorInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("errorType", ::oWSerrorType, oWSerrorType , "ErrorType", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("instance", ::cinstance, cinstance , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("error", ::cerror, cerror , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("errorDetail", ::cerrorDetail, cerrorDetail , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationLogErrorInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationLogErrorInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationErrorCheckInstanceExists of Service WSVtex

WSMETHOD IntegrationErrorCheckInstanceExists WSSEND oWSerrorType,cinstance WSRECEIVE lIntegrationErrorCheckInstanceExistsResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationErrorCheckInstanceExists xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("errorType", ::oWSerrorType, oWSerrorType , "ErrorType", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("instance", ::cinstance, cinstance , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationErrorCheckInstanceExists>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationErrorCheckInstanceExists",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::lIntegrationErrorCheckInstanceExistsResult :=  WSAdvValue( oXmlRet,"_INTEGRATIONERRORCHECKINSTANCEEXISTSRESPONSE:_INTEGRATIONERRORCHECKINSTANCEEXISTSRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CollectionGet of Service WSVtex

WSMETHOD CollectionGet WSSEND nId WSRECEIVE oWSCollectionGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CollectionGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("Id", ::nId, nId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</CollectionGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/CollectionGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSCollectionGetResult:SoapRecv( WSAdvValue( oXmlRet,"_COLLECTIONGETRESPONSE:_COLLECTIONGETRESULT","CollectionDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CollectionInsertUpdate of Service WSVtex

WSMETHOD CollectionInsertUpdate WSSEND oWScollection WSRECEIVE oWSCollectionInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CollectionInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("collection", ::oWScollection, oWScollection , "CollectionDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</CollectionInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/CollectionInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSCollectionInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_COLLECTIONINSERTUPDATERESPONSE:_COLLECTIONINSERTUPDATERESULT","CollectionDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ShippingNotificationInsertUpdate of Service WSVtex

WSMETHOD ShippingNotificationInsertUpdate WSSEND oWSshippingNotification WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ShippingNotificationInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("shippingNotification", ::oWSshippingNotification, oWSshippingNotification , "ShippingNotificationDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ShippingNotificationInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ShippingNotificationInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ShippingNotificationInsertUpdateParameters of Service WSVtex

WSMETHOD ShippingNotificationInsertUpdateParameters WSSEND cOrderId,oWSpackageTracking,cfiscalInvoiceXML WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ShippingNotificationInsertUpdateParameters xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("OrderId", ::cOrderId, cOrderId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("packageTracking", ::oWSpackageTracking, oWSpackageTracking , "PackageTrackingDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fiscalInvoiceXML", ::cfiscalInvoiceXML, cfiscalInvoiceXML , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ShippingNotificationInsertUpdateParameters>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ShippingNotificationInsertUpdateParameters",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method UpdateNotifyShipping of Service WSVtex

WSMETHOD UpdateNotifyShipping WSSEND oWSOrderInvoice WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<UpdateNotifyShipping xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("OrderInvoice", ::oWSOrderInvoice, oWSOrderInvoice , "OrderInvoiceDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</UpdateNotifyShipping>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/UpdateNotifyShipping",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WareHouseIStockableUpdate of Service WSVtex

WSMETHOD WareHouseIStockableUpdate WSSEND nIdEstoque,nIdSku,nQuantidade,cdateOfAvailability WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WareHouseIStockableUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("IdEstoque", ::nIdEstoque, nIdEstoque , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("IdSku", ::nIdSku, nIdSku , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("Quantidade", ::nQuantidade, nQuantidade , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("dateOfAvailability", ::cdateOfAvailability, cdateOfAvailability , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</WareHouseIStockableUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/WareHouseIStockableUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WareHouseIStockableUpdateV3 of Service WSVtex

WSMETHOD WareHouseIStockableUpdateV3 WSSEND cwareHouseId,nitemId,navailableQuantity,cdateOfAvailability WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WareHouseIStockableUpdateV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("wareHouseId", ::cwareHouseId, cwareHouseId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("itemId", ::nitemId, nitemId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("availableQuantity", ::navailableQuantity, navailableQuantity , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("dateOfAvailability", ::cdateOfAvailability, cdateOfAvailability , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</WareHouseIStockableUpdateV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/WareHouseIStockableUpdateV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WareHouseIStockableGetByStockKeepingUnit of Service WSVtex

WSMETHOD WareHouseIStockableGetByStockKeepingUnit WSSEND nWareHouseId,nSkuId WSRECEIVE oWSWareHouseIStockableGetByStockKeepingUnitResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WareHouseIStockableGetByStockKeepingUnit xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("WareHouseId", ::nWareHouseId, nWareHouseId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("SkuId", ::nSkuId, nSkuId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</WareHouseIStockableGetByStockKeepingUnit>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/WareHouseIStockableGetByStockKeepingUnit",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSWareHouseIStockableGetByStockKeepingUnitResult:SoapRecv( WSAdvValue( oXmlRet,"_WAREHOUSEISTOCKABLEGETBYSTOCKKEEPINGUNITRESPONSE:_WAREHOUSEISTOCKABLEGETBYSTOCKKEEPINGUNITRESULT","WareHouseIStockableDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WareHouseIStockableGetByStockKeepingUnitV3 of Service WSVtex

WSMETHOD WareHouseIStockableGetByStockKeepingUnitV3 WSSEND nSkuId WSRECEIVE oWSWareHouseIStockableGetByStockKeepingUnitV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WareHouseIStockableGetByStockKeepingUnitV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("SkuId", ::nSkuId, nSkuId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</WareHouseIStockableGetByStockKeepingUnitV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/WareHouseIStockableGetByStockKeepingUnitV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSWareHouseIStockableGetByStockKeepingUnitV3Result:SoapRecv( WSAdvValue( oXmlRet,"_WAREHOUSEISTOCKABLEGETBYSTOCKKEEPINGUNITV3RESPONSE:_WAREHOUSEISTOCKABLEGETBYSTOCKKEEPINGUNITV3RESULT","ArrayOfWareHouseIStockableDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method NewsletterGet of Service WSVtex

WSMETHOD NewsletterGet WSSEND nNewsId WSRECEIVE oWSNewsletterGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<NewsletterGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("NewsId", ::nNewsId, nNewsId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</NewsletterGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/NewsletterGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSNewsletterGetResult:SoapRecv( WSAdvValue( oXmlRet,"_NEWSLETTERGETRESPONSE:_NEWSLETTERGETRESULT","NewsletterDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method NewsletterGetAll of Service WSVtex

WSMETHOD NewsletterGetAll WSSEND NULLPARAM WSRECEIVE oWSNewsletterGetAllResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<NewsletterGetAll xmlns="http://tempuri.org/">'
cSoap += "</NewsletterGetAll>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/NewsletterGetAll",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSNewsletterGetAllResult:SoapRecv( WSAdvValue( oXmlRet,"_NEWSLETTERGETALLRESPONSE:_NEWSLETTERGETALLRESULT","ArrayOfNewsletterDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method NewsletterGetPaged of Service WSVtex

WSMETHOD NewsletterGetPaged WSSEND npage,nquantity WSRECEIVE oWSNewsletterGetPagedResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<NewsletterGetPaged xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("page", ::npage, npage , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("quantity", ::nquantity, nquantity , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</NewsletterGetPaged>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/NewsletterGetPaged",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSNewsletterGetPagedResult:SoapRecv( WSAdvValue( oXmlRet,"_NEWSLETTERGETPAGEDRESPONSE:_NEWSLETTERGETPAGEDRESULT","ArrayOfNewsletterDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method NewsletterGetAllByDate of Service WSVtex

WSMETHOD NewsletterGetAllByDate WSSEND cBeginDate,cEndDate WSRECEIVE oWSNewsletterGetAllByDateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<NewsletterGetAllByDate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("BeginDate", ::cBeginDate, cBeginDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("EndDate", ::cEndDate, cEndDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</NewsletterGetAllByDate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/NewsletterGetAllByDate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSNewsletterGetAllByDateResult:SoapRecv( WSAdvValue( oXmlRet,"_NEWSLETTERGETALLBYDATERESPONSE:_NEWSLETTERGETALLBYDATERESULT","ArrayOfNewsletterDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitInsertUpdate of Service WSVtex

WSMETHOD StockKeepingUnitInsertUpdate WSSEND oWSstockKeepingUnitVO WSRECEIVE oWSStockKeepingUnitInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepingUnitVO", ::oWSstockKeepingUnitVO, oWSstockKeepingUnitVO , "StockKeepingUnitDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITINSERTUPDATERESPONSE:_STOCKKEEPINGUNITINSERTUPDATERESULT","StockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitPriceUpdate of Service WSVtex

WSMETHOD StockKeepingUnitPriceUpdate WSSEND nstockKeepintUnitId,nprice,nlistPrice,ncostPrice WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitPriceUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepintUnitId", ::nstockKeepintUnitId, nstockKeepintUnitId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("price", ::nprice, nprice , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("listPrice", ::nlistPrice, nlistPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("costPrice", ::ncostPrice, ncostPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitPriceUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitPriceUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitPriceUpdateByRefId of Service WSVtex

WSMETHOD StockKeepingUnitPriceUpdateByRefId WSSEND cstockKeepintUnitRefId,nprice,nlistPrice,ncostPrice WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitPriceUpdateByRefId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepintUnitRefId", ::cstockKeepintUnitRefId, cstockKeepintUnitRefId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("price", ::nprice, nprice , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("listPrice", ::nlistPrice, nlistPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("costPrice", ::ncostPrice, ncostPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitPriceUpdateByRefId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitPriceUpdateByRefId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGet of Service WSVtex

WSMETHOD StockKeepingUnitGet WSSEND nid WSRECEIVE oWSStockKeepingUnitGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("id", ::nid, nid , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETRESPONSE:_STOCKKEEPINGUNITGETRESULT","StockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGetByManufacturerCode of Service WSVtex

WSMETHOD StockKeepingUnitGetByManufacturerCode WSSEND cmanufacturer WSRECEIVE oWSStockKeepingUnitGetByManufacturerCodeResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGetByManufacturerCode xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("manufacturer", ::cmanufacturer, cmanufacturer , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGetByManufacturerCode>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGetByManufacturerCode",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetByManufacturerCodeResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETBYMANUFACTURERCODERESPONSE:_STOCKKEEPINGUNITGETBYMANUFACTURERCODERESULT","ArrayOfStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGetByRefId of Service WSVtex

WSMETHOD StockKeepingUnitGetByRefId WSSEND crefId WSRECEIVE oWSStockKeepingUnitGetByRefIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGetByRefId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("refId", ::crefId, crefId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGetByRefId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGetByRefId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetByRefIdResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETBYREFIDRESPONSE:_STOCKKEEPINGUNITGETBYREFIDRESULT","StockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductInsertUpdate of Service WSVtex

WSMETHOD ProductInsertUpdate WSSEND oWSproductVO WSRECEIVE oWSProductInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet


         
BEGIN WSMETHOD

cSoap += '<ProductInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("productVO", ::oWSproductVO, oWSproductVO , "ProductDTO", .F. , .F., 0 , NIL, .F.) 
//cSoap+=::cSoap
cSoap += "</ProductInsertUpdate>"



oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSProductInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_PRODUCTINSERTUPDATERESPONSE:_PRODUCTINSERTUPDATERESULT","ProductDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductGet of Service WSVtex

WSMETHOD ProductGet WSSEND nidProduct WSRECEIVE oWSProductGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductGet xmlns="http://tempuri.org/">'
//cSoap += WSSoapValue("idProduct", ::nidProduct, nidProduct , "int", .F. , .F., 0 , NIL, .F.) 
cSoap+=::cSoap
cSoap += "</ProductGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSProductGetResult:SoapRecv( WSAdvValue( oXmlRet,"_PRODUCTGETRESPONSE:_PRODUCTGETRESULT","ProductDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductGetByRefId of Service WSVtex

WSMETHOD ProductGetByRefId WSSEND crefId WSRECEIVE oWSProductGetByRefIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductGetByRefId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("refId", ::crefId, crefId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductGetByRefId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductGetByRefId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSProductGetByRefIdResult:SoapRecv( WSAdvValue( oXmlRet,"_PRODUCTGETBYREFIDRESPONSE:_PRODUCTGETBYREFIDRESULT","ProductDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductGetSimilarCategory of Service WSVtex

WSMETHOD ProductGetSimilarCategory WSSEND nproductId WSRECEIVE oWSProductGetSimilarCategoryResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductGetSimilarCategory xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("productId", ::nproductId, nproductId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductGetSimilarCategory>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductGetSimilarCategory",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSProductGetSimilarCategoryResult:SoapRecv( WSAdvValue( oXmlRet,"_PRODUCTGETSIMILARCATEGORYRESPONSE:_PRODUCTGETSIMILARCATEGORYRESULT","ArrayOfint",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductGetAllFromUpdatedDateAndId of Service WSVtex

WSMETHOD ProductGetAllFromUpdatedDateAndId WSSEND cdateUpdated,nproductid,ntopRows WSRECEIVE oWSProductGetAllFromUpdatedDateAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductGetAllFromUpdatedDateAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("dateUpdated", ::cdateUpdated, cdateUpdated , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("productid", ::nproductid, nproductid , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductGetAllFromUpdatedDateAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductGetAllFromUpdatedDateAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSProductGetAllFromUpdatedDateAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_PRODUCTGETALLFROMUPDATEDDATEANDIDRESPONSE:_PRODUCTGETALLFROMUPDATEDDATEANDIDRESULT","ArrayOfProductDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductActive of Service WSVtex

WSMETHOD ProductActive WSSEND nidProduct WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductActive xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idProduct", ::nidProduct, nidProduct , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductActive>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductActive",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitKitListByParent of Service WSVtex

WSMETHOD StockKeepingUnitKitListByParent WSSEND nidSkuParent WSRECEIVE oWSStockKeepingUnitKitListByParentResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitKitListByParent xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idSkuParent", ::nidSkuParent, nidSkuParent , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitKitListByParent>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitKitListByParent",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitKitListByParentResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITKITLISTBYPARENTRESPONSE:_STOCKKEEPINGUNITKITLISTBYPARENTRESULT","ArrayOfStockKeepingUnitKitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitKitListBySkuId of Service WSVtex

WSMETHOD StockKeepingUnitKitListBySkuId WSSEND nidSku WSRECEIVE oWSStockKeepingUnitKitListBySkuIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitKitListBySkuId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idSku", ::nidSku, nidSku , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitKitListBySkuId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitKitListBySkuId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitKitListBySkuIdResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITKITLISTBYSKUIDRESPONSE:_STOCKKEEPINGUNITKITLISTBYSKUIDRESULT","ArrayOfStockKeepingUnitKitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method IntegrationSettings of Service WSVtex

WSMETHOD IntegrationSettings WSSEND cClientName WSRECEIVE oWSIntegrationSettingsResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<IntegrationSettings xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("ClientName", ::cClientName, cClientName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</IntegrationSettings>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/IntegrationSettings",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSIntegrationSettingsResult:SoapRecv( WSAdvValue( oXmlRet,"_INTEGRATIONSETTINGSRESPONSE:_INTEGRATIONSETTINGSRESULT","IntegrationDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientCandidateInsert of Service WSVtex

WSMETHOD ClientCandidateInsert WSSEND oWSClienteCandidato WSRECEIVE oWSClientCandidateInsertResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientCandidateInsert xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("ClienteCandidato", ::oWSClienteCandidato, oWSClienteCandidato , "ClientCandidateDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientCandidateInsert>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientCandidateInsert",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientCandidateInsertResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTCANDIDATEINSERTRESPONSE:_CLIENTCANDIDATEINSERTRESULT","ClientCandidateDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientCandidateDeleteByCpfOrEmail of Service WSVtex

WSMETHOD ClientCandidateDeleteByCpfOrEmail WSSEND oWSClienteCandidato WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientCandidateDeleteByCpfOrEmail xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("ClienteCandidato", ::oWSClienteCandidato, oWSClienteCandidato , "ClientCandidateDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientCandidateDeleteByCpfOrEmail>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientCandidateDeleteByCpfOrEmail",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientCandidateGet of Service WSVtex

WSMETHOD ClientCandidateGet WSSEND nidClusterGrupoClienteCandidato WSRECEIVE oWSClientCandidateGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientCandidateGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idClusterGrupoClienteCandidato", ::nidClusterGrupoClienteCandidato, nidClusterGrupoClienteCandidato , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientCandidateGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientCandidateGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientCandidateGetResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTCANDIDATEGETRESPONSE:_CLIENTCANDIDATEGETRESULT","ClientCandidateDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientCandidateDeleteById of Service WSVtex

WSMETHOD ClientCandidateDeleteById WSSEND nidClientCandidate WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientCandidateDeleteById xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idClientCandidate", ::nidClientCandidate, nidClientCandidate , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientCandidateDeleteById>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientCandidateDeleteById",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitKitDeleteByParent of Service WSVtex

WSMETHOD StockKeepingUnitKitDeleteByParent WSSEND nidSkuParent WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitKitDeleteByParent xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idSkuParent", ::nidSkuParent, nidSkuParent , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitKitDeleteByParent>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitKitDeleteByParent",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitKitInsertUpdate of Service WSVtex

WSMETHOD StockKeepingUnitKitInsertUpdate WSSEND oWSstockKeepingUnitKit WSRECEIVE oWSStockKeepingUnitKitInsertUpdateResult,nstockKeepingUnitKitId WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitKitInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepingUnitKit", ::oWSstockKeepingUnitKit, oWSstockKeepingUnitKit , "StockKeepingUnitKitDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitKitInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitKitInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitKitInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITKITINSERTUPDATERESPONSE:_STOCKKEEPINGUNITKITINSERTUPDATERESULT","StockKeepingUnitKitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )
::nstockKeepingUnitKitId :=  WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITKITINSERTUPDATERESPONSE:_STOCKKEEPINGUNITKITID:TEXT","int",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitActive of Service WSVtex

WSMETHOD StockKeepingUnitActive WSSEND nidStockKeepingUnit WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitActive xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idStockKeepingUnit", ::nidStockKeepingUnit, nidStockKeepingUnit , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitActive>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitActive",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGetAllByProduct of Service WSVtex

WSMETHOD StockKeepingUnitGetAllByProduct WSSEND nidProduct WSRECEIVE oWSStockKeepingUnitGetAllByProductResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGetAllByProduct xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idProduct", ::nidProduct, nidProduct , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGetAllByProduct>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGetAllByProduct",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetAllByProductResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETALLBYPRODUCTRESPONSE:_STOCKKEEPINGUNITGETALLBYPRODUCTRESULT","ArrayOfStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGetAllFromUpdatedDate of Service WSVtex

WSMETHOD StockKeepingUnitGetAllFromUpdatedDate WSSEND cdateUpdated WSRECEIVE oWSStockKeepingUnitGetAllFromUpdatedDateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGetAllFromUpdatedDate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("dateUpdated", ::cdateUpdated, cdateUpdated , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGetAllFromUpdatedDate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGetAllFromUpdatedDate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetAllFromUpdatedDateResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETALLFROMUPDATEDDATERESPONSE:_STOCKKEEPINGUNITGETALLFROMUPDATEDDATERESULT","ArrayOfStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGetAllFromUpdatedDateAndId of Service WSVtex

WSMETHOD StockKeepingUnitGetAllFromUpdatedDateAndId WSSEND cdateUpdated,nstartingStockKeepingUnitId,ntopRows WSRECEIVE oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGetAllFromUpdatedDateAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("dateUpdated", ::cdateUpdated, cdateUpdated , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("startingStockKeepingUnitId", ::nstartingStockKeepingUnitId, nstartingStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGetAllFromUpdatedDateAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGetAllFromUpdatedDateAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetAllFromUpdatedDateAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETALLFROMUPDATEDDATEANDIDRESPONSE:_STOCKKEEPINGUNITGETALLFROMUPDATEDDATEANDIDRESULT","ArrayOfStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitGetByEan of Service WSVtex

WSMETHOD StockKeepingUnitGetByEan WSSEND cEAN13 WSRECEIVE oWSStockKeepingUnitGetByEanResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitGetByEan xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("EAN13", ::cEAN13, cEAN13 , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitGetByEan>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitGetByEan",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitGetByEanResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITGETBYEANRESPONSE:_STOCKKEEPINGUNITGETBYEANRESULT","StockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGet of Service WSVtex

WSMETHOD OrderGet WSSEND norderId WSRECEIVE oWSOrderGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETRESPONSE:_ORDERGETRESULT","OrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetV3 of Service WSVtex

WSMETHOD OrderGetV3 WSSEND corderId WSRECEIVE oWSOrderGetV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::corderId, corderId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetV3Result:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETV3RESPONSE:_ORDERGETV3RESULT","OrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByClient of Service WSVtex

WSMETHOD OrderGetByClient WSSEND nclientId WSRECEIVE oWSOrderGetByClientResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByClient xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientId", ::nclientId, nclientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByClient>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByClient",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByClientResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYCLIENTRESPONSE:_ORDERGETBYCLIENTRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByClientCpf of Service WSVtex

WSMETHOD OrderGetByClientCpf WSSEND ccpfCnpj WSRECEIVE oWSOrderGetByClientCpfResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByClientCpf xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("cpfCnpj", ::ccpfCnpj, ccpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByClientCpf>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByClientCpf",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByClientCpfResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYCLIENTCPFRESPONSE:_ORDERGETBYCLIENTCPFRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByClientEmail of Service WSVtex

WSMETHOD OrderGetByClientEmail WSSEND cemail WSRECEIVE oWSOrderGetByClientEmailResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByClientEmail xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("email", ::cemail, cemail , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByClientEmail>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByClientEmail",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByClientEmailResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYCLIENTEMAILRESPONSE:_ORDERGETBYCLIENTEMAILRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByDeliveryId of Service WSVtex

WSMETHOD OrderGetByDeliveryId WSSEND norderDeliveryId WSRECEIVE oWSOrderGetByDeliveryIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByDeliveryId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderDeliveryId", ::norderDeliveryId, norderDeliveryId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByDeliveryId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByDeliveryId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByDeliveryIdResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYDELIVERYIDRESPONSE:_ORDERGETBYDELIVERYIDRESULT","OrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByManagementId of Service WSVtex

WSMETHOD OrderGetByManagementId WSSEND nmanagementId WSRECEIVE oWSOrderGetByManagementIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByManagementId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("managementId", ::nmanagementId, nmanagementId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByManagementId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByManagementId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByManagementIdResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYMANAGEMENTIDRESPONSE:_ORDERGETBYMANAGEMENTIDRESULT","OrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryUpdateManagementId of Service WSVtex

WSMETHOD OrderDeliveryUpdateManagementId WSSEND oWSorder,nManagementId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryUpdateManagementId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("order", ::oWSorder, oWSorder , "OrderDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ManagementId", ::nManagementId, nManagementId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryUpdateManagementId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryUpdateManagementId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryChangeStatusByManagementId of Service WSVtex

WSMETHOD OrderDeliveryChangeStatusByManagementId WSSEND cstatusOrder,nManagementId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryChangeStatusByManagementId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ManagementId", ::nManagementId, nManagementId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryChangeStatusByManagementId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryChangeStatusByManagementId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByStatus of Service WSVtex

WSMETHOD OrderGetByStatus WSSEND cstatusOrder WSRECEIVE oWSOrderGetByStatusResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByStatus xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByStatus>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByStatus",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByStatusResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYSTATUSRESPONSE:_ORDERGETBYSTATUSRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByStatusAndPaymentId of Service WSVtex

WSMETHOD OrderGetByStatusAndPaymentId WSSEND cstatusOrder,oWSpaymentIds WSRECEIVE oWSOrderGetByStatusAndPaymentIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByStatusAndPaymentId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("paymentIds", ::oWSpaymentIds, oWSpaymentIds , "ArrayOfint", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByStatusAndPaymentId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByStatusAndPaymentId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByStatusAndPaymentIdResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYSTATUSANDPAYMENTIDRESPONSE:_ORDERGETBYSTATUSANDPAYMENTIDRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderPayPalGetStatus of Service WSVtex

WSMETHOD OrderPayPalGetStatus WSSEND nOrderId,cTransactionId WSRECEIVE cOrderPayPalGetStatusResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderPayPalGetStatus xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("OrderId", ::nOrderId, nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("TransactionId", ::cTransactionId, cTransactionId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderPayPalGetStatus>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderPayPalGetStatus",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::cOrderPayPalGetStatusResult :=  WSAdvValue( oXmlRet,"_ORDERPAYPALGETSTATUSRESPONSE:_ORDERPAYPALGETSTATUSRESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetNext50FromId of Service WSVtex

WSMETHOD OrderGetNext50FromId WSSEND norderId WSRECEIVE oWSOrderGetNext50FromIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetNext50FromId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetNext50FromId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetNext50FromId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetNext50FromIdResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETNEXT50FROMIDRESPONSE:_ORDERGETNEXT50FROMIDRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetNext50FromIdV3 of Service WSVtex

WSMETHOD OrderGetNext50FromIdV3 WSSEND nsequence WSRECEIVE oWSOrderGetNext50FromIdV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetNext50FromIdV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("sequence", ::nsequence, nsequence , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetNext50FromIdV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetNext50FromIdV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetNext50FromIdV3Result:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETNEXT50FROMIDV3RESPONSE:_ORDERGETNEXT50FROMIDV3RESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetNext50FromIdAndDate of Service WSVtex

WSMETHOD OrderGetNext50FromIdAndDate WSSEND norderId,clastDate WSRECEIVE oWSOrderGetNext50FromIdAndDateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetNext50FromIdAndDate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("lastDate", ::clastDate, clastDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetNext50FromIdAndDate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetNext50FromIdAndDate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetNext50FromIdAndDateResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETNEXT50FROMIDANDDATERESPONSE:_ORDERGETNEXT50FROMIDANDDATERESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetNext50FromIdAndDateStatusChanged of Service WSVtex

WSMETHOD OrderGetNext50FromIdAndDateStatusChanged WSSEND norderId,clastDate WSRECEIVE oWSOrderGetNext50FromIdAndDateStatusChangedResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetNext50FromIdAndDateStatusChanged xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("lastDate", ::clastDate, clastDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetNext50FromIdAndDateStatusChanged>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetNext50FromIdAndDateStatusChanged",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetNext50FromIdAndDateStatusChangedResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETNEXT50FROMIDANDDATESTATUSCHANGEDRESPONSE:_ORDERGETNEXT50FROMIDANDDATESTATUSCHANGEDRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetInteractions of Service WSVtex

WSMETHOD OrderGetInteractions WSSEND norderId WSRECEIVE oWSOrderGetInteractionsResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetInteractions xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetInteractions>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetInteractions",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetInteractionsResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETINTERACTIONSRESPONSE:_ORDERGETINTERACTIONSRESULT","ArrayOfOrderInteractionDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetNewV2 of Service WSVtex

WSMETHOD OrderGetNewV2 WSSEND NULLPARAM WSRECEIVE oWSOrderGetNewV2Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetNewV2 xmlns="http://tempuri.org/">'
cSoap += "</OrderGetNewV2>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetNewV2",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetNewV2Result:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETNEWV2RESPONSE:_ORDERGETNEWV2RESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderChangeStatusV2 of Service WSVtex

WSMETHOD OrderChangeStatusV2 WSSEND norderId,oWSintegrationStatus WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderChangeStatusV2 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("integrationStatus", ::oWSintegrationStatus, oWSintegrationStatus , "IntegrationStatus", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderChangeStatusV2>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderChangeStatusV2",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetV2 of Service WSVtex

WSMETHOD OrderGetV2 WSSEND norderId WSRECEIVE oWSOrderGetV2Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetV2 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetV2>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetV2",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetV2Result:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETV2RESPONSE:_ORDERGETV2RESULT","OrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByStatusV2 of Service WSVtex

WSMETHOD OrderGetByStatusV2 WSSEND oWSintegrationStatus WSRECEIVE oWSOrderGetByStatusV2Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByStatusV2 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("integrationStatus", ::oWSintegrationStatus, oWSintegrationStatus , "IntegrationStatus", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByStatusV2>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByStatusV2",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByStatusV2Result:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYSTATUSV2RESPONSE:_ORDERGETBYSTATUSV2RESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderAcknowledge of Service WSVtex

WSMETHOD OrderAcknowledge WSSEND norderId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderAcknowledge xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderAcknowledge>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderAcknowledge",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderChangeTrackingNumberV2 of Service WSVtex

WSMETHOD OrderChangeTrackingNumberV2 WSSEND norderId,ctrackingNumber WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderChangeTrackingNumberV2 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("trackingNumber", ::ctrackingNumber, ctrackingNumber , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderChangeTrackingNumberV2>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderChangeTrackingNumberV2",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderSetSellerMapping of Service WSVtex

WSMETHOD OrderSetSellerMapping WSSEND norderId,csellerId,csellerOrderId,oWSitemsMapping WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderSetSellerMapping xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("sellerId", ::csellerId, csellerId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("sellerOrderId", ::csellerOrderId, csellerOrderId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("itemsMapping", ::oWSitemsMapping, oWSitemsMapping , "ArrayOfKeyValueOfstringstring", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderSetSellerMapping>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderSetSellerMapping",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderGetByStatusByQuantity of Service WSVtex

WSMETHOD OrderGetByStatusByQuantity WSSEND cstatusOrder,nquantity WSRECEIVE oWSOrderGetByStatusByQuantityResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderGetByStatusByQuantity xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("quantity", ::nquantity, nquantity , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderGetByStatusByQuantity>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderGetByStatusByQuantity",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderGetByStatusByQuantityResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERGETBYSTATUSBYQUANTITYRESPONSE:_ORDERGETBYSTATUSBYQUANTITYRESULT","ArrayOfOrderDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderChangeStatus of Service WSVtex

WSMETHOD OrderChangeStatus WSSEND nidOrder,cstatusOrder WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderChangeStatus xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idOrder", ::nidOrder, nidOrder , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderChangeStatus>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderChangeStatus",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryChangeStatus of Service WSVtex

WSMETHOD OrderDeliveryChangeStatus WSSEND norderId,cstatusOrder,nManagementId,nAdministratorId,oWSitems WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryChangeStatus xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderId", ::norderId, norderId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ManagementId", ::nManagementId, nManagementId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("AdministratorId", ::nAdministratorId, nAdministratorId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("items", ::oWSitems, oWSitems , "ArrayOfOrderItem", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryChangeStatus>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryChangeStatus",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderStatusGetAll of Service WSVtex

WSMETHOD OrderStatusGetAll WSSEND NULLPARAM WSRECEIVE oWSOrderStatusGetAllResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderStatusGetAll xmlns="http://tempuri.org/">'
cSoap += "</OrderStatusGetAll>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderStatusGetAll",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderStatusGetAllResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERSTATUSGETALLRESPONSE:_ORDERSTATUSGETALLRESULT","ArrayOfOrderStatusDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderPaymentGetAll of Service WSVtex

WSMETHOD OrderPaymentGetAll WSSEND NULLPARAM WSRECEIVE oWSOrderPaymentGetAllResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderPaymentGetAll xmlns="http://tempuri.org/">'
cSoap += "</OrderPaymentGetAll>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderPaymentGetAll",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderPaymentGetAllResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERPAYMENTGETALLRESPONSE:_ORDERPAYMENTGETALLRESULT","ArrayOfPaymentDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryBlankRemoveByDTO of Service WSVtex

WSMETHOD OrderDeliveryBlankRemoveByDTO WSSEND oWSorderDTO WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryBlankRemoveByDTO xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderDTO", ::oWSorderDTO, oWSorderDTO , "OrderDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryBlankRemoveByDTO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryBlankRemoveByDTO",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderItemUpdateOrderDeliveryId of Service WSVtex

WSMETHOD OrderItemUpdateOrderDeliveryId WSSEND oWSorderItemDTO WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderItemUpdateOrderDeliveryId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderItemDTO", ::oWSorderItemDTO, oWSorderItemDTO , "OrderItemDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderItemUpdateOrderDeliveryId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderItemUpdateOrderDeliveryId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryInsertUpdate of Service WSVtex

WSMETHOD OrderDeliveryInsertUpdate WSSEND oWSorderDeliveryDTO WSRECEIVE oWSOrderDeliveryInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("orderDeliveryDTO", ::oWSorderDeliveryDTO, oWSorderDeliveryDTO , "OrderDeliveryDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderDeliveryInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERDELIVERYINSERTUPDATERESPONSE:_ORDERDELIVERYINSERTUPDATERESULT","OrderDeliveryDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryInvoiceNumberInsertUpdate of Service WSVtex

WSMETHOD OrderDeliveryInvoiceNumberInsertUpdate WSSEND cinvoiceNumber,norderDeliveryId WSRECEIVE oWSOrderDeliveryInvoiceNumberInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryInvoiceNumberInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("invoiceNumber", ::cinvoiceNumber, cinvoiceNumber , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("orderDeliveryId", ::norderDeliveryId, norderDeliveryId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryInvoiceNumberInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryInvoiceNumberInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSOrderDeliveryInvoiceNumberInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_ORDERDELIVERYINVOICENUMBERINSERTUPDATERESPONSE:_ORDERDELIVERYINVOICENUMBERINSERTUPDATERESULT","OrderDeliveryDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderChangeStatusById of Service WSVtex

WSMETHOD OrderChangeStatusById WSSEND nidOrderDelivery,cstatusOrder WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderChangeStatusById xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idOrderDelivery", ::nidOrderDelivery, nidOrderDelivery , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("statusOrder", ::cstatusOrder, cstatusOrder , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderChangeStatusById>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderChangeStatusById",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderChangeTrackingNumber of Service WSVtex

WSMETHOD OrderChangeTrackingNumber WSSEND nidOrder,ctrackingNumber WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderChangeTrackingNumber xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idOrder", ::nidOrder, nidOrder , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("trackingNumber", ::ctrackingNumber, ctrackingNumber , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderChangeTrackingNumber>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderChangeTrackingNumber",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method OrderDeliveryChangeTrackingNumber of Service WSVtex

WSMETHOD OrderDeliveryChangeTrackingNumber WSSEND nidOrderDelivery,ctrackingNumber WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<OrderDeliveryChangeTrackingNumber xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idOrderDelivery", ::nidOrderDelivery, nidOrderDelivery , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("trackingNumber", ::ctrackingNumber, ctrackingNumber , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</OrderDeliveryChangeTrackingNumber>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/OrderDeliveryChangeTrackingNumber",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGet of Service WSVtex

WSMETHOD ClientGet WSSEND nidClient WSRECEIVE oWSClientGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idClient", ::nidClient, nidClient , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETRESPONSE:_CLIENTGETRESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetV3 of Service WSVtex

WSMETHOD ClientGetV3 WSSEND cidClientV3 WSRECEIVE oWSClientGetV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idClientV3", ::cidClientV3, cidClientV3 , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetV3Result:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETV3RESPONSE:_CLIENTGETV3RESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetByCPF of Service WSVtex

WSMETHOD ClientGetByCPF WSSEND cCpfCnpj WSRECEIVE oWSClientGetByCPFResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetByCPF xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("CpfCnpj", ::cCpfCnpj, cCpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetByCPF>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetByCPF",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetByCPFResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETBYCPFRESPONSE:_CLIENTGETBYCPFRESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetByEmail of Service WSVtex

WSMETHOD ClientGetByEmail WSSEND cEmail WSRECEIVE oWSClientGetByEmailResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetByEmail xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("Email", ::cEmail, cEmail , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetByEmail>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetByEmail",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetByEmailResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETBYEMAILRESPONSE:_CLIENTGETBYEMAILRESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetByEmailV3 of Service WSVtex

WSMETHOD ClientGetByEmailV3 WSSEND cEmail WSRECEIVE oWSClientGetByEmailV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetByEmailV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("Email", ::cEmail, cEmail , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetByEmailV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetByEmailV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetByEmailV3Result:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETBYEMAILV3RESPONSE:_CLIENTGETBYEMAILV3RESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetByGuid of Service WSVtex

WSMETHOD ClientGetByGuid WSSEND cguid WSRECEIVE oWSClientGetByGuidResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetByGuid xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("guid", ::cguid, cguid , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetByGuid>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetByGuid",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetByGuidResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETBYGUIDRESPONSE:_CLIENTGETBYGUIDRESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetByGuidV3 of Service WSVtex

WSMETHOD ClientGetByGuidV3 WSSEND cguid WSRECEIVE oWSClientGetByGuidV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetByGuidV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("guid", ::cguid, cguid , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetByGuidV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetByGuidV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetByGuidV3Result:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETBYGUIDV3RESPONSE:_CLIENTGETBYGUIDV3RESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetExtendedInfo of Service WSVtex

WSMETHOD ClientGetExtendedInfo WSSEND nclientId WSRECEIVE oWSClientGetExtendedInfoResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetExtendedInfo xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientId", ::nclientId, nclientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetExtendedInfo>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetExtendedInfo",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetExtendedInfoResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETEXTENDEDINFORESPONSE:_CLIENTGETEXTENDEDINFORESULT","ClientExtendedDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetExtendedInfoByCPF of Service WSVtex

WSMETHOD ClientGetExtendedInfoByCPF WSSEND cCpfCnpj WSRECEIVE oWSClientGetExtendedInfoByCPFResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetExtendedInfoByCPF xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("CpfCnpj", ::cCpfCnpj, cCpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetExtendedInfoByCPF>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetExtendedInfoByCPF",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetExtendedInfoByCPFResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETEXTENDEDINFOBYCPFRESPONSE:_CLIENTGETEXTENDEDINFOBYCPFRESULT","ClientExtendedDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientGetAllFromCreatedDateAndId of Service WSVtex

WSMETHOD ClientGetAllFromCreatedDateAndId WSSEND cdateCreated,nstartingClientId,ntopRows WSRECEIVE oWSClientGetAllFromCreatedDateAndIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientGetAllFromCreatedDateAndId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("dateCreated", ::cdateCreated, cdateCreated , "dateTime", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("startingClientId", ::nstartingClientId, nstartingClientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("topRows", ::ntopRows, ntopRows , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientGetAllFromCreatedDateAndId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientGetAllFromCreatedDateAndId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientGetAllFromCreatedDateAndIdResult:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTGETALLFROMCREATEDDATEANDIDRESPONSE:_CLIENTGETALLFROMCREATEDDATEANDIDRESULT","ArrayOfClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientRewardGet of Service WSVtex

WSMETHOD ClientRewardGet WSSEND nclientId WSRECEIVE nClientRewardGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientRewardGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientId", ::nclientId, nclientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientRewardGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientRewardGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::nClientRewardGetResult :=  WSAdvValue( oXmlRet,"_CLIENTREWARDGETRESPONSE:_CLIENTREWARDGETRESULT:TEXT","decimal",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientRewardGetByCPF of Service WSVtex

WSMETHOD ClientRewardGetByCPF WSSEND ccpfCnpj WSRECEIVE nClientRewardGetByCPFResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientRewardGetByCPF xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("cpfCnpj", ::ccpfCnpj, ccpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientRewardGetByCPF>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientRewardGetByCPF",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::nClientRewardGetByCPFResult :=  WSAdvValue( oXmlRet,"_CLIENTREWARDGETBYCPFRESPONSE:_CLIENTREWARDGETBYCPFRESULT:TEXT","decimal",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientRewardUpdate of Service WSVtex

WSMETHOD ClientRewardUpdate WSSEND nclientId,ntotalReward,oWStransactionAction WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientRewardUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientId", ::nclientId, nclientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("totalReward", ::ntotalReward, ntotalReward , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("transactionAction", ::oWStransactionAction, oWStransactionAction , "TransactionAction", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientRewardUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientRewardUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientRewardUpdateByCPF of Service WSVtex

WSMETHOD ClientRewardUpdateByCPF WSSEND ccpfCnpj,ntotalReward,oWStransactionAction WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientRewardUpdateByCPF xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("cpfCnpj", ::ccpfCnpj, ccpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("totalReward", ::ntotalReward, ntotalReward , "decimal", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("transactionAction", ::oWStransactionAction, oWStransactionAction , "TransactionAction", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientRewardUpdateByCPF>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientRewardUpdateByCPF",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientInsertUpdate of Service WSVtex

WSMETHOD ClientInsertUpdate WSSEND oWSclient,oWSaddress WSRECEIVE nclientId,naddressId WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("client", ::oWSclient, oWSclient , "ClientDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("address", ::oWSaddress, oWSaddress , "AddressDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::nclientId          :=  WSAdvValue( oXmlRet,"_CLIENTINSERTUPDATERESPONSE:_CLIENTID:TEXT","int",NIL,NIL,NIL,NIL,NIL,"xs") 
::naddressId         :=  WSAdvValue( oXmlRet,"_CLIENTINSERTUPDATERESPONSE:_ADDRESSID:TEXT","int",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ClientInsertUpdateV3 of Service WSVtex

WSMETHOD ClientInsertUpdateV3 WSSEND oWSclient WSRECEIVE oWSClientInsertUpdateV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ClientInsertUpdateV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("client", ::oWSclient, oWSclient , "ClientDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ClientInsertUpdateV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ClientInsertUpdateV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSClientInsertUpdateV3Result:SoapRecv( WSAdvValue( oXmlRet,"_CLIENTINSERTUPDATEV3RESPONSE:_CLIENTINSERTUPDATEV3RESULT","ClientDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method DistributionCenterGet of Service WSVtex

WSMETHOD DistributionCenterGet WSSEND nidDistributionCenter WSRECEIVE oWSDistributionCenterGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<DistributionCenterGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idDistributionCenter", ::nidDistributionCenter, nidDistributionCenter , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</DistributionCenterGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/DistributionCenterGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSDistributionCenterGetResult:SoapRecv( WSAdvValue( oXmlRet,"_DISTRIBUTIONCENTERGETRESPONSE:_DISTRIBUTIONCENTERGETRESULT","DistributionCenterDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method DistributionCenterGetByTaxId of Service WSVtex

WSMETHOD DistributionCenterGetByTaxId WSSEND ctaxId WSRECEIVE oWSDistributionCenterGetByTaxIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<DistributionCenterGetByTaxId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("taxId", ::ctaxId, ctaxId , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</DistributionCenterGetByTaxId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/DistributionCenterGetByTaxId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSDistributionCenterGetByTaxIdResult:SoapRecv( WSAdvValue( oXmlRet,"_DISTRIBUTIONCENTERGETBYTAXIDRESPONSE:_DISTRIBUTIONCENTERGETBYTAXIDRESULT","DistributionCenterDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightCalculate of Service WSVtex

WSMETHOD FreightCalculate WSSEND nskuId,czipCode,ndistributionCenterId,nfreightTypeId WSRECEIVE oWSFreightCalculateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightCalculate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("skuId", ::nskuId, nskuId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("zipCode", ::czipCode, czipCode , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("distributionCenterId", ::ndistributionCenterId, ndistributionCenterId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("freightTypeId", ::nfreightTypeId, nfreightTypeId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightCalculate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightCalculate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSFreightCalculateResult:SoapRecv( WSAdvValue( oXmlRet,"_FREIGHTCALCULATERESPONSE:_FREIGHTCALCULATERESULT","FreightValueDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightCalculateV3 of Service WSVtex

WSMETHOD FreightCalculateV3 WSSEND oWSfreightSkuContext,czipCode WSRECEIVE oWSFreightCalculateV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightCalculateV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("freightSkuContext", ::oWSfreightSkuContext, oWSfreightSkuContext , "ArrayOfFreightStockKeepingUnitContextDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("zipCode", ::czipCode, czipCode , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightCalculateV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightCalculateV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSFreightCalculateV3Result:SoapRecv( WSAdvValue( oXmlRet,"_FREIGHTCALCULATEV3RESPONSE:_FREIGHTCALCULATEV3RESULT","ArrayOfFreightStockKeepingUnitDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ZipCodeGet of Service WSVtex

WSMETHOD ZipCodeGet WSSEND czipCode WSRECEIVE oWSZipCodeGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ZipCodeGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("zipCode", ::czipCode, czipCode , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ZipCodeGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ZipCodeGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSZipCodeGetResult:SoapRecv( WSAdvValue( oXmlRet,"_ZIPCODEGETRESPONSE:_ZIPCODEGETRESULT","ZipCodeDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightGet of Service WSVtex

WSMETHOD FreightGet WSSEND nidFreight WSRECEIVE oWSFreightGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idFreight", ::nidFreight, nidFreight , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSFreightGetResult:SoapRecv( WSAdvValue( oXmlRet,"_FREIGHTGETRESPONSE:_FREIGHTGETRESULT","FreightDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightGetAll of Service WSVtex

WSMETHOD FreightGetAll WSSEND NULLPARAM WSRECEIVE oWSFreightGetAllResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightGetAll xmlns="http://tempuri.org/">'
cSoap += "</FreightGetAll>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightGetAll",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSFreightGetAllResult:SoapRecv( WSAdvValue( oXmlRet,"_FREIGHTGETALLRESPONSE:_FREIGHTGETALLRESULT","ArrayOfFreightDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightInsertUpdate of Service WSVtex

WSMETHOD FreightInsertUpdate WSSEND oWSfreight WSRECEIVE oWSFreightInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("freight", ::oWSfreight, oWSfreight , "FreightDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSFreightInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_FREIGHTINSERTUPDATERESPONSE:_FREIGHTINSERTUPDATERESULT","FreightDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightValueInsertUpdate of Service WSVtex

WSMETHOD FreightValueInsertUpdate WSSEND oWSfreightValue WSRECEIVE oWSFreightValueInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightValueInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("freightValue", ::oWSfreightValue, oWSfreightValue , "FreightValueDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightValueInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightValueInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSFreightValueInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_FREIGHTVALUEINSERTUPDATERESPONSE:_FREIGHTVALUEINSERTUPDATERESULT","FreightValueDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightValueInsertUpdateByList of Service WSVtex

WSMETHOD FreightValueInsertUpdateByList WSSEND oWSlstFreightValue WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightValueInsertUpdateByList xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("lstFreightValue", ::oWSlstFreightValue, oWSlstFreightValue , "ArrayOfFreightValueDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightValueInsertUpdateByList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightValueInsertUpdateByList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method FreightValueDeleteByFreight of Service WSVtex

WSMETHOD FreightValueDeleteByFreight WSSEND nidFreight WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<FreightValueDeleteByFreight xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idFreight", ::nidFreight, nidFreight , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</FreightValueDeleteByFreight>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/FreightValueDeleteByFreight",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressByAddressClient of Service WSVtex

WSMETHOD AddressByAddressClient WSSEND naddressClientId WSRECEIVE oWSAddressByAddressClientResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressByAddressClient xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("addressClientId", ::naddressClientId, naddressClientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressByAddressClient>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressByAddressClient",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressByAddressClientResult:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSBYADDRESSCLIENTRESPONSE:_ADDRESSBYADDRESSCLIENTRESULT","AddressDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressGetByClientId of Service WSVtex

WSMETHOD AddressGetByClientId WSSEND nclientId WSRECEIVE oWSAddressGetByClientIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressGetByClientId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientId", ::nclientId, nclientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressGetByClientId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressGetByClientId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressGetByClientIdResult:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSGETBYCLIENTIDRESPONSE:_ADDRESSGETBYCLIENTIDRESULT","ArrayOfAddressDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressGetByClientIdV3 of Service WSVtex

WSMETHOD AddressGetByClientIdV3 WSSEND cclientIdV3 WSRECEIVE oWSAddressGetByClientIdV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressGetByClientIdV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientIdV3", ::cclientIdV3, cclientIdV3 , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressGetByClientIdV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressGetByClientIdV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressGetByClientIdV3Result:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSGETBYCLIENTIDV3RESPONSE:_ADDRESSGETBYCLIENTIDV3RESULT","ArrayOfAddressDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressGetByClientIdV2 of Service WSVtex

WSMETHOD AddressGetByClientIdV2 WSSEND cclientIdV2 WSRECEIVE oWSAddressGetByClientIdV2Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressGetByClientIdV2 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("clientIdV2", ::cclientIdV2, cclientIdV2 , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressGetByClientIdV2>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressGetByClientIdV2",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressGetByClientIdV2Result:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSGETBYCLIENTIDV2RESPONSE:_ADDRESSGETBYCLIENTIDV2RESULT","ArrayOfAddressDTO2",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressInsertByClientId of Service WSVtex

WSMETHOD AddressInsertByClientId WSSEND nClientId,oWSClientAddress WSRECEIVE oWSAddressInsertByClientIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressInsertByClientId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("ClientId", ::nClientId, nClientId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ClientAddress", ::oWSClientAddress, oWSClientAddress , "AddressDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressInsertByClientId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressInsertByClientId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressInsertByClientIdResult:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSINSERTBYCLIENTIDRESPONSE:_ADDRESSINSERTBYCLIENTIDRESULT","AddressDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressInsertUpdateV3 of Service WSVtex

WSMETHOD AddressInsertUpdateV3 WSSEND oWSaddress WSRECEIVE oWSAddressInsertUpdateV3Result WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressInsertUpdateV3 xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("address", ::oWSaddress, oWSaddress , "AddressDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressInsertUpdateV3>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressInsertUpdateV3",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressInsertUpdateV3Result:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSINSERTUPDATEV3RESPONSE:_ADDRESSINSERTUPDATEV3RESULT","AddressDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method AddressInsertByCpfCnpj of Service WSVtex

WSMETHOD AddressInsertByCpfCnpj WSSEND cCpfCnpj,oWSClientAddress WSRECEIVE oWSAddressInsertByCpfCnpjResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AddressInsertByCpfCnpj xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("CpfCnpj", ::cCpfCnpj, cCpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ClientAddress", ::oWSClientAddress, oWSClientAddress , "AddressDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</AddressInsertByCpfCnpj>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/AddressInsertByCpfCnpj",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSAddressInsertByCpfCnpjResult:SoapRecv( WSAdvValue( oXmlRet,"_ADDRESSINSERTBYCPFCNPJRESPONSE:_ADDRESSINSERTBYCPFCNPJRESULT","AddressDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BuyTogetherInsertUpdate of Service WSVtex

WSMETHOD BuyTogetherInsertUpdate WSSEND oWSobjBuyTogether WSRECEIVE oWSBuyTogetherInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BuyTogetherInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("objBuyTogether", ::oWSobjBuyTogether, oWSobjBuyTogether , "BuyTogetherDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BuyTogetherInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BuyTogetherInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSBuyTogetherInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_BUYTOGETHERINSERTUPDATERESPONSE:_BUYTOGETHERINSERTUPDATERESULT","BuyTogetherDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BuyTogetherBuyGainInsertUpdate of Service WSVtex

WSMETHOD BuyTogetherBuyGainInsertUpdate WSSEND oWSobjBuyTogetherBuyGainDTO WSRECEIVE oWSBuyTogetherBuyGainInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BuyTogetherBuyGainInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("objBuyTogetherBuyGainDTO", ::oWSobjBuyTogetherBuyGainDTO, oWSobjBuyTogetherBuyGainDTO , "BuyTogetherBuyGainDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BuyTogetherBuyGainInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BuyTogetherBuyGainInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSBuyTogetherBuyGainInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_BUYTOGETHERBUYGAININSERTUPDATERESPONSE:_BUYTOGETHERBUYGAININSERTUPDATERESULT","BuyTogetherBuyGainDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BuyTogethertakeXPayYInsertUpdate of Service WSVtex

WSMETHOD BuyTogethertakeXPayYInsertUpdate WSSEND oWSobjBuyTogetherTakeXPayYDTO WSRECEIVE oWSBuyTogethertakeXPayYInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BuyTogethertakeXPayYInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("objBuyTogetherTakeXPayYDTO", ::oWSobjBuyTogetherTakeXPayYDTO, oWSobjBuyTogetherTakeXPayYDTO , "BuyTogetherTakeXPayYDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BuyTogethertakeXPayYInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BuyTogethertakeXPayYInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSBuyTogethertakeXPayYInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_BUYTOGETHERTAKEXPAYYINSERTUPDATERESPONSE:_BUYTOGETHERTAKEXPAYYINSERTUPDATERESULT","BuyTogetherTakeXPayYDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BuyTogetherDeleteById of Service WSVtex

WSMETHOD BuyTogetherDeleteById WSSEND nbuyTogetherId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BuyTogetherDeleteById xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("buyTogetherId", ::nbuyTogetherId, nbuyTogetherId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BuyTogetherDeleteById>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BuyTogetherDeleteById",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BuyTogetherSkuListInsertUpdate of Service WSVtex

WSMETHOD BuyTogetherSkuListInsertUpdate WSSEND nbuyTogetherId,oWSfirstListStockKeepingUnit,oWSsecondListStockKeepingUnit WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BuyTogetherSkuListInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("buyTogetherId", ::nbuyTogetherId, nbuyTogetherId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("firstListStockKeepingUnit", ::oWSfirstListStockKeepingUnit, oWSfirstListStockKeepingUnit , "ArrayOfint", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("secondListStockKeepingUnit", ::oWSsecondListStockKeepingUnit, oWSsecondListStockKeepingUnit , "ArrayOfint", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BuyTogetherSkuListInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BuyTogetherSkuListInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ServiceGet of Service WSVtex

WSMETHOD ServiceGet WSSEND nidService WSRECEIVE oWSVtexGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ServiceGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idService", ::nidService, nidService , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ServiceGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ServiceGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSVtexGetResult:SoapRecv( WSAdvValue( oXmlRet,"_SERVICEGETRESPONSE:_SERVICEGETRESULT","ServiceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ServicePriceGet of Service WSVtex

WSMETHOD ServicePriceGet WSSEND nidServicePrice WSRECEIVE oWSVtexPriceGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ServicePriceGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idServicePrice", ::nidServicePrice, nidServicePrice , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ServicePriceGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ServicePriceGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSVtexPriceGetResult:SoapRecv( WSAdvValue( oXmlRet,"_SERVICEPRICEGETRESPONSE:_SERVICEPRICEGETRESULT","ServicePriceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ServicePriceList of Service WSVtex

WSMETHOD ServicePriceList WSSEND nidService WSRECEIVE oWSVtexPriceListResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ServicePriceList xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idService", ::nidService, nidService , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ServicePriceList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ServicePriceList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSVtexPriceListResult:SoapRecv( WSAdvValue( oXmlRet,"_SERVICEPRICELISTRESPONSE:_SERVICEPRICELISTRESULT","ArrayOfServicePriceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ServiceInsertUpdate of Service WSVtex

WSMETHOD ServiceInsertUpdate WSSEND oWSVtex WSRECEIVE oWSVtexInsertUpdateResult,nserviceId WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ServiceInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("service", ::oWSVtex, oWSVtex , "ServiceDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ServiceInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ServiceInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSVtexInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_SERVICEINSERTUPDATERESPONSE:_SERVICEINSERTUPDATERESULT","ServiceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )
::nserviceId         :=  WSAdvValue( oXmlRet,"_SERVICEINSERTUPDATERESPONSE:_SERVICEID:TEXT","int",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ServicePriceInsertUpdate of Service WSVtex

WSMETHOD ServicePriceInsertUpdate WSSEND oWSVtexPrice WSRECEIVE oWSVtexPriceInsertUpdateResult,nservicePriceId WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ServicePriceInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("servicePrice", ::oWSVtexPrice, oWSVtexPrice , "ServicePriceDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ServicePriceInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ServicePriceInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSVtexPriceInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_SERVICEPRICEINSERTUPDATERESPONSE:_SERVICEPRICEINSERTUPDATERESULT","ServicePriceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )
::nservicePriceId    :=  WSAdvValue( oXmlRet,"_SERVICEPRICEINSERTUPDATERESPONSE:_SERVICEPRICEID:TEXT","int",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitServiceGet of Service WSVtex

WSMETHOD StockKeepingUnitServiceGet WSSEND nidStockKeepingUnitService WSRECEIVE oWSStockKeepingUnitServiceGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitServiceGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idStockKeepingUnitService", ::nidStockKeepingUnitService, nidStockKeepingUnitService , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitServiceGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitServiceGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitServiceGetResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITSERVICEGETRESPONSE:_STOCKKEEPINGUNITSERVICEGETRESULT","StockKeepingUnitServiceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitServiceList of Service WSVtex

WSMETHOD StockKeepingUnitServiceList WSSEND nidSku WSRECEIVE oWSStockKeepingUnitServiceListResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitServiceList xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idSku", ::nidSku, nidSku , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitServiceList>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitServiceList",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitServiceListResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITSERVICELISTRESPONSE:_STOCKKEEPINGUNITSERVICELISTRESULT","ArrayOfStockKeepingUnitServiceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method StockKeepingUnitServiceInsertUpdate of Service WSVtex

WSMETHOD StockKeepingUnitServiceInsertUpdate WSSEND oWSstockKeepingUnitService WSRECEIVE oWSStockKeepingUnitServiceInsertUpdateResult,nstockKeepingUnitServiceId WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<StockKeepingUnitServiceInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepingUnitService", ::oWSstockKeepingUnitService, oWSstockKeepingUnitService , "StockKeepingUnitServiceDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</StockKeepingUnitServiceInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/StockKeepingUnitServiceInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSStockKeepingUnitServiceInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITSERVICEINSERTUPDATERESPONSE:_STOCKKEEPINGUNITSERVICEINSERTUPDATERESULT","StockKeepingUnitServiceDTO",NIL,NIL,NIL,NIL,NIL,"xs") )
::nstockKeepingUnitServiceId :=  WSAdvValue( oXmlRet,"_STOCKKEEPINGUNITSERVICEINSERTUPDATERESPONSE:_STOCKKEEPINGUNITSERVICEID:TEXT","int",NIL,NIL,NIL,NIL,NIL,"xs") 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BrandGet of Service WSVtex

WSMETHOD BrandGet WSSEND nidBrand WSRECEIVE oWSBrandGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BrandGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idBrand", ::nidBrand, nidBrand , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BrandGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BrandGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSBrandGetResult:SoapRecv( WSAdvValue( oXmlRet,"_BRANDGETRESPONSE:_BRANDGETRESULT","BrandDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BrandGetByName of Service WSVtex

WSMETHOD BrandGetByName WSSEND cnameBrand WSRECEIVE oWSBrandGetByNameResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BrandGetByName xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nameBrand", ::cnameBrand, cnameBrand , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BrandGetByName>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BrandGetByName",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSBrandGetByNameResult:SoapRecv( WSAdvValue( oXmlRet,"_BRANDGETBYNAMERESPONSE:_BRANDGETBYNAMERESULT","BrandDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BrandInsertUpdate of Service WSVtex

WSMETHOD BrandInsertUpdate WSSEND oWSbrand WSRECEIVE oWSBrandInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BrandInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("brand", ::oWSbrand, oWSbrand , "BrandDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BrandInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/BrandInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSBrandInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_BRANDINSERTUPDATERESPONSE:_BRANDINSERTUPDATERESULT","BrandDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CategoryGet of Service WSVtex

WSMETHOD CategoryGet WSSEND nidCategory WSRECEIVE oWSCategoryGetResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CategoryGet xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("idCategory", ::nidCategory, nidCategory , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</CategoryGet>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/CategoryGet",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSCategoryGetResult:SoapRecv( WSAdvValue( oXmlRet,"_CATEGORYGETRESPONSE:_CATEGORYGETRESULT","CategoryDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CategoryGetByName of Service WSVtex

WSMETHOD CategoryGetByName WSSEND cnameCategory WSRECEIVE oWSCategoryGetByNameResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CategoryGetByName xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nameCategory", ::cnameCategory, cnameCategory , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</CategoryGetByName>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/CategoryGetByName",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSCategoryGetByNameResult:SoapRecv( WSAdvValue( oXmlRet,"_CATEGORYGETBYNAMERESPONSE:_CATEGORYGETBYNAMERESULT","CategoryDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CategoryInsertUpdate of Service WSVtex

WSMETHOD CategoryInsertUpdate WSSEND oWScategory WSRECEIVE oWSCategoryInsertUpdateResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CategoryInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("category", ::oWScategory, oWScategory , "CategoryDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</CategoryInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/CategoryInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSCategoryInsertUpdateResult:SoapRecv( WSAdvValue( oXmlRet,"_CATEGORYINSERTUPDATERESPONSE:_CATEGORYINSERTUPDATERESULT","CategoryDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ImageServiceCopyAllImagesFromSkuToSku of Service WSVtex

WSMETHOD ImageServiceCopyAllImagesFromSkuToSku WSSEND nstockKeepingUnitIdFrom,nstockKeepingUnitIdTo WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ImageServiceCopyAllImagesFromSkuToSku xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("stockKeepingUnitIdFrom", ::nstockKeepingUnitIdFrom, nstockKeepingUnitIdFrom , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("stockKeepingUnitIdTo", ::nstockKeepingUnitIdTo, nstockKeepingUnitIdTo , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ImageServiceCopyAllImagesFromSkuToSku>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ImageServiceCopyAllImagesFromSkuToSku",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ImageServiceInsertUpdate of Service WSVtex

WSMETHOD ImageServiceInsertUpdate WSSEND curlImage,cimageName,nstockKeepingUnitId,nfileId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ImageServiceInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("urlImage", ::curlImage, curlImage , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("imageName", ::cimageName, cimageName , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("stockKeepingUnitId", ::nstockKeepingUnitId, nstockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("fileId", ::nfileId, nfileId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ImageServiceInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ImageServiceInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ImageInsertUpdate of Service WSVtex

WSMETHOD ImageInsertUpdate WSSEND oWSimage WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ImageInsertUpdate xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("image", ::oWSimage, oWSimage , "ImageDTO", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ImageInsertUpdate>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ImageInsertUpdate",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ImageListByStockKeepingUnitId of Service WSVtex

WSMETHOD ImageListByStockKeepingUnitId WSSEND nStockKeepingUnitId,nArchiveTypeId WSRECEIVE oWSImageListByStockKeepingUnitIdResult WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ImageListByStockKeepingUnitId xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ArchiveTypeId", ::nArchiveTypeId, nArchiveTypeId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ImageListByStockKeepingUnitId>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ImageListByStockKeepingUnitId",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()
::oWSImageListByStockKeepingUnitIdResult:SoapRecv( WSAdvValue( oXmlRet,"_IMAGELISTBYSTOCKKEEPINGUNITIDRESPONSE:_IMAGELISTBYSTOCKKEEPINGUNITIDRESULT","ArrayOfImageDTO",NIL,NIL,NIL,NIL,NIL,"xs") )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ProductImageRemove of Service WSVtex

WSMETHOD ProductImageRemove WSSEND nproductId WSRECEIVE NULLPARAM WSCLIENT WSVtex
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ProductImageRemove xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("productId", ::nproductId, nproductId , "int", .F. , .F., 0 , NIL, .F.) 
cSoap += "</ProductImageRemove>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://tempuri.org/IService/ProductImageRemove",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	::cUrlWS+"/AdminWebService/Service.svc")

::Init()

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure ArrayOfFieldDTO

WSSTRUCT Service_ArrayOfFieldDTO
	WSDATA   oWSFieldDTO               AS Service_FieldDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfFieldDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfFieldDTO
	::oWSFieldDTO          := {} // Array Of  Service_FIELDDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfFieldDTO
	Local oClone := Service_ArrayOfFieldDTO():NEW()
	oClone:oWSFieldDTO := NIL
	If ::oWSFieldDTO <> NIL 
		oClone:oWSFieldDTO := {}
		aEval( ::oWSFieldDTO , { |x| aadd( oClone:oWSFieldDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfFieldDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FIELDDTO","FieldDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSFieldDTO , Service_FieldDTO():New() )
			::oWSFieldDTO[len(::oWSFieldDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure StockKeepingUnitComplementDTO

WSSTRUCT Service_StockKeepingUnitComplementDTO
	WSDATA   oWSComplementType         AS Service_StockKeepingUnitComplementDTO_ComplementTypeEnum OPTIONAL
	WSDATA   oWSStockKeepingUnitComplements AS Service_ArrayOfint OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitComplementDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitComplementDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitComplementDTO
	Local oClone := Service_StockKeepingUnitComplementDTO():NEW()
	oClone:oWSComplementType    := IIF(::oWSComplementType = NIL , NIL , ::oWSComplementType:Clone() )
	oClone:oWSStockKeepingUnitComplements := IIF(::oWSStockKeepingUnitComplements = NIL , NIL , ::oWSStockKeepingUnitComplements:Clone() )
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitComplementDTO
	Local cSoap := ""
	cSoap += WSSoapValue("ComplementType", ::oWSComplementType, ::oWSComplementType , "StockKeepingUnitComplementDTO.ComplementTypeEnum", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitComplements", ::oWSStockKeepingUnitComplements, ::oWSStockKeepingUnitComplements , "ArrayOfint", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ArrayOfProductFieldNameDTO

WSSTRUCT Service_ArrayOfProductFieldNameDTO
	WSDATA   oWSProductFieldNameDTO    AS Service_ProductFieldNameDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfProductFieldNameDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfProductFieldNameDTO
	::oWSProductFieldNameDTO := {} // Array Of  Service_PRODUCTFIELDNAMEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfProductFieldNameDTO
	Local oClone := Service_ArrayOfProductFieldNameDTO():NEW()
	oClone:oWSProductFieldNameDTO := NIL
	If ::oWSProductFieldNameDTO <> NIL 
		oClone:oWSProductFieldNameDTO := {}
		aEval( ::oWSProductFieldNameDTO , { |x| aadd( oClone:oWSProductFieldNameDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfProductFieldNameDTO
	Local cSoap := ""
	aEval( ::oWSProductFieldNameDTO , {|x| cSoap := cSoap  +  WSSoapValue("ProductFieldNameDTO", x , x , "ProductFieldNameDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfProductFieldIdDTO

WSSTRUCT Service_ArrayOfProductFieldIdDTO
	WSDATA   oWSProductFieldIdDTO      AS Service_ProductFieldIdDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfProductFieldIdDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfProductFieldIdDTO
	::oWSProductFieldIdDTO := {} // Array Of  Service_PRODUCTFIELDIDDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfProductFieldIdDTO
	Local oClone := Service_ArrayOfProductFieldIdDTO():NEW()
	oClone:oWSProductFieldIdDTO := NIL
	If ::oWSProductFieldIdDTO <> NIL 
		oClone:oWSProductFieldIdDTO := {}
		aEval( ::oWSProductFieldIdDTO , { |x| aadd( oClone:oWSProductFieldIdDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfProductFieldIdDTO
	Local cSoap := ""
	aEval( ::oWSProductFieldIdDTO , {|x| cSoap := cSoap  +  WSSoapValue("ProductFieldIdDTO", x , x , "ProductFieldIdDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfStockKeepingUnitFieldNameDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitFieldNameDTO
	WSDATA   oWSStockKeepingUnitFieldNameDTO AS Service_StockKeepingUnitFieldNameDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitFieldNameDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitFieldNameDTO
	::oWSStockKeepingUnitFieldNameDTO := {} // Array Of  Service_STOCKKEEPINGUNITFIELDNAMEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitFieldNameDTO
	Local oClone := Service_ArrayOfStockKeepingUnitFieldNameDTO():NEW()
	oClone:oWSStockKeepingUnitFieldNameDTO := NIL
	If ::oWSStockKeepingUnitFieldNameDTO <> NIL 
		oClone:oWSStockKeepingUnitFieldNameDTO := {}
		aEval( ::oWSStockKeepingUnitFieldNameDTO , { |x| aadd( oClone:oWSStockKeepingUnitFieldNameDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfStockKeepingUnitFieldNameDTO
	Local cSoap := ""
	aEval( ::oWSStockKeepingUnitFieldNameDTO , {|x| cSoap := cSoap  +  WSSoapValue("StockKeepingUnitFieldNameDTO", x , x , "StockKeepingUnitFieldNameDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfStockKeepingUnitFieldIdDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitFieldIdDTO
	WSDATA   oWSStockKeepingUnitFieldIdDTO AS Service_StockKeepingUnitFieldIdDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitFieldIdDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitFieldIdDTO
	::oWSStockKeepingUnitFieldIdDTO := {} // Array Of  Service_STOCKKEEPINGUNITFIELDIDDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitFieldIdDTO
	Local oClone := Service_ArrayOfStockKeepingUnitFieldIdDTO():NEW()
	oClone:oWSStockKeepingUnitFieldIdDTO := NIL
	If ::oWSStockKeepingUnitFieldIdDTO <> NIL 
		oClone:oWSStockKeepingUnitFieldIdDTO := {}
		aEval( ::oWSStockKeepingUnitFieldIdDTO , { |x| aadd( oClone:oWSStockKeepingUnitFieldIdDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfStockKeepingUnitFieldIdDTO
	Local cSoap := ""
	aEval( ::oWSStockKeepingUnitFieldIdDTO , {|x| cSoap := cSoap  +  WSSoapValue("StockKeepingUnitFieldIdDTO", x , x , "StockKeepingUnitFieldIdDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfStoreDTO

WSSTRUCT Service_ArrayOfStoreDTO
	WSDATA   oWSStoreDTO               AS Service_StoreDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStoreDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStoreDTO
	::oWSStoreDTO          := {} // Array Of  Service_STOREDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStoreDTO
	Local oClone := Service_ArrayOfStoreDTO():NEW()
	oClone:oWSStoreDTO := NIL
	If ::oWSStoreDTO <> NIL 
		oClone:oWSStoreDTO := {}
		aEval( ::oWSStoreDTO , { |x| aadd( oClone:oWSStoreDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfStoreDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STOREDTO","StoreDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSStoreDTO , Service_StoreDTO():New() )
			::oWSStoreDTO[len(::oWSStoreDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure StoreDTO

WSSTRUCT Service_StoreDTO
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StoreDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StoreDTO
Return

WSMETHOD CLONE WSCLIENT Service_StoreDTO
	Local oClone := Service_StoreDTO():NEW()
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:cName                := ::cName
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_StoreDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure GiftCardDTO

WSSTRUCT Service_GiftCardDTO
	WSDATA   cEmissionDate             AS dateTime OPTIONAL
	WSDATA   cExpiringDate             AS dateTime OPTIONAL
	WSDATA   nFunds                    AS decimal OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lMultipleCredits          AS boolean OPTIONAL
	WSDATA   lMultipleRedemptions      AS boolean OPTIONAL
	WSDATA   cOwnerId                  AS string OPTIONAL
	WSDATA   cRedeptionCode            AS string OPTIONAL
	WSDATA   lRestrictedToOwner        AS boolean OPTIONAL
	WSDATA   nStatusId                 AS short OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_GiftCardDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_GiftCardDTO
Return

WSMETHOD CLONE WSCLIENT Service_GiftCardDTO
	Local oClone := Service_GiftCardDTO():NEW()
	oClone:cEmissionDate        := ::cEmissionDate
	oClone:cExpiringDate        := ::cExpiringDate
	oClone:nFunds               := ::nFunds
	oClone:nId                  := ::nId
	oClone:lMultipleCredits     := ::lMultipleCredits
	oClone:lMultipleRedemptions := ::lMultipleRedemptions
	oClone:cOwnerId             := ::cOwnerId
	oClone:cRedeptionCode       := ::cRedeptionCode
	oClone:lRestrictedToOwner   := ::lRestrictedToOwner
	oClone:nStatusId            := ::nStatusId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_GiftCardDTO
	Local cSoap := ""
	cSoap += WSSoapValue("EmissionDate", ::cEmissionDate, ::cEmissionDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ExpiringDate", ::cExpiringDate, ::cExpiringDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Funds", ::nFunds, ::nFunds , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MultipleCredits", ::lMultipleCredits, ::lMultipleCredits , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MultipleRedemptions", ::lMultipleRedemptions, ::lMultipleRedemptions , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OwnerId", ::cOwnerId, ::cOwnerId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RedeptionCode", ::cRedeptionCode, ::cRedeptionCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RestrictedToOwner", ::lRestrictedToOwner, ::lRestrictedToOwner , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StatusId", ::nStatusId, ::nStatusId , "short", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_GiftCardDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cEmissionDate      :=  WSAdvValue( oResponse,"_EMISSIONDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cExpiringDate      :=  WSAdvValue( oResponse,"_EXPIRINGDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFunds             :=  WSAdvValue( oResponse,"_FUNDS","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lMultipleCredits   :=  WSAdvValue( oResponse,"_MULTIPLECREDITS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lMultipleRedemptions :=  WSAdvValue( oResponse,"_MULTIPLEREDEMPTIONS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cOwnerId           :=  WSAdvValue( oResponse,"_OWNERID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cRedeptionCode     :=  WSAdvValue( oResponse,"_REDEPTIONCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lRestrictedToOwner :=  WSAdvValue( oResponse,"_RESTRICTEDTOOWNER","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nStatusId          :=  WSAdvValue( oResponse,"_STATUSID","short",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure GiftCardTransactionItemDTO

WSSTRUCT Service_GiftCardTransactionItemDTO
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   cRedemptionCode           AS string OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSDATA   oWSTransactionAction      AS Service_TransactionAction OPTIONAL
	WSDATA   lTransactionConfirmed     AS boolean OPTIONAL
	WSDATA   nValue                    AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_GiftCardTransactionItemDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_GiftCardTransactionItemDTO
Return

WSMETHOD CLONE WSCLIENT Service_GiftCardTransactionItemDTO
	Local oClone := Service_GiftCardTransactionItemDTO():NEW()
	oClone:nOrderId             := ::nOrderId
	oClone:cRedemptionCode      := ::cRedemptionCode
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
	oClone:oWSTransactionAction := IIF(::oWSTransactionAction = NIL , NIL , ::oWSTransactionAction:Clone() )
	oClone:lTransactionConfirmed := ::lTransactionConfirmed
	oClone:nValue               := ::nValue
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_GiftCardTransactionItemDTO
	Local cSoap := ""
	cSoap += WSSoapValue("OrderId", ::nOrderId, ::nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RedemptionCode", ::cRedemptionCode, ::cRedemptionCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TransactionAction", ::oWSTransactionAction, ::oWSTransactionAction , "TransactionAction", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TransactionConfirmed", ::lTransactionConfirmed, ::lTransactionConfirmed , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Value", ::nValue, ::nValue , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure GiftListDTO

WSSTRUCT Service_GiftListDTO
	WSDATA   nClientAddressId          AS int OPTIONAL
	WSDATA   nClientId                 AS int OPTIONAL
	WSDATA   cDateCreated              AS dateTime OPTIONAL
	WSDATA   cDateModified             AS dateTime OPTIONAL
	WSDATA   cEventCity                AS string OPTIONAL
	WSDATA   cEventDate                AS dateTime OPTIONAL
	WSDATA   cEventLocation            AS string OPTIONAL
	WSDATA   cEventState               AS string OPTIONAL
	WSDATA   nFileId                   AS int OPTIONAL
	WSDATA   nGiftCardId               AS int OPTIONAL
	WSDATA   nGiftListId               AS int OPTIONAL
	WSDATA   oWSGiftListMembers        AS Service_ArrayOfGiftListMemberDTO OPTIONAL
	WSDATA   nGiftListTypeId           AS int OPTIONAL
	WSDATA   cGifted                   AS string OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsPublic                 AS boolean OPTIONAL
	WSDATA   cMessage                  AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cProfileSystemUserAddressName AS string OPTIONAL
	WSDATA   cProfileSystemUserId      AS string OPTIONAL
	WSDATA   cUrlFolder                AS string OPTIONAL
	WSDATA   nVersion                  AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_GiftListDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_GiftListDTO
Return

WSMETHOD CLONE WSCLIENT Service_GiftListDTO
	Local oClone := Service_GiftListDTO():NEW()
	oClone:nClientAddressId     := ::nClientAddressId
	oClone:nClientId            := ::nClientId
	oClone:cDateCreated         := ::cDateCreated
	oClone:cDateModified        := ::cDateModified
	oClone:cEventCity           := ::cEventCity
	oClone:cEventDate           := ::cEventDate
	oClone:cEventLocation       := ::cEventLocation
	oClone:cEventState          := ::cEventState
	oClone:nFileId              := ::nFileId
	oClone:nGiftCardId          := ::nGiftCardId
	oClone:nGiftListId          := ::nGiftListId
	oClone:oWSGiftListMembers   := IIF(::oWSGiftListMembers = NIL , NIL , ::oWSGiftListMembers:Clone() )
	oClone:nGiftListTypeId      := ::nGiftListTypeId
	oClone:cGifted              := ::cGifted
	oClone:lIsActive            := ::lIsActive
	oClone:lIsPublic            := ::lIsPublic
	oClone:cMessage             := ::cMessage
	oClone:cName                := ::cName
	oClone:cProfileSystemUserAddressName := ::cProfileSystemUserAddressName
	oClone:cProfileSystemUserId := ::cProfileSystemUserId
	oClone:cUrlFolder           := ::cUrlFolder
	oClone:nVersion             := ::nVersion
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_GiftListDTO
	Local cSoap := ""
	cSoap += WSSoapValue("ClientAddressId", ::nClientAddressId, ::nClientAddressId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ClientId", ::nClientId, ::nClientId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DateCreated", ::cDateCreated, ::cDateCreated , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DateModified", ::cDateModified, ::cDateModified , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EventCity", ::cEventCity, ::cEventCity , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EventDate", ::cEventDate, ::cEventDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EventLocation", ::cEventLocation, ::cEventLocation , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EventState", ::cEventState, ::cEventState , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FileId", ::nFileId, ::nFileId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftCardId", ::nGiftCardId, ::nGiftCardId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListId", ::nGiftListId, ::nGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListMembers", ::oWSGiftListMembers, ::oWSGiftListMembers , "ArrayOfGiftListMemberDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListTypeId", ::nGiftListTypeId, ::nGiftListTypeId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Gifted", ::cGifted, ::cGifted , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsPublic", ::lIsPublic, ::lIsPublic , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Message", ::cMessage, ::cMessage , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProfileSystemUserAddressName", ::cProfileSystemUserAddressName, ::cProfileSystemUserAddressName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProfileSystemUserId", ::cProfileSystemUserId, ::cProfileSystemUserId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UrlFolder", ::cUrlFolder, ::cUrlFolder , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Version", ::nVersion, ::nVersion , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_GiftListDTO
	Local oNode12
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nClientAddressId   :=  WSAdvValue( oResponse,"_CLIENTADDRESSID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nClientId          :=  WSAdvValue( oResponse,"_CLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDateCreated       :=  WSAdvValue( oResponse,"_DATECREATED","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDateModified      :=  WSAdvValue( oResponse,"_DATEMODIFIED","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEventCity         :=  WSAdvValue( oResponse,"_EVENTCITY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEventDate         :=  WSAdvValue( oResponse,"_EVENTDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEventLocation     :=  WSAdvValue( oResponse,"_EVENTLOCATION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEventState        :=  WSAdvValue( oResponse,"_EVENTSTATE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFileId            :=  WSAdvValue( oResponse,"_FILEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nGiftCardId        :=  WSAdvValue( oResponse,"_GIFTCARDID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nGiftListId        :=  WSAdvValue( oResponse,"_GIFTLISTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode12 :=  WSAdvValue( oResponse,"_GIFTLISTMEMBERS","ArrayOfGiftListMemberDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode12 != NIL
		::oWSGiftListMembers := Service_ArrayOfGiftListMemberDTO():New()
		::oWSGiftListMembers:SoapRecv(oNode12)
	EndIf
	::nGiftListTypeId    :=  WSAdvValue( oResponse,"_GIFTLISTTYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cGifted            :=  WSAdvValue( oResponse,"_GIFTED","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsPublic          :=  WSAdvValue( oResponse,"_ISPUBLIC","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cMessage           :=  WSAdvValue( oResponse,"_MESSAGE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cProfileSystemUserAddressName :=  WSAdvValue( oResponse,"_PROFILESYSTEMUSERADDRESSNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cProfileSystemUserId :=  WSAdvValue( oResponse,"_PROFILESYSTEMUSERID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cUrlFolder         :=  WSAdvValue( oResponse,"_URLFOLDER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nVersion           :=  WSAdvValue( oResponse,"_VERSION","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfGiftListDTO

WSSTRUCT Service_ArrayOfGiftListDTO
	WSDATA   oWSGiftListDTO            AS Service_GiftListDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfGiftListDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfGiftListDTO
	::oWSGiftListDTO       := {} // Array Of  Service_GIFTLISTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfGiftListDTO
	Local oClone := Service_ArrayOfGiftListDTO():NEW()
	oClone:oWSGiftListDTO := NIL
	If ::oWSGiftListDTO <> NIL 
		oClone:oWSGiftListDTO := {}
		aEval( ::oWSGiftListDTO , { |x| aadd( oClone:oWSGiftListDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfGiftListDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_GIFTLISTDTO","GiftListDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSGiftListDTO , Service_GiftListDTO():New() )
			::oWSGiftListDTO[len(::oWSGiftListDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure GiftListTypeDTO

WSSTRUCT Service_GiftListTypeDTO
	WSDATA   nGiftListTypeId           AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   lIsMessageAvailable       AS boolean OPTIONAL
	WSDATA   lIsStockImpact            AS boolean OPTIONAL
	WSDATA   lShipToListOwner          AS boolean OPTIONAL
	WSDATA   nDaysToExpireToVisitors   AS int OPTIONAL
	WSDATA   nDaysToExpireToMembers    AS int OPTIONAL
	WSDATA   nDaysToEventMin           AS int OPTIONAL
	WSDATA   nDaysToEventMax           AS int OPTIONAL
	WSDATA   nMemberMin                AS int OPTIONAL
	WSDATA   nMemberMax                AS int OPTIONAL
	WSDATA   cMemberTitle              AS string OPTIONAL
	WSDATA   cTextTitle1               AS string OPTIONAL
	WSDATA   cTextTitle2               AS string OPTIONAL
	WSDATA   lIsPublic                 AS boolean OPTIONAL
	WSDATA   lIsProtected              AS boolean OPTIONAL
	WSDATA   lIsUnique                 AS boolean OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   nVersion                  AS int OPTIONAL
	WSDATA   nGiftCardRechargeSkuId    AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_GiftListTypeDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_GiftListTypeDTO
Return

WSMETHOD CLONE WSCLIENT Service_GiftListTypeDTO
	Local oClone := Service_GiftListTypeDTO():NEW()
	oClone:nGiftListTypeId      := ::nGiftListTypeId
	oClone:cName                := ::cName
	oClone:cDescription         := ::cDescription
	oClone:lIsMessageAvailable  := ::lIsMessageAvailable
	oClone:lIsStockImpact       := ::lIsStockImpact
	oClone:lShipToListOwner     := ::lShipToListOwner
	oClone:nDaysToExpireToVisitors := ::nDaysToExpireToVisitors
	oClone:nDaysToExpireToMembers := ::nDaysToExpireToMembers
	oClone:nDaysToEventMin      := ::nDaysToEventMin
	oClone:nDaysToEventMax      := ::nDaysToEventMax
	oClone:nMemberMin           := ::nMemberMin
	oClone:nMemberMax           := ::nMemberMax
	oClone:cMemberTitle         := ::cMemberTitle
	oClone:cTextTitle1          := ::cTextTitle1
	oClone:cTextTitle2          := ::cTextTitle2
	oClone:lIsPublic            := ::lIsPublic
	oClone:lIsProtected         := ::lIsProtected
	oClone:lIsUnique            := ::lIsUnique
	oClone:lIsActive            := ::lIsActive
	oClone:nVersion             := ::nVersion
	oClone:nGiftCardRechargeSkuId := ::nGiftCardRechargeSkuId
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_GiftListTypeDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nGiftListTypeId    :=  WSAdvValue( oResponse,"_GIFTLISTTYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsMessageAvailable :=  WSAdvValue( oResponse,"_ISMESSAGEAVAILABLE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsStockImpact     :=  WSAdvValue( oResponse,"_ISSTOCKIMPACT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lShipToListOwner   :=  WSAdvValue( oResponse,"_SHIPTOLISTOWNER","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nDaysToExpireToVisitors :=  WSAdvValue( oResponse,"_DAYSTOEXPIRETOVISITORS","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDaysToExpireToMembers :=  WSAdvValue( oResponse,"_DAYSTOEXPIRETOMEMBERS","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDaysToEventMin    :=  WSAdvValue( oResponse,"_DAYSTOEVENTMIN","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDaysToEventMax    :=  WSAdvValue( oResponse,"_DAYSTOEVENTMAX","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nMemberMin         :=  WSAdvValue( oResponse,"_MEMBERMIN","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nMemberMax         :=  WSAdvValue( oResponse,"_MEMBERMAX","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cMemberTitle       :=  WSAdvValue( oResponse,"_MEMBERTITLE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTextTitle1        :=  WSAdvValue( oResponse,"_TEXTTITLE1","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTextTitle2        :=  WSAdvValue( oResponse,"_TEXTTITLE2","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsPublic          :=  WSAdvValue( oResponse,"_ISPUBLIC","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsProtected       :=  WSAdvValue( oResponse,"_ISPROTECTED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsUnique          :=  WSAdvValue( oResponse,"_ISUNIQUE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nVersion           :=  WSAdvValue( oResponse,"_VERSION","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nGiftCardRechargeSkuId :=  WSAdvValue( oResponse,"_GIFTCARDRECHARGESKUID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfGiftListMemberDTO

WSSTRUCT Service_ArrayOfGiftListMemberDTO
	WSDATA   oWSGiftListMemberDTO      AS Service_GiftListMemberDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfGiftListMemberDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfGiftListMemberDTO
	::oWSGiftListMemberDTO := {} // Array Of  Service_GIFTLISTMEMBERDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfGiftListMemberDTO
	Local oClone := Service_ArrayOfGiftListMemberDTO():NEW()
	oClone:oWSGiftListMemberDTO := NIL
	If ::oWSGiftListMemberDTO <> NIL 
		oClone:oWSGiftListMemberDTO := {}
		aEval( ::oWSGiftListMemberDTO , { |x| aadd( oClone:oWSGiftListMemberDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfGiftListMemberDTO
	Local cSoap := ""
	aEval( ::oWSGiftListMemberDTO , {|x| cSoap := cSoap  +  WSSoapValue("GiftListMemberDTO", x , x , "GiftListMemberDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfGiftListMemberDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_GIFTLISTMEMBERDTO","GiftListMemberDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSGiftListMemberDTO , Service_GiftListMemberDTO():New() )
			::oWSGiftListMemberDTO[len(::oWSGiftListMemberDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfStockKeepingUnitQuantityDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitQuantityDTO
	WSDATA   oWSStockKeepingUnitQuantityDTO AS Service_StockKeepingUnitQuantityDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitQuantityDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitQuantityDTO
	::oWSStockKeepingUnitQuantityDTO := {} // Array Of  Service_STOCKKEEPINGUNITQUANTITYDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitQuantityDTO
	Local oClone := Service_ArrayOfStockKeepingUnitQuantityDTO():NEW()
	oClone:oWSStockKeepingUnitQuantityDTO := NIL
	If ::oWSStockKeepingUnitQuantityDTO <> NIL 
		oClone:oWSStockKeepingUnitQuantityDTO := {}
		aEval( ::oWSStockKeepingUnitQuantityDTO , { |x| aadd( oClone:oWSStockKeepingUnitQuantityDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfStockKeepingUnitQuantityDTO
	Local cSoap := ""
	aEval( ::oWSStockKeepingUnitQuantityDTO , {|x| cSoap := cSoap  +  WSSoapValue("StockKeepingUnitQuantityDTO", x , x , "StockKeepingUnitQuantityDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfEmailQueueDTO

WSSTRUCT Service_ArrayOfEmailQueueDTO
	WSDATA   oWSEmailQueueDTO          AS Service_EmailQueueDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfEmailQueueDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfEmailQueueDTO
	::oWSEmailQueueDTO     := {} // Array Of  Service_EMAILQUEUEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfEmailQueueDTO
	Local oClone := Service_ArrayOfEmailQueueDTO():NEW()
	oClone:oWSEmailQueueDTO := NIL
	If ::oWSEmailQueueDTO <> NIL 
		oClone:oWSEmailQueueDTO := {}
		aEval( ::oWSEmailQueueDTO , { |x| aadd( oClone:oWSEmailQueueDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfEmailQueueDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_EMAILQUEUEDTO","EmailQueueDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSEmailQueueDTO , Service_EmailQueueDTO():New() )
			::oWSEmailQueueDTO[len(::oWSEmailQueueDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfIntegrationErrorDTO

WSSTRUCT Service_ArrayOfIntegrationErrorDTO
	WSDATA   oWSIntegrationErrorDTO    AS Service_IntegrationErrorDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfIntegrationErrorDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfIntegrationErrorDTO
	::oWSIntegrationErrorDTO := {} // Array Of  Service_INTEGRATIONERRORDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfIntegrationErrorDTO
	Local oClone := Service_ArrayOfIntegrationErrorDTO():NEW()
	oClone:oWSIntegrationErrorDTO := NIL
	If ::oWSIntegrationErrorDTO <> NIL 
		oClone:oWSIntegrationErrorDTO := {}
		aEval( ::oWSIntegrationErrorDTO , { |x| aadd( oClone:oWSIntegrationErrorDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfIntegrationErrorDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_INTEGRATIONERRORDTO","IntegrationErrorDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSIntegrationErrorDTO , Service_IntegrationErrorDTO():New() )
			::oWSIntegrationErrorDTO[len(::oWSIntegrationErrorDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfIntegrationInterfaceDTO

WSSTRUCT Service_ArrayOfIntegrationInterfaceDTO
	WSDATA   oWSIntegrationInterfaceDTO AS Service_IntegrationInterfaceDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfIntegrationInterfaceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfIntegrationInterfaceDTO
	::oWSIntegrationInterfaceDTO := {} // Array Of  Service_INTEGRATIONINTERFACEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfIntegrationInterfaceDTO
	Local oClone := Service_ArrayOfIntegrationInterfaceDTO():NEW()
	oClone:oWSIntegrationInterfaceDTO := NIL
	If ::oWSIntegrationInterfaceDTO <> NIL 
		oClone:oWSIntegrationInterfaceDTO := {}
		aEval( ::oWSIntegrationInterfaceDTO , { |x| aadd( oClone:oWSIntegrationInterfaceDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfIntegrationInterfaceDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_INTEGRATIONINTERFACEDTO","IntegrationInterfaceDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSIntegrationInterfaceDTO , Service_IntegrationInterfaceDTO():New() )
			::oWSIntegrationInterfaceDTO[len(::oWSIntegrationInterfaceDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure CollectionDTO

WSSTRUCT Service_CollectionDTO
	WSDATA   cFromDate                 AS dateTime OPTIONAL
	WSDATA   lHighlight                AS boolean OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lListInactiveProducts     AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   oWSProductIdCollection    AS Service_ArrayOfint OPTIONAL
	WSDATA   lSearchable               AS boolean OPTIONAL
	WSDATA   cToDate                   AS dateTime OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_CollectionDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_CollectionDTO
Return

WSMETHOD CLONE WSCLIENT Service_CollectionDTO
	Local oClone := Service_CollectionDTO():NEW()
	oClone:cFromDate            := ::cFromDate
	oClone:lHighlight           := ::lHighlight
	oClone:nId                  := ::nId
	oClone:lListInactiveProducts := ::lListInactiveProducts
	oClone:cName                := ::cName
	oClone:oWSProductIdCollection := IIF(::oWSProductIdCollection = NIL , NIL , ::oWSProductIdCollection:Clone() )
	oClone:lSearchable          := ::lSearchable
	oClone:cToDate              := ::cToDate
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_CollectionDTO
	Local cSoap := ""
	cSoap += WSSoapValue("FromDate", ::cFromDate, ::cFromDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Highlight", ::lHighlight, ::lHighlight , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListInactiveProducts", ::lListInactiveProducts, ::lListInactiveProducts , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProductIdCollection", ::oWSProductIdCollection, ::oWSProductIdCollection , "ArrayOfint", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Searchable", ::lSearchable, ::lSearchable , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ToDate", ::cToDate, ::cToDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_CollectionDTO
	Local oNode6
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cFromDate          :=  WSAdvValue( oResponse,"_FROMDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::lHighlight         :=  WSAdvValue( oResponse,"_HIGHLIGHT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lListInactiveProducts :=  WSAdvValue( oResponse,"_LISTINACTIVEPRODUCTS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode6 :=  WSAdvValue( oResponse,"_PRODUCTIDCOLLECTION","ArrayOfint",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode6 != NIL
		::oWSProductIdCollection := Service_ArrayOfint():New()
		::oWSProductIdCollection:SoapRecv(oNode6)
	EndIf
	::lSearchable        :=  WSAdvValue( oResponse,"_SEARCHABLE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cToDate            :=  WSAdvValue( oResponse,"_TODATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ShippingNotificationDTO

WSSTRUCT Service_ShippingNotificationDTO
	WSDATA   oWSFiscalInvoice          AS Service_FiscalInvoiceDTO OPTIONAL
	WSDATA   cOrderId                  AS string OPTIONAL
	WSDATA   oWSPackadgeTracking       AS Service_PackageTrackingDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ShippingNotificationDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ShippingNotificationDTO
Return

WSMETHOD CLONE WSCLIENT Service_ShippingNotificationDTO
	Local oClone := Service_ShippingNotificationDTO():NEW()
	oClone:oWSFiscalInvoice     := IIF(::oWSFiscalInvoice = NIL , NIL , ::oWSFiscalInvoice:Clone() )
	oClone:cOrderId             := ::cOrderId
	oClone:oWSPackadgeTracking  := IIF(::oWSPackadgeTracking = NIL , NIL , ::oWSPackadgeTracking:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ShippingNotificationDTO
	Local cSoap := ""
	cSoap += WSSoapValue("FiscalInvoice", ::oWSFiscalInvoice, ::oWSFiscalInvoice , "FiscalInvoiceDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderId", ::cOrderId, ::cOrderId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PackadgeTracking", ::oWSPackadgeTracking, ::oWSPackadgeTracking , "PackageTrackingDTO", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure PackageTrackingDTO

WSSTRUCT Service_PackageTrackingDTO
	WSDATA   nAWB                      AS int OPTIONAL
	WSDATA   nAmount                   AS int OPTIONAL
	WSDATA   cCodeTracking             AS string OPTIONAL
	WSDATA   nConsignmentNumber        AS int OPTIONAL
	WSDATA   cFiscalInvoice            AS string OPTIONAL
	WSDATA   nFiscalInvoiceSeries      AS int OPTIONAL
	WSDATA   oWSFreight                AS SCHEMA OPTIONAL
	WSDATA   cGenerationDate           AS dateTime OPTIONAL
	WSDATA   nOrderNumber              AS int OPTIONAL
	WSDATA   nProcessCode              AS int OPTIONAL
	WSDATA   cProtocol                 AS string OPTIONAL
	WSDATA   nServiceReturn            AS int OPTIONAL
	WSDATA   nStoreID                  AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_PackageTrackingDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_PackageTrackingDTO
Return

WSMETHOD CLONE WSCLIENT Service_PackageTrackingDTO
	Local oClone := Service_PackageTrackingDTO():NEW()
	oClone:nAWB                 := ::nAWB
	oClone:nAmount              := ::nAmount
	oClone:cCodeTracking        := ::cCodeTracking
	oClone:nConsignmentNumber   := ::nConsignmentNumber
	oClone:cFiscalInvoice       := ::cFiscalInvoice
	oClone:nFiscalInvoiceSeries := ::nFiscalInvoiceSeries
	oClone:oWSFreight           := IIF(::oWSFreight = NIL , NIL , ::oWSFreight:Clone() )
	oClone:cGenerationDate      := ::cGenerationDate
	oClone:nOrderNumber         := ::nOrderNumber
	oClone:nProcessCode         := ::nProcessCode
	oClone:cProtocol            := ::cProtocol
	oClone:nServiceReturn       := ::nServiceReturn
	oClone:nStoreID             := ::nStoreID
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_PackageTrackingDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AWB", ::nAWB, ::nAWB , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Amount", ::nAmount, ::nAmount , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CodeTracking", ::cCodeTracking, ::cCodeTracking , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ConsignmentNumber", ::nConsignmentNumber, ::nConsignmentNumber , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FiscalInvoice", ::cFiscalInvoice, ::cFiscalInvoice , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FiscalInvoiceSeries", ::nFiscalInvoiceSeries, ::nFiscalInvoiceSeries , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Freight", ::oWSFreight, ::oWSFreight , "SCHEMA", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GenerationDate", ::cGenerationDate, ::cGenerationDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderNumber", ::nOrderNumber, ::nOrderNumber , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProcessCode", ::nProcessCode, ::nProcessCode , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Protocol", ::cProtocol, ::cProtocol , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ServiceReturn", ::nServiceReturn, ::nServiceReturn , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StoreID", ::nStoreID, ::nStoreID , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure WareHouseIStockableDTO

WSSTRUCT Service_WareHouseIStockableDTO
	WSDATA   nAvailableQuantity        AS int OPTIONAL
	WSDATA   nReservedQuantity         AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSDATA   nTotalQuantity            AS int OPTIONAL
	WSDATA   nWareHouseId              AS int OPTIONAL
	WSDATA   cWareHouseIdV3            AS string OPTIONAL
	WSDATA   cWareHouseName            AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_WareHouseIStockableDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_WareHouseIStockableDTO
Return

WSMETHOD CLONE WSCLIENT Service_WareHouseIStockableDTO
	Local oClone := Service_WareHouseIStockableDTO():NEW()
	oClone:nAvailableQuantity   := ::nAvailableQuantity
	oClone:nReservedQuantity    := ::nReservedQuantity
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
	oClone:nTotalQuantity       := ::nTotalQuantity
	oClone:nWareHouseId         := ::nWareHouseId
	oClone:cWareHouseIdV3       := ::cWareHouseIdV3
	oClone:cWareHouseName       := ::cWareHouseName
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_WareHouseIStockableDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nAvailableQuantity :=  WSAdvValue( oResponse,"_AVAILABLEQUANTITY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nReservedQuantity  :=  WSAdvValue( oResponse,"_RESERVEDQUANTITY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nTotalQuantity     :=  WSAdvValue( oResponse,"_TOTALQUANTITY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nWareHouseId       :=  WSAdvValue( oResponse,"_WAREHOUSEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cWareHouseIdV3     :=  WSAdvValue( oResponse,"_WAREHOUSEIDV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cWareHouseName     :=  WSAdvValue( oResponse,"_WAREHOUSENAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfWareHouseIStockableDTO

WSSTRUCT Service_ArrayOfWareHouseIStockableDTO
	WSDATA   oWSWareHouseIStockableDTO AS Service_WareHouseIStockableDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfWareHouseIStockableDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfWareHouseIStockableDTO
	::oWSWareHouseIStockableDTO := {} // Array Of  Service_WAREHOUSEISTOCKABLEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfWareHouseIStockableDTO
	Local oClone := Service_ArrayOfWareHouseIStockableDTO():NEW()
	oClone:oWSWareHouseIStockableDTO := NIL
	If ::oWSWareHouseIStockableDTO <> NIL 
		oClone:oWSWareHouseIStockableDTO := {}
		aEval( ::oWSWareHouseIStockableDTO , { |x| aadd( oClone:oWSWareHouseIStockableDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfWareHouseIStockableDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_WAREHOUSEISTOCKABLEDTO","WareHouseIStockableDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSWareHouseIStockableDTO , Service_WareHouseIStockableDTO():New() )
			::oWSWareHouseIStockableDTO[len(::oWSWareHouseIStockableDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure NewsletterDTO

WSSTRUCT Service_NewsletterDTO
	WSDATA   cData                     AS dateTime OPTIONAL
	WSDATA   cEmail                    AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsPersisted              AS boolean OPTIONAL
	WSDATA   lIsRemoved                AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_NewsletterDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_NewsletterDTO
Return

WSMETHOD CLONE WSCLIENT Service_NewsletterDTO
	Local oClone := Service_NewsletterDTO():NEW()
	oClone:cData                := ::cData
	oClone:cEmail               := ::cEmail
	oClone:nId                  := ::nId
	oClone:lIsPersisted         := ::lIsPersisted
	oClone:lIsRemoved           := ::lIsRemoved
	oClone:cName                := ::cName
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_NewsletterDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cData              :=  WSAdvValue( oResponse,"_DATA","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEmail             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsPersisted       :=  WSAdvValue( oResponse,"_ISPERSISTED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsRemoved         :=  WSAdvValue( oResponse,"_ISREMOVED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfNewsletterDTO

WSSTRUCT Service_ArrayOfNewsletterDTO
	WSDATA   oWSNewsletterDTO          AS Service_NewsletterDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfNewsletterDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfNewsletterDTO
	::oWSNewsletterDTO     := {} // Array Of  Service_NEWSLETTERDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfNewsletterDTO
	Local oClone := Service_ArrayOfNewsletterDTO():NEW()
	oClone:oWSNewsletterDTO := NIL
	If ::oWSNewsletterDTO <> NIL 
		oClone:oWSNewsletterDTO := {}
		aEval( ::oWSNewsletterDTO , { |x| aadd( oClone:oWSNewsletterDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfNewsletterDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_NEWSLETTERDTO","NewsletterDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSNewsletterDTO , Service_NewsletterDTO():New() )
			::oWSNewsletterDTO[len(::oWSNewsletterDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure StockKeepingUnitDTO

WSSTRUCT Service_StockKeepingUnitDTO
	WSDATA   nCommercialConditionId    AS int OPTIONAL
	WSDATA   nCostPrice                AS decimal OPTIONAL
	WSDATA   nCubicWeight              AS decimal OPTIONAL
	WSDATA   cDateUpdated              AS dateTime OPTIONAL
	WSDATA   cEstimatedDateArrival     AS dateTime OPTIONAL
	WSDATA   nHeight                   AS decimal OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   cInternalNote             AS string OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsAvaiable               AS boolean OPTIONAL
	WSDATA   lIsKit                    AS boolean OPTIONAL
	WSDATA   nLength                   AS decimal OPTIONAL
	WSDATA   nListPrice                AS decimal OPTIONAL
	WSDATA   cManufacturerCode         AS string OPTIONAL
	WSDATA   cMeasurementUnit          AS string OPTIONAL
	WSDATA   nModalId                  AS int OPTIONAL
	WSDATA   cModalType                AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   nPrice                    AS decimal OPTIONAL
	WSDATA   nProductId                AS int OPTIONAL
	WSDATA   cProductName              AS string OPTIONAL
	WSDATA   nRealHeight               AS decimal OPTIONAL
	WSDATA   nRealLength               AS decimal OPTIONAL
	WSDATA   nRealWeightKg             AS decimal OPTIONAL
	WSDATA   nRealWidth                AS decimal OPTIONAL
	WSDATA   cRefId                    AS string OPTIONAL
	WSDATA   nRewardValue              AS decimal OPTIONAL
	WSDATA   oWSStockKeepingUnitEans   AS Service_ArrayOfStockKeepingUnitEanDTO OPTIONAL
	WSDATA   nUnitMultiplier           AS decimal OPTIONAL
	WSDATA   nWeightKg                 AS decimal OPTIONAL
	WSDATA   nWidth                    AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitDTO
	Local oClone := Service_StockKeepingUnitDTO():NEW()
	oClone:nCommercialConditionId := ::nCommercialConditionId
	oClone:nCostPrice           := ::nCostPrice
	oClone:nCubicWeight         := ::nCubicWeight
	oClone:cDateUpdated         := ::cDateUpdated
	oClone:cEstimatedDateArrival := ::cEstimatedDateArrival
	oClone:nHeight              := ::nHeight
	oClone:nId                  := ::nId
	oClone:cInternalNote        := ::cInternalNote
	oClone:lIsActive            := ::lIsActive
	oClone:lIsAvaiable          := ::lIsAvaiable
	oClone:lIsKit               := ::lIsKit
	oClone:nLength              := ::nLength
	oClone:nListPrice           := ::nListPrice
	oClone:cManufacturerCode    := ::cManufacturerCode
	oClone:cMeasurementUnit     := ::cMeasurementUnit
	oClone:nModalId             := ::nModalId
	oClone:cModalType           := ::cModalType
	oClone:cName                := ::cName
	oClone:nPrice               := ::nPrice
	oClone:nProductId           := ::nProductId
	oClone:cProductName         := ::cProductName
	oClone:nRealHeight          := ::nRealHeight
	oClone:nRealLength          := ::nRealLength
	oClone:nRealWeightKg        := ::nRealWeightKg
	oClone:nRealWidth           := ::nRealWidth
	oClone:cRefId               := ::cRefId
	oClone:nRewardValue         := ::nRewardValue
	oClone:oWSStockKeepingUnitEans := IIF(::oWSStockKeepingUnitEans = NIL , NIL , ::oWSStockKeepingUnitEans:Clone() )
	oClone:nUnitMultiplier      := ::nUnitMultiplier
	oClone:nWeightKg            := ::nWeightKg
	oClone:nWidth               := ::nWidth
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitDTO
	Local cSoap := ""
	cSoap += WSSoapValue("CommercialConditionId", ::nCommercialConditionId, ::nCommercialConditionId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CostPrice", ::nCostPrice, ::nCostPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CubicWeight", ::nCubicWeight, ::nCubicWeight , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DateUpdated", ::cDateUpdated, ::cDateUpdated , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EstimatedDateArrival", ::cEstimatedDateArrival, ::cEstimatedDateArrival , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Height", ::nHeight, ::nHeight , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InternalNote", ::cInternalNote, ::cInternalNote , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsAvaiable", ::lIsAvaiable, ::lIsAvaiable , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsKit", ::lIsKit, ::lIsKit , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Length", ::nLength, ::nLength , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListPrice", ::nListPrice, ::nListPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ManufacturerCode", ::cManufacturerCode, ::cManufacturerCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MeasurementUnit", ::cMeasurementUnit, ::cMeasurementUnit , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ModalId", ::nModalId, ::nModalId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ModalType", ::cModalType, ::cModalType , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Price", ::nPrice, ::nPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProductId", ::nProductId, ::nProductId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProductName", ::cProductName, ::cProductName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RealHeight", ::nRealHeight, ::nRealHeight , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RealLength", ::nRealLength, ::nRealLength , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RealWeightKg", ::nRealWeightKg, ::nRealWeightKg , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RealWidth", ::nRealWidth, ::nRealWidth , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RefId", ::cRefId, ::cRefId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RewardValue", ::nRewardValue, ::nRewardValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitEans", ::oWSStockKeepingUnitEans, ::oWSStockKeepingUnitEans , "ArrayOfStockKeepingUnitEanDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UnitMultiplier", ::nUnitMultiplier, ::nUnitMultiplier , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("WeightKg", ::nWeightKg, ::nWeightKg , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Width", ::nWidth, ::nWidth , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_StockKeepingUnitDTO
	Local oNode28
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nCommercialConditionId :=  WSAdvValue( oResponse,"_COMMERCIALCONDITIONID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCostPrice         :=  WSAdvValue( oResponse,"_COSTPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCubicWeight       :=  WSAdvValue( oResponse,"_CUBICWEIGHT","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDateUpdated       :=  WSAdvValue( oResponse,"_DATEUPDATED","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEstimatedDateArrival :=  WSAdvValue( oResponse,"_ESTIMATEDDATEARRIVAL","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nHeight            :=  WSAdvValue( oResponse,"_HEIGHT","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cInternalNote      :=  WSAdvValue( oResponse,"_INTERNALNOTE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsAvaiable        :=  WSAdvValue( oResponse,"_ISAVAIABLE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsKit             :=  WSAdvValue( oResponse,"_ISKIT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nLength            :=  WSAdvValue( oResponse,"_LENGTH","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nListPrice         :=  WSAdvValue( oResponse,"_LISTPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cManufacturerCode  :=  WSAdvValue( oResponse,"_MANUFACTURERCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cMeasurementUnit   :=  WSAdvValue( oResponse,"_MEASUREMENTUNIT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nModalId           :=  WSAdvValue( oResponse,"_MODALID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cModalType         :=  WSAdvValue( oResponse,"_MODALTYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nPrice             :=  WSAdvValue( oResponse,"_PRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nProductId         :=  WSAdvValue( oResponse,"_PRODUCTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cProductName       :=  WSAdvValue( oResponse,"_PRODUCTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nRealHeight        :=  WSAdvValue( oResponse,"_REALHEIGHT","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nRealLength        :=  WSAdvValue( oResponse,"_REALLENGTH","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nRealWeightKg      :=  WSAdvValue( oResponse,"_REALWEIGHTKG","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nRealWidth         :=  WSAdvValue( oResponse,"_REALWIDTH","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cRefId             :=  WSAdvValue( oResponse,"_REFID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nRewardValue       :=  WSAdvValue( oResponse,"_REWARDVALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode28 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITEANS","ArrayOfStockKeepingUnitEanDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode28 != NIL
		::oWSStockKeepingUnitEans := Service_ArrayOfStockKeepingUnitEanDTO():New()
		::oWSStockKeepingUnitEans:SoapRecv(oNode28)
	EndIf
	::nUnitMultiplier    :=  WSAdvValue( oResponse,"_UNITMULTIPLIER","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nWeightKg          :=  WSAdvValue( oResponse,"_WEIGHTKG","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nWidth             :=  WSAdvValue( oResponse,"_WIDTH","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfStockKeepingUnitDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitDTO
	WSDATA   oWSStockKeepingUnitDTO    AS Service_StockKeepingUnitDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitDTO
	::oWSStockKeepingUnitDTO := {} // Array Of  Service_STOCKKEEPINGUNITDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitDTO
	Local oClone := Service_ArrayOfStockKeepingUnitDTO():NEW()
	oClone:oWSStockKeepingUnitDTO := NIL
	If ::oWSStockKeepingUnitDTO <> NIL 
		oClone:oWSStockKeepingUnitDTO := {}
		aEval( ::oWSStockKeepingUnitDTO , { |x| aadd( oClone:oWSStockKeepingUnitDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfStockKeepingUnitDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITDTO","StockKeepingUnitDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSStockKeepingUnitDTO , Service_StockKeepingUnitDTO():New() )
			::oWSStockKeepingUnitDTO[len(::oWSStockKeepingUnitDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ProductDTO

WSSTRUCT Service_ProductDTO
	WSDATA   cAdWordsRemarketingCode   AS string OPTIONAL
	WSDATA   nBrandId                  AS int OPTIONAL
	WSDATA   nCategoryId               AS int OPTIONAL
	WSDATA   nDepartmentId             AS int OPTIONAL
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   cDescriptionShort         AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsVisible                AS boolean OPTIONAL
	WSDATA   cKeyWords                 AS string OPTIONAL
	WSDATA   cLinkId                   AS string OPTIONAL
	WSDATA   oWSListStoreId            AS Service_ArrayOfint OPTIONAL
	WSDATA   cLomadeeCampaignCode      AS string OPTIONAL
	WSDATA   cMetaTagDescription       AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cRefId                    AS string OPTIONAL
	WSDATA   cReleaseDate              AS dateTime OPTIONAL
	WSDATA   lShowWithoutStock         AS boolean OPTIONAL
	WSDATA   nSupplierId               AS int OPTIONAL
	WSDATA   cTaxCode                  AS string OPTIONAL
	WSDATA   cTitle                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ProductDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ProductDTO
Return

WSMETHOD CLONE WSCLIENT Service_ProductDTO
	Local oClone := Service_ProductDTO():NEW()
	oClone:cAdWordsRemarketingCode := ::cAdWordsRemarketingCode
	oClone:nBrandId             := ::nBrandId
	oClone:nCategoryId          := ::nCategoryId
	oClone:nDepartmentId        := ::nDepartmentId
	oClone:cDescription         := ::cDescription
	oClone:cDescriptionShort    := ::cDescriptionShort
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:lIsVisible           := ::lIsVisible
	oClone:cKeyWords            := ::cKeyWords
	oClone:cLinkId              := ::cLinkId
	oClone:oWSListStoreId       := IIF(::oWSListStoreId = NIL , NIL , ::oWSListStoreId:Clone() )
	oClone:cLomadeeCampaignCode := ::cLomadeeCampaignCode
	oClone:cMetaTagDescription  := ::cMetaTagDescription
	oClone:cName                := ::cName
	oClone:cRefId               := ::cRefId
	oClone:cReleaseDate         := ::cReleaseDate
	oClone:lShowWithoutStock    := ::lShowWithoutStock
	oClone:nSupplierId          := ::nSupplierId
	oClone:cTaxCode             := ::cTaxCode
	oClone:cTitle               := ::cTitle
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ProductDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AdWordsRemarketingCode", ::cAdWordsRemarketingCode, ::cAdWordsRemarketingCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("BrandId", ::nBrandId, ::nBrandId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CategoryId", ::nCategoryId, ::nCategoryId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DepartmentId", ::nDepartmentId, ::nDepartmentId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DescriptionShort", ::cDescriptionShort, ::cDescriptionShort , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsVisible", ::lIsVisible, ::lIsVisible , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("KeyWords", ::cKeyWords, ::cKeyWords , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LinkId", ::cLinkId, ::cLinkId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListStoreId", ::oWSListStoreId, ::oWSListStoreId , "ArrayOfint", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LomadeeCampaignCode", ::cLomadeeCampaignCode, ::cLomadeeCampaignCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MetaTagDescription", ::cMetaTagDescription, ::cMetaTagDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RefId", ::cRefId, ::cRefId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ReleaseDate", ::cReleaseDate, ::cReleaseDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ShowWithoutStock", ::lShowWithoutStock, ::lShowWithoutStock , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("SupplierId", ::nSupplierId, ::nSupplierId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TaxCode", ::cTaxCode, ::cTaxCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Title", ::cTitle, ::cTitle , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ProductDTO
	Local oNode12
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAdWordsRemarketingCode :=  WSAdvValue( oResponse,"_ADWORDSREMARKETINGCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nBrandId           :=  WSAdvValue( oResponse,"_BRANDID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCategoryId        :=  WSAdvValue( oResponse,"_CATEGORYID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDepartmentId      :=  WSAdvValue( oResponse,"_DEPARTMENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDescriptionShort  :=  WSAdvValue( oResponse,"_DESCRIPTIONSHORT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsVisible         :=  WSAdvValue( oResponse,"_ISVISIBLE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cKeyWords          :=  WSAdvValue( oResponse,"_KEYWORDS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cLinkId            :=  WSAdvValue( oResponse,"_LINKID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode12 :=  WSAdvValue( oResponse,"_LISTSTOREID","ArrayOfint",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode12 != NIL
		::oWSListStoreId := Service_ArrayOfint():New()
		::oWSListStoreId:SoapRecv(oNode12)
	EndIf
	::cLomadeeCampaignCode :=  WSAdvValue( oResponse,"_LOMADEECAMPAIGNCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cMetaTagDescription :=  WSAdvValue( oResponse,"_METATAGDESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cRefId             :=  WSAdvValue( oResponse,"_REFID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cReleaseDate       :=  WSAdvValue( oResponse,"_RELEASEDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::lShowWithoutStock  :=  WSAdvValue( oResponse,"_SHOWWITHOUTSTOCK","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nSupplierId        :=  WSAdvValue( oResponse,"_SUPPLIERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cTaxCode           :=  WSAdvValue( oResponse,"_TAXCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfint

WSSTRUCT Service_ArrayOfint
	WSDATA   nint                      AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfint
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfint
	::nint                 := {} // Array Of  0
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfint
	Local oClone := Service_ArrayOfint():NEW()
	oClone:nint                 := IIf(::nint <> NIL , aClone(::nint) , NIL )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfint
	Local cSoap := ""
	aEval( ::nint , {|x| cSoap := cSoap  +  WSSoapValue("int", x , x , "int", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfint
	Local oNodes1 :=  WSAdvValue( oResponse,"_INT","int",{},NIL,.T.,"N",NIL,"xs") 
	::Init()
	If oResponse = NIL ; Return ; Endif 
	aEval(oNodes1 , { |x| aadd(::nint ,  val(x:TEXT)  ) } )
Return

// WSDL Data Structure ArrayOfProductDTO

WSSTRUCT Service_ArrayOfProductDTO
	WSDATA   oWSProductDTO             AS Service_ProductDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfProductDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfProductDTO
	::oWSProductDTO        := {} // Array Of  Service_PRODUCTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfProductDTO
	Local oClone := Service_ArrayOfProductDTO():NEW()
	oClone:oWSProductDTO := NIL
	If ::oWSProductDTO <> NIL 
		oClone:oWSProductDTO := {}
		aEval( ::oWSProductDTO , { |x| aadd( oClone:oWSProductDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfProductDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_PRODUCTDTO","ProductDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSProductDTO , Service_ProductDTO():New() )
			::oWSProductDTO[len(::oWSProductDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfStockKeepingUnitKitDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitKitDTO
	WSDATA   oWSStockKeepingUnitKitDTO AS Service_StockKeepingUnitKitDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitKitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitKitDTO
	::oWSStockKeepingUnitKitDTO := {} // Array Of  Service_STOCKKEEPINGUNITKITDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitKitDTO
	Local oClone := Service_ArrayOfStockKeepingUnitKitDTO():NEW()
	oClone:oWSStockKeepingUnitKitDTO := NIL
	If ::oWSStockKeepingUnitKitDTO <> NIL 
		oClone:oWSStockKeepingUnitKitDTO := {}
		aEval( ::oWSStockKeepingUnitKitDTO , { |x| aadd( oClone:oWSStockKeepingUnitKitDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfStockKeepingUnitKitDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITKITDTO","StockKeepingUnitKitDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSStockKeepingUnitKitDTO , Service_StockKeepingUnitKitDTO():New() )
			::oWSStockKeepingUnitKitDTO[len(::oWSStockKeepingUnitKitDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure IntegrationDTO

WSSTRUCT Service_IntegrationDTO
	WSDATA   cAbacosDecryptKey         AS string OPTIONAL
	WSDATA   cAbacosKey                AS string OPTIONAL
	WSDATA   cAbacosWebService         AS string OPTIONAL
	WSDATA   lAutoIntegration          AS boolean OPTIONAL
	WSDATA   nBrandIdDefault           AS int OPTIONAL
	WSDATA   nCategoryIdDefault        AS int OPTIONAL
	WSDATA   nCheckoutVersion          AS int OPTIONAL
	WSDATA   cClientName               AS string OPTIONAL
	WSDATA   lDisableUtmCampaignOnMultiStore AS boolean OPTIONAL
	WSDATA   lEspecificationSkuOnUniqueProduct AS boolean OPTIONAL
	WSDATA   cIVDecryptKey             AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIgnoreBrandForExistingProducts AS boolean OPTIONAL
	WSDATA   lIgnoreCategoryForExistingProducts AS boolean OPTIONAL
	WSDATA   lIgnoreNameForExistingProductsAndSkus AS boolean OPTIONAL
	WSDATA   lIntegrateDescription     AS boolean OPTIONAL
	WSDATA   lIntegrateDiscountOnItem  AS boolean OPTIONAL
	WSDATA   lIntegrateEAN             AS boolean OPTIONAL
	WSDATA   lIntegrateEspecification  AS boolean OPTIONAL
	WSDATA   lIntegrateGiftListOnOrder AS boolean OPTIONAL
	WSDATA   lIntegrateKitComponentOnOrder AS boolean OPTIONAL
	WSDATA   lIntegratePrice           AS boolean OPTIONAL
	WSDATA   lIntegrateTelemarketing   AS boolean OPTIONAL
	WSDATA   oWSIntegrationWarehouse   AS Service_ArrayOfIntegrationWarehouseDTO OPTIONAL
	WSDATA   lLogSuccess               AS boolean OPTIONAL
	WSDATA   lLogXml                   AS boolean OPTIONAL
	WSDATA   cOrderStatus              AS string OPTIONAL
	WSDATA   oWSPaymentIdWithoutTaxes  AS Service_ArrayOfint OPTIONAL
	WSDATA   cVtexDecryptKey           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_IntegrationDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_IntegrationDTO
Return

WSMETHOD CLONE WSCLIENT Service_IntegrationDTO
	Local oClone := Service_IntegrationDTO():NEW()
	oClone:cAbacosDecryptKey    := ::cAbacosDecryptKey
	oClone:cAbacosKey           := ::cAbacosKey
	oClone:cAbacosWebService    := ::cAbacosWebService
	oClone:lAutoIntegration     := ::lAutoIntegration
	oClone:nBrandIdDefault      := ::nBrandIdDefault
	oClone:nCategoryIdDefault   := ::nCategoryIdDefault
	oClone:nCheckoutVersion     := ::nCheckoutVersion
	oClone:cClientName          := ::cClientName
	oClone:lDisableUtmCampaignOnMultiStore := ::lDisableUtmCampaignOnMultiStore
	oClone:lEspecificationSkuOnUniqueProduct := ::lEspecificationSkuOnUniqueProduct
	oClone:cIVDecryptKey        := ::cIVDecryptKey
	oClone:nId                  := ::nId
	oClone:lIgnoreBrandForExistingProducts := ::lIgnoreBrandForExistingProducts
	oClone:lIgnoreCategoryForExistingProducts := ::lIgnoreCategoryForExistingProducts
	oClone:lIgnoreNameForExistingProductsAndSkus := ::lIgnoreNameForExistingProductsAndSkus
	oClone:lIntegrateDescription := ::lIntegrateDescription
	oClone:lIntegrateDiscountOnItem := ::lIntegrateDiscountOnItem
	oClone:lIntegrateEAN        := ::lIntegrateEAN
	oClone:lIntegrateEspecification := ::lIntegrateEspecification
	oClone:lIntegrateGiftListOnOrder := ::lIntegrateGiftListOnOrder
	oClone:lIntegrateKitComponentOnOrder := ::lIntegrateKitComponentOnOrder
	oClone:lIntegratePrice      := ::lIntegratePrice
	oClone:lIntegrateTelemarketing := ::lIntegrateTelemarketing
	oClone:oWSIntegrationWarehouse := IIF(::oWSIntegrationWarehouse = NIL , NIL , ::oWSIntegrationWarehouse:Clone() )
	oClone:lLogSuccess          := ::lLogSuccess
	oClone:lLogXml              := ::lLogXml
	oClone:cOrderStatus         := ::cOrderStatus
	oClone:oWSPaymentIdWithoutTaxes := IIF(::oWSPaymentIdWithoutTaxes = NIL , NIL , ::oWSPaymentIdWithoutTaxes:Clone() )
	oClone:cVtexDecryptKey      := ::cVtexDecryptKey
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_IntegrationDTO
	Local oNode24
	Local oNode28
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAbacosDecryptKey  :=  WSAdvValue( oResponse,"_ABACOSDECRYPTKEY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cAbacosKey         :=  WSAdvValue( oResponse,"_ABACOSKEY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cAbacosWebService  :=  WSAdvValue( oResponse,"_ABACOSWEBSERVICE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lAutoIntegration   :=  WSAdvValue( oResponse,"_AUTOINTEGRATION","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nBrandIdDefault    :=  WSAdvValue( oResponse,"_BRANDIDDEFAULT","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCategoryIdDefault :=  WSAdvValue( oResponse,"_CATEGORYIDDEFAULT","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCheckoutVersion   :=  WSAdvValue( oResponse,"_CHECKOUTVERSION","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cClientName        :=  WSAdvValue( oResponse,"_CLIENTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lDisableUtmCampaignOnMultiStore :=  WSAdvValue( oResponse,"_DISABLEUTMCAMPAIGNONMULTISTORE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lEspecificationSkuOnUniqueProduct :=  WSAdvValue( oResponse,"_ESPECIFICATIONSKUONUNIQUEPRODUCT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cIVDecryptKey      :=  WSAdvValue( oResponse,"_IVDECRYPTKEY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIgnoreBrandForExistingProducts :=  WSAdvValue( oResponse,"_IGNOREBRANDFOREXISTINGPRODUCTS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIgnoreCategoryForExistingProducts :=  WSAdvValue( oResponse,"_IGNORECATEGORYFOREXISTINGPRODUCTS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIgnoreNameForExistingProductsAndSkus :=  WSAdvValue( oResponse,"_IGNORENAMEFOREXISTINGPRODUCTSANDSKUS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateDescription :=  WSAdvValue( oResponse,"_INTEGRATEDESCRIPTION","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateDiscountOnItem :=  WSAdvValue( oResponse,"_INTEGRATEDISCOUNTONITEM","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateEAN      :=  WSAdvValue( oResponse,"_INTEGRATEEAN","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateEspecification :=  WSAdvValue( oResponse,"_INTEGRATEESPECIFICATION","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateGiftListOnOrder :=  WSAdvValue( oResponse,"_INTEGRATEGIFTLISTONORDER","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateKitComponentOnOrder :=  WSAdvValue( oResponse,"_INTEGRATEKITCOMPONENTONORDER","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegratePrice    :=  WSAdvValue( oResponse,"_INTEGRATEPRICE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIntegrateTelemarketing :=  WSAdvValue( oResponse,"_INTEGRATETELEMARKETING","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	oNode24 :=  WSAdvValue( oResponse,"_INTEGRATIONWAREHOUSE","ArrayOfIntegrationWarehouseDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode24 != NIL
		::oWSIntegrationWarehouse := Service_ArrayOfIntegrationWarehouseDTO():New()
		::oWSIntegrationWarehouse:SoapRecv(oNode24)
	EndIf
	::lLogSuccess        :=  WSAdvValue( oResponse,"_LOGSUCCESS","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lLogXml            :=  WSAdvValue( oResponse,"_LOGXML","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cOrderStatus       :=  WSAdvValue( oResponse,"_ORDERSTATUS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode28 :=  WSAdvValue( oResponse,"_PAYMENTIDWITHOUTTAXES","ArrayOfint",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode28 != NIL
		::oWSPaymentIdWithoutTaxes := Service_ArrayOfint():New()
		::oWSPaymentIdWithoutTaxes:SoapRecv(oNode28)
	EndIf
	::cVtexDecryptKey    :=  WSAdvValue( oResponse,"_VTEXDECRYPTKEY","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ClientCandidateDTO

WSSTRUCT Service_ClientCandidateDTO
	WSDATA   nIdGroupClientCandidate   AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cText                     AS string OPTIONAL
	WSDATA   oWSlistCpf                AS Service_ArrayOfstring OPTIONAL
	WSDATA   oWSlistEmail              AS Service_ArrayOfstring OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ClientCandidateDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ClientCandidateDTO
Return

WSMETHOD CLONE WSCLIENT Service_ClientCandidateDTO
	Local oClone := Service_ClientCandidateDTO():NEW()
	oClone:nIdGroupClientCandidate := ::nIdGroupClientCandidate
	oClone:cName                := ::cName
	oClone:cText                := ::cText
	oClone:oWSlistCpf           := IIF(::oWSlistCpf = NIL , NIL , ::oWSlistCpf:Clone() )
	oClone:oWSlistEmail         := IIF(::oWSlistEmail = NIL , NIL , ::oWSlistEmail:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ClientCandidateDTO
	Local cSoap := ""
	cSoap += WSSoapValue("IdGroupClientCandidate", ::nIdGroupClientCandidate, ::nIdGroupClientCandidate , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Text", ::cText, ::cText , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("listCpf", ::oWSlistCpf, ::oWSlistCpf , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("listEmail", ::oWSlistEmail, ::oWSlistEmail , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ClientCandidateDTO
	Local oNode4
	Local oNode5
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nIdGroupClientCandidate :=  WSAdvValue( oResponse,"_IDGROUPCLIENTCANDIDATE","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cText              :=  WSAdvValue( oResponse,"_TEXT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode4 :=  WSAdvValue( oResponse,"_LISTCPF","ArrayOfstring",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode4 != NIL
		::oWSlistCpf := Service_ArrayOfstring():New()
		::oWSlistCpf:SoapRecv(oNode4)
	EndIf
	oNode5 :=  WSAdvValue( oResponse,"_LISTEMAIL","ArrayOfstring",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode5 != NIL
		::oWSlistEmail := Service_ArrayOfstring():New()
		::oWSlistEmail:SoapRecv(oNode5)
	EndIf
Return

// WSDL Data Structure StockKeepingUnitKitDTO

WSSTRUCT Service_StockKeepingUnitKitDTO
	WSDATA   nAmount                   AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSDATA   nStockKeepingUnitParent   AS int OPTIONAL
	WSDATA   nUnitPrice                AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitKitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitKitDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitKitDTO
	Local oClone := Service_StockKeepingUnitKitDTO():NEW()
	oClone:nAmount              := ::nAmount
	oClone:nId                  := ::nId
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
	oClone:nStockKeepingUnitParent := ::nStockKeepingUnitParent
	oClone:nUnitPrice           := ::nUnitPrice
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitKitDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Amount", ::nAmount, ::nAmount , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitParent", ::nStockKeepingUnitParent, ::nStockKeepingUnitParent , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UnitPrice", ::nUnitPrice, ::nUnitPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_StockKeepingUnitKitDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nAmount            :=  WSAdvValue( oResponse,"_AMOUNT","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockKeepingUnitParent :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITPARENT","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nUnitPrice         :=  WSAdvValue( oResponse,"_UNITPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure OrderDTO

WSSTRUCT Service_OrderDTO
	WSDATA   oWSAddress                AS Service_AddressOrderDTO OPTIONAL
	WSDATA   cAffiliateId              AS string OPTIONAL
	WSDATA   cCampaign                 AS string OPTIONAL
	WSDATA   oWSClient                 AS Service_ClientDTO OPTIONAL
	WSDATA   cClientIP                 AS string OPTIONAL
	WSDATA   nClientId                 AS int OPTIONAL
	WSDATA   cCoupon                   AS string OPTIONAL
	WSDATA   oWSGiftListStockKeepingUnits AS Service_ArrayOfGiftListStockKeepingUnitDTO OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   cIdV3                     AS string OPTIONAL
	WSDATA   lIsGiftList               AS boolean OPTIONAL
	WSDATA   lIsMultiStore             AS boolean OPTIONAL
	WSDATA   cKeywords                 AS string OPTIONAL
	WSDATA   oWSListOrderDiscount      AS Service_ArrayOfOrderDiscountDTO OPTIONAL
	WSDATA   cMedia                    AS string OPTIONAL
	WSDATA   oWSOrderDeliveries        AS Service_ArrayOfOrderDeliveryDTO OPTIONAL
	WSDATA   oWSOrderInvoices          AS Service_ArrayOfOrderInvoiceDTO OPTIONAL
	WSDATA   oWSOrderPayments          AS Service_ArrayOfOrderPaymentDTO OPTIONAL
	WSDATA   cPurchaseDate             AS dateTime OPTIONAL
	WSDATA   oWSPurchaseDateUtc        AS Service_DateTimeOffset OPTIONAL
	WSDATA   cSource                   AS string OPTIONAL
	WSDATA   nStoreId                  AS int OPTIONAL
	WSDATA   cStoreName                AS string OPTIONAL
	WSDATA   nTax                      AS decimal OPTIONAL
	WSDATA   nTelemarketingId          AS int OPTIONAL
	WSDATA   cTelemarketingLogin       AS string OPTIONAL
	WSDATA   cTelemarketingObservation AS string OPTIONAL
	WSDATA   cTelemarketingStoreLocatorCode AS string OPTIONAL
	WSDATA   cTelemarketingStoreLocatorName AS string OPTIONAL
	WSDATA   n_Cost                    AS decimal OPTIONAL
	WSDATA   n_CostFinal               AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderDTO
	Local oClone := Service_OrderDTO():NEW()
	oClone:oWSAddress           := IIF(::oWSAddress = NIL , NIL , ::oWSAddress:Clone() )
	oClone:cAffiliateId         := ::cAffiliateId
	oClone:cCampaign            := ::cCampaign
	oClone:oWSClient            := IIF(::oWSClient = NIL , NIL , ::oWSClient:Clone() )
	oClone:cClientIP            := ::cClientIP
	oClone:nClientId            := ::nClientId
	oClone:cCoupon              := ::cCoupon
	oClone:oWSGiftListStockKeepingUnits := IIF(::oWSGiftListStockKeepingUnits = NIL , NIL , ::oWSGiftListStockKeepingUnits:Clone() )
	oClone:nId                  := ::nId
	oClone:cIdV3                := ::cIdV3
	oClone:lIsGiftList          := ::lIsGiftList
	oClone:lIsMultiStore        := ::lIsMultiStore
	oClone:cKeywords            := ::cKeywords
	oClone:oWSListOrderDiscount := IIF(::oWSListOrderDiscount = NIL , NIL , ::oWSListOrderDiscount:Clone() )
	oClone:cMedia               := ::cMedia
	oClone:oWSOrderDeliveries   := IIF(::oWSOrderDeliveries = NIL , NIL , ::oWSOrderDeliveries:Clone() )
	oClone:oWSOrderInvoices     := IIF(::oWSOrderInvoices = NIL , NIL , ::oWSOrderInvoices:Clone() )
	oClone:oWSOrderPayments     := IIF(::oWSOrderPayments = NIL , NIL , ::oWSOrderPayments:Clone() )
	oClone:cPurchaseDate        := ::cPurchaseDate
	oClone:oWSPurchaseDateUtc   := IIF(::oWSPurchaseDateUtc = NIL , NIL , ::oWSPurchaseDateUtc:Clone() )
	oClone:cSource              := ::cSource
	oClone:nStoreId             := ::nStoreId
	oClone:cStoreName           := ::cStoreName
	oClone:nTax                 := ::nTax
	oClone:nTelemarketingId     := ::nTelemarketingId
	oClone:cTelemarketingLogin  := ::cTelemarketingLogin
	oClone:cTelemarketingObservation := ::cTelemarketingObservation
	oClone:cTelemarketingStoreLocatorCode := ::cTelemarketingStoreLocatorCode
	oClone:cTelemarketingStoreLocatorName := ::cTelemarketingStoreLocatorName
	oClone:n_Cost               := ::n_Cost
	oClone:n_CostFinal          := ::n_CostFinal
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Address", ::oWSAddress, ::oWSAddress , "AddressOrderDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("AffiliateId", ::cAffiliateId, ::cAffiliateId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Campaign", ::cCampaign, ::cCampaign , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Client", ::oWSClient, ::oWSClient , "ClientDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ClientIP", ::cClientIP, ::cClientIP , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ClientId", ::nClientId, ::nClientId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Coupon", ::cCoupon, ::cCoupon , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListStockKeepingUnits", ::oWSGiftListStockKeepingUnits, ::oWSGiftListStockKeepingUnits , "ArrayOfGiftListStockKeepingUnitDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IdV3", ::cIdV3, ::cIdV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsGiftList", ::lIsGiftList, ::lIsGiftList , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsMultiStore", ::lIsMultiStore, ::lIsMultiStore , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Keywords", ::cKeywords, ::cKeywords , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListOrderDiscount", ::oWSListOrderDiscount, ::oWSListOrderDiscount , "ArrayOfOrderDiscountDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Media", ::cMedia, ::cMedia , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderDeliveries", ::oWSOrderDeliveries, ::oWSOrderDeliveries , "ArrayOfOrderDeliveryDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderInvoices", ::oWSOrderInvoices, ::oWSOrderInvoices , "ArrayOfOrderInvoiceDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderPayments", ::oWSOrderPayments, ::oWSOrderPayments , "ArrayOfOrderPaymentDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PurchaseDate", ::cPurchaseDate, ::cPurchaseDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PurchaseDateUtc", ::oWSPurchaseDateUtc, ::oWSPurchaseDateUtc , "DateTimeOffset", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Source", ::cSource, ::cSource , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StoreId", ::nStoreId, ::nStoreId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StoreName", ::cStoreName, ::cStoreName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Tax", ::nTax, ::nTax , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TelemarketingId", ::nTelemarketingId, ::nTelemarketingId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TelemarketingLogin", ::cTelemarketingLogin, ::cTelemarketingLogin , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TelemarketingObservation", ::cTelemarketingObservation, ::cTelemarketingObservation , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TelemarketingStoreLocatorCode", ::cTelemarketingStoreLocatorCode, ::cTelemarketingStoreLocatorCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TelemarketingStoreLocatorName", ::cTelemarketingStoreLocatorName, ::cTelemarketingStoreLocatorName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("_Cost", ::n_Cost, ::n_Cost , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("_CostFinal", ::n_CostFinal, ::n_CostFinal , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderDTO
	Local oNode1
	Local oNode4
	Local oNode8
	Local oNode14
	Local oNode16
	Local oNode17
	Local oNode18
	Local oNode20
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_ADDRESS","AddressOrderDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode1 != NIL
		::oWSAddress := Service_AddressOrderDTO():New()
		::oWSAddress:SoapRecv(oNode1)
	EndIf
	::cAffiliateId       :=  WSAdvValue( oResponse,"_AFFILIATEID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCampaign          :=  WSAdvValue( oResponse,"_CAMPAIGN","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode4 :=  WSAdvValue( oResponse,"_CLIENT","ClientDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode4 != NIL
		::oWSClient := Service_ClientDTO():New()
		::oWSClient:SoapRecv(oNode4)
	EndIf
	::cClientIP          :=  WSAdvValue( oResponse,"_CLIENTIP","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nClientId          :=  WSAdvValue( oResponse,"_CLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cCoupon            :=  WSAdvValue( oResponse,"_COUPON","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode8 :=  WSAdvValue( oResponse,"_GIFTLISTSTOCKKEEPINGUNITS","ArrayOfGiftListStockKeepingUnitDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode8 != NIL
		::oWSGiftListStockKeepingUnits := Service_ArrayOfGiftListStockKeepingUnitDTO():New()
		::oWSGiftListStockKeepingUnits:SoapRecv(oNode8)
	EndIf
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cIdV3              :=  WSAdvValue( oResponse,"_IDV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsGiftList        :=  WSAdvValue( oResponse,"_ISGIFTLIST","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsMultiStore      :=  WSAdvValue( oResponse,"_ISMULTISTORE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cKeywords          :=  WSAdvValue( oResponse,"_KEYWORDS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode14 :=  WSAdvValue( oResponse,"_LISTORDERDISCOUNT","ArrayOfOrderDiscountDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode14 != NIL
		::oWSListOrderDiscount := Service_ArrayOfOrderDiscountDTO():New()
		::oWSListOrderDiscount:SoapRecv(oNode14)
	EndIf
	::cMedia             :=  WSAdvValue( oResponse,"_MEDIA","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode16 :=  WSAdvValue( oResponse,"_ORDERDELIVERIES","ArrayOfOrderDeliveryDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode16 != NIL
		::oWSOrderDeliveries := Service_ArrayOfOrderDeliveryDTO():New()
		::oWSOrderDeliveries:SoapRecv(oNode16)
	EndIf
	oNode17 :=  WSAdvValue( oResponse,"_ORDERINVOICES","ArrayOfOrderInvoiceDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode17 != NIL
		::oWSOrderInvoices := Service_ArrayOfOrderInvoiceDTO():New()
		::oWSOrderInvoices:SoapRecv(oNode17)
	EndIf
	oNode18 :=  WSAdvValue( oResponse,"_ORDERPAYMENTS","ArrayOfOrderPaymentDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode18 != NIL
		::oWSOrderPayments := Service_ArrayOfOrderPaymentDTO():New()
		::oWSOrderPayments:SoapRecv(oNode18)
	EndIf
	::cPurchaseDate      :=  WSAdvValue( oResponse,"_PURCHASEDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode20 :=  WSAdvValue( oResponse,"_PURCHASEDATEUTC","DateTimeOffset",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode20 != NIL
		::oWSPurchaseDateUtc := Service_DateTimeOffset():New()
		::oWSPurchaseDateUtc:SoapRecv(oNode20)
	EndIf
	::cSource            :=  WSAdvValue( oResponse,"_SOURCE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nStoreId           :=  WSAdvValue( oResponse,"_STOREID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cStoreName         :=  WSAdvValue( oResponse,"_STORENAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nTax               :=  WSAdvValue( oResponse,"_TAX","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nTelemarketingId   :=  WSAdvValue( oResponse,"_TELEMARKETINGID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cTelemarketingLogin :=  WSAdvValue( oResponse,"_TELEMARKETINGLOGIN","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTelemarketingObservation :=  WSAdvValue( oResponse,"_TELEMARKETINGOBSERVATION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTelemarketingStoreLocatorCode :=  WSAdvValue( oResponse,"_TELEMARKETINGSTORELOCATORCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTelemarketingStoreLocatorName :=  WSAdvValue( oResponse,"_TELEMARKETINGSTORELOCATORNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::n_Cost             :=  WSAdvValue( oResponse,"__COST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::n_CostFinal        :=  WSAdvValue( oResponse,"__COSTFINAL","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfOrderDTO

WSSTRUCT Service_ArrayOfOrderDTO
	WSDATA   oWSOrderDTO               AS Service_OrderDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderDTO
	::oWSOrderDTO          := {} // Array Of  Service_ORDERDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderDTO
	Local oClone := Service_ArrayOfOrderDTO():NEW()
	oClone:oWSOrderDTO := NIL
	If ::oWSOrderDTO <> NIL 
		oClone:oWSOrderDTO := {}
		aEval( ::oWSOrderDTO , { |x| aadd( oClone:oWSOrderDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERDTO","OrderDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderDTO , Service_OrderDTO():New() )
			::oWSOrderDTO[len(::oWSOrderDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfOrderInteractionDTO

WSSTRUCT Service_ArrayOfOrderInteractionDTO
	WSDATA   oWSOrderInteractionDTO    AS Service_OrderInteractionDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderInteractionDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderInteractionDTO
	::oWSOrderInteractionDTO := {} // Array Of  Service_ORDERINTERACTIONDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderInteractionDTO
	Local oClone := Service_ArrayOfOrderInteractionDTO():NEW()
	oClone:oWSOrderInteractionDTO := NIL
	If ::oWSOrderInteractionDTO <> NIL 
		oClone:oWSOrderInteractionDTO := {}
		aEval( ::oWSOrderInteractionDTO , { |x| aadd( oClone:oWSOrderInteractionDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderInteractionDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERINTERACTIONDTO","OrderInteractionDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderInteractionDTO , Service_OrderInteractionDTO():New() )
			::oWSOrderInteractionDTO[len(::oWSOrderInteractionDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Enumeration IntegrationStatus

WSSTRUCT Service_IntegrationStatus
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_IntegrationStatus
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "Private" )
	aadd(::aValueList , "Available" )
	aadd(::aValueList , "Sent" )
	aadd(::aValueList , "PaymentDenied" )
	aadd(::aValueList , "Canceled" )
	aadd(::aValueList , "SentToCarrier" )
	aadd(::aValueList , "Delivered" )
	aadd(::aValueList , "UnsuccessfulDelivery" )
	aadd(::aValueList , "Undefined" )
	aadd(::aValueList , "" )
Return Self

WSMETHOD SOAPSEND WSCLIENT Service_IntegrationStatus
	Local cSoap := "" 
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_IntegrationStatus
	::Value := NIL
	If oResponse = NIL ; Return ; Endif 
	::Value :=  oResponse:TEXT
Return 

WSMETHOD CLONE WSCLIENT Service_IntegrationStatus
Local oClone := Service_IntegrationStatus():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure ArrayOfKeyValueOfstringstring

WSSTRUCT Service_ArrayOfKeyValueOfstringstring
	WSDATA   oWSKeyValueOfstringstring AS Service_KeyValueOfstringstring OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfKeyValueOfstringstring
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfKeyValueOfstringstring
	::oWSKeyValueOfstringstring := {} // Array Of  Service_KEYVALUEOFSTRINGSTRING():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfKeyValueOfstringstring
	Local oClone := Service_ArrayOfKeyValueOfstringstring():NEW()
	oClone:oWSKeyValueOfstringstring := NIL
	If ::oWSKeyValueOfstringstring <> NIL 
		oClone:oWSKeyValueOfstringstring := {}
		aEval( ::oWSKeyValueOfstringstring , { |x| aadd( oClone:oWSKeyValueOfstringstring , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfKeyValueOfstringstring
	Local cSoap := ""
	aEval( ::oWSKeyValueOfstringstring , {|x| cSoap := cSoap  +  WSSoapValue("KeyValueOfstringstring", x , x , "KeyValueOfstringstring", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfOrderItem

WSSTRUCT Service_ArrayOfOrderItem
	WSDATA   oWSOrderItem              AS Service_OrderItem OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderItem
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderItem
	::oWSOrderItem         := {} // Array Of  Service_ORDERITEM():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderItem
	Local oClone := Service_ArrayOfOrderItem():NEW()
	oClone:oWSOrderItem := NIL
	If ::oWSOrderItem <> NIL 
		oClone:oWSOrderItem := {}
		aEval( ::oWSOrderItem , { |x| aadd( oClone:oWSOrderItem , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderItem
	Local cSoap := ""
	aEval( ::oWSOrderItem , {|x| cSoap := cSoap  +  WSSoapValue("OrderItem", x , x , "OrderItem", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfOrderStatusDTO

WSSTRUCT Service_ArrayOfOrderStatusDTO
	WSDATA   oWSOrderStatusDTO         AS Service_OrderStatusDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderStatusDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderStatusDTO
	::oWSOrderStatusDTO    := {} // Array Of  Service_ORDERSTATUSDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderStatusDTO
	Local oClone := Service_ArrayOfOrderStatusDTO():NEW()
	oClone:oWSOrderStatusDTO := NIL
	If ::oWSOrderStatusDTO <> NIL 
		oClone:oWSOrderStatusDTO := {}
		aEval( ::oWSOrderStatusDTO , { |x| aadd( oClone:oWSOrderStatusDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderStatusDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERSTATUSDTO","OrderStatusDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderStatusDTO , Service_OrderStatusDTO():New() )
			::oWSOrderStatusDTO[len(::oWSOrderStatusDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfPaymentDTO

WSSTRUCT Service_ArrayOfPaymentDTO
	WSDATA   oWSPaymentDTO             AS Service_PaymentDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfPaymentDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfPaymentDTO
	::oWSPaymentDTO        := {} // Array Of  Service_PAYMENTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfPaymentDTO
	Local oClone := Service_ArrayOfPaymentDTO():NEW()
	oClone:oWSPaymentDTO := NIL
	If ::oWSPaymentDTO <> NIL 
		oClone:oWSPaymentDTO := {}
		aEval( ::oWSPaymentDTO , { |x| aadd( oClone:oWSPaymentDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfPaymentDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_PAYMENTDTO","PaymentDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSPaymentDTO , Service_PaymentDTO():New() )
			::oWSPaymentDTO[len(::oWSPaymentDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ClientDTO

WSSTRUCT Service_ClientDTO
	WSDATA   nAddressClientId          AS int OPTIONAL
	WSDATA   nAge                      AS int OPTIONAL
	WSDATA   cCelPhone                 AS string OPTIONAL
	WSDATA   cChangeDate               AS dateTime OPTIONAL
	WSDATA   cCompanyName              AS string OPTIONAL
	WSDATA   cCompanyNickName          AS string OPTIONAL
	WSDATA   cCpfCnpj                  AS string OPTIONAL
	WSDATA   cCreateDate               AS dateTime OPTIONAL
	WSDATA   cDateBirth                AS dateTime OPTIONAL
	WSDATA   cEmail                    AS string OPTIONAL
	WSDATA   cFirstName                AS string OPTIONAL
	WSDATA   cGender                   AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsCorporate              AS boolean OPTIONAL
	WSDATA   lIsFraud                  AS boolean OPTIONAL
	WSDATA   lIsNewsReceiver           AS boolean OPTIONAL
	WSDATA   lIsSMSNewsReceiver        AS boolean OPTIONAL
	WSDATA   lIsStateInscriptionImmune AS boolean OPTIONAL
	WSDATA   cLastLogonDate            AS dateTime OPTIONAL
	WSDATA   cLastName                 AS string OPTIONAL
	WSDATA   cNickName                 AS string OPTIONAL
	WSDATA   cOfficePhone              AS string OPTIONAL
	WSDATA   cPassword                 AS string OPTIONAL
	WSDATA   cPhone                    AS string OPTIONAL
	WSDATA   nRewardGiftCardId         AS int OPTIONAL
	WSDATA   cStateInscription         AS string OPTIONAL
	WSDATA   oWSUserGUID               AS Service_guid OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ClientDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ClientDTO
Return

WSMETHOD CLONE WSCLIENT Service_ClientDTO
	Local oClone := Service_ClientDTO():NEW()
	oClone:nAddressClientId     := ::nAddressClientId
	oClone:nAge                 := ::nAge
	oClone:cCelPhone            := ::cCelPhone
	oClone:cChangeDate          := ::cChangeDate
	oClone:cCompanyName         := ::cCompanyName
	oClone:cCompanyNickName     := ::cCompanyNickName
	oClone:cCpfCnpj             := ::cCpfCnpj
	oClone:cCreateDate          := ::cCreateDate
	oClone:cDateBirth           := ::cDateBirth
	oClone:cEmail               := ::cEmail
	oClone:cFirstName           := ::cFirstName
	oClone:cGender              := ::cGender
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:lIsCorporate         := ::lIsCorporate
	oClone:lIsFraud             := ::lIsFraud
	oClone:lIsNewsReceiver      := ::lIsNewsReceiver
	oClone:lIsSMSNewsReceiver   := ::lIsSMSNewsReceiver
	oClone:lIsStateInscriptionImmune := ::lIsStateInscriptionImmune
	oClone:cLastLogonDate       := ::cLastLogonDate
	oClone:cLastName            := ::cLastName
	oClone:cNickName            := ::cNickName
	oClone:cOfficePhone         := ::cOfficePhone
	oClone:cPassword            := ::cPassword
	oClone:cPhone               := ::cPhone
	oClone:nRewardGiftCardId    := ::nRewardGiftCardId
	oClone:cStateInscription    := ::cStateInscription
	oClone:oWSUserGUID          := IIF(::oWSUserGUID = NIL , NIL , ::oWSUserGUID:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ClientDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AddressClientId", ::nAddressClientId, ::nAddressClientId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Age", ::nAge, ::nAge , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CelPhone", ::cCelPhone, ::cCelPhone , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ChangeDate", ::cChangeDate, ::cChangeDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CompanyName", ::cCompanyName, ::cCompanyName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CompanyNickName", ::cCompanyNickName, ::cCompanyNickName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CpfCnpj", ::cCpfCnpj, ::cCpfCnpj , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CreateDate", ::cCreateDate, ::cCreateDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DateBirth", ::cDateBirth, ::cDateBirth , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Email", ::cEmail, ::cEmail , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FirstName", ::cFirstName, ::cFirstName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Gender", ::cGender, ::cGender , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsCorporate", ::lIsCorporate, ::lIsCorporate , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsFraud", ::lIsFraud, ::lIsFraud , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsNewsReceiver", ::lIsNewsReceiver, ::lIsNewsReceiver , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsSMSNewsReceiver", ::lIsSMSNewsReceiver, ::lIsSMSNewsReceiver , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsStateInscriptionImmune", ::lIsStateInscriptionImmune, ::lIsStateInscriptionImmune , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LastLogonDate", ::cLastLogonDate, ::cLastLogonDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LastName", ::cLastName, ::cLastName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NickName", ::cNickName, ::cNickName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OfficePhone", ::cOfficePhone, ::cOfficePhone , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Password", ::cPassword, ::cPassword , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Phone", ::cPhone, ::cPhone , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RewardGiftCardId", ::nRewardGiftCardId, ::nRewardGiftCardId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StateInscription", ::cStateInscription, ::cStateInscription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UserGUID", ::oWSUserGUID, ::oWSUserGUID , "guid", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ClientDTO
	Local oNode28
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nAddressClientId   :=  WSAdvValue( oResponse,"_ADDRESSCLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nAge               :=  WSAdvValue( oResponse,"_AGE","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cCelPhone          :=  WSAdvValue( oResponse,"_CELPHONE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cChangeDate        :=  WSAdvValue( oResponse,"_CHANGEDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCompanyName       :=  WSAdvValue( oResponse,"_COMPANYNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCompanyNickName   :=  WSAdvValue( oResponse,"_COMPANYNICKNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCpfCnpj           :=  WSAdvValue( oResponse,"_CPFCNPJ","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCreateDate        :=  WSAdvValue( oResponse,"_CREATEDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDateBirth         :=  WSAdvValue( oResponse,"_DATEBIRTH","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEmail             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cFirstName         :=  WSAdvValue( oResponse,"_FIRSTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cGender            :=  WSAdvValue( oResponse,"_GENDER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsCorporate       :=  WSAdvValue( oResponse,"_ISCORPORATE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsFraud           :=  WSAdvValue( oResponse,"_ISFRAUD","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsNewsReceiver    :=  WSAdvValue( oResponse,"_ISNEWSRECEIVER","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsSMSNewsReceiver :=  WSAdvValue( oResponse,"_ISSMSNEWSRECEIVER","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsStateInscriptionImmune :=  WSAdvValue( oResponse,"_ISSTATEINSCRIPTIONIMMUNE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cLastLogonDate     :=  WSAdvValue( oResponse,"_LASTLOGONDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cLastName          :=  WSAdvValue( oResponse,"_LASTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cNickName          :=  WSAdvValue( oResponse,"_NICKNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cOfficePhone       :=  WSAdvValue( oResponse,"_OFFICEPHONE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cPassword          :=  WSAdvValue( oResponse,"_PASSWORD","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cPhone             :=  WSAdvValue( oResponse,"_PHONE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nRewardGiftCardId  :=  WSAdvValue( oResponse,"_REWARDGIFTCARDID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cStateInscription  :=  WSAdvValue( oResponse,"_STATEINSCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode28 :=  WSAdvValue( oResponse,"_USERGUID","guid",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode28 != NIL
		::oWSUserGUID := Service_guid():New()
		::oWSUserGUID:SoapRecv(oNode28)
	EndIf
Return

// WSDL Data Structure ClientExtendedDTO

WSSTRUCT Service_ClientExtendedDTO
	WSDATA   oWSClient                 AS Service_ClientDTO OPTIONAL
	WSDATA   oWSClientFields           AS Service_ArrayOfClientFieldDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ClientExtendedDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ClientExtendedDTO
Return

WSMETHOD CLONE WSCLIENT Service_ClientExtendedDTO
	Local oClone := Service_ClientExtendedDTO():NEW()
	oClone:oWSClient            := IIF(::oWSClient = NIL , NIL , ::oWSClient:Clone() )
	oClone:oWSClientFields      := IIF(::oWSClientFields = NIL , NIL , ::oWSClientFields:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ClientExtendedDTO
	Local oNode1
	Local oNode2
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_CLIENT","ClientDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode1 != NIL
		::oWSClient := Service_ClientDTO():New()
		::oWSClient:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_CLIENTFIELDS","ArrayOfClientFieldDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode2 != NIL
		::oWSClientFields := Service_ArrayOfClientFieldDTO():New()
		::oWSClientFields:SoapRecv(oNode2)
	EndIf
Return

// WSDL Data Structure ArrayOfClientDTO

WSSTRUCT Service_ArrayOfClientDTO
	WSDATA   oWSClientDTO              AS Service_ClientDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfClientDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfClientDTO
	::oWSClientDTO         := {} // Array Of  Service_CLIENTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfClientDTO
	Local oClone := Service_ArrayOfClientDTO():NEW()
	oClone:oWSClientDTO := NIL
	If ::oWSClientDTO <> NIL 
		oClone:oWSClientDTO := {}
		aEval( ::oWSClientDTO , { |x| aadd( oClone:oWSClientDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfClientDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_CLIENTDTO","ClientDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSClientDTO , Service_ClientDTO():New() )
			::oWSClientDTO[len(::oWSClientDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Enumeration TransactionAction

WSSTRUCT Service_TransactionAction
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_TransactionAction
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "Credit" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "Debit" )
	aadd(::aValueList , "" )
Return Self

WSMETHOD SOAPSEND WSCLIENT Service_TransactionAction
	Local cSoap := "" 
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_TransactionAction
	::Value := NIL
	If oResponse = NIL ; Return ; Endif 
	::Value :=  oResponse:TEXT
Return 

WSMETHOD CLONE WSCLIENT Service_TransactionAction
Local oClone := Service_TransactionAction():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure AddressDTO

WSSTRUCT Service_AddressDTO
	WSDATA   oWSAddressGUID            AS Service_guid OPTIONAL
	WSDATA   cAddressNameV3            AS string OPTIONAL
	WSDATA   cAddressType              AS string OPTIONAL
	WSDATA   cCity                     AS string OPTIONAL
	WSDATA   cCountry                  AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   cMore                     AS string OPTIONAL
	WSDATA   cNeighborhood             AS string OPTIONAL
	WSDATA   nNumber                   AS int OPTIONAL
	WSDATA   cRecipientName            AS string OPTIONAL
	WSDATA   cReferencePoint           AS string OPTIONAL
	WSDATA   cState                    AS string OPTIONAL
	WSDATA   cStreet                   AS string OPTIONAL
	WSDATA   oWSUserGUID               AS Service_guid OPTIONAL
	WSDATA   cZipCode                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_AddressDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_AddressDTO
Return

WSMETHOD CLONE WSCLIENT Service_AddressDTO
	Local oClone := Service_AddressDTO():NEW()
	oClone:oWSAddressGUID       := IIF(::oWSAddressGUID = NIL , NIL , ::oWSAddressGUID:Clone() )
	oClone:cAddressNameV3       := ::cAddressNameV3
	oClone:cAddressType         := ::cAddressType
	oClone:cCity                := ::cCity
	oClone:cCountry             := ::cCountry
	oClone:nId                  := ::nId
	oClone:cMore                := ::cMore
	oClone:cNeighborhood        := ::cNeighborhood
	oClone:nNumber              := ::nNumber
	oClone:cRecipientName       := ::cRecipientName
	oClone:cReferencePoint      := ::cReferencePoint
	oClone:cState               := ::cState
	oClone:cStreet              := ::cStreet
	oClone:oWSUserGUID          := IIF(::oWSUserGUID = NIL , NIL , ::oWSUserGUID:Clone() )
	oClone:cZipCode             := ::cZipCode
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_AddressDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AddressGUID", ::oWSAddressGUID, ::oWSAddressGUID , "guid", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("AddressNameV3", ::cAddressNameV3, ::cAddressNameV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("AddressType", ::cAddressType, ::cAddressType , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("City", ::cCity, ::cCity , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Country", ::cCountry, ::cCountry , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("More", ::cMore, ::cMore , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Neighborhood", ::cNeighborhood, ::cNeighborhood , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Number", ::nNumber, ::nNumber , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RecipientName", ::cRecipientName, ::cRecipientName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ReferencePoint", ::cReferencePoint, ::cReferencePoint , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("State", ::cState, ::cState , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Street", ::cStreet, ::cStreet , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UserGUID", ::oWSUserGUID, ::oWSUserGUID , "guid", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ZipCode", ::cZipCode, ::cZipCode , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_AddressDTO
	Local oNode1
	Local oNode14
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_ADDRESSGUID","guid",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode1 != NIL
		::oWSAddressGUID := Service_guid():New()
		::oWSAddressGUID:SoapRecv(oNode1)
	EndIf
	::cAddressNameV3     :=  WSAdvValue( oResponse,"_ADDRESSNAMEV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cAddressType       :=  WSAdvValue( oResponse,"_ADDRESSTYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCountry           :=  WSAdvValue( oResponse,"_COUNTRY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cMore              :=  WSAdvValue( oResponse,"_MORE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cNeighborhood      :=  WSAdvValue( oResponse,"_NEIGHBORHOOD","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nNumber            :=  WSAdvValue( oResponse,"_NUMBER","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cRecipientName     :=  WSAdvValue( oResponse,"_RECIPIENTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cReferencePoint    :=  WSAdvValue( oResponse,"_REFERENCEPOINT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cState             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode14 :=  WSAdvValue( oResponse,"_USERGUID","guid",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode14 != NIL
		::oWSUserGUID := Service_guid():New()
		::oWSUserGUID:SoapRecv(oNode14)
	EndIf
	::cZipCode           :=  WSAdvValue( oResponse,"_ZIPCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure FreightValueDTO

WSSTRUCT Service_FreightValueDTO
	WSDATA   nAbsoluteMoneyCost        AS decimal OPTIONAL
	WSDATA   cActiveEndDate            AS dateTime OPTIONAL
	WSDATA   cActiveStartDate          AS dateTime OPTIONAL
	WSDATA   nCubedWeight              AS decimal OPTIONAL
	WSDATA   nFreightId                AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nMaxVolume                AS decimal OPTIONAL
	WSDATA   nPricePercent             AS decimal OPTIONAL
	WSDATA   nPricePercentByWeight     AS decimal OPTIONAL
	WSDATA   nTimeCost                 AS int OPTIONAL
	WSDATA   nWeightEnd                AS decimal OPTIONAL
	WSDATA   nWeightStart              AS decimal OPTIONAL
	WSDATA   nZipCodeEnd               AS int OPTIONAL
	WSDATA   nZipCodeStart             AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FreightValueDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FreightValueDTO
Return

WSMETHOD CLONE WSCLIENT Service_FreightValueDTO
	Local oClone := Service_FreightValueDTO():NEW()
	oClone:nAbsoluteMoneyCost   := ::nAbsoluteMoneyCost
	oClone:cActiveEndDate       := ::cActiveEndDate
	oClone:cActiveStartDate     := ::cActiveStartDate
	oClone:nCubedWeight         := ::nCubedWeight
	oClone:nFreightId           := ::nFreightId
	oClone:nId                  := ::nId
	oClone:nMaxVolume           := ::nMaxVolume
	oClone:nPricePercent        := ::nPricePercent
	oClone:nPricePercentByWeight := ::nPricePercentByWeight
	oClone:nTimeCost            := ::nTimeCost
	oClone:nWeightEnd           := ::nWeightEnd
	oClone:nWeightStart         := ::nWeightStart
	oClone:nZipCodeEnd          := ::nZipCodeEnd
	oClone:nZipCodeStart        := ::nZipCodeStart
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_FreightValueDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AbsoluteMoneyCost", ::nAbsoluteMoneyCost, ::nAbsoluteMoneyCost , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ActiveEndDate", ::cActiveEndDate, ::cActiveEndDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ActiveStartDate", ::cActiveStartDate, ::cActiveStartDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CubedWeight", ::nCubedWeight, ::nCubedWeight , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightId", ::nFreightId, ::nFreightId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MaxVolume", ::nMaxVolume, ::nMaxVolume , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PricePercent", ::nPricePercent, ::nPricePercent , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PricePercentByWeight", ::nPricePercentByWeight, ::nPricePercentByWeight , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TimeCost", ::nTimeCost, ::nTimeCost , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("WeightEnd", ::nWeightEnd, ::nWeightEnd , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("WeightStart", ::nWeightStart, ::nWeightStart , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ZipCodeEnd", ::nZipCodeEnd, ::nZipCodeEnd , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ZipCodeStart", ::nZipCodeStart, ::nZipCodeStart , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_FreightValueDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nAbsoluteMoneyCost :=  WSAdvValue( oResponse,"_ABSOLUTEMONEYCOST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cActiveEndDate     :=  WSAdvValue( oResponse,"_ACTIVEENDDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cActiveStartDate   :=  WSAdvValue( oResponse,"_ACTIVESTARTDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nCubedWeight       :=  WSAdvValue( oResponse,"_CUBEDWEIGHT","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nFreightId         :=  WSAdvValue( oResponse,"_FREIGHTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nMaxVolume         :=  WSAdvValue( oResponse,"_MAXVOLUME","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nPricePercent      :=  WSAdvValue( oResponse,"_PRICEPERCENT","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nPricePercentByWeight :=  WSAdvValue( oResponse,"_PRICEPERCENTBYWEIGHT","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nTimeCost          :=  WSAdvValue( oResponse,"_TIMECOST","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nWeightEnd         :=  WSAdvValue( oResponse,"_WEIGHTEND","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nWeightStart       :=  WSAdvValue( oResponse,"_WEIGHTSTART","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nZipCodeEnd        :=  WSAdvValue( oResponse,"_ZIPCODEEND","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nZipCodeStart      :=  WSAdvValue( oResponse,"_ZIPCODESTART","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfFreightStockKeepingUnitContextDTO

WSSTRUCT Service_ArrayOfFreightStockKeepingUnitContextDTO
	WSDATA   oWSFreightStockKeepingUnitContextDTO AS Service_FreightStockKeepingUnitContextDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfFreightStockKeepingUnitContextDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfFreightStockKeepingUnitContextDTO
	::oWSFreightStockKeepingUnitContextDTO := {} // Array Of  Service_FREIGHTSTOCKKEEPINGUNITCONTEXTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfFreightStockKeepingUnitContextDTO
	Local oClone := Service_ArrayOfFreightStockKeepingUnitContextDTO():NEW()
	oClone:oWSFreightStockKeepingUnitContextDTO := NIL
	If ::oWSFreightStockKeepingUnitContextDTO <> NIL 
		oClone:oWSFreightStockKeepingUnitContextDTO := {}
		aEval( ::oWSFreightStockKeepingUnitContextDTO , { |x| aadd( oClone:oWSFreightStockKeepingUnitContextDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfFreightStockKeepingUnitContextDTO
	Local cSoap := ""
	aEval( ::oWSFreightStockKeepingUnitContextDTO , {|x| cSoap := cSoap  +  WSSoapValue("FreightStockKeepingUnitContextDTO", x , x , "FreightStockKeepingUnitContextDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfFreightStockKeepingUnitDTO

WSSTRUCT Service_ArrayOfFreightStockKeepingUnitDTO
	WSDATA   oWSFreightStockKeepingUnitDTO AS Service_FreightStockKeepingUnitDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfFreightStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfFreightStockKeepingUnitDTO
	::oWSFreightStockKeepingUnitDTO := {} // Array Of  Service_FREIGHTSTOCKKEEPINGUNITDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfFreightStockKeepingUnitDTO
	Local oClone := Service_ArrayOfFreightStockKeepingUnitDTO():NEW()
	oClone:oWSFreightStockKeepingUnitDTO := NIL
	If ::oWSFreightStockKeepingUnitDTO <> NIL 
		oClone:oWSFreightStockKeepingUnitDTO := {}
		aEval( ::oWSFreightStockKeepingUnitDTO , { |x| aadd( oClone:oWSFreightStockKeepingUnitDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfFreightStockKeepingUnitDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FREIGHTSTOCKKEEPINGUNITDTO","FreightStockKeepingUnitDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSFreightStockKeepingUnitDTO , Service_FreightStockKeepingUnitDTO():New() )
			::oWSFreightStockKeepingUnitDTO[len(::oWSFreightStockKeepingUnitDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ZipCodeDTO

WSSTRUCT Service_ZipCodeDTO
	WSDATA   cCity                     AS string OPTIONAL
	WSDATA   cNeighborhood             AS string OPTIONAL
	WSDATA   cState                    AS string OPTIONAL
	WSDATA   cStateFullName            AS string OPTIONAL
	WSDATA   cStreet                   AS string OPTIONAL
	WSDATA   cValue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ZipCodeDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ZipCodeDTO
Return

WSMETHOD CLONE WSCLIENT Service_ZipCodeDTO
	Local oClone := Service_ZipCodeDTO():NEW()
	oClone:cCity                := ::cCity
	oClone:cNeighborhood        := ::cNeighborhood
	oClone:cState               := ::cState
	oClone:cStateFullName       := ::cStateFullName
	oClone:cStreet              := ::cStreet
	oClone:cValue               := ::cValue
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ZipCodeDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cNeighborhood      :=  WSAdvValue( oResponse,"_NEIGHBORHOOD","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cState             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStateFullName     :=  WSAdvValue( oResponse,"_STATEFULLNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cValue             :=  WSAdvValue( oResponse,"_VALUE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure FreightDTO

WSSTRUCT Service_FreightDTO
	WSDATA   nDistributionCenterID     AS int OPTIONAL
	WSDATA   nFreightID                AS int OPTIONAL
	WSDATA   nFreightTypeID            AS int OPTIONAL
	WSDATA   nModalID                  AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FreightDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FreightDTO
Return

WSMETHOD CLONE WSCLIENT Service_FreightDTO
	Local oClone := Service_FreightDTO():NEW()
	oClone:nDistributionCenterID := ::nDistributionCenterID
	oClone:nFreightID           := ::nFreightID
	oClone:nFreightTypeID       := ::nFreightTypeID
	oClone:nModalID             := ::nModalID
	oClone:cName                := ::cName
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_FreightDTO
	Local cSoap := ""
	cSoap += WSSoapValue("DistributionCenterID", ::nDistributionCenterID, ::nDistributionCenterID , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightID", ::nFreightID, ::nFreightID , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightTypeID", ::nFreightTypeID, ::nFreightTypeID , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ModalID", ::nModalID, ::nModalID , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_FreightDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nDistributionCenterID :=  WSAdvValue( oResponse,"_DISTRIBUTIONCENTERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nFreightID         :=  WSAdvValue( oResponse,"_FREIGHTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nFreightTypeID     :=  WSAdvValue( oResponse,"_FREIGHTTYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nModalID           :=  WSAdvValue( oResponse,"_MODALID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfFreightDTO

WSSTRUCT Service_ArrayOfFreightDTO
	WSDATA   oWSFreightDTO             AS Service_FreightDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfFreightDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfFreightDTO
	::oWSFreightDTO        := {} // Array Of  Service_FREIGHTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfFreightDTO
	Local oClone := Service_ArrayOfFreightDTO():NEW()
	oClone:oWSFreightDTO := NIL
	If ::oWSFreightDTO <> NIL 
		oClone:oWSFreightDTO := {}
		aEval( ::oWSFreightDTO , { |x| aadd( oClone:oWSFreightDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfFreightDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FREIGHTDTO","FreightDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSFreightDTO , Service_FreightDTO():New() )
			::oWSFreightDTO[len(::oWSFreightDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfFreightValueDTO

WSSTRUCT Service_ArrayOfFreightValueDTO
	WSDATA   oWSFreightValueDTO        AS Service_FreightValueDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfFreightValueDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfFreightValueDTO
	::oWSFreightValueDTO   := {} // Array Of  Service_FREIGHTVALUEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfFreightValueDTO
	Local oClone := Service_ArrayOfFreightValueDTO():NEW()
	oClone:oWSFreightValueDTO := NIL
	If ::oWSFreightValueDTO <> NIL 
		oClone:oWSFreightValueDTO := {}
		aEval( ::oWSFreightValueDTO , { |x| aadd( oClone:oWSFreightValueDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfFreightValueDTO
	Local cSoap := ""
	aEval( ::oWSFreightValueDTO , {|x| cSoap := cSoap  +  WSSoapValue("FreightValueDTO", x , x , "FreightValueDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

// WSDL Data Structure ArrayOfAddressDTO

WSSTRUCT Service_ArrayOfAddressDTO
	WSDATA   oWSAddressDTO             AS Service_AddressDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfAddressDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfAddressDTO
	::oWSAddressDTO        := {} // Array Of  Service_ADDRESSDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfAddressDTO
	Local oClone := Service_ArrayOfAddressDTO():NEW()
	oClone:oWSAddressDTO := NIL
	If ::oWSAddressDTO <> NIL 
		oClone:oWSAddressDTO := {}
		aEval( ::oWSAddressDTO , { |x| aadd( oClone:oWSAddressDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfAddressDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ADDRESSDTO","AddressDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSAddressDTO , Service_AddressDTO():New() )
			::oWSAddressDTO[len(::oWSAddressDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfAddressDTO2

WSSTRUCT Service_ArrayOfAddressDTO2
	WSDATA   oWSAddressDTO2            AS Service_AddressDTO2 OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfAddressDTO2
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfAddressDTO2
	::oWSAddressDTO2       := {} // Array Of  Service_ADDRESSDTO2():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfAddressDTO2
	Local oClone := Service_ArrayOfAddressDTO2():NEW()
	oClone:oWSAddressDTO2 := NIL
	If ::oWSAddressDTO2 <> NIL 
		oClone:oWSAddressDTO2 := {}
		aEval( ::oWSAddressDTO2 , { |x| aadd( oClone:oWSAddressDTO2 , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfAddressDTO2
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ADDRESSDTO2","AddressDTO2",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSAddressDTO2 , Service_AddressDTO2():New() )
			::oWSAddressDTO2[len(::oWSAddressDTO2)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure BuyTogetherDTO

WSSTRUCT Service_BuyTogetherDTO
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   nDiscountFirstList        AS decimal OPTIONAL
	WSDATA   nDiscountSecondList       AS decimal OPTIONAL
	WSDATA   cEndDate                  AS dateTime OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   nMinimumAmountSku         AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cStartDate                AS dateTime OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_BuyTogetherDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_BuyTogetherDTO
Return

WSMETHOD CLONE WSCLIENT Service_BuyTogetherDTO
	Local oClone := Service_BuyTogetherDTO():NEW()
	oClone:cDescription         := ::cDescription
	oClone:nDiscountFirstList   := ::nDiscountFirstList
	oClone:nDiscountSecondList  := ::nDiscountSecondList
	oClone:cEndDate             := ::cEndDate
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:nMinimumAmountSku    := ::nMinimumAmountSku
	oClone:cName                := ::cName
	oClone:cStartDate           := ::cStartDate
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_BuyTogetherDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DiscountFirstList", ::nDiscountFirstList, ::nDiscountFirstList , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DiscountSecondList", ::nDiscountSecondList, ::nDiscountSecondList , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EndDate", ::cEndDate, ::cEndDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MinimumAmountSku", ::nMinimumAmountSku, ::nMinimumAmountSku , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StartDate", ::cStartDate, ::cStartDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_BuyTogetherDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nDiscountFirstList :=  WSAdvValue( oResponse,"_DISCOUNTFIRSTLIST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDiscountSecondList :=  WSAdvValue( oResponse,"_DISCOUNTSECONDLIST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cEndDate           :=  WSAdvValue( oResponse,"_ENDDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nMinimumAmountSku  :=  WSAdvValue( oResponse,"_MINIMUMAMOUNTSKU","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStartDate         :=  WSAdvValue( oResponse,"_STARTDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure BuyTogetherBuyGainDTO

WSSTRUCT Service_BuyTogetherBuyGainDTO
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   cEndDate                  AS dateTime OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nIdCollection             AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsBenefitFreeShipping    AS boolean OPTIONAL
	WSDATA   nMinimumAmountSkuBenefit  AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cStartDate                AS dateTime OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_BuyTogetherBuyGainDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_BuyTogetherBuyGainDTO
Return

WSMETHOD CLONE WSCLIENT Service_BuyTogetherBuyGainDTO
	Local oClone := Service_BuyTogetherBuyGainDTO():NEW()
	oClone:cDescription         := ::cDescription
	oClone:cEndDate             := ::cEndDate
	oClone:nId                  := ::nId
	oClone:nIdCollection        := ::nIdCollection
	oClone:lIsActive            := ::lIsActive
	oClone:lIsBenefitFreeShipping := ::lIsBenefitFreeShipping
	oClone:nMinimumAmountSkuBenefit := ::nMinimumAmountSkuBenefit
	oClone:cName                := ::cName
	oClone:cStartDate           := ::cStartDate
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_BuyTogetherBuyGainDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EndDate", ::cEndDate, ::cEndDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IdCollection", ::nIdCollection, ::nIdCollection , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsBenefitFreeShipping", ::lIsBenefitFreeShipping, ::lIsBenefitFreeShipping , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MinimumAmountSkuBenefit", ::nMinimumAmountSkuBenefit, ::nMinimumAmountSkuBenefit , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StartDate", ::cStartDate, ::cStartDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_BuyTogetherBuyGainDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEndDate           :=  WSAdvValue( oResponse,"_ENDDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nIdCollection      :=  WSAdvValue( oResponse,"_IDCOLLECTION","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsBenefitFreeShipping :=  WSAdvValue( oResponse,"_ISBENEFITFREESHIPPING","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nMinimumAmountSkuBenefit :=  WSAdvValue( oResponse,"_MINIMUMAMOUNTSKUBENEFIT","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStartDate         :=  WSAdvValue( oResponse,"_STARTDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure BuyTogetherTakeXPayYDTO

WSSTRUCT Service_BuyTogetherTakeXPayYDTO
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   cEndDate                  AS dateTime OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nIdCollection             AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   nMinimumAmountSkuCondition AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cStartDate                AS dateTime OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_BuyTogetherTakeXPayYDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_BuyTogetherTakeXPayYDTO
Return

WSMETHOD CLONE WSCLIENT Service_BuyTogetherTakeXPayYDTO
	Local oClone := Service_BuyTogetherTakeXPayYDTO():NEW()
	oClone:cDescription         := ::cDescription
	oClone:cEndDate             := ::cEndDate
	oClone:nId                  := ::nId
	oClone:nIdCollection        := ::nIdCollection
	oClone:lIsActive            := ::lIsActive
	oClone:nMinimumAmountSkuCondition := ::nMinimumAmountSkuCondition
	oClone:cName                := ::cName
	oClone:cStartDate           := ::cStartDate
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_BuyTogetherTakeXPayYDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EndDate", ::cEndDate, ::cEndDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IdCollection", ::nIdCollection, ::nIdCollection , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MinimumAmountSkuCondition", ::nMinimumAmountSkuCondition, ::nMinimumAmountSkuCondition , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StartDate", ::cStartDate, ::cStartDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_BuyTogetherTakeXPayYDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEndDate           :=  WSAdvValue( oResponse,"_ENDDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nIdCollection      :=  WSAdvValue( oResponse,"_IDCOLLECTION","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nMinimumAmountSkuCondition :=  WSAdvValue( oResponse,"_MINIMUMAMOUNTSKUCONDITION","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStartDate         :=  WSAdvValue( oResponse,"_STARTDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfServicePriceDTO

WSSTRUCT Service_ArrayOfServicePriceDTO
	WSDATA   oWSVtexPriceDTO        AS Service_ServicePriceDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfServicePriceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfServicePriceDTO
	::oWSVtexPriceDTO   := {} // Array Of  Service_SERVICEPRICEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfServicePriceDTO
	Local oClone := Service_ArrayOfServicePriceDTO():NEW()
	oClone:oWSVtexPriceDTO := NIL
	If ::oWSVtexPriceDTO <> NIL 
		oClone:oWSVtexPriceDTO := {}
		aEval( ::oWSVtexPriceDTO , { |x| aadd( oClone:oWSVtexPriceDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfServicePriceDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_SERVICEPRICEDTO","ServicePriceDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSVtexPriceDTO , Service_ServicePriceDTO():New() )
			::oWSVtexPriceDTO[len(::oWSVtexPriceDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfStockKeepingUnitServiceDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitServiceDTO
	WSDATA   oWSStockKeepingUnitServiceDTO AS Service_StockKeepingUnitServiceDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitServiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitServiceDTO
	::oWSStockKeepingUnitServiceDTO := {} // Array Of  Service_STOCKKEEPINGUNITSERVICEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitServiceDTO
	Local oClone := Service_ArrayOfStockKeepingUnitServiceDTO():NEW()
	oClone:oWSStockKeepingUnitServiceDTO := NIL
	If ::oWSStockKeepingUnitServiceDTO <> NIL 
		oClone:oWSStockKeepingUnitServiceDTO := {}
		aEval( ::oWSStockKeepingUnitServiceDTO , { |x| aadd( oClone:oWSStockKeepingUnitServiceDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfStockKeepingUnitServiceDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITSERVICEDTO","StockKeepingUnitServiceDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSStockKeepingUnitServiceDTO , Service_StockKeepingUnitServiceDTO():New() )
			::oWSStockKeepingUnitServiceDTO[len(::oWSStockKeepingUnitServiceDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure BrandDTO

WSSTRUCT Service_BrandDTO
	WSDATA   cAdWordsRemarketingCode   AS string OPTIONAL
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   cKeywords                 AS string OPTIONAL
	WSDATA   cLomadeeCampaignCode      AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cTitle                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_BrandDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_BrandDTO
Return

WSMETHOD CLONE WSCLIENT Service_BrandDTO
	Local oClone := Service_BrandDTO():NEW()
	oClone:cAdWordsRemarketingCode := ::cAdWordsRemarketingCode
	oClone:cDescription         := ::cDescription
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:cKeywords            := ::cKeywords
	oClone:cLomadeeCampaignCode := ::cLomadeeCampaignCode
	oClone:cName                := ::cName
	oClone:cTitle               := ::cTitle
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_BrandDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AdWordsRemarketingCode", ::cAdWordsRemarketingCode, ::cAdWordsRemarketingCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Keywords", ::cKeywords, ::cKeywords , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LomadeeCampaignCode", ::cLomadeeCampaignCode, ::cLomadeeCampaignCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Title", ::cTitle, ::cTitle , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_BrandDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAdWordsRemarketingCode :=  WSAdvValue( oResponse,"_ADWORDSREMARKETINGCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cKeywords          :=  WSAdvValue( oResponse,"_KEYWORDS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cLomadeeCampaignCode :=  WSAdvValue( oResponse,"_LOMADEECAMPAIGNCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure CategoryDTO

WSSTRUCT Service_CategoryDTO
	WSDATA   cAdWordsRemarketingCode   AS string OPTIONAL
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   nFatherCategoryId         AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   cKeywords                 AS string OPTIONAL
	WSDATA   cLomadeeCampaignCode      AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cTitle                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_CategoryDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_CategoryDTO
Return

WSMETHOD CLONE WSCLIENT Service_CategoryDTO
	Local oClone := Service_CategoryDTO():NEW()
	oClone:cAdWordsRemarketingCode := ::cAdWordsRemarketingCode
	oClone:cDescription         := ::cDescription
	oClone:nFatherCategoryId    := ::nFatherCategoryId
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:cKeywords            := ::cKeywords
	oClone:cLomadeeCampaignCode := ::cLomadeeCampaignCode
	oClone:cName                := ::cName
	oClone:cTitle               := ::cTitle
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_CategoryDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AdWordsRemarketingCode", ::cAdWordsRemarketingCode, ::cAdWordsRemarketingCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FatherCategoryId", ::nFatherCategoryId, ::nFatherCategoryId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Keywords", ::cKeywords, ::cKeywords , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LomadeeCampaignCode", ::cLomadeeCampaignCode, ::cLomadeeCampaignCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Title", ::cTitle, ::cTitle , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_CategoryDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAdWordsRemarketingCode :=  WSAdvValue( oResponse,"_ADWORDSREMARKETINGCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFatherCategoryId  :=  WSAdvValue( oResponse,"_FATHERCATEGORYID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cKeywords          :=  WSAdvValue( oResponse,"_KEYWORDS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cLomadeeCampaignCode :=  WSAdvValue( oResponse,"_LOMADEECAMPAIGNCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfImageDTO

WSSTRUCT Service_ArrayOfImageDTO
	WSDATA   oWSImageDTO               AS Service_ImageDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfImageDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfImageDTO
	::oWSImageDTO          := {} // Array Of  Service_IMAGEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfImageDTO
	Local oClone := Service_ArrayOfImageDTO():NEW()
	oClone:oWSImageDTO := NIL
	If ::oWSImageDTO <> NIL 
		oClone:oWSImageDTO := {}
		aEval( ::oWSImageDTO , { |x| aadd( oClone:oWSImageDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfImageDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_IMAGEDTO","ImageDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSImageDTO , Service_ImageDTO():New() )
			::oWSImageDTO[len(::oWSImageDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure FieldDTO

WSSTRUCT Service_FieldDTO
	WSDATA   nCategoryId               AS int OPTIONAL
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   nFieldId                  AS int OPTIONAL
	WSDATA   nFieldTypeId              AS int OPTIONAL
	WSDATA   cFieldTypeName            AS string OPTIONAL
	WSDATA   nFieldValueId             AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsRequired               AS boolean OPTIONAL
	WSDATA   lIsStockKeepingUnit       AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FieldDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FieldDTO
Return

WSMETHOD CLONE WSCLIENT Service_FieldDTO
	Local oClone := Service_FieldDTO():NEW()
	oClone:nCategoryId          := ::nCategoryId
	oClone:cDescription         := ::cDescription
	oClone:nFieldId             := ::nFieldId
	oClone:nFieldTypeId         := ::nFieldTypeId
	oClone:cFieldTypeName       := ::cFieldTypeName
	oClone:nFieldValueId        := ::nFieldValueId
	oClone:lIsActive            := ::lIsActive
	oClone:lIsRequired          := ::lIsRequired
	oClone:lIsStockKeepingUnit  := ::lIsStockKeepingUnit
	oClone:cName                := ::cName
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_FieldDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nCategoryId        :=  WSAdvValue( oResponse,"_CATEGORYID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFieldId           :=  WSAdvValue( oResponse,"_FIELDID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nFieldTypeId       :=  WSAdvValue( oResponse,"_FIELDTYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cFieldTypeName     :=  WSAdvValue( oResponse,"_FIELDTYPENAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFieldValueId      :=  WSAdvValue( oResponse,"_FIELDVALUEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsRequired        :=  WSAdvValue( oResponse,"_ISREQUIRED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsStockKeepingUnit :=  WSAdvValue( oResponse,"_ISSTOCKKEEPINGUNIT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Enumeration StockKeepingUnitComplementDTO.ComplementTypeEnum

WSSTRUCT Service_StockKeepingUnitComplementDTO_ComplementTypeEnum
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitComplementDTO_ComplementTypeEnum
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "Accessory" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "Sugestion" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "Similarly" )
	aadd(::aValueList , "" )
Return Self

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitComplementDTO_ComplementTypeEnum
	Local cSoap := "" 
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_StockKeepingUnitComplementDTO_ComplementTypeEnum
	::Value := NIL
	If oResponse = NIL ; Return ; Endif 
	::Value :=  oResponse:TEXT
Return 

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitComplementDTO_ComplementTypeEnum
Local oClone := Service_StockKeepingUnitComplementDTO_ComplementTypeEnum():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure ProductFieldNameDTO

WSSTRUCT Service_ProductFieldNameDTO
	WSDATA   cfieldName                AS string OPTIONAL
	WSDATA   oWSfieldValues            AS Service_ArrayOfstring OPTIONAL
	WSDATA   nproductid                AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ProductFieldNameDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ProductFieldNameDTO
Return

WSMETHOD CLONE WSCLIENT Service_ProductFieldNameDTO
	Local oClone := Service_ProductFieldNameDTO():NEW()
	oClone:cfieldName           := ::cfieldName
	oClone:oWSfieldValues       := IIF(::oWSfieldValues = NIL , NIL , ::oWSfieldValues:Clone() )
	oClone:nproductid           := ::nproductid
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ProductFieldNameDTO
	Local cSoap := ""
	cSoap += WSSoapValue("fieldName", ::cfieldName, ::cfieldName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, ::oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("productid", ::nproductid, ::nproductid , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ProductFieldIdDTO

WSSTRUCT Service_ProductFieldIdDTO
	WSDATA   nfieldId                  AS int OPTIONAL
	WSDATA   oWSfieldValues            AS Service_ArrayOfstring OPTIONAL
	WSDATA   nproductid                AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ProductFieldIdDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ProductFieldIdDTO
Return

WSMETHOD CLONE WSCLIENT Service_ProductFieldIdDTO
	Local oClone := Service_ProductFieldIdDTO():NEW()
	oClone:nfieldId             := ::nfieldId
	oClone:oWSfieldValues       := IIF(::oWSfieldValues = NIL , NIL , ::oWSfieldValues:Clone() )
	oClone:nproductid           := ::nproductid
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ProductFieldIdDTO
	Local cSoap := ""
	cSoap += WSSoapValue("fieldId", ::nfieldId, ::nfieldId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, ::oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("productid", ::nproductid, ::nproductid , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure StockKeepingUnitFieldNameDTO

WSSTRUCT Service_StockKeepingUnitFieldNameDTO
	WSDATA   cfieldName                AS string OPTIONAL
	WSDATA   oWSfieldValues            AS Service_ArrayOfstring OPTIONAL
	WSDATA   nidSku                    AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitFieldNameDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitFieldNameDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitFieldNameDTO
	Local oClone := Service_StockKeepingUnitFieldNameDTO():NEW()
	oClone:cfieldName           := ::cfieldName
	oClone:oWSfieldValues       := IIF(::oWSfieldValues = NIL , NIL , ::oWSfieldValues:Clone() )
	oClone:nidSku               := ::nidSku
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitFieldNameDTO
	Local cSoap := ""
	cSoap += WSSoapValue("fieldName", ::cfieldName, ::cfieldName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, ::oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("idSku", ::nidSku, ::nidSku , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure StockKeepingUnitFieldIdDTO

WSSTRUCT Service_StockKeepingUnitFieldIdDTO
	WSDATA   nfieldId                  AS int OPTIONAL
	WSDATA   oWSfieldValues            AS Service_ArrayOfstring OPTIONAL
	WSDATA   nidSku                    AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitFieldIdDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitFieldIdDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitFieldIdDTO
	Local oClone := Service_StockKeepingUnitFieldIdDTO():NEW()
	oClone:nfieldId             := ::nfieldId
	oClone:oWSfieldValues       := IIF(::oWSfieldValues = NIL , NIL , ::oWSfieldValues:Clone() )
	oClone:nidSku               := ::nidSku
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitFieldIdDTO
	Local cSoap := ""
	cSoap += WSSoapValue("fieldId", ::nfieldId, ::nfieldId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("fieldValues", ::oWSfieldValues, ::oWSfieldValues , "ArrayOfstring", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("idSku", ::nidSku, ::nidSku , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure GiftListMemberDTO

WSSTRUCT Service_GiftListMemberDTO
	WSDATA   nGiftListMemberId         AS int OPTIONAL
	WSDATA   nGiftListId               AS int OPTIONAL
	WSDATA   nClientId                 AS int OPTIONAL
	WSDATA   cTitle                    AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cSurname                  AS string OPTIONAL
	WSDATA   cMail                     AS string OPTIONAL
	WSDATA   cText1                    AS string OPTIONAL
	WSDATA   cText2                    AS string OPTIONAL
	WSDATA   lIsAdmin                  AS boolean OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   cProfileSystemUserId      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_GiftListMemberDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_GiftListMemberDTO
Return

WSMETHOD CLONE WSCLIENT Service_GiftListMemberDTO
	Local oClone := Service_GiftListMemberDTO():NEW()
	oClone:nGiftListMemberId    := ::nGiftListMemberId
	oClone:nGiftListId          := ::nGiftListId
	oClone:nClientId            := ::nClientId
	oClone:cTitle               := ::cTitle
	oClone:cName                := ::cName
	oClone:cSurname             := ::cSurname
	oClone:cMail                := ::cMail
	oClone:cText1               := ::cText1
	oClone:cText2               := ::cText2
	oClone:lIsAdmin             := ::lIsAdmin
	oClone:lIsActive            := ::lIsActive
	oClone:cProfileSystemUserId := ::cProfileSystemUserId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_GiftListMemberDTO
	Local cSoap := ""
	cSoap += WSSoapValue("GiftListMemberId", ::nGiftListMemberId, ::nGiftListMemberId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListId", ::nGiftListId, ::nGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ClientId", ::nClientId, ::nClientId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Title", ::cTitle, ::cTitle , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Surname", ::cSurname, ::cSurname , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Mail", ::cMail, ::cMail , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Text1", ::cText1, ::cText1 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Text2", ::cText2, ::cText2 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsAdmin", ::lIsAdmin, ::lIsAdmin , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProfileSystemUserId", ::cProfileSystemUserId, ::cProfileSystemUserId , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_GiftListMemberDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nGiftListMemberId  :=  WSAdvValue( oResponse,"_GIFTLISTMEMBERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nGiftListId        :=  WSAdvValue( oResponse,"_GIFTLISTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nClientId          :=  WSAdvValue( oResponse,"_CLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cTitle             :=  WSAdvValue( oResponse,"_TITLE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cSurname           :=  WSAdvValue( oResponse,"_SURNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cMail              :=  WSAdvValue( oResponse,"_MAIL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cText1             :=  WSAdvValue( oResponse,"_TEXT1","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cText2             :=  WSAdvValue( oResponse,"_TEXT2","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsAdmin           :=  WSAdvValue( oResponse,"_ISADMIN","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cProfileSystemUserId :=  WSAdvValue( oResponse,"_PROFILESYSTEMUSERID","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure StockKeepingUnitQuantityDTO

WSSTRUCT Service_StockKeepingUnitQuantityDTO
	WSDATA   nQuantity                 AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitQuantityDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitQuantityDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitQuantityDTO
	Local oClone := Service_StockKeepingUnitQuantityDTO():NEW()
	oClone:nQuantity            := ::nQuantity
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitQuantityDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Quantity", ::nQuantity, ::nQuantity , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure EmailQueueDTO

WSSTRUCT Service_EmailQueueDTO
	WSDATA   nAdministratorId          AS int OPTIONAL
	WSDATA   nClientId                 AS int OPTIONAL
	WSDATA   nEmailQueueId             AS int OPTIONAL
	WSDATA   nEmailQueueTypeId         AS int OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   cRecipientEmail           AS string OPTIONAL
	WSDATA   cRecipientName            AS string OPTIONAL
	WSDATA   cRegisterDate             AS dateTime OPTIONAL
	WSDATA   cSenderEmail              AS string OPTIONAL
	WSDATA   cSenderName               AS string OPTIONAL
	WSDATA   cSendingDate              AS dateTime OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSDATA   cSubject                  AS string OPTIONAL
	WSDATA   nSupplierId               AS int OPTIONAL
	WSDATA   cText                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_EmailQueueDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_EmailQueueDTO
Return

WSMETHOD CLONE WSCLIENT Service_EmailQueueDTO
	Local oClone := Service_EmailQueueDTO():NEW()
	oClone:nAdministratorId     := ::nAdministratorId
	oClone:nClientId            := ::nClientId
	oClone:nEmailQueueId        := ::nEmailQueueId
	oClone:nEmailQueueTypeId    := ::nEmailQueueTypeId
	oClone:nOrderId             := ::nOrderId
	oClone:cRecipientEmail      := ::cRecipientEmail
	oClone:cRecipientName       := ::cRecipientName
	oClone:cRegisterDate        := ::cRegisterDate
	oClone:cSenderEmail         := ::cSenderEmail
	oClone:cSenderName          := ::cSenderName
	oClone:cSendingDate         := ::cSendingDate
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
	oClone:cSubject             := ::cSubject
	oClone:nSupplierId          := ::nSupplierId
	oClone:cText                := ::cText
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_EmailQueueDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nAdministratorId   :=  WSAdvValue( oResponse,"_ADMINISTRATORID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nClientId          :=  WSAdvValue( oResponse,"_CLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nEmailQueueId      :=  WSAdvValue( oResponse,"_EMAILQUEUEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nEmailQueueTypeId  :=  WSAdvValue( oResponse,"_EMAILQUEUETYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cRecipientEmail    :=  WSAdvValue( oResponse,"_RECIPIENTEMAIL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cRecipientName     :=  WSAdvValue( oResponse,"_RECIPIENTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cRegisterDate      :=  WSAdvValue( oResponse,"_REGISTERDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cSenderEmail       :=  WSAdvValue( oResponse,"_SENDEREMAIL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cSenderName        :=  WSAdvValue( oResponse,"_SENDERNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cSendingDate       :=  WSAdvValue( oResponse,"_SENDINGDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cSubject           :=  WSAdvValue( oResponse,"_SUBJECT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nSupplierId        :=  WSAdvValue( oResponse,"_SUPPLIERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cText              :=  WSAdvValue( oResponse,"_TEXT","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure IntegrationErrorDTO

WSSTRUCT Service_IntegrationErrorDTO
	WSDATA   cAwareDate                AS dateTime OPTIONAL
	WSDATA   cDate                     AS dateTime OPTIONAL
	WSDATA   cError                    AS string OPTIONAL
	WSDATA   cErrorDetail              AS string OPTIONAL
	WSDATA   nIdIntegrationError       AS int OPTIONAL
	WSDATA   cInstance                 AS string OPTIONAL
	WSDATA   cInterfaceClass           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_IntegrationErrorDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_IntegrationErrorDTO
Return

WSMETHOD CLONE WSCLIENT Service_IntegrationErrorDTO
	Local oClone := Service_IntegrationErrorDTO():NEW()
	oClone:cAwareDate           := ::cAwareDate
	oClone:cDate                := ::cDate
	oClone:cError               := ::cError
	oClone:cErrorDetail         := ::cErrorDetail
	oClone:nIdIntegrationError  := ::nIdIntegrationError
	oClone:cInstance            := ::cInstance
	oClone:cInterfaceClass      := ::cInterfaceClass
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_IntegrationErrorDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAwareDate         :=  WSAdvValue( oResponse,"_AWAREDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDate              :=  WSAdvValue( oResponse,"_DATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cError             :=  WSAdvValue( oResponse,"_ERROR","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cErrorDetail       :=  WSAdvValue( oResponse,"_ERRORDETAIL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nIdIntegrationError :=  WSAdvValue( oResponse,"_IDINTEGRATIONERROR","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cInstance          :=  WSAdvValue( oResponse,"_INSTANCE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cInterfaceClass    :=  WSAdvValue( oResponse,"_INTERFACECLASS","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure IntegrationInterfaceDTO

WSSTRUCT Service_IntegrationInterfaceDTO
	WSDATA   cDateLastError            AS dateTime OPTIONAL
	WSDATA   cDateLastSuccess          AS dateTime OPTIONAL
	WSDATA   oWSInterfaceEnum          AS Service_ErrorType OPTIONAL
	WSDATA   cInterfaceName            AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_IntegrationInterfaceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_IntegrationInterfaceDTO
Return

WSMETHOD CLONE WSCLIENT Service_IntegrationInterfaceDTO
	Local oClone := Service_IntegrationInterfaceDTO():NEW()
	oClone:cDateLastError       := ::cDateLastError
	oClone:cDateLastSuccess     := ::cDateLastSuccess
	oClone:oWSInterfaceEnum     := IIF(::oWSInterfaceEnum = NIL , NIL , ::oWSInterfaceEnum:Clone() )
	oClone:cInterfaceName       := ::cInterfaceName
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_IntegrationInterfaceDTO
	Local oNode3
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDateLastError     :=  WSAdvValue( oResponse,"_DATELASTERROR","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDateLastSuccess   :=  WSAdvValue( oResponse,"_DATELASTSUCCESS","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode3 :=  WSAdvValue( oResponse,"_INTERFACEENUM","ErrorType",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode3 != NIL
		::oWSInterfaceEnum := Service_ErrorType():New()
		::oWSInterfaceEnum:SoapRecv(oNode3)
	EndIf
	::cInterfaceName     :=  WSAdvValue( oResponse,"_INTERFACENAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure FiscalInvoiceDTO

WSSTRUCT Service_FiscalInvoiceDTO
	WSDATA   oWSdest                   AS Service_Dest OPTIONAL
	WSDATA   oWSdet                    AS Service_Det OPTIONAL
	WSDATA   oWSemit                   AS Service_Emit OPTIONAL
	WSDATA   oWSide                    AS Service_Ide OPTIONAL
	WSDATA   oWSinfAdic                AS Service_InfAdic OPTIONAL
	WSDATA   oWStotal                  AS Service_Total OPTIONAL
	WSDATA   oWStransp                 AS Service_Transp OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FiscalInvoiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FiscalInvoiceDTO
Return

WSMETHOD CLONE WSCLIENT Service_FiscalInvoiceDTO
	Local oClone := Service_FiscalInvoiceDTO():NEW()
	oClone:oWSdest              := IIF(::oWSdest = NIL , NIL , ::oWSdest:Clone() )
	oClone:oWSdet               := IIF(::oWSdet = NIL , NIL , ::oWSdet:Clone() )
	oClone:oWSemit              := IIF(::oWSemit = NIL , NIL , ::oWSemit:Clone() )
	oClone:oWSide               := IIF(::oWSide = NIL , NIL , ::oWSide:Clone() )
	oClone:oWSinfAdic           := IIF(::oWSinfAdic = NIL , NIL , ::oWSinfAdic:Clone() )
	oClone:oWStotal             := IIF(::oWStotal = NIL , NIL , ::oWStotal:Clone() )
	oClone:oWStransp            := IIF(::oWStransp = NIL , NIL , ::oWStransp:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_FiscalInvoiceDTO
	Local cSoap := ""
	cSoap += WSSoapValue("dest", ::oWSdest, ::oWSdest , "Dest", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("det", ::oWSdet, ::oWSdet , "Det", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("emit", ::oWSemit, ::oWSemit , "Emit", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ide", ::oWSide, ::oWSide , "Ide", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("infAdic", ::oWSinfAdic, ::oWSinfAdic , "InfAdic", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("total", ::oWStotal, ::oWStotal , "Total", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("transp", ::oWStransp, ::oWStransp , "Transp", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ArrayOfStockKeepingUnitEanDTO

WSSTRUCT Service_ArrayOfStockKeepingUnitEanDTO
	WSDATA   oWSStockKeepingUnitEanDTO AS Service_StockKeepingUnitEanDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfStockKeepingUnitEanDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfStockKeepingUnitEanDTO
	::oWSStockKeepingUnitEanDTO := {} // Array Of  Service_STOCKKEEPINGUNITEANDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfStockKeepingUnitEanDTO
	Local oClone := Service_ArrayOfStockKeepingUnitEanDTO():NEW()
	oClone:oWSStockKeepingUnitEanDTO := NIL
	If ::oWSStockKeepingUnitEanDTO <> NIL 
		oClone:oWSStockKeepingUnitEanDTO := {}
		aEval( ::oWSStockKeepingUnitEanDTO , { |x| aadd( oClone:oWSStockKeepingUnitEanDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfStockKeepingUnitEanDTO
	Local cSoap := ""
	aEval( ::oWSStockKeepingUnitEanDTO , {|x| cSoap := cSoap  +  WSSoapValue("StockKeepingUnitEanDTO", x , x , "StockKeepingUnitEanDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfStockKeepingUnitEanDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITEANDTO","StockKeepingUnitEanDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSStockKeepingUnitEanDTO , Service_StockKeepingUnitEanDTO():New() )
			::oWSStockKeepingUnitEanDTO[len(::oWSStockKeepingUnitEanDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfIntegrationWarehouseDTO

WSSTRUCT Service_ArrayOfIntegrationWarehouseDTO
	WSDATA   oWSIntegrationWarehouseDTO AS Service_IntegrationWarehouseDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfIntegrationWarehouseDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfIntegrationWarehouseDTO
	::oWSIntegrationWarehouseDTO := {} // Array Of  Service_INTEGRATIONWAREHOUSEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfIntegrationWarehouseDTO
	Local oClone := Service_ArrayOfIntegrationWarehouseDTO():NEW()
	oClone:oWSIntegrationWarehouseDTO := NIL
	If ::oWSIntegrationWarehouseDTO <> NIL 
		oClone:oWSIntegrationWarehouseDTO := {}
		aEval( ::oWSIntegrationWarehouseDTO , { |x| aadd( oClone:oWSIntegrationWarehouseDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfIntegrationWarehouseDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_INTEGRATIONWAREHOUSEDTO","IntegrationWarehouseDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSIntegrationWarehouseDTO , Service_IntegrationWarehouseDTO():New() )
			::oWSIntegrationWarehouseDTO[len(::oWSIntegrationWarehouseDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfstring

WSSTRUCT Service_ArrayOfstring
	WSDATA   cstring                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfstring
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfstring
	::cstring              := {} // Array Of  ""
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfstring
	Local oClone := Service_ArrayOfstring():NEW()
	oClone:cstring              := IIf(::cstring <> NIL , aClone(::cstring) , NIL )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfstring
	Local cSoap := ""
	aEval( ::cstring , {|x| cSoap := cSoap  +  WSSoapValue("string", x , x , "string", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfstring
	Local oNodes1 :=  WSAdvValue( oResponse,"_STRING","string",{},NIL,.T.,"S",NIL,"xs") 
	::Init()
	If oResponse = NIL ; Return ; Endif 
	aEval(oNodes1 , { |x| aadd(::cstring ,  x:TEXT  ) } )
Return

// WSDL Data Structure AddressOrderDTO

WSSTRUCT Service_AddressOrderDTO
	WSDATA   cAddressName              AS string OPTIONAL
	WSDATA   cAddressType              AS string OPTIONAL
	WSDATA   cCelPhone                 AS string OPTIONAL
	WSDATA   cCity                     AS string OPTIONAL
	WSDATA   cCountry                  AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   cMore                     AS string OPTIONAL
	WSDATA   cNeighborhood             AS string OPTIONAL
	WSDATA   nNumber                   AS int OPTIONAL
	WSDATA   cNumberV3                 AS string OPTIONAL
	WSDATA   cOfficePhone              AS string OPTIONAL
	WSDATA   cPhone                    AS string OPTIONAL
	WSDATA   cReceiverName             AS string OPTIONAL
	WSDATA   cReferencePoint           AS string OPTIONAL
	WSDATA   cState                    AS string OPTIONAL
	WSDATA   cStreet                   AS string OPTIONAL
	WSDATA   cZipCode                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_AddressOrderDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_AddressOrderDTO
Return

WSMETHOD CLONE WSCLIENT Service_AddressOrderDTO
	Local oClone := Service_AddressOrderDTO():NEW()
	oClone:cAddressName         := ::cAddressName
	oClone:cAddressType         := ::cAddressType
	oClone:cCelPhone            := ::cCelPhone
	oClone:cCity                := ::cCity
	oClone:cCountry             := ::cCountry
	oClone:nId                  := ::nId
	oClone:cMore                := ::cMore
	oClone:cNeighborhood        := ::cNeighborhood
	oClone:nNumber              := ::nNumber
	oClone:cNumberV3            := ::cNumberV3
	oClone:cOfficePhone         := ::cOfficePhone
	oClone:cPhone               := ::cPhone
	oClone:cReceiverName        := ::cReceiverName
	oClone:cReferencePoint      := ::cReferencePoint
	oClone:cState               := ::cState
	oClone:cStreet              := ::cStreet
	oClone:cZipCode             := ::cZipCode
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_AddressOrderDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AddressName", ::cAddressName, ::cAddressName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("AddressType", ::cAddressType, ::cAddressType , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CelPhone", ::cCelPhone, ::cCelPhone , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("City", ::cCity, ::cCity , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Country", ::cCountry, ::cCountry , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("More", ::cMore, ::cMore , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Neighborhood", ::cNeighborhood, ::cNeighborhood , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Number", ::nNumber, ::nNumber , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NumberV3", ::cNumberV3, ::cNumberV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OfficePhone", ::cOfficePhone, ::cOfficePhone , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Phone", ::cPhone, ::cPhone , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ReceiverName", ::cReceiverName, ::cReceiverName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ReferencePoint", ::cReferencePoint, ::cReferencePoint , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("State", ::cState, ::cState , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Street", ::cStreet, ::cStreet , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ZipCode", ::cZipCode, ::cZipCode , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_AddressOrderDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAddressName       :=  WSAdvValue( oResponse,"_ADDRESSNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cAddressType       :=  WSAdvValue( oResponse,"_ADDRESSTYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCelPhone          :=  WSAdvValue( oResponse,"_CELPHONE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCountry           :=  WSAdvValue( oResponse,"_COUNTRY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cMore              :=  WSAdvValue( oResponse,"_MORE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cNeighborhood      :=  WSAdvValue( oResponse,"_NEIGHBORHOOD","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nNumber            :=  WSAdvValue( oResponse,"_NUMBER","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cNumberV3          :=  WSAdvValue( oResponse,"_NUMBERV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cOfficePhone       :=  WSAdvValue( oResponse,"_OFFICEPHONE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cPhone             :=  WSAdvValue( oResponse,"_PHONE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cReceiverName      :=  WSAdvValue( oResponse,"_RECEIVERNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cReferencePoint    :=  WSAdvValue( oResponse,"_REFERENCEPOINT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cState             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cZipCode           :=  WSAdvValue( oResponse,"_ZIPCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfGiftListStockKeepingUnitDTO

WSSTRUCT Service_ArrayOfGiftListStockKeepingUnitDTO
	WSDATA   oWSGiftListStockKeepingUnitDTO AS Service_GiftListStockKeepingUnitDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfGiftListStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfGiftListStockKeepingUnitDTO
	::oWSGiftListStockKeepingUnitDTO := {} // Array Of  Service_GIFTLISTSTOCKKEEPINGUNITDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfGiftListStockKeepingUnitDTO
	Local oClone := Service_ArrayOfGiftListStockKeepingUnitDTO():NEW()
	oClone:oWSGiftListStockKeepingUnitDTO := NIL
	If ::oWSGiftListStockKeepingUnitDTO <> NIL 
		oClone:oWSGiftListStockKeepingUnitDTO := {}
		aEval( ::oWSGiftListStockKeepingUnitDTO , { |x| aadd( oClone:oWSGiftListStockKeepingUnitDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfGiftListStockKeepingUnitDTO
	Local cSoap := ""
	aEval( ::oWSGiftListStockKeepingUnitDTO , {|x| cSoap := cSoap  +  WSSoapValue("GiftListStockKeepingUnitDTO", x , x , "GiftListStockKeepingUnitDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfGiftListStockKeepingUnitDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_GIFTLISTSTOCKKEEPINGUNITDTO","GiftListStockKeepingUnitDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSGiftListStockKeepingUnitDTO , Service_GiftListStockKeepingUnitDTO():New() )
			::oWSGiftListStockKeepingUnitDTO[len(::oWSGiftListStockKeepingUnitDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfOrderDiscountDTO

WSSTRUCT Service_ArrayOfOrderDiscountDTO
	WSDATA   oWSOrderDiscountDTO       AS Service_OrderDiscountDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderDiscountDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderDiscountDTO
	::oWSOrderDiscountDTO  := {} // Array Of  Service_ORDERDISCOUNTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderDiscountDTO
	Local oClone := Service_ArrayOfOrderDiscountDTO():NEW()
	oClone:oWSOrderDiscountDTO := NIL
	If ::oWSOrderDiscountDTO <> NIL 
		oClone:oWSOrderDiscountDTO := {}
		aEval( ::oWSOrderDiscountDTO , { |x| aadd( oClone:oWSOrderDiscountDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderDiscountDTO
	Local cSoap := ""
	aEval( ::oWSOrderDiscountDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderDiscountDTO", x , x , "OrderDiscountDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderDiscountDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERDISCOUNTDTO","OrderDiscountDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderDiscountDTO , Service_OrderDiscountDTO():New() )
			::oWSOrderDiscountDTO[len(::oWSOrderDiscountDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfOrderDeliveryDTO

WSSTRUCT Service_ArrayOfOrderDeliveryDTO
	WSDATA   oWSOrderDeliveryDTO       AS Service_OrderDeliveryDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderDeliveryDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderDeliveryDTO
	::oWSOrderDeliveryDTO  := {} // Array Of  Service_ORDERDELIVERYDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderDeliveryDTO
	Local oClone := Service_ArrayOfOrderDeliveryDTO():NEW()
	oClone:oWSOrderDeliveryDTO := NIL
	If ::oWSOrderDeliveryDTO <> NIL 
		oClone:oWSOrderDeliveryDTO := {}
		aEval( ::oWSOrderDeliveryDTO , { |x| aadd( oClone:oWSOrderDeliveryDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderDeliveryDTO
	Local cSoap := ""
	aEval( ::oWSOrderDeliveryDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderDeliveryDTO", x , x , "OrderDeliveryDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderDeliveryDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERDELIVERYDTO","OrderDeliveryDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderDeliveryDTO , Service_OrderDeliveryDTO():New() )
			::oWSOrderDeliveryDTO[len(::oWSOrderDeliveryDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfOrderInvoiceDTO

WSSTRUCT Service_ArrayOfOrderInvoiceDTO
	WSDATA   oWSOrderInvoiceDTO        AS Service_OrderInvoiceDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderInvoiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderInvoiceDTO
	::oWSOrderInvoiceDTO   := {} // Array Of  Service_ORDERINVOICEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderInvoiceDTO
	Local oClone := Service_ArrayOfOrderInvoiceDTO():NEW()
	oClone:oWSOrderInvoiceDTO := NIL
	If ::oWSOrderInvoiceDTO <> NIL 
		oClone:oWSOrderInvoiceDTO := {}
		aEval( ::oWSOrderInvoiceDTO , { |x| aadd( oClone:oWSOrderInvoiceDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderInvoiceDTO
	Local cSoap := ""
	aEval( ::oWSOrderInvoiceDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderInvoiceDTO", x , x , "OrderInvoiceDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderInvoiceDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERINVOICEDTO","OrderInvoiceDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderInvoiceDTO , Service_OrderInvoiceDTO():New() )
			::oWSOrderInvoiceDTO[len(::oWSOrderInvoiceDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfOrderPaymentDTO

WSSTRUCT Service_ArrayOfOrderPaymentDTO
	WSDATA   oWSOrderPaymentDTO        AS Service_OrderPaymentDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderPaymentDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderPaymentDTO
	::oWSOrderPaymentDTO   := {} // Array Of  Service_ORDERPAYMENTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderPaymentDTO
	Local oClone := Service_ArrayOfOrderPaymentDTO():NEW()
	oClone:oWSOrderPaymentDTO := NIL
	If ::oWSOrderPaymentDTO <> NIL 
		oClone:oWSOrderPaymentDTO := {}
		aEval( ::oWSOrderPaymentDTO , { |x| aadd( oClone:oWSOrderPaymentDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderPaymentDTO
	Local cSoap := ""
	aEval( ::oWSOrderPaymentDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderPaymentDTO", x , x , "OrderPaymentDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderPaymentDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERPAYMENTDTO","OrderPaymentDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderPaymentDTO , Service_OrderPaymentDTO():New() )
			::oWSOrderPaymentDTO[len(::oWSOrderPaymentDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure DateTimeOffset

WSSTRUCT Service_DateTimeOffset
	WSDATA   cDateTime                 AS dateTime OPTIONAL
	WSDATA   nOffsetMinutes            AS short OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_DateTimeOffset
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_DateTimeOffset
Return

WSMETHOD CLONE WSCLIENT Service_DateTimeOffset
	Local oClone := Service_DateTimeOffset():NEW()
	oClone:cDateTime            := ::cDateTime
	oClone:nOffsetMinutes       := ::nOffsetMinutes
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_DateTimeOffset
	Local cSoap := ""
	cSoap += WSSoapValue("DateTime", ::cDateTime, ::cDateTime , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OffsetMinutes", ::nOffsetMinutes, ::nOffsetMinutes , "short", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_DateTimeOffset
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDateTime          :=  WSAdvValue( oResponse,"_DATETIME","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nOffsetMinutes     :=  WSAdvValue( oResponse,"_OFFSETMINUTES","short",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure OrderInteractionDTO

WSSTRUCT Service_OrderInteractionDTO
	WSDATA   nClientId                 AS int OPTIONAL
	WSDATA   cDate                     AS dateTime OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   oWSStatusId               AS Service_OrderInteractionDTO_StatusIdEnum OPTIONAL
	WSDATA   cText                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderInteractionDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderInteractionDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderInteractionDTO
	Local oClone := Service_OrderInteractionDTO():NEW()
	oClone:nClientId            := ::nClientId
	oClone:cDate                := ::cDate
	oClone:nId                  := ::nId
	oClone:nOrderId             := ::nOrderId
	oClone:oWSStatusId          := IIF(::oWSStatusId = NIL , NIL , ::oWSStatusId:Clone() )
	oClone:cText                := ::cText
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderInteractionDTO
	Local oNode5
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nClientId          :=  WSAdvValue( oResponse,"_CLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDate              :=  WSAdvValue( oResponse,"_DATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode5 :=  WSAdvValue( oResponse,"_STATUSID","OrderInteractionDTO.StatusIdEnum",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode5 != NIL
		::oWSStatusId := Service_OrderInteractionDTO_StatusIdEnum():New()
		::oWSStatusId:SoapRecv(oNode5)
	EndIf
	::cText              :=  WSAdvValue( oResponse,"_TEXT","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure KeyValueOfstringstring

WSSTRUCT Service_KeyValueOfstringstring
	WSDATA   cKey                      AS string OPTIONAL
	WSDATA   cValue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_KeyValueOfstringstring
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_KeyValueOfstringstring
Return

WSMETHOD CLONE WSCLIENT Service_KeyValueOfstringstring
	Local oClone := Service_KeyValueOfstringstring():NEW()
	oClone:cKey                 := ::cKey
	oClone:cValue               := ::cValue
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_KeyValueOfstringstring
	Local cSoap := ""
	cSoap += WSSoapValue("Key", ::cKey, ::cKey , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Value", ::cValue, ::cValue , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure OrderItem

WSSTRUCT Service_OrderItem
	WSDATA   nBuyTogetherDiscountId    AS int OPTIONAL
	WSDATA   nCost                     AS decimal OPTIONAL
	WSDATA   nCostOff                  AS decimal OPTIONAL
	WSDATA   nCupomValue               AS decimal OPTIONAL
	WSDATA   nCupomValueOff            AS decimal OPTIONAL
	WSDATA   nGiftDiscountId           AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsStockImpact            AS boolean OPTIONAL
	WSDATA   nItemId                   AS int OPTIONAL
	WSDATA   nOrderDeliveryId          AS int OPTIONAL
	WSDATA   nParentOrderItemId        AS int OPTIONAL
	WSDATA   nShippingCost             AS decimal OPTIONAL
	WSDATA   nShippingCostOff          AS decimal OPTIONAL
	WSDATA   nStockLikelyId            AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderItem
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderItem
Return

WSMETHOD CLONE WSCLIENT Service_OrderItem
	Local oClone := Service_OrderItem():NEW()
	oClone:nBuyTogetherDiscountId := ::nBuyTogetherDiscountId
	oClone:nCost                := ::nCost
	oClone:nCostOff             := ::nCostOff
	oClone:nCupomValue          := ::nCupomValue
	oClone:nCupomValueOff       := ::nCupomValueOff
	oClone:nGiftDiscountId      := ::nGiftDiscountId
	oClone:nId                  := ::nId
	oClone:lIsStockImpact       := ::lIsStockImpact
	oClone:nItemId              := ::nItemId
	oClone:nOrderDeliveryId     := ::nOrderDeliveryId
	oClone:nParentOrderItemId   := ::nParentOrderItemId
	oClone:nShippingCost        := ::nShippingCost
	oClone:nShippingCostOff     := ::nShippingCostOff
	oClone:nStockLikelyId       := ::nStockLikelyId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderItem
	Local cSoap := ""
	cSoap += WSSoapValue("BuyTogetherDiscountId", ::nBuyTogetherDiscountId, ::nBuyTogetherDiscountId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Cost", ::nCost, ::nCost , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CostOff", ::nCostOff, ::nCostOff , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CupomValue", ::nCupomValue, ::nCupomValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CupomValueOff", ::nCupomValueOff, ::nCupomValueOff , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftDiscountId", ::nGiftDiscountId, ::nGiftDiscountId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsStockImpact", ::lIsStockImpact, ::lIsStockImpact , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ItemId", ::nItemId, ::nItemId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderDeliveryId", ::nOrderDeliveryId, ::nOrderDeliveryId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ParentOrderItemId", ::nParentOrderItemId, ::nParentOrderItemId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ShippingCost", ::nShippingCost, ::nShippingCost , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ShippingCostOff", ::nShippingCostOff, ::nShippingCostOff , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockLikelyId", ::nStockLikelyId, ::nStockLikelyId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure PaymentDTO

WSSTRUCT Service_PaymentDTO
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cType                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_PaymentDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_PaymentDTO
Return

WSMETHOD CLONE WSCLIENT Service_PaymentDTO
	Local oClone := Service_PaymentDTO():NEW()
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:cName                := ::cName
	oClone:cType                := ::cType
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_PaymentDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cType              :=  WSAdvValue( oResponse,"_TYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure guid

WSSTRUCT Service_guid
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_guid
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_guid
Return

WSMETHOD CLONE WSCLIENT Service_guid
	Local oClone := Service_guid():NEW()
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_guid
	Local cSoap := ""
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_guid
	::Init()
	If oResponse = NIL ; Return ; Endif 
Return

// WSDL Data Structure ArrayOfClientFieldDTO

WSSTRUCT Service_ArrayOfClientFieldDTO
	WSDATA   oWSClientFieldDTO         AS Service_ClientFieldDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfClientFieldDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfClientFieldDTO
	::oWSClientFieldDTO    := {} // Array Of  Service_CLIENTFIELDDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfClientFieldDTO
	Local oClone := Service_ArrayOfClientFieldDTO():NEW()
	oClone:oWSClientFieldDTO := NIL
	If ::oWSClientFieldDTO <> NIL 
		oClone:oWSClientFieldDTO := {}
		aEval( ::oWSClientFieldDTO , { |x| aadd( oClone:oWSClientFieldDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfClientFieldDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_CLIENTFIELDDTO","ClientFieldDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSClientFieldDTO , Service_ClientFieldDTO():New() )
			::oWSClientFieldDTO[len(::oWSClientFieldDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure FreightStockKeepingUnitContextDTO

WSSTRUCT Service_FreightStockKeepingUnitContextDTO
	WSDATA   nQuantity                 AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FreightStockKeepingUnitContextDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FreightStockKeepingUnitContextDTO
Return

WSMETHOD CLONE WSCLIENT Service_FreightStockKeepingUnitContextDTO
	Local oClone := Service_FreightStockKeepingUnitContextDTO():NEW()
	oClone:nQuantity            := ::nQuantity
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_FreightStockKeepingUnitContextDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Quantity", ::nQuantity, ::nQuantity , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure FreightStockKeepingUnitDTO

WSSTRUCT Service_FreightStockKeepingUnitDTO
	WSDATA   nDeliveryTime             AS int OPTIONAL
	WSDATA   cFreightAdditionalInfo    AS string OPTIONAL
	WSDATA   nFreightPrice             AS decimal OPTIONAL
	WSDATA   oWSFreightScheduledDateOptions AS Service_ArrayOfFreightScheduledDateOptionDTO OPTIONAL
	WSDATA   cFreightType              AS string OPTIONAL
	WSDATA   cFreightTypeId            AS string OPTIONAL
	WSDATA   nQuantity                 AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FreightStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FreightStockKeepingUnitDTO
Return

WSMETHOD CLONE WSCLIENT Service_FreightStockKeepingUnitDTO
	Local oClone := Service_FreightStockKeepingUnitDTO():NEW()
	oClone:nDeliveryTime        := ::nDeliveryTime
	oClone:cFreightAdditionalInfo := ::cFreightAdditionalInfo
	oClone:nFreightPrice        := ::nFreightPrice
	oClone:oWSFreightScheduledDateOptions := IIF(::oWSFreightScheduledDateOptions = NIL , NIL , ::oWSFreightScheduledDateOptions:Clone() )
	oClone:cFreightType         := ::cFreightType
	oClone:cFreightTypeId       := ::cFreightTypeId
	oClone:nQuantity            := ::nQuantity
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_FreightStockKeepingUnitDTO
	Local oNode4
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nDeliveryTime      :=  WSAdvValue( oResponse,"_DELIVERYTIME","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cFreightAdditionalInfo :=  WSAdvValue( oResponse,"_FREIGHTADDITIONALINFO","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFreightPrice      :=  WSAdvValue( oResponse,"_FREIGHTPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode4 :=  WSAdvValue( oResponse,"_FREIGHTSCHEDULEDDATEOPTIONS","ArrayOfFreightScheduledDateOptionDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode4 != NIL
		::oWSFreightScheduledDateOptions := Service_ArrayOfFreightScheduledDateOptionDTO():New()
		::oWSFreightScheduledDateOptions:SoapRecv(oNode4)
	EndIf
	::cFreightType       :=  WSAdvValue( oResponse,"_FREIGHTTYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cFreightTypeId     :=  WSAdvValue( oResponse,"_FREIGHTTYPEID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nQuantity          :=  WSAdvValue( oResponse,"_QUANTITY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure AddressDTO2

WSSTRUCT Service_AddressDTO2
	WSDATA   oWSAddressGUID            AS Service_guid OPTIONAL
	WSDATA   cAddressNameV3            AS string OPTIONAL
	WSDATA   cAddressType              AS string OPTIONAL
	WSDATA   cCity                     AS string OPTIONAL
	WSDATA   cCountry                  AS string OPTIONAL
	WSDATA   cId                       AS string OPTIONAL
	WSDATA   cMore                     AS string OPTIONAL
	WSDATA   cNeighborhood             AS string OPTIONAL
	WSDATA   nNumber                   AS int OPTIONAL
	WSDATA   cRecipientName            AS string OPTIONAL
	WSDATA   cReferencePoint           AS string OPTIONAL
	WSDATA   cState                    AS string OPTIONAL
	WSDATA   cStreet                   AS string OPTIONAL
	WSDATA   oWSUserGUID               AS Service_guid OPTIONAL
	WSDATA   cZipCode                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_AddressDTO2
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_AddressDTO2
Return

WSMETHOD CLONE WSCLIENT Service_AddressDTO2
	Local oClone := Service_AddressDTO2():NEW()
	oClone:oWSAddressGUID       := IIF(::oWSAddressGUID = NIL , NIL , ::oWSAddressGUID:Clone() )
	oClone:cAddressNameV3       := ::cAddressNameV3
	oClone:cAddressType         := ::cAddressType
	oClone:cCity                := ::cCity
	oClone:cCountry             := ::cCountry
	oClone:cId                  := ::cId
	oClone:cMore                := ::cMore
	oClone:cNeighborhood        := ::cNeighborhood
	oClone:nNumber              := ::nNumber
	oClone:cRecipientName       := ::cRecipientName
	oClone:cReferencePoint      := ::cReferencePoint
	oClone:cState               := ::cState
	oClone:cStreet              := ::cStreet
	oClone:oWSUserGUID          := IIF(::oWSUserGUID = NIL , NIL , ::oWSUserGUID:Clone() )
	oClone:cZipCode             := ::cZipCode
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_AddressDTO2
	Local oNode1
	Local oNode14
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_ADDRESSGUID","guid",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode1 != NIL
		::oWSAddressGUID := Service_guid():New()
		::oWSAddressGUID:SoapRecv(oNode1)
	EndIf
	::cAddressNameV3     :=  WSAdvValue( oResponse,"_ADDRESSNAMEV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cAddressType       :=  WSAdvValue( oResponse,"_ADDRESSTYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCountry           :=  WSAdvValue( oResponse,"_COUNTRY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cId                :=  WSAdvValue( oResponse,"_ID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cMore              :=  WSAdvValue( oResponse,"_MORE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cNeighborhood      :=  WSAdvValue( oResponse,"_NEIGHBORHOOD","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nNumber            :=  WSAdvValue( oResponse,"_NUMBER","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cRecipientName     :=  WSAdvValue( oResponse,"_RECIPIENTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cReferencePoint    :=  WSAdvValue( oResponse,"_REFERENCEPOINT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cState             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode14 :=  WSAdvValue( oResponse,"_USERGUID","guid",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode14 != NIL
		::oWSUserGUID := Service_guid():New()
		::oWSUserGUID:SoapRecv(oNode14)
	EndIf
	::cZipCode           :=  WSAdvValue( oResponse,"_ZIPCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ImageDTO

WSSTRUCT Service_ImageDTO
	WSDATA   nArchiveFormatId          AS int OPTIONAL
	WSDATA   nArchiveParentId          AS int OPTIONAL
	WSDATA   nArchiveTypeId            AS int OPTIONAL
	WSDATA   cDateLastModified         AS dateTime OPTIONAL
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   cFileLocation             AS string OPTIONAL
	WSDATA   nHeight                   AS int OPTIONAL
	WSDATA   cHeightUnitMeasure        AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsMain                   AS boolean OPTIONAL
	WSDATA   cLabel                    AS string OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSDATA   cTag                      AS string OPTIONAL
	WSDATA   cUrl                      AS string OPTIONAL
	WSDATA   nWidth                    AS int OPTIONAL
	WSDATA   cWidthUnitMeasure         AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ImageDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ImageDTO
Return

WSMETHOD CLONE WSCLIENT Service_ImageDTO
	Local oClone := Service_ImageDTO():NEW()
	oClone:nArchiveFormatId     := ::nArchiveFormatId
	oClone:nArchiveParentId     := ::nArchiveParentId
	oClone:nArchiveTypeId       := ::nArchiveTypeId
	oClone:cDateLastModified    := ::cDateLastModified
	oClone:cDescription         := ::cDescription
	oClone:cFileLocation        := ::cFileLocation
	oClone:nHeight              := ::nHeight
	oClone:cHeightUnitMeasure   := ::cHeightUnitMeasure
	oClone:nId                  := ::nId
	oClone:lIsMain              := ::lIsMain
	oClone:cLabel               := ::cLabel
	oClone:cName                := ::cName
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
	oClone:cTag                 := ::cTag
	oClone:cUrl                 := ::cUrl
	oClone:nWidth               := ::nWidth
	oClone:cWidthUnitMeasure    := ::cWidthUnitMeasure
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ImageDTO
	Local cSoap := ""
	cSoap += WSSoapValue("ArchiveFormatId", ::nArchiveFormatId, ::nArchiveFormatId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ArchiveParentId", ::nArchiveParentId, ::nArchiveParentId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ArchiveTypeId", ::nArchiveTypeId, ::nArchiveTypeId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DateLastModified", ::cDateLastModified, ::cDateLastModified , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FileLocation", ::cFileLocation, ::cFileLocation , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Height", ::nHeight, ::nHeight , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("HeightUnitMeasure", ::cHeightUnitMeasure, ::cHeightUnitMeasure , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsMain", ::lIsMain, ::lIsMain , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Label", ::cLabel, ::cLabel , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Tag", ::cTag, ::cTag , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Url", ::cUrl, ::cUrl , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Width", ::nWidth, ::nWidth , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("WidthUnitMeasure", ::cWidthUnitMeasure, ::cWidthUnitMeasure , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ImageDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nArchiveFormatId   :=  WSAdvValue( oResponse,"_ARCHIVEFORMATID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nArchiveParentId   :=  WSAdvValue( oResponse,"_ARCHIVEPARENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nArchiveTypeId     :=  WSAdvValue( oResponse,"_ARCHIVETYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDateLastModified  :=  WSAdvValue( oResponse,"_DATELASTMODIFIED","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cFileLocation      :=  WSAdvValue( oResponse,"_FILELOCATION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nHeight            :=  WSAdvValue( oResponse,"_HEIGHT","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cHeightUnitMeasure :=  WSAdvValue( oResponse,"_HEIGHTUNITMEASURE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsMain            :=  WSAdvValue( oResponse,"_ISMAIN","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cLabel             :=  WSAdvValue( oResponse,"_LABEL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cTag               :=  WSAdvValue( oResponse,"_TAG","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cUrl               :=  WSAdvValue( oResponse,"_URL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nWidth             :=  WSAdvValue( oResponse,"_WIDTH","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cWidthUnitMeasure  :=  WSAdvValue( oResponse,"_WIDTHUNITMEASURE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Enumeration ErrorType

WSSTRUCT Service_ErrorType
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ErrorType
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "CATEGORIA" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "CLIENTE" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "ESTOQUE" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "IMAGEM" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "KIT" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "MARCA" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "PEDIDO" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "PRODUTO" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "SKU" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "SERVICO" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "ENTREGA" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "TRACKING" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "FRETE" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "FRETEVALOR" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "GIFTCARD" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "EMAILQUEUE" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "GIFTLIST" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "GIFTLISTSKU" )
	aadd(::aValueList , "" )
	aadd(::aValueList , "BUYTOGETHER" )
	aadd(::aValueList , "" )
Return Self

WSMETHOD SOAPSEND WSCLIENT Service_ErrorType
	Local cSoap := "" 
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ErrorType
	::Value := NIL
	If oResponse = NIL ; Return ; Endif 
	::Value :=  oResponse:TEXT
Return 

WSMETHOD CLONE WSCLIENT Service_ErrorType
Local oClone := Service_ErrorType():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure Dest

WSSTRUCT Service_Dest
	WSDATA   nCPF                      AS int OPTIONAL
	WSDATA   nIE                       AS int OPTIONAL
	WSDATA   cemail                    AS string OPTIONAL
	WSDATA   oWSenderEmit              AS Service_Ender OPTIONAL
	WSDATA   cxNome                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Dest
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Dest
Return

WSMETHOD CLONE WSCLIENT Service_Dest
	Local oClone := Service_Dest():NEW()
	oClone:nCPF                 := ::nCPF
	oClone:nIE                  := ::nIE
	oClone:cemail               := ::cemail
	oClone:oWSenderEmit         := IIF(::oWSenderEmit = NIL , NIL , ::oWSenderEmit:Clone() )
	oClone:cxNome               := ::cxNome
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Dest
	Local cSoap := ""
	cSoap += WSSoapValue("CPF", ::nCPF, ::nCPF , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IE", ::nIE, ::nIE , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("email", ::cemail, ::cemail , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("enderEmit", ::oWSenderEmit, ::oWSenderEmit , "Ender", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xNome", ::cxNome, ::cxNome , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Det

WSSTRUCT Service_Det
	WSDATA   oWSimposto                AS Service_Imposto OPTIONAL
	WSDATA   oWSprod                   AS Service_Prod OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Det
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Det
Return

WSMETHOD CLONE WSCLIENT Service_Det
	Local oClone := Service_Det():NEW()
	oClone:oWSimposto           := IIF(::oWSimposto = NIL , NIL , ::oWSimposto:Clone() )
	oClone:oWSprod              := IIF(::oWSprod = NIL , NIL , ::oWSprod:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Det
	Local cSoap := ""
	cSoap += WSSoapValue("imposto", ::oWSimposto, ::oWSimposto , "Imposto", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("prod", ::oWSprod, ::oWSprod , "Prod", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Emit

WSSTRUCT Service_Emit
	WSDATA   nCNPJ                     AS int OPTIONAL
	WSDATA   nCRT                      AS int OPTIONAL
	WSDATA   nIE                       AS int OPTIONAL
	WSDATA   oWSenderEmit              AS Service_Ender OPTIONAL
	WSDATA   cxNome                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Emit
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Emit
Return

WSMETHOD CLONE WSCLIENT Service_Emit
	Local oClone := Service_Emit():NEW()
	oClone:nCNPJ                := ::nCNPJ
	oClone:nCRT                 := ::nCRT
	oClone:nIE                  := ::nIE
	oClone:oWSenderEmit         := IIF(::oWSenderEmit = NIL , NIL , ::oWSenderEmit:Clone() )
	oClone:cxNome               := ::cxNome
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Emit
	Local cSoap := ""
	cSoap += WSSoapValue("CNPJ", ::nCNPJ, ::nCNPJ , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CRT", ::nCRT, ::nCRT , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IE", ::nIE, ::nIE , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("enderEmit", ::oWSenderEmit, ::oWSenderEmit , "Ender", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xNome", ::cxNome, ::cxNome , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Ide

WSSTRUCT Service_Ide
	WSDATA   ncDV                      AS int OPTIONAL
	WSDATA   ncMunFG                   AS int OPTIONAL
	WSDATA   ncNF                      AS int OPTIONAL
	WSDATA   ncUF                      AS int OPTIONAL
	WSDATA   cdEmi                     AS dateTime OPTIONAL
	WSDATA   cdSaiEnt                  AS dateTime OPTIONAL
	WSDATA   cdhCont                   AS dateTime OPTIONAL
	WSDATA   nfinNFe                   AS int OPTIONAL
	WSDATA   chSaiEnt                  AS dateTime OPTIONAL
	WSDATA   nindPag                   AS int OPTIONAL
	WSDATA   nmod                      AS int OPTIONAL
	WSDATA   nnNF                      AS int OPTIONAL
	WSDATA   cnatOp                    AS string OPTIONAL
	WSDATA   nprocEmi                  AS int OPTIONAL
	WSDATA   nserie                    AS int OPTIONAL
	WSDATA   ntpAmb                    AS int OPTIONAL
	WSDATA   ntpEmis                   AS int OPTIONAL
	WSDATA   ntpImp                    AS int OPTIONAL
	WSDATA   ntpNF                     AS int OPTIONAL
	WSDATA   cverProc                  AS string OPTIONAL
	WSDATA   cxJust                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Ide
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Ide
Return

WSMETHOD CLONE WSCLIENT Service_Ide
	Local oClone := Service_Ide():NEW()
	oClone:ncDV                 := ::ncDV
	oClone:ncMunFG              := ::ncMunFG
	oClone:ncNF                 := ::ncNF
	oClone:ncUF                 := ::ncUF
	oClone:cdEmi                := ::cdEmi
	oClone:cdSaiEnt             := ::cdSaiEnt
	oClone:cdhCont              := ::cdhCont
	oClone:nfinNFe              := ::nfinNFe
	oClone:chSaiEnt             := ::chSaiEnt
	oClone:nindPag              := ::nindPag
	oClone:nmod                 := ::nmod
	oClone:nnNF                 := ::nnNF
	oClone:cnatOp               := ::cnatOp
	oClone:nprocEmi             := ::nprocEmi
	oClone:nserie               := ::nserie
	oClone:ntpAmb               := ::ntpAmb
	oClone:ntpEmis              := ::ntpEmis
	oClone:ntpImp               := ::ntpImp
	oClone:ntpNF                := ::ntpNF
	oClone:cverProc             := ::cverProc
	oClone:cxJust               := ::cxJust
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Ide
	Local cSoap := ""
	cSoap += WSSoapValue("cDV", ::ncDV, ::ncDV , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cMunFG", ::ncMunFG, ::ncMunFG , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cNF", ::ncNF, ::ncNF , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cUF", ::ncUF, ::ncUF , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("dEmi", ::cdEmi, ::cdEmi , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("dSaiEnt", ::cdSaiEnt, ::cdSaiEnt , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("dhCont", ::cdhCont, ::cdhCont , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("finNFe", ::nfinNFe, ::nfinNFe , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("hSaiEnt", ::chSaiEnt, ::chSaiEnt , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("indPag", ::nindPag, ::nindPag , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("mod", ::nmod, ::nmod , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("nNF", ::nnNF, ::nnNF , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("natOp", ::cnatOp, ::cnatOp , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("procEmi", ::nprocEmi, ::nprocEmi , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("serie", ::nserie, ::nserie , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("tpAmb", ::ntpAmb, ::ntpAmb , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("tpEmis", ::ntpEmis, ::ntpEmis , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("tpImp", ::ntpImp, ::ntpImp , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("tpNF", ::ntpNF, ::ntpNF , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("verProc", ::cverProc, ::cverProc , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xJust", ::cxJust, ::cxJust , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure InfAdic

WSSTRUCT Service_InfAdic
	WSDATA   cinfCpl                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_InfAdic
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_InfAdic
Return

WSMETHOD CLONE WSCLIENT Service_InfAdic
	Local oClone := Service_InfAdic():NEW()
	oClone:cinfCpl              := ::cinfCpl
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_InfAdic
	Local cSoap := ""
	cSoap += WSSoapValue("infCpl", ::cinfCpl, ::cinfCpl , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Total

WSSTRUCT Service_Total
	WSDATA   oWSicmsTot                AS Service_ICMSTot OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Total
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Total
Return

WSMETHOD CLONE WSCLIENT Service_Total
	Local oClone := Service_Total():NEW()
	oClone:oWSicmsTot           := IIF(::oWSicmsTot = NIL , NIL , ::oWSicmsTot:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Total
	Local cSoap := ""
	cSoap += WSSoapValue("icmsTot", ::oWSicmsTot, ::oWSicmsTot , "ICMSTot", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Transp

WSSTRUCT Service_Transp
	WSDATA   nmodFrete                 AS int OPTIONAL
	WSDATA   oWStransporta             AS Service_Transporta OPTIONAL
	WSDATA   oWSvol                    AS Service_Vol OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Transp
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Transp
Return

WSMETHOD CLONE WSCLIENT Service_Transp
	Local oClone := Service_Transp():NEW()
	oClone:nmodFrete            := ::nmodFrete
	oClone:oWStransporta        := IIF(::oWStransporta = NIL , NIL , ::oWStransporta:Clone() )
	oClone:oWSvol               := IIF(::oWSvol = NIL , NIL , ::oWSvol:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Transp
	Local cSoap := ""
	cSoap += WSSoapValue("modFrete", ::nmodFrete, ::nmodFrete , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("transporta", ::oWStransporta, ::oWStransporta , "Transporta", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vol", ::oWSvol, ::oWSvol , "Vol", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure StockKeepingUnitEanDTO

WSSTRUCT Service_StockKeepingUnitEanDTO
	WSDATA   cEan                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitEanDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitEanDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitEanDTO
	Local oClone := Service_StockKeepingUnitEanDTO():NEW()
	oClone:cEan                 := ::cEan
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitEanDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Ean", ::cEan, ::cEan , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_StockKeepingUnitEanDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cEan               :=  WSAdvValue( oResponse,"_EAN","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure IntegrationWarehouseDTO

WSSTRUCT Service_IntegrationWarehouseDTO
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nIdIntegration            AS int OPTIONAL
	WSDATA   nIdWarehouse              AS int OPTIONAL
	WSDATA   cWarehouseAbacosKey       AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_IntegrationWarehouseDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_IntegrationWarehouseDTO
Return

WSMETHOD CLONE WSCLIENT Service_IntegrationWarehouseDTO
	Local oClone := Service_IntegrationWarehouseDTO():NEW()
	oClone:nId                  := ::nId
	oClone:nIdIntegration       := ::nIdIntegration
	oClone:nIdWarehouse         := ::nIdWarehouse
	oClone:cWarehouseAbacosKey  := ::cWarehouseAbacosKey
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_IntegrationWarehouseDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nIdIntegration     :=  WSAdvValue( oResponse,"_IDINTEGRATION","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nIdWarehouse       :=  WSAdvValue( oResponse,"_IDWAREHOUSE","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cWarehouseAbacosKey :=  WSAdvValue( oResponse,"_WAREHOUSEABACOSKEY","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure GiftListStockKeepingUnitDTO

WSSTRUCT Service_GiftListStockKeepingUnitDTO
	WSDATA   cDateCreated              AS dateTime OPTIONAL
	WSDATA   cDatePurchased            AS dateTime OPTIONAL
	WSDATA   nFreightAndServicesValue  AS decimal OPTIONAL
	WSDATA   nGiftListId               AS int OPTIONAL
	WSDATA   nGiftListSkuId            AS int OPTIONAL
	WSDATA   nInsertedByClientId       AS int OPTIONAL
	WSDATA   cInsertedByProfileSystemUserId AS string OPTIONAL
	WSDATA   nItemValue                AS decimal OPTIONAL
	WSDATA   cOmsOrderId               AS string OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   cOrderMessage             AS string OPTIONAL
	WSDATA   cOrderMessageFrom         AS string OPTIONAL
	WSDATA   cOrderMessageTo           AS string OPTIONAL
	WSDATA   cOrderResponseMessage     AS string OPTIONAL
	WSDATA   nSkuId                    AS int OPTIONAL
	WSDATA   nWishedByClientId         AS int OPTIONAL
	WSDATA   cWishedByProfileSystemUserId AS string OPTIONAL
	WSDATA   l_IsOrderFinished         AS boolean OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_GiftListStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_GiftListStockKeepingUnitDTO
Return

WSMETHOD CLONE WSCLIENT Service_GiftListStockKeepingUnitDTO
	Local oClone := Service_GiftListStockKeepingUnitDTO():NEW()
	oClone:cDateCreated         := ::cDateCreated
	oClone:cDatePurchased       := ::cDatePurchased
	oClone:nFreightAndServicesValue := ::nFreightAndServicesValue
	oClone:nGiftListId          := ::nGiftListId
	oClone:nGiftListSkuId       := ::nGiftListSkuId
	oClone:nInsertedByClientId  := ::nInsertedByClientId
	oClone:cInsertedByProfileSystemUserId := ::cInsertedByProfileSystemUserId
	oClone:nItemValue           := ::nItemValue
	oClone:cOmsOrderId          := ::cOmsOrderId
	oClone:nOrderId             := ::nOrderId
	oClone:cOrderMessage        := ::cOrderMessage
	oClone:cOrderMessageFrom    := ::cOrderMessageFrom
	oClone:cOrderMessageTo      := ::cOrderMessageTo
	oClone:cOrderResponseMessage := ::cOrderResponseMessage
	oClone:nSkuId               := ::nSkuId
	oClone:nWishedByClientId    := ::nWishedByClientId
	oClone:cWishedByProfileSystemUserId := ::cWishedByProfileSystemUserId
	oClone:l_IsOrderFinished    := ::l_IsOrderFinished
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_GiftListStockKeepingUnitDTO
	Local cSoap := ""
	cSoap += WSSoapValue("DateCreated", ::cDateCreated, ::cDateCreated , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DatePurchased", ::cDatePurchased, ::cDatePurchased , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightAndServicesValue", ::nFreightAndServicesValue, ::nFreightAndServicesValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListId", ::nGiftListId, ::nGiftListId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftListSkuId", ::nGiftListSkuId, ::nGiftListSkuId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InsertedByClientId", ::nInsertedByClientId, ::nInsertedByClientId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InsertedByProfileSystemUserId", ::cInsertedByProfileSystemUserId, ::cInsertedByProfileSystemUserId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ItemValue", ::nItemValue, ::nItemValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OmsOrderId", ::cOmsOrderId, ::cOmsOrderId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderId", ::nOrderId, ::nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderMessage", ::cOrderMessage, ::cOrderMessage , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderMessageFrom", ::cOrderMessageFrom, ::cOrderMessageFrom , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderMessageTo", ::cOrderMessageTo, ::cOrderMessageTo , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderResponseMessage", ::cOrderResponseMessage, ::cOrderResponseMessage , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("SkuId", ::nSkuId, ::nSkuId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("WishedByClientId", ::nWishedByClientId, ::nWishedByClientId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("WishedByProfileSystemUserId", ::cWishedByProfileSystemUserId, ::cWishedByProfileSystemUserId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("_IsOrderFinished", ::l_IsOrderFinished, ::l_IsOrderFinished , "boolean", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_GiftListStockKeepingUnitDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDateCreated       :=  WSAdvValue( oResponse,"_DATECREATED","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDatePurchased     :=  WSAdvValue( oResponse,"_DATEPURCHASED","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFreightAndServicesValue :=  WSAdvValue( oResponse,"_FREIGHTANDSERVICESVALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nGiftListId        :=  WSAdvValue( oResponse,"_GIFTLISTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nGiftListSkuId     :=  WSAdvValue( oResponse,"_GIFTLISTSKUID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nInsertedByClientId :=  WSAdvValue( oResponse,"_INSERTEDBYCLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cInsertedByProfileSystemUserId :=  WSAdvValue( oResponse,"_INSERTEDBYPROFILESYSTEMUSERID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nItemValue         :=  WSAdvValue( oResponse,"_ITEMVALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cOmsOrderId        :=  WSAdvValue( oResponse,"_OMSORDERID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cOrderMessage      :=  WSAdvValue( oResponse,"_ORDERMESSAGE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cOrderMessageFrom  :=  WSAdvValue( oResponse,"_ORDERMESSAGEFROM","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cOrderMessageTo    :=  WSAdvValue( oResponse,"_ORDERMESSAGETO","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cOrderResponseMessage :=  WSAdvValue( oResponse,"_ORDERRESPONSEMESSAGE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nSkuId             :=  WSAdvValue( oResponse,"_SKUID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nWishedByClientId  :=  WSAdvValue( oResponse,"_WISHEDBYCLIENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cWishedByProfileSystemUserId :=  WSAdvValue( oResponse,"_WISHEDBYPROFILESYSTEMUSERID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::l_IsOrderFinished  :=  WSAdvValue( oResponse,"__ISORDERFINISHED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
Return

// WSDL Data Structure OrderDiscountDTO

WSSTRUCT Service_OrderDiscountDTO
	WSDATA   nDiscountId               AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   nSkuId                    AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderDiscountDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderDiscountDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderDiscountDTO
	Local oClone := Service_OrderDiscountDTO():NEW()
	oClone:nDiscountId          := ::nDiscountId
	oClone:nId                  := ::nId
	oClone:cName                := ::cName
	oClone:nOrderId             := ::nOrderId
	oClone:nSkuId               := ::nSkuId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderDiscountDTO
	Local cSoap := ""
	cSoap += WSSoapValue("DiscountId", ::nDiscountId, ::nDiscountId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderId", ::nOrderId, ::nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("SkuId", ::nSkuId, ::nSkuId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderDiscountDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nDiscountId        :=  WSAdvValue( oResponse,"_DISCOUNTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nSkuId             :=  WSAdvValue( oResponse,"_SKUID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure OrderDeliveryDTO

WSSTRUCT Service_OrderDeliveryDTO
	WSDATA   cDateExpectedDelivery     AS dateTime OPTIONAL
	WSDATA   nDaysForDistributionCenterProcessing AS int OPTIONAL
	WSDATA   nDaysForFreightDelivery   AS int OPTIONAL
	WSDATA   nDaysForStockProcessing   AS int OPTIONAL
	WSDATA   cDeliveryDate             AS dateTime OPTIONAL
	WSDATA   oWSDistributionCenter     AS Service_DistributionCenterDTO OPTIONAL
	WSDATA   nFreightId                AS int OPTIONAL
	WSDATA   cFreightIdV3              AS string OPTIONAL
	WSDATA   cFreightName              AS string OPTIONAL
	WSDATA   nFreightTypeId            AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   cInvoiceNumber            AS string OPTIONAL
	WSDATA   nManagementId             AS int OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   oWSOrderItems             AS Service_ArrayOfOrderItemDTO OPTIONAL
	WSDATA   oWSOrderStatus            AS Service_OrderStatusDTO OPTIONAL
	WSDATA   cOrderStatusId            AS string OPTIONAL
	WSDATA   cScheduledDate            AS dateTime OPTIONAL
	WSDATA   cScheduledShift           AS string OPTIONAL
	WSDATA   nStatusAdministratorId    AS int OPTIONAL
	WSDATA   cStausChangeDate          AS dateTime OPTIONAL
	WSDATA   cTrackingNumber           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderDeliveryDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderDeliveryDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderDeliveryDTO
	Local oClone := Service_OrderDeliveryDTO():NEW()
	oClone:cDateExpectedDelivery := ::cDateExpectedDelivery
	oClone:nDaysForDistributionCenterProcessing := ::nDaysForDistributionCenterProcessing
	oClone:nDaysForFreightDelivery := ::nDaysForFreightDelivery
	oClone:nDaysForStockProcessing := ::nDaysForStockProcessing
	oClone:cDeliveryDate        := ::cDeliveryDate
	oClone:oWSDistributionCenter := IIF(::oWSDistributionCenter = NIL , NIL , ::oWSDistributionCenter:Clone() )
	oClone:nFreightId           := ::nFreightId
	oClone:cFreightIdV3         := ::cFreightIdV3
	oClone:cFreightName         := ::cFreightName
	oClone:nFreightTypeId       := ::nFreightTypeId
	oClone:nId                  := ::nId
	oClone:cInvoiceNumber       := ::cInvoiceNumber
	oClone:nManagementId        := ::nManagementId
	oClone:nOrderId             := ::nOrderId
	oClone:oWSOrderItems        := IIF(::oWSOrderItems = NIL , NIL , ::oWSOrderItems:Clone() )
	oClone:oWSOrderStatus       := IIF(::oWSOrderStatus = NIL , NIL , ::oWSOrderStatus:Clone() )
	oClone:cOrderStatusId       := ::cOrderStatusId
	oClone:cScheduledDate       := ::cScheduledDate
	oClone:cScheduledShift      := ::cScheduledShift
	oClone:nStatusAdministratorId := ::nStatusAdministratorId
	oClone:cStausChangeDate     := ::cStausChangeDate
	oClone:cTrackingNumber      := ::cTrackingNumber
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderDeliveryDTO
	Local cSoap := ""
	cSoap += WSSoapValue("DateExpectedDelivery", ::cDateExpectedDelivery, ::cDateExpectedDelivery , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DaysForDistributionCenterProcessing", ::nDaysForDistributionCenterProcessing, ::nDaysForDistributionCenterProcessing , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DaysForFreightDelivery", ::nDaysForFreightDelivery, ::nDaysForFreightDelivery , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DaysForStockProcessing", ::nDaysForStockProcessing, ::nDaysForStockProcessing , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DeliveryDate", ::cDeliveryDate, ::cDeliveryDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DistributionCenter", ::oWSDistributionCenter, ::oWSDistributionCenter , "DistributionCenterDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightId", ::nFreightId, ::nFreightId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightIdV3", ::cFreightIdV3, ::cFreightIdV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightName", ::cFreightName, ::cFreightName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FreightTypeId", ::nFreightTypeId, ::nFreightTypeId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InvoiceNumber", ::cInvoiceNumber, ::cInvoiceNumber , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ManagementId", ::nManagementId, ::nManagementId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderId", ::nOrderId, ::nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderItems", ::oWSOrderItems, ::oWSOrderItems , "ArrayOfOrderItemDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderStatus", ::oWSOrderStatus, ::oWSOrderStatus , "OrderStatusDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderStatusId", ::cOrderStatusId, ::cOrderStatusId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ScheduledDate", ::cScheduledDate, ::cScheduledDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ScheduledShift", ::cScheduledShift, ::cScheduledShift , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StatusAdministratorId", ::nStatusAdministratorId, ::nStatusAdministratorId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StausChangeDate", ::cStausChangeDate, ::cStausChangeDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TrackingNumber", ::cTrackingNumber, ::cTrackingNumber , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderDeliveryDTO
	Local oNode6
	Local oNode15
	Local oNode16
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDateExpectedDelivery :=  WSAdvValue( oResponse,"_DATEEXPECTEDDELIVERY","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nDaysForDistributionCenterProcessing :=  WSAdvValue( oResponse,"_DAYSFORDISTRIBUTIONCENTERPROCESSING","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDaysForFreightDelivery :=  WSAdvValue( oResponse,"_DAYSFORFREIGHTDELIVERY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nDaysForStockProcessing :=  WSAdvValue( oResponse,"_DAYSFORSTOCKPROCESSING","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cDeliveryDate      :=  WSAdvValue( oResponse,"_DELIVERYDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode6 :=  WSAdvValue( oResponse,"_DISTRIBUTIONCENTER","DistributionCenterDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode6 != NIL
		::oWSDistributionCenter := Service_DistributionCenterDTO():New()
		::oWSDistributionCenter:SoapRecv(oNode6)
	EndIf
	::nFreightId         :=  WSAdvValue( oResponse,"_FREIGHTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cFreightIdV3       :=  WSAdvValue( oResponse,"_FREIGHTIDV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cFreightName       :=  WSAdvValue( oResponse,"_FREIGHTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFreightTypeId     :=  WSAdvValue( oResponse,"_FREIGHTTYPEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cInvoiceNumber     :=  WSAdvValue( oResponse,"_INVOICENUMBER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nManagementId      :=  WSAdvValue( oResponse,"_MANAGEMENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode15 :=  WSAdvValue( oResponse,"_ORDERITEMS","ArrayOfOrderItemDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode15 != NIL
		::oWSOrderItems := Service_ArrayOfOrderItemDTO():New()
		::oWSOrderItems:SoapRecv(oNode15)
	EndIf
	oNode16 :=  WSAdvValue( oResponse,"_ORDERSTATUS","OrderStatusDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode16 != NIL
		::oWSOrderStatus := Service_OrderStatusDTO():New()
		::oWSOrderStatus:SoapRecv(oNode16)
	EndIf
	::cOrderStatusId     :=  WSAdvValue( oResponse,"_ORDERSTATUSID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cScheduledDate     :=  WSAdvValue( oResponse,"_SCHEDULEDDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cScheduledShift    :=  WSAdvValue( oResponse,"_SCHEDULEDSHIFT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nStatusAdministratorId :=  WSAdvValue( oResponse,"_STATUSADMINISTRATORID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cStausChangeDate   :=  WSAdvValue( oResponse,"_STAUSCHANGEDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTrackingNumber    :=  WSAdvValue( oResponse,"_TRACKINGNUMBER","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure OrderInvoiceDTO

WSSTRUCT Service_OrderInvoiceDTO
	WSDATA   cCourier                  AS string OPTIONAL
	WSDATA   cEmbeddedInvoice          AS string OPTIONAL
	WSDATA   cInvoiceNumber            AS string OPTIONAL
	WSDATA   cInvoiceUrl               AS string OPTIONAL
	WSDATA   nInvoiceValue             AS decimal OPTIONAL
	WSDATA   cIssuanceDate             AS dateTime OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   cOrderIdV3                AS string OPTIONAL
	WSDATA   oWSStockKeepingUnits      AS Service_ArrayOfOrderInvoiceStockKeepingUnitDTO OPTIONAL
	WSDATA   cTrackingNumber           AS string OPTIONAL
	WSDATA   cTrackingUrl              AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderInvoiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderInvoiceDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderInvoiceDTO
	Local oClone := Service_OrderInvoiceDTO():NEW()
	oClone:cCourier             := ::cCourier
	oClone:cEmbeddedInvoice     := ::cEmbeddedInvoice
	oClone:cInvoiceNumber       := ::cInvoiceNumber
	oClone:cInvoiceUrl          := ::cInvoiceUrl
	oClone:nInvoiceValue        := ::nInvoiceValue
	oClone:cIssuanceDate        := ::cIssuanceDate
	oClone:nOrderId             := ::nOrderId
	oClone:cOrderIdV3           := ::cOrderIdV3
	oClone:oWSStockKeepingUnits := IIF(::oWSStockKeepingUnits = NIL , NIL , ::oWSStockKeepingUnits:Clone() )
	oClone:cTrackingNumber      := ::cTrackingNumber
	oClone:cTrackingUrl         := ::cTrackingUrl
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderInvoiceDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Courier", ::cCourier, ::cCourier , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EmbeddedInvoice", ::cEmbeddedInvoice, ::cEmbeddedInvoice , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InvoiceNumber", ::cInvoiceNumber, ::cInvoiceNumber , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InvoiceUrl", ::cInvoiceUrl, ::cInvoiceUrl , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InvoiceValue", ::nInvoiceValue, ::nInvoiceValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IssuanceDate", ::cIssuanceDate, ::cIssuanceDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderId", ::nOrderId, ::nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderIdV3", ::cOrderIdV3, ::cOrderIdV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnits", ::oWSStockKeepingUnits, ::oWSStockKeepingUnits , "ArrayOfOrderInvoiceStockKeepingUnitDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TrackingNumber", ::cTrackingNumber, ::cTrackingNumber , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TrackingUrl", ::cTrackingUrl, ::cTrackingUrl , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderInvoiceDTO
	Local oNode9
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCourier           :=  WSAdvValue( oResponse,"_COURIER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cEmbeddedInvoice   :=  WSAdvValue( oResponse,"_EMBEDDEDINVOICE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cInvoiceNumber     :=  WSAdvValue( oResponse,"_INVOICENUMBER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cInvoiceUrl        :=  WSAdvValue( oResponse,"_INVOICEURL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nInvoiceValue      :=  WSAdvValue( oResponse,"_INVOICEVALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cIssuanceDate      :=  WSAdvValue( oResponse,"_ISSUANCEDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cOrderIdV3         :=  WSAdvValue( oResponse,"_ORDERIDV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	oNode9 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITS","ArrayOfOrderInvoiceStockKeepingUnitDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode9 != NIL
		::oWSStockKeepingUnits := Service_ArrayOfOrderInvoiceStockKeepingUnitDTO():New()
		::oWSStockKeepingUnits:SoapRecv(oNode9)
	EndIf
	::cTrackingNumber    :=  WSAdvValue( oResponse,"_TRACKINGNUMBER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cTrackingUrl       :=  WSAdvValue( oResponse,"_TRACKINGURL","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure OrderPaymentDTO

WSSTRUCT Service_OrderPaymentDTO
	WSDATA   cAddressType              AS string OPTIONAL
	WSDATA   cCardFirst6Numbers        AS string OPTIONAL
	WSDATA   cCardLast4Numbers         AS string OPTIONAL
	WSDATA   cCardMonth                AS string OPTIONAL
	WSDATA   cCardName                 AS string OPTIONAL
	WSDATA   cCardNumber               AS string OPTIONAL
	WSDATA   cCardSecurityCode         AS string OPTIONAL
	WSDATA   cCardYear                 AS string OPTIONAL
	WSDATA   cCity                     AS string OPTIONAL
	WSDATA   cComplement               AS string OPTIONAL
	WSDATA   nCostWithInterest         AS decimal OPTIONAL
	WSDATA   cCountry                  AS string OPTIONAL
	WSDATA   cDate                     AS dateTime OPTIONAL
	WSDATA   nGiftCardId               AS int OPTIONAL
	WSDATA   cGiftCardRedemptionCode   AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nInstallmentValue         AS decimal OPTIONAL
	WSDATA   nInterest                 AS decimal OPTIONAL
	WSDATA   lIsValid                  AS boolean OPTIONAL
	WSDATA   cNeighborhood             AS string OPTIONAL
	WSDATA   nNumber                   AS int OPTIONAL
	WSDATA   cNumberV3                 AS string OPTIONAL
	WSDATA   nOrderId                  AS int OPTIONAL
	WSDATA   nOrderPaymentStatusId     AS int OPTIONAL
	WSDATA   cPaymentAuthorizationId   AS string OPTIONAL
	WSDATA   nPaymentId                AS int OPTIONAL
	WSDATA   cPaymentTransactionId     AS string OPTIONAL
	WSDATA   cPaymentUniqueSerialNumber AS string OPTIONAL
	WSDATA   nPlots                    AS int OPTIONAL
	WSDATA   cReferencePoint           AS string OPTIONAL
	WSDATA   cState                    AS string OPTIONAL
	WSDATA   cStreet                   AS string OPTIONAL
	WSDATA   cUrl                      AS string OPTIONAL
	WSDATA   cZipCode                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderPaymentDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderPaymentDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderPaymentDTO
	Local oClone := Service_OrderPaymentDTO():NEW()
	oClone:cAddressType         := ::cAddressType
	oClone:cCardFirst6Numbers   := ::cCardFirst6Numbers
	oClone:cCardLast4Numbers    := ::cCardLast4Numbers
	oClone:cCardMonth           := ::cCardMonth
	oClone:cCardName            := ::cCardName
	oClone:cCardNumber          := ::cCardNumber
	oClone:cCardSecurityCode    := ::cCardSecurityCode
	oClone:cCardYear            := ::cCardYear
	oClone:cCity                := ::cCity
	oClone:cComplement          := ::cComplement
	oClone:nCostWithInterest    := ::nCostWithInterest
	oClone:cCountry             := ::cCountry
	oClone:cDate                := ::cDate
	oClone:nGiftCardId          := ::nGiftCardId
	oClone:cGiftCardRedemptionCode := ::cGiftCardRedemptionCode
	oClone:nId                  := ::nId
	oClone:nInstallmentValue    := ::nInstallmentValue
	oClone:nInterest            := ::nInterest
	oClone:lIsValid             := ::lIsValid
	oClone:cNeighborhood        := ::cNeighborhood
	oClone:nNumber              := ::nNumber
	oClone:cNumberV3            := ::cNumberV3
	oClone:nOrderId             := ::nOrderId
	oClone:nOrderPaymentStatusId := ::nOrderPaymentStatusId
	oClone:cPaymentAuthorizationId := ::cPaymentAuthorizationId
	oClone:nPaymentId           := ::nPaymentId
	oClone:cPaymentTransactionId := ::cPaymentTransactionId
	oClone:cPaymentUniqueSerialNumber := ::cPaymentUniqueSerialNumber
	oClone:nPlots               := ::nPlots
	oClone:cReferencePoint      := ::cReferencePoint
	oClone:cState               := ::cState
	oClone:cStreet              := ::cStreet
	oClone:cUrl                 := ::cUrl
	oClone:cZipCode             := ::cZipCode
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderPaymentDTO
	Local cSoap := ""
	cSoap += WSSoapValue("AddressType", ::cAddressType, ::cAddressType , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardFirst6Numbers", ::cCardFirst6Numbers, ::cCardFirst6Numbers , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardLast4Numbers", ::cCardLast4Numbers, ::cCardLast4Numbers , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardMonth", ::cCardMonth, ::cCardMonth , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardName", ::cCardName, ::cCardName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardNumber", ::cCardNumber, ::cCardNumber , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardSecurityCode", ::cCardSecurityCode, ::cCardSecurityCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CardYear", ::cCardYear, ::cCardYear , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("City", ::cCity, ::cCity , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Complement", ::cComplement, ::cComplement , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CostWithInterest", ::nCostWithInterest, ::nCostWithInterest , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Country", ::cCountry, ::cCountry , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Date", ::cDate, ::cDate , "dateTime", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftCardId", ::nGiftCardId, ::nGiftCardId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftCardRedemptionCode", ::cGiftCardRedemptionCode, ::cGiftCardRedemptionCode , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("InstallmentValue", ::nInstallmentValue, ::nInstallmentValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Interest", ::nInterest, ::nInterest , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsValid", ::lIsValid, ::lIsValid , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Neighborhood", ::cNeighborhood, ::cNeighborhood , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Number", ::nNumber, ::nNumber , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NumberV3", ::cNumberV3, ::cNumberV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderId", ::nOrderId, ::nOrderId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderPaymentStatusId", ::nOrderPaymentStatusId, ::nOrderPaymentStatusId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PaymentAuthorizationId", ::cPaymentAuthorizationId, ::cPaymentAuthorizationId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PaymentId", ::nPaymentId, ::nPaymentId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PaymentTransactionId", ::cPaymentTransactionId, ::cPaymentTransactionId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PaymentUniqueSerialNumber", ::cPaymentUniqueSerialNumber, ::cPaymentUniqueSerialNumber , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Plots", ::nPlots, ::nPlots , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ReferencePoint", ::cReferencePoint, ::cReferencePoint , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("State", ::cState, ::cState , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Street", ::cStreet, ::cStreet , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Url", ::cUrl, ::cUrl , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ZipCode", ::cZipCode, ::cZipCode , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderPaymentDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAddressType       :=  WSAdvValue( oResponse,"_ADDRESSTYPE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardFirst6Numbers :=  WSAdvValue( oResponse,"_CARDFIRST6NUMBERS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardLast4Numbers  :=  WSAdvValue( oResponse,"_CARDLAST4NUMBERS","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardMonth         :=  WSAdvValue( oResponse,"_CARDMONTH","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardName          :=  WSAdvValue( oResponse,"_CARDNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardNumber        :=  WSAdvValue( oResponse,"_CARDNUMBER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardSecurityCode  :=  WSAdvValue( oResponse,"_CARDSECURITYCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCardYear          :=  WSAdvValue( oResponse,"_CARDYEAR","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cCity              :=  WSAdvValue( oResponse,"_CITY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cComplement        :=  WSAdvValue( oResponse,"_COMPLEMENT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nCostWithInterest  :=  WSAdvValue( oResponse,"_COSTWITHINTEREST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cCountry           :=  WSAdvValue( oResponse,"_COUNTRY","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cDate              :=  WSAdvValue( oResponse,"_DATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::nGiftCardId        :=  WSAdvValue( oResponse,"_GIFTCARDID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cGiftCardRedemptionCode :=  WSAdvValue( oResponse,"_GIFTCARDREDEMPTIONCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nInstallmentValue  :=  WSAdvValue( oResponse,"_INSTALLMENTVALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nInterest          :=  WSAdvValue( oResponse,"_INTEREST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsValid           :=  WSAdvValue( oResponse,"_ISVALID","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cNeighborhood      :=  WSAdvValue( oResponse,"_NEIGHBORHOOD","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nNumber            :=  WSAdvValue( oResponse,"_NUMBER","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cNumberV3          :=  WSAdvValue( oResponse,"_NUMBERV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nOrderId           :=  WSAdvValue( oResponse,"_ORDERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nOrderPaymentStatusId :=  WSAdvValue( oResponse,"_ORDERPAYMENTSTATUSID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cPaymentAuthorizationId :=  WSAdvValue( oResponse,"_PAYMENTAUTHORIZATIONID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nPaymentId         :=  WSAdvValue( oResponse,"_PAYMENTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cPaymentTransactionId :=  WSAdvValue( oResponse,"_PAYMENTTRANSACTIONID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cPaymentUniqueSerialNumber :=  WSAdvValue( oResponse,"_PAYMENTUNIQUESERIALNUMBER","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nPlots             :=  WSAdvValue( oResponse,"_PLOTS","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cReferencePoint    :=  WSAdvValue( oResponse,"_REFERENCEPOINT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cState             :=  WSAdvValue( oResponse,"_STATE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStreet            :=  WSAdvValue( oResponse,"_STREET","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cUrl               :=  WSAdvValue( oResponse,"_URL","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cZipCode           :=  WSAdvValue( oResponse,"_ZIPCODE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Enumeration OrderInteractionDTO.StatusIdEnum

WSSTRUCT Service_OrderInteractionDTO_StatusIdEnum
	WSDATA   Value                     AS string
	WSDATA   cValueType                AS string
	WSDATA   aValueList                AS Array Of string
	WSMETHOD NEW
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderInteractionDTO_StatusIdEnum
	::Value := NIL
	::cValueType := "string"
	::aValueList := {}
	aadd(::aValueList , "Pending" )
	aadd(::aValueList , "InProgress" )
	aadd(::aValueList , "Completed" )
Return Self

WSMETHOD SOAPSEND WSCLIENT Service_OrderInteractionDTO_StatusIdEnum
	Local cSoap := "" 
	cSoap += WSSoapValue("Value", ::Value, NIL , "string", .F. , .F., 3 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderInteractionDTO_StatusIdEnum
	::Value := NIL
	If oResponse = NIL ; Return ; Endif 
	::Value :=  oResponse:TEXT
Return 

WSMETHOD CLONE WSCLIENT Service_OrderInteractionDTO_StatusIdEnum
Local oClone := Service_OrderInteractionDTO_StatusIdEnum():New()
	oClone:Value := ::Value
Return oClone

// WSDL Data Structure ClientFieldDTO

WSSTRUCT Service_ClientFieldDTO
	WSDATA   cFieldGroup               AS string OPTIONAL
	WSDATA   nFieldGroupId             AS int OPTIONAL
	WSDATA   nFieldId                  AS int OPTIONAL
	WSDATA   nFieldValueId             AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsRequired               AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   cValue                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ClientFieldDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ClientFieldDTO
Return

WSMETHOD CLONE WSCLIENT Service_ClientFieldDTO
	Local oClone := Service_ClientFieldDTO():NEW()
	oClone:cFieldGroup          := ::cFieldGroup
	oClone:nFieldGroupId        := ::nFieldGroupId
	oClone:nFieldId             := ::nFieldId
	oClone:nFieldValueId        := ::nFieldValueId
	oClone:lIsActive            := ::lIsActive
	oClone:lIsRequired          := ::lIsRequired
	oClone:cName                := ::cName
	oClone:cValue               := ::cValue
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ClientFieldDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cFieldGroup        :=  WSAdvValue( oResponse,"_FIELDGROUP","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nFieldGroupId      :=  WSAdvValue( oResponse,"_FIELDGROUPID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nFieldId           :=  WSAdvValue( oResponse,"_FIELDID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nFieldValueId      :=  WSAdvValue( oResponse,"_FIELDVALUEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsRequired        :=  WSAdvValue( oResponse,"_ISREQUIRED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cValue             :=  WSAdvValue( oResponse,"_VALUE","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfFreightScheduledDateOptionDTO

WSSTRUCT Service_ArrayOfFreightScheduledDateOptionDTO
	WSDATA   oWSFreightScheduledDateOptionDTO AS Service_FreightScheduledDateOptionDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfFreightScheduledDateOptionDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfFreightScheduledDateOptionDTO
	::oWSFreightScheduledDateOptionDTO := {} // Array Of  Service_FREIGHTSCHEDULEDDATEOPTIONDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfFreightScheduledDateOptionDTO
	Local oClone := Service_ArrayOfFreightScheduledDateOptionDTO():NEW()
	oClone:oWSFreightScheduledDateOptionDTO := NIL
	If ::oWSFreightScheduledDateOptionDTO <> NIL 
		oClone:oWSFreightScheduledDateOptionDTO := {}
		aEval( ::oWSFreightScheduledDateOptionDTO , { |x| aadd( oClone:oWSFreightScheduledDateOptionDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfFreightScheduledDateOptionDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FREIGHTSCHEDULEDDATEOPTIONDTO","FreightScheduledDateOptionDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSFreightScheduledDateOptionDTO , Service_FreightScheduledDateOptionDTO():New() )
			::oWSFreightScheduledDateOptionDTO[len(::oWSFreightScheduledDateOptionDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure Ender

WSSTRUCT Service_Ender
	WSDATA   nCEP                      AS int OPTIONAL
	WSDATA   cUF                       AS string OPTIONAL
	WSDATA   ncMun                     AS int OPTIONAL
	WSDATA   ccPais                    AS string OPTIONAL
	WSDATA   nfone                     AS int OPTIONAL
	WSDATA   cnro                      AS string OPTIONAL
	WSDATA   cxBairro                  AS string OPTIONAL
	WSDATA   cxCpl                     AS string OPTIONAL
	WSDATA   cxLgr                     AS string OPTIONAL
	WSDATA   cxMun                     AS string OPTIONAL
	WSDATA   cxPais                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Ender
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Ender
Return

WSMETHOD CLONE WSCLIENT Service_Ender
	Local oClone := Service_Ender():NEW()
	oClone:nCEP                 := ::nCEP
	oClone:cUF                  := ::cUF
	oClone:ncMun                := ::ncMun
	oClone:ccPais               := ::ccPais
	oClone:nfone                := ::nfone
	oClone:cnro                 := ::cnro
	oClone:cxBairro             := ::cxBairro
	oClone:cxCpl                := ::cxCpl
	oClone:cxLgr                := ::cxLgr
	oClone:cxMun                := ::cxMun
	oClone:cxPais               := ::cxPais
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Ender
	Local cSoap := ""
	cSoap += WSSoapValue("CEP", ::nCEP, ::nCEP , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UF", ::cUF, ::cUF , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cMun", ::ncMun, ::ncMun , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cPais", ::ccPais, ::ccPais , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("fone", ::nfone, ::nfone , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("nro", ::cnro, ::cnro , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xBairro", ::cxBairro, ::cxBairro , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xCpl", ::cxCpl, ::cxCpl , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xLgr", ::cxLgr, ::cxLgr , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xMun", ::cxMun, ::cxMun , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xPais", ::cxPais, ::cxPais , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Imposto

WSSTRUCT Service_Imposto
	WSDATA   oWScofins                 AS Service_COFINS OPTIONAL
	WSDATA   oWSicms                   AS Service_ICMS OPTIONAL
	WSDATA   oWSpis                    AS Service_PIS OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Imposto
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Imposto
Return

WSMETHOD CLONE WSCLIENT Service_Imposto
	Local oClone := Service_Imposto():NEW()
	oClone:oWScofins            := IIF(::oWScofins = NIL , NIL , ::oWScofins:Clone() )
	oClone:oWSicms              := IIF(::oWSicms = NIL , NIL , ::oWSicms:Clone() )
	oClone:oWSpis               := IIF(::oWSpis = NIL , NIL , ::oWSpis:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Imposto
	Local cSoap := ""
	cSoap += WSSoapValue("cofins", ::oWScofins, ::oWScofins , "COFINS", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("icms", ::oWSicms, ::oWSicms , "ICMS", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("pis", ::oWSpis, ::oWSpis , "PIS", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Prod

WSSTRUCT Service_Prod
	WSDATA   nCFOP                     AS int OPTIONAL
	WSDATA   nNCM                      AS int OPTIONAL
	WSDATA   ncEAN                     AS int OPTIONAL
	WSDATA   ncEANTrib                 AS int OPTIONAL
	WSDATA   ccProd                    AS string OPTIONAL
	WSDATA   nindTot                   AS int OPTIONAL
	WSDATA   cqCom                     AS string OPTIONAL
	WSDATA   nqTrib                    AS int OPTIONAL
	WSDATA   cuCom                     AS string OPTIONAL
	WSDATA   cuTrib                    AS string OPTIONAL
	WSDATA   nvDesc                    AS decimal OPTIONAL
	WSDATA   nvProd                    AS decimal OPTIONAL
	WSDATA   nvUnCom                   AS decimal OPTIONAL
	WSDATA   nvUnTrib                  AS decimal OPTIONAL
	WSDATA   cxPrd                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Prod
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Prod
Return

WSMETHOD CLONE WSCLIENT Service_Prod
	Local oClone := Service_Prod():NEW()
	oClone:nCFOP                := ::nCFOP
	oClone:nNCM                 := ::nNCM
	oClone:ncEAN                := ::ncEAN
	oClone:ncEANTrib            := ::ncEANTrib
	oClone:ccProd               := ::ccProd
	oClone:nindTot              := ::nindTot
	oClone:cqCom                := ::cqCom
	oClone:nqTrib               := ::nqTrib
	oClone:cuCom                := ::cuCom
	oClone:cuTrib               := ::cuTrib
	oClone:nvDesc               := ::nvDesc
	oClone:nvProd               := ::nvProd
	oClone:nvUnCom              := ::nvUnCom
	oClone:nvUnTrib             := ::nvUnTrib
	oClone:cxPrd                := ::cxPrd
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Prod
	Local cSoap := ""
	cSoap += WSSoapValue("CFOP", ::nCFOP, ::nCFOP , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NCM", ::nNCM, ::nNCM , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cEAN", ::ncEAN, ::ncEAN , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cEANTrib", ::ncEANTrib, ::ncEANTrib , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("cProd", ::ccProd, ::ccProd , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("indTot", ::nindTot, ::nindTot , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("qCom", ::cqCom, ::cqCom , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("qTrib", ::nqTrib, ::nqTrib , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("uCom", ::cuCom, ::cuCom , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("uTrib", ::cuTrib, ::cuTrib , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vDesc", ::nvDesc, ::nvDesc , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vProd", ::nvProd, ::nvProd , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vUnCom", ::nvUnCom, ::nvUnCom , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vUnTrib", ::nvUnTrib, ::nvUnTrib , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xPrd", ::cxPrd, ::cxPrd , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ICMSTot

WSSTRUCT Service_ICMSTot
	WSDATA   nvBC                      AS decimal OPTIONAL
	WSDATA   nvBCST                    AS decimal OPTIONAL
	WSDATA   nvCOFINS                  AS decimal OPTIONAL
	WSDATA   nvDesc                    AS decimal OPTIONAL
	WSDATA   nvFrete                   AS decimal OPTIONAL
	WSDATA   nvICMS                    AS decimal OPTIONAL
	WSDATA   nvII                      AS decimal OPTIONAL
	WSDATA   nvIPI                     AS decimal OPTIONAL
	WSDATA   nvNF                      AS decimal OPTIONAL
	WSDATA   nvOutro                   AS decimal OPTIONAL
	WSDATA   nvPIS                     AS decimal OPTIONAL
	WSDATA   nvProd                    AS decimal OPTIONAL
	WSDATA   nvST                      AS decimal OPTIONAL
	WSDATA   nvSeg                     AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ICMSTot
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ICMSTot
Return

WSMETHOD CLONE WSCLIENT Service_ICMSTot
	Local oClone := Service_ICMSTot():NEW()
	oClone:nvBC                 := ::nvBC
	oClone:nvBCST               := ::nvBCST
	oClone:nvCOFINS             := ::nvCOFINS
	oClone:nvDesc               := ::nvDesc
	oClone:nvFrete              := ::nvFrete
	oClone:nvICMS               := ::nvICMS
	oClone:nvII                 := ::nvII
	oClone:nvIPI                := ::nvIPI
	oClone:nvNF                 := ::nvNF
	oClone:nvOutro              := ::nvOutro
	oClone:nvPIS                := ::nvPIS
	oClone:nvProd               := ::nvProd
	oClone:nvST                 := ::nvST
	oClone:nvSeg                := ::nvSeg
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ICMSTot
	Local cSoap := ""
	cSoap += WSSoapValue("vBC", ::nvBC, ::nvBC , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vBCST", ::nvBCST, ::nvBCST , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vCOFINS", ::nvCOFINS, ::nvCOFINS , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vDesc", ::nvDesc, ::nvDesc , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vFrete", ::nvFrete, ::nvFrete , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vICMS", ::nvICMS, ::nvICMS , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vII", ::nvII, ::nvII , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vIPI", ::nvIPI, ::nvIPI , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vNF", ::nvNF, ::nvNF , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vOutro", ::nvOutro, ::nvOutro , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vPIS", ::nvPIS, ::nvPIS , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vProd", ::nvProd, ::nvProd , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vST", ::nvST, ::nvST , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vSeg", ::nvSeg, ::nvSeg , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Transporta

WSSTRUCT Service_Transporta
	WSDATA   nCNPJ                     AS int OPTIONAL
	WSDATA   nIE                       AS int OPTIONAL
	WSDATA   cUF                       AS string OPTIONAL
	WSDATA   cxEnder                   AS string OPTIONAL
	WSDATA   cxMun                     AS string OPTIONAL
	WSDATA   cxNome                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Transporta
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Transporta
Return

WSMETHOD CLONE WSCLIENT Service_Transporta
	Local oClone := Service_Transporta():NEW()
	oClone:nCNPJ                := ::nCNPJ
	oClone:nIE                  := ::nIE
	oClone:cUF                  := ::cUF
	oClone:cxEnder              := ::cxEnder
	oClone:cxMun                := ::cxMun
	oClone:cxNome               := ::cxNome
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Transporta
	Local cSoap := ""
	cSoap += WSSoapValue("CNPJ", ::nCNPJ, ::nCNPJ , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IE", ::nIE, ::nIE , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UF", ::cUF, ::cUF , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xEnder", ::cxEnder, ::cxEnder , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xMun", ::cxMun, ::cxMun , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("xNome", ::cxNome, ::cxNome , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure Vol

WSSTRUCT Service_Vol
	WSDATA   cesp                      AS string OPTIONAL
	WSDATA   npesoB                    AS decimal OPTIONAL
	WSDATA   npesoL                    AS decimal OPTIONAL
	WSDATA   nqVol                     AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_Vol
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_Vol
Return

WSMETHOD CLONE WSCLIENT Service_Vol
	Local oClone := Service_Vol():NEW()
	oClone:cesp                 := ::cesp
	oClone:npesoB               := ::npesoB
	oClone:npesoL               := ::npesoL
	oClone:nqVol                := ::nqVol
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_Vol
	Local cSoap := ""
	cSoap += WSSoapValue("esp", ::cesp, ::cesp , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("pesoB", ::npesoB, ::npesoB , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("pesoL", ::npesoL, ::npesoL , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("qVol", ::nqVol, ::nqVol , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure DistributionCenterDTO

WSSTRUCT Service_DistributionCenterDTO
	WSDATA   nDistributionCenterID     AS int OPTIONAL
	WSDATA   nHandlingTimeCost         AS int OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   nPriority                 AS int OPTIONAL
	WSDATA   cTaxID                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_DistributionCenterDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_DistributionCenterDTO
Return

WSMETHOD CLONE WSCLIENT Service_DistributionCenterDTO
	Local oClone := Service_DistributionCenterDTO():NEW()
	oClone:nDistributionCenterID := ::nDistributionCenterID
	oClone:nHandlingTimeCost    := ::nHandlingTimeCost
	oClone:cName                := ::cName
	oClone:nPriority            := ::nPriority
	oClone:cTaxID               := ::cTaxID
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_DistributionCenterDTO
	Local cSoap := ""
	cSoap += WSSoapValue("DistributionCenterID", ::nDistributionCenterID, ::nDistributionCenterID , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("HandlingTimeCost", ::nHandlingTimeCost, ::nHandlingTimeCost , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Priority", ::nPriority, ::nPriority , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("TaxID", ::cTaxID, ::cTaxID , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_DistributionCenterDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nDistributionCenterID :=  WSAdvValue( oResponse,"_DISTRIBUTIONCENTERID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nHandlingTimeCost  :=  WSAdvValue( oResponse,"_HANDLINGTIMECOST","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nPriority          :=  WSAdvValue( oResponse,"_PRIORITY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cTaxID             :=  WSAdvValue( oResponse,"_TAXID","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfOrderItemDTO

WSSTRUCT Service_ArrayOfOrderItemDTO
	WSDATA   oWSOrderItemDTO           AS Service_OrderItemDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderItemDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderItemDTO
	::oWSOrderItemDTO      := {} // Array Of  Service_ORDERITEMDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderItemDTO
	Local oClone := Service_ArrayOfOrderItemDTO():NEW()
	oClone:oWSOrderItemDTO := NIL
	If ::oWSOrderItemDTO <> NIL 
		oClone:oWSOrderItemDTO := {}
		aEval( ::oWSOrderItemDTO , { |x| aadd( oClone:oWSOrderItemDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderItemDTO
	Local cSoap := ""
	aEval( ::oWSOrderItemDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderItemDTO", x , x , "OrderItemDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderItemDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERITEMDTO","OrderItemDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderItemDTO , Service_OrderItemDTO():New() )
			::oWSOrderItemDTO[len(::oWSOrderItemDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OrderStatusDTO

WSSTRUCT Service_OrderStatusDTO
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   cId                       AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderStatusDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderStatusDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderStatusDTO
	Local oClone := Service_OrderStatusDTO():NEW()
	oClone:cDescription         := ::cDescription
	oClone:cId                  := ::cId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderStatusDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::cId, ::cId , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderStatusDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cId                :=  WSAdvValue( oResponse,"_ID","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure ArrayOfOrderInvoiceStockKeepingUnitDTO

WSSTRUCT Service_ArrayOfOrderInvoiceStockKeepingUnitDTO
	WSDATA   oWSOrderInvoiceStockKeepingUnitDTO AS Service_OrderInvoiceStockKeepingUnitDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderInvoiceStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderInvoiceStockKeepingUnitDTO
	::oWSOrderInvoiceStockKeepingUnitDTO := {} // Array Of  Service_ORDERINVOICESTOCKKEEPINGUNITDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderInvoiceStockKeepingUnitDTO
	Local oClone := Service_ArrayOfOrderInvoiceStockKeepingUnitDTO():NEW()
	oClone:oWSOrderInvoiceStockKeepingUnitDTO := NIL
	If ::oWSOrderInvoiceStockKeepingUnitDTO <> NIL 
		oClone:oWSOrderInvoiceStockKeepingUnitDTO := {}
		aEval( ::oWSOrderInvoiceStockKeepingUnitDTO , { |x| aadd( oClone:oWSOrderInvoiceStockKeepingUnitDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderInvoiceStockKeepingUnitDTO
	Local cSoap := ""
	aEval( ::oWSOrderInvoiceStockKeepingUnitDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderInvoiceStockKeepingUnitDTO", x , x , "OrderInvoiceStockKeepingUnitDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderInvoiceStockKeepingUnitDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERINVOICESTOCKKEEPINGUNITDTO","OrderInvoiceStockKeepingUnitDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderInvoiceStockKeepingUnitDTO , Service_OrderInvoiceStockKeepingUnitDTO():New() )
			::oWSOrderInvoiceStockKeepingUnitDTO[len(::oWSOrderInvoiceStockKeepingUnitDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure FreightScheduledDateOptionDTO

WSSTRUCT Service_FreightScheduledDateOptionDTO
	WSDATA   oWSAvailablePeriods       AS Service_ArrayOfstring OPTIONAL
	WSDATA   cEndDate                  AS dateTime OPTIONAL
	WSDATA   cStartDate                AS dateTime OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_FreightScheduledDateOptionDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_FreightScheduledDateOptionDTO
Return

WSMETHOD CLONE WSCLIENT Service_FreightScheduledDateOptionDTO
	Local oClone := Service_FreightScheduledDateOptionDTO():NEW()
	oClone:oWSAvailablePeriods  := IIF(::oWSAvailablePeriods = NIL , NIL , ::oWSAvailablePeriods:Clone() )
	oClone:cEndDate             := ::cEndDate
	oClone:cStartDate           := ::cStartDate
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_FreightScheduledDateOptionDTO
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_AVAILABLEPERIODS","ArrayOfstring",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode1 != NIL
		::oWSAvailablePeriods := Service_ArrayOfstring():New()
		::oWSAvailablePeriods:SoapRecv(oNode1)
	EndIf
	::cEndDate           :=  WSAdvValue( oResponse,"_ENDDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
	::cStartDate         :=  WSAdvValue( oResponse,"_STARTDATE","dateTime",NIL,NIL,NIL,"S",NIL,"xs") 
Return

// WSDL Data Structure COFINS

WSSTRUCT Service_COFINS
	WSDATA   oWScOFINSAliq             AS Service_COFINSAliq OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_COFINS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_COFINS
Return

WSMETHOD CLONE WSCLIENT Service_COFINS
	Local oClone := Service_COFINS():NEW()
	oClone:oWScOFINSAliq        := IIF(::oWScOFINSAliq = NIL , NIL , ::oWScOFINSAliq:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_COFINS
	Local cSoap := ""
	cSoap += WSSoapValue("cOFINSAliq", ::oWScOFINSAliq, ::oWScOFINSAliq , "COFINSAliq", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ICMS

WSSTRUCT Service_ICMS
	WSDATA   oWSicms60                 AS Service_ICMS60 OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ICMS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ICMS
Return

WSMETHOD CLONE WSCLIENT Service_ICMS
	Local oClone := Service_ICMS():NEW()
	oClone:oWSicms60            := IIF(::oWSicms60 = NIL , NIL , ::oWSicms60:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ICMS
	Local cSoap := ""
	cSoap += WSSoapValue("icms60", ::oWSicms60, ::oWSicms60 , "ICMS60", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure PIS

WSSTRUCT Service_PIS
	WSDATA   oWSpisAliq                AS Service_PISAliq OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_PIS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_PIS
Return

WSMETHOD CLONE WSCLIENT Service_PIS
	Local oClone := Service_PIS():NEW()
	oClone:oWSpisAliq           := IIF(::oWSpisAliq = NIL , NIL , ::oWSpisAliq:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_PIS
	Local cSoap := ""
	cSoap += WSSoapValue("pisAliq", ::oWSpisAliq, ::oWSpisAliq , "PISAliq", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure OrderItemDTO

WSSTRUCT Service_OrderItemDTO
	WSDATA   nBuyTogetherDiscountId    AS int OPTIONAL
	WSDATA   nCost                     AS decimal OPTIONAL
	WSDATA   nCostOff                  AS decimal OPTIONAL
	WSDATA   nCupomValue               AS decimal OPTIONAL
	WSDATA   nCupomValueOff            AS decimal OPTIONAL
	WSDATA   oWSDiscounts              AS Service_ArrayOfOrderItemDiscountDTO OPTIONAL
	WSDATA   nGiftDiscountId           AS int OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsGift                   AS boolean OPTIONAL
	WSDATA   lIsKit                    AS boolean OPTIONAL
	WSDATA   lIsStockImpact            AS boolean OPTIONAL
	WSDATA   nItemId                   AS int OPTIONAL
	WSDATA   nListPrice                AS decimal OPTIONAL
	WSDATA   cMeasurementUnit          AS string OPTIONAL
	WSDATA   nOrderDeliveryId          AS int OPTIONAL
	WSDATA   oWSOrderItemServices      AS Service_ArrayOfOrderItemServiceDTO OPTIONAL
	WSDATA   nParentOrderItemId        AS int OPTIONAL
	WSDATA   nProductId                AS int OPTIONAL
	WSDATA   cProductRefId             AS string OPTIONAL
	WSDATA   cRefId                    AS string OPTIONAL
	WSDATA   nShippingCost             AS decimal OPTIONAL
	WSDATA   nShippingCostOff          AS decimal OPTIONAL
	WSDATA   nStockLikelyId            AS int OPTIONAL
	WSDATA   cStockLikelyIdV3          AS string OPTIONAL
	WSDATA   nUnitMultiplier           AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderItemDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderItemDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderItemDTO
	Local oClone := Service_OrderItemDTO():NEW()
	oClone:nBuyTogetherDiscountId := ::nBuyTogetherDiscountId
	oClone:nCost                := ::nCost
	oClone:nCostOff             := ::nCostOff
	oClone:nCupomValue          := ::nCupomValue
	oClone:nCupomValueOff       := ::nCupomValueOff
	oClone:oWSDiscounts         := IIF(::oWSDiscounts = NIL , NIL , ::oWSDiscounts:Clone() )
	oClone:nGiftDiscountId      := ::nGiftDiscountId
	oClone:nId                  := ::nId
	oClone:lIsGift              := ::lIsGift
	oClone:lIsKit               := ::lIsKit
	oClone:lIsStockImpact       := ::lIsStockImpact
	oClone:nItemId              := ::nItemId
	oClone:nListPrice           := ::nListPrice
	oClone:cMeasurementUnit     := ::cMeasurementUnit
	oClone:nOrderDeliveryId     := ::nOrderDeliveryId
	oClone:oWSOrderItemServices := IIF(::oWSOrderItemServices = NIL , NIL , ::oWSOrderItemServices:Clone() )
	oClone:nParentOrderItemId   := ::nParentOrderItemId
	oClone:nProductId           := ::nProductId
	oClone:cProductRefId        := ::cProductRefId
	oClone:cRefId               := ::cRefId
	oClone:nShippingCost        := ::nShippingCost
	oClone:nShippingCostOff     := ::nShippingCostOff
	oClone:nStockLikelyId       := ::nStockLikelyId
	oClone:cStockLikelyIdV3     := ::cStockLikelyIdV3
	oClone:nUnitMultiplier      := ::nUnitMultiplier
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderItemDTO
	Local cSoap := ""
	cSoap += WSSoapValue("BuyTogetherDiscountId", ::nBuyTogetherDiscountId, ::nBuyTogetherDiscountId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Cost", ::nCost, ::nCost , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CostOff", ::nCostOff, ::nCostOff , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CupomValue", ::nCupomValue, ::nCupomValue , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CupomValueOff", ::nCupomValueOff, ::nCupomValueOff , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Discounts", ::oWSDiscounts, ::oWSDiscounts , "ArrayOfOrderItemDiscountDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftDiscountId", ::nGiftDiscountId, ::nGiftDiscountId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsGift", ::lIsGift, ::lIsGift , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsKit", ::lIsKit, ::lIsKit , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsStockImpact", ::lIsStockImpact, ::lIsStockImpact , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ItemId", ::nItemId, ::nItemId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListPrice", ::nListPrice, ::nListPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("MeasurementUnit", ::cMeasurementUnit, ::cMeasurementUnit , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderDeliveryId", ::nOrderDeliveryId, ::nOrderDeliveryId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderItemServices", ::oWSOrderItemServices, ::oWSOrderItemServices , "ArrayOfOrderItemServiceDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ParentOrderItemId", ::nParentOrderItemId, ::nParentOrderItemId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProductId", ::nProductId, ::nProductId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ProductRefId", ::cProductRefId, ::cProductRefId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("RefId", ::cRefId, ::cRefId , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ShippingCost", ::nShippingCost, ::nShippingCost , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ShippingCostOff", ::nShippingCostOff, ::nShippingCostOff , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockLikelyId", ::nStockLikelyId, ::nStockLikelyId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockLikelyIdV3", ::cStockLikelyIdV3, ::cStockLikelyIdV3 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("UnitMultiplier", ::nUnitMultiplier, ::nUnitMultiplier , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderItemDTO
	Local oNode6
	Local oNode16
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nBuyTogetherDiscountId :=  WSAdvValue( oResponse,"_BUYTOGETHERDISCOUNTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCost              :=  WSAdvValue( oResponse,"_COST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCostOff           :=  WSAdvValue( oResponse,"_COSTOFF","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCupomValue        :=  WSAdvValue( oResponse,"_CUPOMVALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nCupomValueOff     :=  WSAdvValue( oResponse,"_CUPOMVALUEOFF","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode6 :=  WSAdvValue( oResponse,"_DISCOUNTS","ArrayOfOrderItemDiscountDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode6 != NIL
		::oWSDiscounts := Service_ArrayOfOrderItemDiscountDTO():New()
		::oWSDiscounts:SoapRecv(oNode6)
	EndIf
	::nGiftDiscountId    :=  WSAdvValue( oResponse,"_GIFTDISCOUNTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsGift            :=  WSAdvValue( oResponse,"_ISGIFT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsKit             :=  WSAdvValue( oResponse,"_ISKIT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsStockImpact     :=  WSAdvValue( oResponse,"_ISSTOCKIMPACT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nItemId            :=  WSAdvValue( oResponse,"_ITEMID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nListPrice         :=  WSAdvValue( oResponse,"_LISTPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cMeasurementUnit   :=  WSAdvValue( oResponse,"_MEASUREMENTUNIT","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nOrderDeliveryId   :=  WSAdvValue( oResponse,"_ORDERDELIVERYID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode16 :=  WSAdvValue( oResponse,"_ORDERITEMSERVICES","ArrayOfOrderItemServiceDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode16 != NIL
		::oWSOrderItemServices := Service_ArrayOfOrderItemServiceDTO():New()
		::oWSOrderItemServices:SoapRecv(oNode16)
	EndIf
	::nParentOrderItemId :=  WSAdvValue( oResponse,"_PARENTORDERITEMID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nProductId         :=  WSAdvValue( oResponse,"_PRODUCTID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cProductRefId      :=  WSAdvValue( oResponse,"_PRODUCTREFID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cRefId             :=  WSAdvValue( oResponse,"_REFID","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nShippingCost      :=  WSAdvValue( oResponse,"_SHIPPINGCOST","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nShippingCostOff   :=  WSAdvValue( oResponse,"_SHIPPINGCOSTOFF","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockLikelyId     :=  WSAdvValue( oResponse,"_STOCKLIKELYID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cStockLikelyIdV3   :=  WSAdvValue( oResponse,"_STOCKLIKELYIDV3","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nUnitMultiplier    :=  WSAdvValue( oResponse,"_UNITMULTIPLIER","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure OrderInvoiceStockKeepingUnitDTO

WSSTRUCT Service_OrderInvoiceStockKeepingUnitDTO
	WSDATA   nPrice                    AS decimal OPTIONAL
	WSDATA   nQuantity                 AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderInvoiceStockKeepingUnitDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderInvoiceStockKeepingUnitDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderInvoiceStockKeepingUnitDTO
	Local oClone := Service_OrderInvoiceStockKeepingUnitDTO():NEW()
	oClone:nPrice               := ::nPrice
	oClone:nQuantity            := ::nQuantity
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderInvoiceStockKeepingUnitDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Price", ::nPrice, ::nPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Quantity", ::nQuantity, ::nQuantity , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderInvoiceStockKeepingUnitDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nPrice             :=  WSAdvValue( oResponse,"_PRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nQuantity          :=  WSAdvValue( oResponse,"_QUANTITY","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure COFINSAliq

WSSTRUCT Service_COFINSAliq
	WSDATA   nCST                      AS int OPTIONAL
	WSDATA   npCOFINS                  AS decimal OPTIONAL
	WSDATA   nvBC                      AS decimal OPTIONAL
	WSDATA   nvCOFINS                  AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_COFINSAliq
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_COFINSAliq
Return

WSMETHOD CLONE WSCLIENT Service_COFINSAliq
	Local oClone := Service_COFINSAliq():NEW()
	oClone:nCST                 := ::nCST
	oClone:npCOFINS             := ::npCOFINS
	oClone:nvBC                 := ::nvBC
	oClone:nvCOFINS             := ::nvCOFINS
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_COFINSAliq
	Local cSoap := ""
	cSoap += WSSoapValue("CST", ::nCST, ::nCST , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("pCOFINS", ::npCOFINS, ::npCOFINS , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vBC", ::nvBC, ::nvBC , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vCOFINS", ::nvCOFINS, ::nvCOFINS , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ICMS60

WSSTRUCT Service_ICMS60
	WSDATA   nCST                      AS int OPTIONAL
	WSDATA   norig                     AS int OPTIONAL
	WSDATA   nvBCSTRet                 AS decimal OPTIONAL
	WSDATA   nvICMSSTRet               AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ICMS60
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ICMS60
Return

WSMETHOD CLONE WSCLIENT Service_ICMS60
	Local oClone := Service_ICMS60():NEW()
	oClone:nCST                 := ::nCST
	oClone:norig                := ::norig
	oClone:nvBCSTRet            := ::nvBCSTRet
	oClone:nvICMSSTRet          := ::nvICMSSTRet
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ICMS60
	Local cSoap := ""
	cSoap += WSSoapValue("CST", ::nCST, ::nCST , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("orig", ::norig, ::norig , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vBCSTRet", ::nvBCSTRet, ::nvBCSTRet , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vICMSSTRet", ::nvICMSSTRet, ::nvICMSSTRet , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure PISAliq

WSSTRUCT Service_PISAliq
	WSDATA   nCST                      AS int OPTIONAL
	WSDATA   npPIS                     AS decimal OPTIONAL
	WSDATA   nvBC                      AS decimal OPTIONAL
	WSDATA   nvPIS                     AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_PISAliq
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_PISAliq
Return

WSMETHOD CLONE WSCLIENT Service_PISAliq
	Local oClone := Service_PISAliq():NEW()
	oClone:nCST                 := ::nCST
	oClone:npPIS                := ::npPIS
	oClone:nvBC                 := ::nvBC
	oClone:nvPIS                := ::nvPIS
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_PISAliq
	Local cSoap := ""
	cSoap += WSSoapValue("CST", ::nCST, ::nCST , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("pPIS", ::npPIS, ::npPIS , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vBC", ::nvBC, ::nvBC , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("vPIS", ::nvPIS, ::nvPIS , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ArrayOfOrderItemDiscountDTO

WSSTRUCT Service_ArrayOfOrderItemDiscountDTO
	WSDATA   oWSOrderItemDiscountDTO   AS Service_OrderItemDiscountDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderItemDiscountDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderItemDiscountDTO
	::oWSOrderItemDiscountDTO := {} // Array Of  Service_ORDERITEMDISCOUNTDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderItemDiscountDTO
	Local oClone := Service_ArrayOfOrderItemDiscountDTO():NEW()
	oClone:oWSOrderItemDiscountDTO := NIL
	If ::oWSOrderItemDiscountDTO <> NIL 
		oClone:oWSOrderItemDiscountDTO := {}
		aEval( ::oWSOrderItemDiscountDTO , { |x| aadd( oClone:oWSOrderItemDiscountDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderItemDiscountDTO
	Local cSoap := ""
	aEval( ::oWSOrderItemDiscountDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderItemDiscountDTO", x , x , "OrderItemDiscountDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderItemDiscountDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERITEMDISCOUNTDTO","OrderItemDiscountDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderItemDiscountDTO , Service_OrderItemDiscountDTO():New() )
			::oWSOrderItemDiscountDTO[len(::oWSOrderItemDiscountDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfOrderItemServiceDTO

WSSTRUCT Service_ArrayOfOrderItemServiceDTO
	WSDATA   oWSOrderItemServiceDTO    AS Service_OrderItemServiceDTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ArrayOfOrderItemServiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ArrayOfOrderItemServiceDTO
	::oWSOrderItemServiceDTO := {} // Array Of  Service_ORDERITEMSERVICEDTO():New()
Return

WSMETHOD CLONE WSCLIENT Service_ArrayOfOrderItemServiceDTO
	Local oClone := Service_ArrayOfOrderItemServiceDTO():NEW()
	oClone:oWSOrderItemServiceDTO := NIL
	If ::oWSOrderItemServiceDTO <> NIL 
		oClone:oWSOrderItemServiceDTO := {}
		aEval( ::oWSOrderItemServiceDTO , { |x| aadd( oClone:oWSOrderItemServiceDTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ArrayOfOrderItemServiceDTO
	Local cSoap := ""
	aEval( ::oWSOrderItemServiceDTO , {|x| cSoap := cSoap  +  WSSoapValue("OrderItemServiceDTO", x , x , "OrderItemServiceDTO", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ArrayOfOrderItemServiceDTO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ORDERITEMSERVICEDTO","OrderItemServiceDTO",{},NIL,.T.,"O",NIL,"xs") 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSOrderItemServiceDTO , Service_OrderItemServiceDTO():New() )
			::oWSOrderItemServiceDTO[len(::oWSOrderItemServiceDTO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure OrderItemDiscountDTO

WSSTRUCT Service_OrderItemDiscountDTO
	WSDATA   cDiscountName             AS string OPTIONAL
	WSDATA   lIsPercentual             AS boolean OPTIONAL
	WSDATA   nValue                    AS decimal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderItemDiscountDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderItemDiscountDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderItemDiscountDTO
	Local oClone := Service_OrderItemDiscountDTO():NEW()
	oClone:cDiscountName        := ::cDiscountName
	oClone:lIsPercentual        := ::lIsPercentual
	oClone:nValue               := ::nValue
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderItemDiscountDTO
	Local cSoap := ""
	cSoap += WSSoapValue("DiscountName", ::cDiscountName, ::cDiscountName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsPercentual", ::lIsPercentual, ::lIsPercentual , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Value", ::nValue, ::nValue , "decimal", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderItemDiscountDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDiscountName      :=  WSAdvValue( oResponse,"_DISCOUNTNAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::lIsPercentual      :=  WSAdvValue( oResponse,"_ISPERCENTUAL","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::nValue             :=  WSAdvValue( oResponse,"_VALUE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure OrderItemServiceDTO

WSSTRUCT Service_OrderItemServiceDTO
	WSDATA   nArchiveId                AS int OPTIONAL
	WSDATA   cGiftCardFrom             AS string OPTIONAL
	WSDATA   cGiftCardMessage          AS string OPTIONAL
	WSDATA   cGiftCardTo               AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nListPrice                AS decimal OPTIONAL
	WSDATA   nOrderItemId              AS int OPTIONAL
	WSDATA   nPrice                    AS decimal OPTIONAL
	WSDATA   oWSStockKeepingUnitService AS Service_StockKeepingUnitServiceDTO OPTIONAL
	WSDATA   nStockKeepingUnitServiceId AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_OrderItemServiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_OrderItemServiceDTO
Return

WSMETHOD CLONE WSCLIENT Service_OrderItemServiceDTO
	Local oClone := Service_OrderItemServiceDTO():NEW()
	oClone:nArchiveId           := ::nArchiveId
	oClone:cGiftCardFrom        := ::cGiftCardFrom
	oClone:cGiftCardMessage     := ::cGiftCardMessage
	oClone:cGiftCardTo          := ::cGiftCardTo
	oClone:nId                  := ::nId
	oClone:nListPrice           := ::nListPrice
	oClone:nOrderItemId         := ::nOrderItemId
	oClone:nPrice               := ::nPrice
	oClone:oWSStockKeepingUnitService := IIF(::oWSStockKeepingUnitService = NIL , NIL , ::oWSStockKeepingUnitService:Clone() )
	oClone:nStockKeepingUnitServiceId := ::nStockKeepingUnitServiceId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_OrderItemServiceDTO
	Local cSoap := ""
	cSoap += WSSoapValue("ArchiveId", ::nArchiveId, ::nArchiveId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftCardFrom", ::cGiftCardFrom, ::cGiftCardFrom , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftCardMessage", ::cGiftCardMessage, ::cGiftCardMessage , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("GiftCardTo", ::cGiftCardTo, ::cGiftCardTo , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListPrice", ::nListPrice, ::nListPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("OrderItemId", ::nOrderItemId, ::nOrderItemId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Price", ::nPrice, ::nPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitService", ::oWSStockKeepingUnitService, ::oWSStockKeepingUnitService , "StockKeepingUnitServiceDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitServiceId", ::nStockKeepingUnitServiceId, ::nStockKeepingUnitServiceId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_OrderItemServiceDTO
	Local oNode9
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nArchiveId         :=  WSAdvValue( oResponse,"_ARCHIVEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::cGiftCardFrom      :=  WSAdvValue( oResponse,"_GIFTCARDFROM","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cGiftCardMessage   :=  WSAdvValue( oResponse,"_GIFTCARDMESSAGE","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::cGiftCardTo        :=  WSAdvValue( oResponse,"_GIFTCARDTO","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nListPrice         :=  WSAdvValue( oResponse,"_LISTPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::nOrderItemId       :=  WSAdvValue( oResponse,"_ORDERITEMID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nPrice             :=  WSAdvValue( oResponse,"_PRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode9 :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITSERVICE","StockKeepingUnitServiceDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode9 != NIL
		::oWSStockKeepingUnitService := Service_StockKeepingUnitServiceDTO():New()
		::oWSStockKeepingUnitService:SoapRecv(oNode9)
	EndIf
	::nStockKeepingUnitServiceId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITSERVICEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure StockKeepingUnitServiceDTO

WSSTRUCT Service_StockKeepingUnitServiceDTO
	WSDATA   cDescription              AS string OPTIONAL
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   nServiceId                AS int OPTIONAL
	WSDATA   oWSVtexPrice           AS Service_ServicePriceDTO OPTIONAL
	WSDATA   nServicePriceId           AS int OPTIONAL
	WSDATA   nStockKeepingUnitId       AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_StockKeepingUnitServiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_StockKeepingUnitServiceDTO
Return

WSMETHOD CLONE WSCLIENT Service_StockKeepingUnitServiceDTO
	Local oClone := Service_StockKeepingUnitServiceDTO():NEW()
	oClone:cDescription         := ::cDescription
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:cName                := ::cName
	oClone:nServiceId           := ::nServiceId
	oClone:oWSVtexPrice      := IIF(::oWSVtexPrice = NIL , NIL , ::oWSVtexPrice:Clone() )
	oClone:nServicePriceId      := ::nServicePriceId
	oClone:nStockKeepingUnitId  := ::nStockKeepingUnitId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_StockKeepingUnitServiceDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Description", ::cDescription, ::cDescription , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ServiceId", ::nServiceId, ::nServiceId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ServicePrice", ::oWSVtexPrice, ::oWSVtexPrice , "ServicePriceDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ServicePriceId", ::nServicePriceId, ::nServicePriceId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("StockKeepingUnitId", ::nStockKeepingUnitId, ::nStockKeepingUnitId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_StockKeepingUnitServiceDTO
	Local oNode6
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDescription       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nServiceId         :=  WSAdvValue( oResponse,"_SERVICEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode6 :=  WSAdvValue( oResponse,"_SERVICEPRICE","ServicePriceDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode6 != NIL
		::oWSVtexPrice := Service_ServicePriceDTO():New()
		::oWSVtexPrice:SoapRecv(oNode6)
	EndIf
	::nServicePriceId    :=  WSAdvValue( oResponse,"_SERVICEPRICEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nStockKeepingUnitId :=  WSAdvValue( oResponse,"_STOCKKEEPINGUNITID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ServicePriceDTO

WSSTRUCT Service_ServicePriceDTO
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   nListPrice                AS decimal OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSDATA   nPrice                    AS decimal OPTIONAL
	WSDATA   oWSVtex                AS Service_ServiceDTO OPTIONAL
	WSDATA   nServiceId                AS int OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ServicePriceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ServicePriceDTO
Return

WSMETHOD CLONE WSCLIENT Service_ServicePriceDTO
	Local oClone := Service_ServicePriceDTO():NEW()
	oClone:nId                  := ::nId
	oClone:nListPrice           := ::nListPrice
	oClone:cName                := ::cName
	oClone:nPrice               := ::nPrice
	oClone:oWSVtex           := IIF(::oWSVtex = NIL , NIL , ::oWSVtex:Clone() )
	oClone:nServiceId           := ::nServiceId
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ServicePriceDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ListPrice", ::nListPrice, ::nListPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Price", ::nPrice, ::nPrice , "decimal", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Service", ::oWSVtex, ::oWSVtex , "ServiceDTO", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ServiceId", ::nServiceId, ::nServiceId , "int", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ServicePriceDTO
	Local oNode5
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::nListPrice         :=  WSAdvValue( oResponse,"_LISTPRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
	::nPrice             :=  WSAdvValue( oResponse,"_PRICE","decimal",NIL,NIL,NIL,"N",NIL,"xs") 
	oNode5 :=  WSAdvValue( oResponse,"_SERVICE","ServiceDTO",NIL,NIL,NIL,"O",NIL,"xs") 
	If oNode5 != NIL
		::oWSVtex := Service_ServiceDTO():New()
		::oWSVtex:SoapRecv(oNode5)
	EndIf
	::nServiceId         :=  WSAdvValue( oResponse,"_SERVICEID","int",NIL,NIL,NIL,"N",NIL,"xs") 
Return

// WSDL Data Structure ServiceDTO

WSSTRUCT Service_ServiceDTO
	WSDATA   nId                       AS int OPTIONAL
	WSDATA   lIsActive                 AS boolean OPTIONAL
	WSDATA   lIsFile                   AS boolean OPTIONAL
	WSDATA   lIsGiftCard               AS boolean OPTIONAL
	WSDATA   lIsRequired               AS boolean OPTIONAL
	WSDATA   lIsVisibleOnCart          AS boolean OPTIONAL
	WSDATA   lIsVisibleOnProduct       AS boolean OPTIONAL
	WSDATA   lIsVisibleOnService       AS boolean OPTIONAL
	WSDATA   cName                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT Service_ServiceDTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT Service_ServiceDTO
Return

WSMETHOD CLONE WSCLIENT Service_ServiceDTO
	Local oClone := Service_ServiceDTO():NEW()
	oClone:nId                  := ::nId
	oClone:lIsActive            := ::lIsActive
	oClone:lIsFile              := ::lIsFile
	oClone:lIsGiftCard          := ::lIsGiftCard
	oClone:lIsRequired          := ::lIsRequired
	oClone:lIsVisibleOnCart     := ::lIsVisibleOnCart
	oClone:lIsVisibleOnProduct  := ::lIsVisibleOnProduct
	oClone:lIsVisibleOnService  := ::lIsVisibleOnService
	oClone:cName                := ::cName
Return oClone

WSMETHOD SOAPSEND WSCLIENT Service_ServiceDTO
	Local cSoap := ""
	cSoap += WSSoapValue("Id", ::nId, ::nId , "int", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsActive", ::lIsActive, ::lIsActive , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsFile", ::lIsFile, ::lIsFile , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsGiftCard", ::lIsGiftCard, ::lIsGiftCard , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsRequired", ::lIsRequired, ::lIsRequired , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsVisibleOnCart", ::lIsVisibleOnCart, ::lIsVisibleOnCart , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsVisibleOnProduct", ::lIsVisibleOnProduct, ::lIsVisibleOnProduct , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("IsVisibleOnService", ::lIsVisibleOnService, ::lIsVisibleOnService , "boolean", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("Name", ::cName, ::cName , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT Service_ServiceDTO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nId                :=  WSAdvValue( oResponse,"_ID","int",NIL,NIL,NIL,"N",NIL,"xs") 
	::lIsActive          :=  WSAdvValue( oResponse,"_ISACTIVE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsFile            :=  WSAdvValue( oResponse,"_ISFILE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsGiftCard        :=  WSAdvValue( oResponse,"_ISGIFTCARD","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsRequired        :=  WSAdvValue( oResponse,"_ISREQUIRED","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsVisibleOnCart   :=  WSAdvValue( oResponse,"_ISVISIBLEONCART","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsVisibleOnProduct :=  WSAdvValue( oResponse,"_ISVISIBLEONPRODUCT","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::lIsVisibleOnService :=  WSAdvValue( oResponse,"_ISVISIBLEONSERVICE","boolean",NIL,NIL,NIL,"L",NIL,"xs") 
	::cName              :=  WSAdvValue( oResponse,"_NAME","string",NIL,NIL,NIL,"S",NIL,"xs") 
Return