//
//  DigitCodeViewController.swift
//  MyStore
//
//  Created by Long Tran on 07/06/2023.
//

import UIKit
import FirebaseAuth

class DigitCodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfDigitCode: CustomTextField!
    
    @IBOutlet weak var lblWarning: UILabel!
    var vertificationId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWarning.text = ""
        lblWarning.textColor = UIColor.red
        
        tfDigitCode.delegate = self
        // Do any additional setup after loading the view.
    }
    

}

extension DigitCodeViewController{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard tfDigitCode.text?.count != 0  else {
            lblWarning.text = "You have not entered the code."
            return true
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationId ?? "", verificationCode: tfDigitCode.text ?? "")
        
        Auth.auth().signIn(with: credential) { authData, error in
            if (error != nil){
                self.lblWarning.text = "You entered the wrong code."
                return
            }
            print("success")
            
        }
        return true
    }
}
