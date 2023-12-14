//
//  HomeViewController.swift
//  MyStore
//
//  Created by Long Tran on 09/06/2023.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

//    data test ui
    private let items : [Item] = [Item(imgName: "imgEarPhone", title: "Logitech G433 Headset", brand: "Logitech", rate: "4.8", price: "100"),Item(imgName: "imgLaptop", title: "HP Laptop", brand: "HP", rate: "5.0", price: "1000"), Item(imgName: "imgWatch", title: "Smart Apple Watch SE", brand: "brand", rate: "4.5", price: "100")]
    
    private let  categories : [Category] = [Category(title: "Developer", imgName: "imgDev", numberSuggestedItem: "21"), Category(title: "PhotoGrapher", imgName: "imgPhotographer", numberSuggestedItem: "20"), Category(title: "Creative", imgName: "imgCreative", numberSuggestedItem: "30")]
    private var collectionViewDataSource : GeneralCollectionViewDataSource<Category>?
    private var tableViewDataSource : GeneralTableViewDataSource<Item>?
    
    @IBOutlet weak var tableViewNewArrivals: UITableView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItemOrderOnNav()
        let searchBar = setupSearchBarOnNav()
        searchBar.searchTextField.delegate = self
    
//      setup arrivalsView
        let tableViewArrivalsDataSource = GeneralTableViewDataSource(models: items, reuseIdentifier: ItemTableViewCell.identifier) { model, cell in
            (cell as! ItemTableViewCell).setup(imgName: model.imgName, title: model.title, price: model.price)
        }
        tableViewDataSource = tableViewArrivalsDataSource
        tableViewNewArrivals.dataSource = tableViewArrivalsDataSource
        tableViewNewArrivals.register(ItemTableViewCell.nib(), forCellReuseIdentifier: ItemTableViewCell.identifier)
        
//      setup workspace view
        let categoryCollectionViewDataSource =  GeneralCollectionViewDataSource(models: categories, reuseIdentifier: "CategoryCollectionViewCellVertical") { model, cell in
            (cell as! CategoryCollectionViewCell).setup(nameImg: model.imgName, title: model.title, numberSuggested: model.numberSuggestedItem)
        }
        collectionViewDataSource = categoryCollectionViewDataSource
        collectionViewCategory.dataSource = categoryCollectionViewDataSource
        let nibCollectionViewCell = UINib(nibName: "CategoryCollectionViewCellVertical", bundle: nil)
        collectionViewCategory.register(nibCollectionViewCell, forCellWithReuseIdentifier: "CategoryCollectionViewCellVertical")
    }
    

    

    @IBAction func goToDetailVC(_ sender: Any) {
        setupBackbuttonWithTitle(title: "")
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showSearchVc()
        return false
    }
    
}


extension HomeViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

