//
//  SpinnerViewController.swift
//  MyStore
//
//  Created by Long Tran on 07/06/2023.
//

import UIKit
import Firebase
import FirebaseAuth

//protocol SpinnerViewControllerDelegate{
//    func showSpinner()
//    func dismiss()
//}

class SpinnerViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SpinnerViewController", bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(){
        spinner.style = .large
        self.view.backgroundColor = .clear
        spinner.startAnimating()
       

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

extension SpinnerViewController: AuthUIDelegate{
//    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
//        self.delegate?.showSpinner()
//
//    }
//
//
//    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
//        self.delegate?.dismiss()
//    }
    

    
 

}

