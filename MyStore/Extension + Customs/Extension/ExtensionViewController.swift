//
//  ExtensionViewController.swift
//  MyStore
//
//  Created by Long Tran on 19/04/2023.
//

import UIKit

extension UIViewController{

    func updateContrain(contrain : NSLayoutConstraint){
        let scale = view.bounds.height / 736
        contrain.constant = contrain.constant * scale
        
    }
    
    func setupBackbuttonWithTitle(title: String){
        let backItem = UIBarButtonItem()
        backItem.title = title
        backItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Avenir Heavy", size: 21)], for: UIControl.State.normal)
        navigationItem.backBarButtonItem = backItem
    
    }
    
    func setUPSearchBar(searchSuggest : UIViewController) -> UISearchController{
        let searchController =  UISearchController(searchResultsController: searchSuggest)
        searchController.searchBar.contentMode = .bottom

        searchController.searchBar.searchTextField.placeholder = "Search product name"
        searchController.searchBar.searchTextField.font = UIFont(name: "Avenir", size: 16)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        searchController.automaticallyShowsSearchResultsController = true
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        label.text = "Search"
        label.font = UIFont(name: "Avenir Heavy", size: 21)
        navigationItem.titleView = label
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.searchTextField.layer.cornerRadius = 10


        return searchController
    }
    
    func setupItemOrderOnNav(){
        let showPreOrdersBtn = UIBarButtonItem()
        showPreOrdersBtn.image = UIImage(named: "custom.cart.fill")
        navigationItem.rightBarButtonItem = showPreOrdersBtn
    }
    
    func setupSearchBarOnNav()-> UISearchBar{
        let searchBar = UISearchBar()
        searchBar.searchTextField.cornerRadius = 10
        searchBar.searchTextField.placeholder = "Search product"
        navigationItem.titleView = searchBar
        
        
        return searchBar
    }
    
     func showSearchVc(){
        setupBackbuttonWithTitle(title: "")
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.modalTransitionStyle = .partialCurl
        navigationController?.pushViewController(searchVC, animated: true)
    }
    

    
    
}

