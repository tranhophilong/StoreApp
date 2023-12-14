//
//  LoginViewController.swift
//  MyStore
//
//  Created by Long Tran on 19/04/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackbuttonWithTitle(title: "")
    }
    

    @IBAction func countinueWithPhone(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhoneNumberViewController") as! PhoneNumberViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func continueWithFb(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
                loginManager.logIn(permissions: ["public_profile","email"], from: self) { result, error in
                    if let error = error {
                        print("Encountered Erorr: \(error)")
                    } else if let result = result, result.isCancelled {
                        print("Cancelled")
                    } else {
                        print("logged")
                        let credential = FacebookAuthProvider.credential(withAccessToken: (result?.token!.tokenString)!)
                        Auth.auth().signIn(with: credential){result,error in
                            
                        }
                    }
                }
    }
    
    @IBAction func continueWithGoogle(_ sender: Any) {
        guard let clientID  = FirebaseApp.app()?.options.clientID else {
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self){ [unowned self] result, error in
            guard error == nil else{
                print("error")
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else{
                print("not user")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential){ result,error in
                
            }
            
        }
        
    }
    

    
}
