//
//  PopUpErrorPhoneNumber.swift
//  MyStore
//
//  Created by Long Tran on 06/06/2023.
//

import UIKit

class PopUpErrorPhoneNumber: UIViewController {

    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PopUpErrorPhoneNumber", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black
        self.backView.alpha = 0.4
        
    }
    
    func show(sender: UIViewController){
        sender.present(self, animated: true)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
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
