//
//  OptionsItemViewController.swift
//  MyStore
//
//  Created by Long Tran on 25/07/2023.
//

import UIKit

class OptionsItemViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config(){
//        self.view.backgroundColor = .clear
        self.backView.backgroundColor = UIColor.black
        self.backView.alpha = 0.1
    }
    
    func show(sender: UIViewController){
        sender.present(self, animated: true)
    }



}
