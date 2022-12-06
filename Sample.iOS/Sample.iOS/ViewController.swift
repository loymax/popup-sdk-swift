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
       
        var popup = PopupAPI.getPopup(clientId: "123", action: "") {
            (result, error) in guard result != nil else {
                return
            }
            var str: String = ""
            str += "\n\npopupClientIdGet\n"
            str += "popupId\n"
            str += "\(result?.popupId)\n"
            str += "content\n"
            str += "\(result?.content?.title)\n"
            str += "\(result?.content?.subtitle)\n"
            str += "\(result?.content?.imageUrl)\n"
            str += "\(result?.content?.text)\n"
            str += "\(result?.content?.button?.name)\n"
            str += "action\n"
            str += "\(result?.action)\n"
            str += "navlink\n"
            str += "\(result?.navlink)\n"
            str += "style\n"
            str += "\(result?.style?.mainColor)\n"
            str += "\(result?.style?.secondColor)\n\n"
            self.textView.text += str
        }

        var confirmReq : ConfirmRequest = ConfirmRequest()
        confirmReq.popupId = 111
        confirmReq.clientId = "222"
        confirmReq.sourceId = 333
        var confirm = PopupAPI.viewPopup(confirmRequest: confirmReq) {
            (result, error) in guard result != nil else {
                return
            }
            var str: String = ""
            str += "\n\nConfirm\n"
            str += "success\n\n"
            self.textView.text += str
        }
    }
}
