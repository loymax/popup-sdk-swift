# AuthorizationAPI

All URIs are relative to *https://smcmaster-api.smc.nsk-k8s.loymax.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**generateAccessToken**](AuthorizationAPI.md#generateaccesstoken) | **POST** /token | Авторизация в системе SMC


# **generateAccessToken**
```swift
    open class func generateAccessToken(generateAccessTokenRequest: GenerateAccessTokenRequest? = nil, completion: @escaping (_ data: GenerateAccessToken200Response?, _ error: Error?) -> Void)
```

Авторизация в системе SMC

Получение токена для авторизации в системе SMC. Для использования скопируйте полученный токен из поля                `data.attributes.access_token` (Без `Bearer `!). Откройте модальное окно авторизаци (Зеленая кнопка `Authorize` выше),                вставьте его в поле значения и нажмите `Authorize`

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import SmartCommSDK

let generateAccessTokenRequest = generateAccessToken_request(data: generateAccessToken_request_data(attributes: generateAccessToken_request_data_attributes(username: "username_example", password: "password_example"))) // GenerateAccessTokenRequest |  (optional)

// Авторизация в системе SMC
AuthorizationAPI.generateAccessToken(generateAccessTokenRequest: generateAccessTokenRequest) { (response, error) in
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
 **generateAccessTokenRequest** | [**GenerateAccessTokenRequest**](GenerateAccessTokenRequest.md) |  | [optional] 

### Return type

[**GenerateAccessToken200Response**](GenerateAccessToken200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

