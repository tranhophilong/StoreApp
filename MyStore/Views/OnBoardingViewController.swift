//
//  OnBoardingViewController.swift
//  MyStore
//
//  Created by Long Tran on 18/04/2023.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var imgBg: UIImageView!
    let arrImgBg = ["ImgBg", "imgBg2", "imgBg3"]
    var indexImg = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackbuttonWithTitle(title: "")
        // Do any additional setup after loading the view.
//        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(setBg), userInfo: nil, repeats: true)
        

        
        
    }
   @objc func setBg(){

          indexImg += 1
          if indexImg == arrImgBg.count {
              indexImg = 0

          }
       UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.allowUserInteraction, animations: { [weak self] in
           self!.imgBg.alpha = 0.7
           self!.imgBg.alpha = 1
           self!.imgBg.image = UIImage(named: self!.arrImgBg[self!.indexImg])
           
          })
      }

    
    @IBAction func actionHome(_ sender: Any) {
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        print(1)
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

}
