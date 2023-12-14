//
//  CustomLabel.swift
//  MyStore
//
//  Created by Long Tran on 09/06/2023.
//

import UIKit

class CustomLabel : UILabel{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    func config(){
        font  = UIFont(name: "Avenir Heavy", size: 21)
        if tag == 103 {
            font  = UIFont(name: "Avenir Heavy", size: 12)
            textColor = UIColor(named: "Grey Deeper")
        }
        else if tag == 101{
            font  = UIFont(name: "Avenir", size: 16)
        }
        else if tag == 102 {
            font  = UIFont(name: "Avenir Heavy", size: 16)
            textColor = UIColor(named: "Secondary")
        }
        else if tag == 104 {
            font = UIFont(name: "Avenir Heavy", size:12)
            textColor = UIColor(named: "Secondary")
        }
        else if tag == 105 {
            font  = UIFont(name: "Avenir", size: 10)
        }
    
    }
}
