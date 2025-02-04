# 📌 LoymaxPopupSdk & SmartCommunications
Управление попапами и коммуникацией с клиентами


---
# LoymaxPopupSdk

Библиотека Loymax, созданная с помощью OpenApi Generator.

## Sources/LoymaxPopupSdk/ - Библиотека  
/LoymaxPopupSdk/APIs/PopupAPI.swift - методы  
/LoymaxPopupSdk/Models/ - модели  


## Sample.iOS - пример

Для использования LoymaxPopupSdk необходимо добавить cтенд:  
AppDelegate.swift -> application -> `OpenAPIClientAPI.basePath = ""`  

Подключение библиотеки в проект:  
`import LoymaxPopupSdk`  

Пример:  
`OpenAPIClientAPI.basePath = "https://api.loymaxsc.net/api"`  

Пример использования методов:
* перед вызовом методов, необходимо установить ("Bearer *******" можно получить с помощью https://api.loymaxsc.net/token):
```swift
OpenAPIClientAPI.customHeaders =
[
    "Authorization" : "Bearer *******",
    "Accept" : "application/json",
    "Content-Type": "application/json"
]
* /popup/
```swift
var popupReq : PopupRequest = PopupRequest()
popupReq.clientId = "10452636"
popupReq.action = "app_open"
var popup = PopupAPI.popup(popupRequest: popupReq) {
        (result, error) in guard result != nil else {
            return
        }
    }
* /popup/confirm
    ```swift
    var confirmReq : ConfirmRequest = ConfirmRequest()
    confirmReq.popupId = 1655869443
    confirmReq.clientId = "10452636"
    confirmReq.sourceId = 333
    var confirm = PopupAPI.viewPopup(confirmRequest: confirmReq) {
        (result, error) in guard result != nil else {
            return
        }
    }
    ```  

---
# SmartCommunications API Documentation

## Overview

SmartCommunications API is generated using OpenAPI Generator version 6.2.1. This SDK provides a native Swift interface to interact with the SmartCommunications platform.

- SDK Version: 2.1.0
- OpenAPI Generator: 6.2.1
- Swift Version: 5.0+
- Minimum iOS Version: 13.0

## Installation

### Swift Package Manager (SPM)

Для добавления **LoymaxPopupSdk** и **SmartCommunicationsSDK** в проект **SDKSample** с помощью **Swift Package Manager (SPM)** выполните следующие шаги:

1. **Откройте Xcode** и загрузите проект `SDKSample`.
2. Перейдите в **File → Add Packages...**.
3. В поле поиска введите URL-адрес репозитория: `https://github.com/loymax/popup-sdk-swift.git`.
4. Выберите нужную версию (например, **Up to Next Major**).
5. Нажмите **Add Package**.
6. В появившемся окне выберите одну или обе библиотеки:
   - LoymaxPopupSdk
   - SmartCommunications
7. Убедитесь, что обе библиотеки подключены к целевой сборке `SCExample`.

### Импорт библиотек в коде:

    ```swift
    import LoymaxPopupSdk
    import SmartCommunicationsSDK
    ```
После подключения библиотек, следуйте инструкциям выше для их настройки и использования в проекте.

Для использования SmartCommunicationsSDK необходимо добавить cтенд:  
AppDelegate.swift -> application -> `SmartCommunicationsAPI.basePath = ""` 

## Documentation for API Endpoints

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*AuthorizationAPI* | [**getAuthToken**](docs/AuthorizationAPI.md#getauthtoken) | **POST** /token | Авторизация в системе SMC
*CommunicationAPI* | [**logPushEvent**](docs/CommunicationAPI.md#logpushevent) | **POST** /communication/{type}/events | Передать в Смарт факт показа (открытия) пуша
*CustomerAPI* | [**addCustomerToken**](docs/CustomerAPI.md#addcustomertoken) | **POST** /customer/{id}/contact | Передать в Смарт полученный от APNS/FCM/rustore/HuaweiPushToolkit токен
*CustomerAPI* | [**getCustomerNotificationStatus**](docs/CustomerAPI.md#getcustomernotificationstatus) | **GET** /customer/{id}/channel | Получить из Смарта статус разрешения на уведомления клиенту
*CustomerAPI* | [**getCustomerSubscriptionCategories**](docs/CustomerAPI.md#getcustomersubscriptioncategories) | **GET** /customer/{id}/subscribe | Получить из Смарта статус подписки клиента на категории рассылок
*CustomerAPI* | [**modifyCustomerSubscriptionCategories**](docs/CustomerAPI.md#modifycustomersubscriptioncategories) | **PATCH** /customer/{id}/subscribe | Передать в Смарт статус подписки на категории
*CustomerAPI* | [**setCustomerNotificationStatus**](docs/CustomerAPI.md#setcustomernotificationstatus) | **POST** /customer/{id}/channel | Передать в Смарт статус разрешения на уведомления клиенту

## Documentation For Models

- [AddCustomerTokenRequest](docs/AddCustomerTokenRequest.md)
- [AddCustomerTokenRequestData](docs/AddCustomerTokenRequestData.md)
- [AddCustomerTokenRequestDataAttributes](docs/AddCustomerTokenRequestDataAttributes.md)
- [AddCustomerTokenRequestDataAttributesContactsInner](docs/AddCustomerTokenRequestDataAttributesContactsInner.md)
- [AuthTokenResponse](docs/AuthTokenResponse.md)
- [AuthTokenResponseData](docs/AuthTokenResponseData.md)
- [AuthTokenResponseDataAttributes](docs/AuthTokenResponseDataAttributes.md)
- [AuthTokenResponseDataAttributesUser](docs/AuthTokenResponseDataAttributesUser.md)
- [CustomerNotificationStatus](docs/CustomerNotificationStatus.md)
- [CustomerNotificationStatusDataInner](docs/CustomerNotificationStatusDataInner.md)
- [CustomerNotificationStatusDataInnerAttributes](docs/CustomerNotificationStatusDataInnerAttributes.md)
- [CustomerSubscriptionCategories](docs/CustomerSubscriptionCategories.md)
- [CustomerSubscriptionCategoriesDataInner](docs/CustomerSubscriptionCategoriesDataInner.md)
- [CustomerSubscriptionCategoriesDataInnerAttributes](docs/CustomerSubscriptionCategoriesDataInnerAttributes.md)
- [GetAuthToken200Response](docs/GetAuthToken200Response.md)
- [GetAuthTokenRequest](docs/GetAuthTokenRequest.md)
- [GetAuthTokenRequestData](docs/GetAuthTokenRequestData.md)
- [GetAuthTokenRequestDataAttributes](docs/GetAuthTokenRequestDataAttributes.md)
- [GetCustomerNotificationStatus200Response](docs/GetCustomerNotificationStatus200Response.md)
- [GetCustomerSubscriptionCategories200Response](docs/GetCustomerSubscriptionCategories200Response.md)
- [LogPushEvent200Response](docs/LogPushEvent200Response.md)
- [LogPushEventRequest](docs/LogPushEventRequest.md)
- [LogPushEventRequestDataInner](docs/LogPushEventRequestDataInner.md)
- [ModifySubscriptionRequest](docs/ModifySubscriptionRequest.md)
- [ModifySubscriptionRequestData](docs/ModifySubscriptionRequestData.md)
- [ModifySubscriptionRequestDataAttributes](docs/ModifySubscriptionRequestDataAttributes.md)
- [ModifySubscriptionRequestDataAttributesCategories](docs/ModifySubscriptionRequestDataAttributesCategories.md)
- [ModifySubscriptionRequestDataAttributesCategoriesMailingCode](docs/ModifySubscriptionRequestDataAttributesCategoriesMailingCode.md)
- [RateLimitErrorResponse](docs/RateLimitErrorResponse.md)
- [RateLimitErrorResponseErrorsInner](docs/RateLimitErrorResponseErrorsInner.md)
- [SMCErrorDetails](docs/SMCErrorDetails.md)
- [SMCErrorResponse](docs/SMCErrorResponse.md)
- [SMCLinks](docs/SMCLinks.md)
- [SMCMeta](docs/SMCMeta.md)
- [SMCSuccessResponse](docs/SMCSuccessResponse.md)
- [SMCSuccessResponseData](docs/SMCSuccessResponseData.md)
- [SMCSuccessResponseDataAttributes](docs/SMCSuccessResponseDataAttributes.md)
- [SetCustomerNotificationStatusRequest](docs/SetCustomerNotificationStatusRequest.md)
- [SetCustomerNotificationStatusRequestData](docs/SetCustomerNotificationStatusRequestData.md)
- [SetCustomerNotificationStatusRequestDataAttributes](docs/SetCustomerNotificationStatusRequestDataAttributes.md)

<a id="documentation-for-authorization"></a>
## Documentation For Authorization

Authentication schemes defined for the API:
<a id="bearerAuth"></a>
### bearerAuth

- **Type**: HTTP Bearer Token authentication (JWT)

All API requests require authentication using Bearer token:
```http
Authorization: Bearer YOUR_TOKEN_HERE
```

Для получения токена:
1. Перейдите по адресу https://api.loymaxsc.net/token
2. Предоставьте учетные данные клиента
3. Используйте полученный токен во всех последующих запросах

Срок действия токена: 1 час

# Migration and FAQ

### How do I migrate from the Swift 5 generator to the swift 6 generator?

https://openapi-generator.tech/docs/faq-generators#how-do-i-migrate-from-the-swift-5-generator-to-the-swift-6-generator

### How do I implement bearer token authentication with URLSession on the Swift 5 API client?

https://openapi-generator.tech/docs/faq-generators#how-do-i-implement-bearer-token-authentication-with-urlsession-on-the-swift-5-api-client

### Распространенные проблемы реализации

1. Ошибки аутентификации
- Проверьте срок действия токена
- Убедитесь в правильном формате токена
- Проверьте учетные данные клиента

2. Неверный формат запроса
- Проверьте параметры запроса
- Убедитесь в наличии обязательных полей
- Проверьте типы данных

3. Ограничение частоты запросов
- Реализуйте экспоненциальную задержку
- При возможности используйте кэширование ответов
- Отслеживайте использование API

### Best Practices

- Всегда проверяйте входные данные
- Корректно обрабатывайте ошибки API
- Реализуйте правильное логирование ошибок
- Используйте подходящие значения тайм-аутов
- Реализуйте логику повторных попыток для неудачных запросов
- При необходимости используйте кэширование ответов
