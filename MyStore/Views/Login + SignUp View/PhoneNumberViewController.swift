//
//  PhoneNumberViewController.swift
//  MyStore
//
//  Created by Long Tran on 06/05/2023.
//

import UIKit
import FirebaseAuth



class PhoneNumberViewController: UIViewController, CountryViewControllerDelegate {

    
    @IBOutlet weak var tfPhoneNumber: CustomTextField!
    @IBOutlet weak var btnCountryCode: CustommButton!
    @IBOutlet weak var btnCountinue: CustommButton!
    @IBOutlet weak var disBtwBtnContinueAndBottom: NSLayoutConstraint!
    
    var first = false
    let countrySuggest = Country.shared.dctCountry[Country.shared.listFirstChar[0]]![0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Country.shared
        let imageName = countrySuggest["code"] as! String
        let dialCode = countrySuggest["dial_code"] as! String
        setUpCoutryCode(image: imageName, code: dialCode)
        btnCountryCode.layoutIfNeeded()
        tfPhoneNumber.layoutIfNeeded()
        addUnderline(view: btnCountryCode, with: 8)
        addUnderline(view: tfPhoneNumber, with: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        tfPhoneNumber.addTarget(self, action: #selector(eventTypingnumber), for: UIControl.Event.editingChanged)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        removeUnderline(view: btnCountryCode)
        removeUnderline(view: tfPhoneNumber)
        addUnderline(view: btnCountryCode, with: 8 )
        addUnderline(view: tfPhoneNumber, with: 0)

    }
    
    @objc func eventTypingnumber(){
        if tfPhoneNumber.text?.count ?? 0 > 5{
            btnCountinue.isEnabled = true
            btnCountinue.layer.opacity = 1
        }else{
            btnCountinue.isEnabled = false
            btnCountinue.layer.opacity = 0.5
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        if first == false{
            disBtwBtnContinueAndBottom.constant = keyboardFrame.size.height - 20
            first = true
        }
    }
    
    @IBAction func showListCountry(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    
    
    @IBAction func continueWithPhone(_ sender: Any) {
        let phoneNumber = Country.shared.dctCountry[Country.shared.listFirstChar[0]]![0]["dial_code"] as! String + String(Int(tfPhoneNumber.text!)!)
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                  print("error phone number")
                let popupLayer = PopUpErrorPhoneNumber()
                popupLayer.show(sender: self)
                  return
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
                let digitVC = self.storyboard?.instantiateViewController(withIdentifier: "DigitCodeViewController") as! DigitCodeViewController
                digitVC.vertificationId = verificationID
                digitVC.modalPresentationStyle = .fullScreen
                self.navigationController?.present(digitVC, animated: true)
                
            }
    }
    

}

extension PhoneNumberViewController{
    
    
    func setImageAndCountryCode(image: String, dialCode countrCode: String) {
     setUpCoutryCode(image: image, code: countrCode)
    }
    
    func setUpCoutryCode(image: String, code: String){
        btnCountryCode.setImage(UIImage(named: image), for: UIControl.State.normal)
        if code.count > 4{
            btnCountryCode.setTitle(String(code.prefix(2)), for: UIControl.State.normal)
        }else{
            btnCountryCode.setTitle((code), for: UIControl.State.normal)
        }
    }
    
    func addUnderline(view: AnyObject, with cut: Int){
        view.layoutIfNeeded()
        let bottomLine  = CALayer()
        bottomLine.name =  "bottom underline"
        bottomLine.frame = CGRect(x: 0, y: view.frame.height + 1 , width: view.frame.width - CGFloat(cut) , height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        view.layer.addSublayer(bottomLine)
    }
    
    func removeUnderline(view: AnyObject){
        for layer in view.layer?.sublayers ?? []{
            if layer.name == "bottom underline"{
                layer.removeFromSuperlayer()
                break
            }
        }
    }
    
}



    

    
    

