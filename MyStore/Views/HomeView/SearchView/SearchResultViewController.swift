//
//  SearchResultViewController.swift
//  MyStore
//
//  Created by Long Tran on 14/06/2023.
//

import UIKit

class SearchResultViewController: UIViewController{
    
    
    private let items : [Item] = [Item(imgName: "imgHub", title: "Hub", brand: "brand", rate: "4.8", price: "100"),Item(imgName: "imgKeyBoard", title: "Machenical keyboard", brand: "brand", rate: "5.0", price: "100"), Item(imgName: "imgLaptop", title: "Huawei Laptop", brand: "Huaway", rate: "4.5", price: "1000")]

    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var ItemCollectionView: UICollectionView!
    private var collectionViewDataSource : GeneralCollectionViewDataSource<Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBar = setupSearchBarOnNav()
        searchBar.searchTextField.delegate = self
        let collectionViewDataSource = GeneralCollectionViewDataSource(models: items, reuseIdentifier: ItemCollectionViewCell.identifier) { model, cell in
            (cell as! ItemCollectionViewCell).setup(imgName: model.imgName, price: model.price, title: model.title)
        }
        self.collectionViewDataSource = collectionViewDataSource
        ItemCollectionView.dataSource = collectionViewDataSource
        ItemCollectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        
  
    }
    
    @IBAction func showFilterVC(_ sender: Any) {
        let filterVC = FilterViewController()
        filterVC.transitioningDelegate = self
        filterVC.show(sender: self)

    }

    
}

    

extension SearchResultViewController : UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UITextFieldDelegate   {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ItemCollectionView.frame.size.width/2  - 5, height: 210)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showSearchVc()
        return false
    }
    


}


extension SearchResultViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissTransition()
    }
}
