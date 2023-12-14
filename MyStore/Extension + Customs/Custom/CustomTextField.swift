//
//  CustomTextField.swift
//  MyStore
//
//  Created by Long Tran on 19/04/2023.
//

import UIKit
class CustomTextField : UITextField{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        confiure()
    }
    
    func confiure(){
        if tag == 101{
            borderStyle = .none
            textAlignment = .left
            keyboardType = .numberPad
            becomeFirstResponder()
            tintColor = .black
            textContentType = .telephoneNumber
            font = UIFont(name: "Avenir Regular", size: 15)
        }
        
        else if tag == 102{
            borderStyle = .none
            textAlignment = .left
            becomeFirstResponder()
            tintColor = .black
            placeholder = "000000"
            font = UIFont(name: "Avenir Regular", size: 30)
        }
  
    }
    

    

}
