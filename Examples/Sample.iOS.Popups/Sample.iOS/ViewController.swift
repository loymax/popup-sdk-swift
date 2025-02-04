//
//  ViewController.swift
//  Sample.iOS
//
//  Created by Nelaps on 14.11.2022.
//

import UIKit
import LoymaxPopupSdk

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        OpenAPIClientAPI.customHeaders =
        [
            "Authorization" : "Bearer *******",
            "Accept" : "application/json",
            "Content-Type": "application/json"
        ]
        
        var popupReq : PopupRequest = PopupRequest()
        popupReq.clientId = "10452636"
        //popupReq.reference = ""
        popupReq.action = "app_open"
        var popup = PopupAPI.popup(popupRequest: popupReq) {
            (result, error) in guard result != nil else {
                print(error?.localizedDescription)
                return
            }
            var str: String = ""
            guard let result = result else {return}
            for popup in result {
                str += "navlink\n"
                str += "\(popup.navlink)\n"
                str += "popupId\n"
                str += "\(popup.popupId)\n"
                str += "reference\n"
                str += "\(popup.reference)\n"
                str += "style\n"
                str += "\(popup.style?.mainColor)\n"
                str += "\(popup.style?.secondColor)\n\n"
            }
            str += "\nPopup\n"
            str += "success\n\n"

            self.textView.text += str
        }

        var confirmReq : ConfirmRequest = ConfirmRequest()
        confirmReq.popupId = 1655869443
        confirmReq.clientId = "10452636"
        confirmReq.sourceId = 333
        var confirm = PopupAPI.popupConfirm(confirmRequest: confirmReq) {
            (result, error) in guard result != nil else {
                print(error?.localizedDescription)
                return
            }
            var str: String = ""
            str += "\n\nConfirm\n"
            str += "success\n\n"
            self.textView.text += str
        }
    }
    
}
