# CustomerAPI

All URIs are relative to *https://smcmaster-api.smc.nsk-k8s.loymax.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addCustomerContactToken**](CustomerAPI.md#addcustomercontacttoken) | **POST** /customer/{id}/contact | Передать в Смарт полученный от APNS/FCM/rustore/HuaweiPushToolkit токен
[**getCustomerNotificationStatus**](CustomerAPI.md#getcustomernotificationstatus) | **GET** /customer/{id}/channel | Получить из Смарта статус разрешения на уведомления клиенту
[**getCustomerSubscriptionCategories**](CustomerAPI.md#getcustomersubscriptioncategories) | **GET** /customer/{id}/subscribe | Получить из Смарта статус подписки клиента на категории рассылок
[**modifyCustomerSubscriptionCategories**](CustomerAPI.md#modifycustomersubscriptioncategories) | **PATCH** /customer/{id}/subscribe | Передать в Смарт статус подписки на категории
[**setCustomerNotificationStatus**](CustomerAPI.md#setcustomernotificationstatus) | **POST** /customer/{id}/channel | Передать в Смарт статус разрешения на уведомления клиенту


# **addCustomerContactToken**
```swift
    open class func addCustomerContactToken(id: String, addCustomerContactTokenRequest: AddCustomerContactTokenRequest? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Передать в Смарт полученный от APNS/FCM/rustore/HuaweiPushToolkit токен

Вставить контактные данные клиента

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommSDK

let id = "id_example" // String | Внешний идентификатор клиента (client_external_id)
let addCustomerContactTokenRequest = addCustomerContactToken_request(data: addCustomerContactToken_request_data(attributes: addCustomerContactToken_request_data_attributes(contacts: [addCustomerContactToken_request_data_attributes_contacts_inner(type: "type_example", subtype: "subtype_example", value: "value_example", device: "device_example")]))) // AddCustomerContactTokenRequest | Тело запроса должно содрежать массив контактных данных, где `type` и `value` обязательные (optional)

// Передать в Смарт полученный от APNS/FCM/rustore/HuaweiPushToolkit токен
CustomerAPI.addCustomerContactToken(id: id, addCustomerContactTokenRequest: addCustomerContactTokenRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** | Внешний идентификатор клиента (client_external_id) | 
 **addCustomerContactTokenRequest** | [**AddCustomerContactTokenRequest**](AddCustomerContactTokenRequest.md) | Тело запроса должно содрежать массив контактных данных, где &#x60;type&#x60; и &#x60;value&#x60; обязательные | [optional] 

### Return type

Void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCustomerNotificationStatus**
```swift
    open class func getCustomerNotificationStatus(id: String, completion: @escaping (_ data: GetCustomerNotificationStatus200Response?, _ error: Error?) -> Void)
```

Получить из Смарта статус разрешения на уведомления клиенту

Возвращает разрешения на уведомления клиенту

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommSDK

let id = "id_example" // String | Внешний идентификатор клиента (client_external_id)

// Получить из Смарта статус разрешения на уведомления клиенту
CustomerAPI.getCustomerNotificationStatus(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** | Внешний идентификатор клиента (client_external_id) | 

### Return type

[**GetCustomerNotificationStatus200Response**](GetCustomerNotificationStatus200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCustomerSubscriptionCategories**
```swift
    open class func getCustomerSubscriptionCategories(id: String, completion: @escaping (_ data: GetCustomerSubscriptionCategories200Response?, _ error: Error?) -> Void)
```

Получить из Смарта статус подписки клиента на категории рассылок

Внимание! Если клиент не подписан на какую-либо из категорий - она не будет отображаться                (`data.attributes` динамическое).                В случае полного отсутствия подписок у клиента - вернется пустой массив `attributes`

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommSDK

let id = "id_example" // String | Внешний идентификатор клиента (client_external_id)

// Получить из Смарта статус подписки клиента на категории рассылок
CustomerAPI.getCustomerSubscriptionCategories(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** | Внешний идентификатор клиента (client_external_id) | 

### Return type

[**GetCustomerSubscriptionCategories200Response**](GetCustomerSubscriptionCategories200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **modifyCustomerSubscriptionCategories**
```swift
    open class func modifyCustomerSubscriptionCategories(id: String, modifyCustomerSubscriptionCategoriesRequest: ModifyCustomerSubscriptionCategoriesRequest? = nil, completion: @escaping (_ data: SetCustomerNotificationStatus200Response?, _ error: Error?) -> Void)
```

Передать в Смарт статус подписки на категории



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommSDK

let id = "id_example" // String | Внешний идентификатор клиента (client_external_id)
let modifyCustomerSubscriptionCategoriesRequest = modifyCustomerSubscriptionCategories_request(data: modifyCustomerSubscriptionCategories_request_data(attributes: modifyCustomerSubscriptionCategories_request_data_attributes(categories: modifyCustomerSubscriptionCategories_request_data_attributes_categories(mailingCode: modifyCustomerSubscriptionCategories_request_data_attributes_categories_mailingCode(email: "email_example", sms: "sms_example", push: "push_example", messengertelegram: "messengertelegram_example", messengerwhatsapp: "messengerwhatsapp_example"))))) // ModifyCustomerSubscriptionCategoriesRequest | В `categories` передаются одна или более категорий рассылок, содержащей пары ключ-значение,                    где ключ - это код категории рассылки (`mailingCode`), а значение - это объект, содержащий пары ключ-значение, где                    ключ - это тип массовых рассылок, а значение - статус подписки (`Y` - подписан, `N` - отписан, `ND` - удалить из категории) (optional)

// Передать в Смарт статус подписки на категории
CustomerAPI.modifyCustomerSubscriptionCategories(id: id, modifyCustomerSubscriptionCategoriesRequest: modifyCustomerSubscriptionCategoriesRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** | Внешний идентификатор клиента (client_external_id) | 
 **modifyCustomerSubscriptionCategoriesRequest** | [**ModifyCustomerSubscriptionCategoriesRequest**](ModifyCustomerSubscriptionCategoriesRequest.md) | В &#x60;categories&#x60; передаются одна или более категорий рассылок, содержащей пары ключ-значение,                    где ключ - это код категории рассылки (&#x60;mailingCode&#x60;), а значение - это объект, содержащий пары ключ-значение, где                    ключ - это тип массовых рассылок, а значение - статус подписки (&#x60;Y&#x60; - подписан, &#x60;N&#x60; - отписан, &#x60;ND&#x60; - удалить из категории) | [optional] 

### Return type

[**SetCustomerNotificationStatus200Response**](SetCustomerNotificationStatus200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setCustomerNotificationStatus**
```swift
    open class func setCustomerNotificationStatus(id: String, setCustomerNotificationStatusRequest: SetCustomerNotificationStatusRequest? = nil, completion: @escaping (_ data: SetCustomerNotificationStatus200Response?, _ error: Error?) -> Void)
```

Передать в Смарт статус разрешения на уведомления клиенту

Изменить/добавить подписки клиента на каналы коммуникаций

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommSDK

let id = "id_example" // String | Внешний идентификатор клиента (client_external_id)
let setCustomerNotificationStatusRequest = setCustomerNotificationStatus_request(data: setCustomerNotificationStatus_request_data(attributes: setCustomerNotificationStatus_request_data_attributes(email: "email_example", push: "push_example", sms: "sms_example"))) // SetCustomerNotificationStatusRequest | Атрибут должен содрежать пары ключ-значение, где ключ - это тип канала коммуникации,                    а значение - это статус разрешения на уведомления клиенту (optional)

// Передать в Смарт статус разрешения на уведомления клиенту
CustomerAPI.setCustomerNotificationStatus(id: id, setCustomerNotificationStatusRequest: setCustomerNotificationStatusRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** | Внешний идентификатор клиента (client_external_id) | 
 **setCustomerNotificationStatusRequest** | [**SetCustomerNotificationStatusRequest**](SetCustomerNotificationStatusRequest.md) | Атрибут должен содрежать пары ключ-значение, где ключ - это тип канала коммуникации,                    а значение - это статус разрешения на уведомления клиенту | [optional] 

### Return type

[**SetCustomerNotificationStatus200Response**](SetCustomerNotificationStatus200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

