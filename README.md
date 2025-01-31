# LoymaxPopupSdk

Библиотека Loymax, созданная с помощью OpenApi Generator.

## Sources/LoymaxPopupSdk/ - Библиотека  
/LoymaxPopupSdk/APIs/PopupAPI.swift - методы  
/LoymaxPopupSdk/Models/ - модели  


## Sample.iOS - пример

Необходимо добавить cтенд:  
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
