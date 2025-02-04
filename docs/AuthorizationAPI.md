# AuthorizationAPI

All URIs are relative to *https://smcmaster-api.smc.nsk-k8s.loymax.net/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAuthToken**](AuthorizationAPI.md#getauthtoken) | **POST** /token | Авторизация в системе SMC


# **getAuthToken**
```swift
    open class func getAuthToken(getAuthTokenRequest: GetAuthTokenRequest, completion: @escaping (_ data: GetAuthToken200Response?, _ error: Error?) -> Void)
```

Авторизация в системе SMC

Получение токена для авторизации в системе SMC.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommunications

let getAuthTokenRequest = getAuthToken_request(data: getAuthToken_request_data(attributes: getAuthToken_request_data_attributes(username: "username_example", password: "password_example"))) // GetAuthTokenRequest | Учетные данные для получения токена.

// Авторизация в системе SMC
AuthorizationAPI.getAuthToken(getAuthTokenRequest: getAuthTokenRequest) { (response, error) in
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
 **getAuthTokenRequest** | [**GetAuthTokenRequest**](GetAuthTokenRequest.md) | Учетные данные для получения токена. | 

### Return type

[**GetAuthToken200Response**](GetAuthToken200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

