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
`OpenAPIClientAPI.basePath = "https://example.loymax.tech/publicapi"`  

Пример использования методов:    

* /popup/{clientId}
   ```swift
   var popup = PopupAPI.getPopup(clientId: "123", action: "") {
        (result, error) in guard result != nil else {
            return
        }
    }
* /popup/confirm
    ```swift
    var confirmReq : ConfirmRequest = ConfirmRequest()
    confirmReq.popupId = 111
    confirmReq.clientId = "222"
    confirmReq.sourceId = 333
    var confirm = PopupAPI.viewPopup(confirmRequest: confirmReq) {
        (result, error) in guard result != nil else {
            return
        }
    }
    ```  
