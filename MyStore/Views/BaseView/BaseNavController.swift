//
//  BaseNavController.swift
//  MyStore
//
//  Created by Long Tran on 09/06/2023.
//

import UIKit

class BaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.yellow, NSAttributedString.Key.font: UIFont(name: "Avenir Heavy", size: 21)!]
        navigationBar.tintColor = UIColor.black
        
        
    
//        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
