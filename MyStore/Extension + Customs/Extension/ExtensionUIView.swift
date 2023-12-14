//
//  ExtensionUIView.swift
//  MyStore
//
//  Created by Long Tran on 19/04/2023.
//

import UIKit
extension UIView{
    @IBInspectable var cornerRadius : CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    
    @IBInspectable var borderWidth : CGFloat{
        get{
            return self.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var boderColor : UIColor? {
        get{
            guard let color = layer.borderColor else {return nil}
            return UIColor(cgColor: color)
        }
        
        set{
            guard let color = newValue else {return}
            layer.borderColor = color.cgColor
        }
    }
}
