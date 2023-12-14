//
//  CustomButton.swift
//  MyStore
//
//  Created by Long Tran on 19/04/2023.
//

import UIKit

class CustommButton : UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(){
        self.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 16)
        self.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.tintColor = UIColor.black
        backgroundColor = UIColor(named: "Btncolor")
        layer.cornerRadius = 10
        
        if tag == 104{
            contentMode = .left
            self.titleLabel?.font = UIFont(name: "Avenir Regular", size: 25)
            self.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.contentHorizontalAlignment = .center
            self.contentVerticalAlignment = .center
            backgroundColor = UIColor.white
            borderWidth = 0
        }
        else if tag == 105{
            layer.cornerRadius = 15
            isEnabled = false
            self.layer.opacity = 0.5
            self.tintColor = UIColor.white
            self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        else if tag == 107{
            self.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 21)
        
        }
        else if tag == 108 {
            self.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 12)
            self.tintColor = UIColor(named: "Grey Deeper")
            backgroundColor = UIColor.white
            cornerRadius = 0
        }
        

    }
    
 
    

}
