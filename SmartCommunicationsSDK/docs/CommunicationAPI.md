# CommunicationAPI

All URIs are relative to *https://smcmaster-api.smc.nsk-k8s.loymax.net/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**logPushEvent**](CommunicationAPI.md#logpushevent) | **POST** /communication/{type}/events | Передать в Смарт факт показа (открытия) пуша


# **logPushEvent**
```swift
    open class func logPushEvent(type: String, logPushEventRequest: LogPushEventRequest? = nil, completion: @escaping (_ data: LogPushEvent200Response?, _ error: Error?) -> Void)
```

Передать в Смарт факт показа (открытия) пуша

Передать факт показа (открытия) пуша

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommunications

let type = "type_example" // String | Тип коммуникации (email/sms/push/bot)
let logPushEventRequest = logPushEvent_request(data: [logPushEvent_request_data_inner(type: "type_example", messageId: "messageId_example", externalClientId: "externalClientId_example")]) // LogPushEventRequest |  (optional)

// Передать в Смарт факт показа (открытия) пуша
CommunicationAPI.logPushEvent(type: type, logPushEventRequest: logPushEventRequest) { (response, error) in
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
 **type** | **String** | Тип коммуникации (email/sms/push/bot) | 
 **logPushEventRequest** | [**LogPushEventRequest**](LogPushEventRequest.md) |  | [optional] 

### Return type

[**LogPushEvent200Response**](LogPushEvent200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

