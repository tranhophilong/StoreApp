//
//  SearchViewController.swift
//  MyStore
//
//  Created by Long Tran on 14/06/2023.
//

import UIKit


class SearchViewController: UIViewController {

    @IBOutlet weak var collectionViewHistory: UICollectionView!
    @IBOutlet weak var recentSearchTableView: UITableView!
    @IBOutlet weak var popularSearchTableView: UITableView!
    var searchRecents : [String] = []
    private var collectionViewDataSource : GeneralCollectionViewDataSource<Item>?
    @IBOutlet weak var recentView: UIView!
    
//    data test
    private let items : [Item] = [Item(imgName: "imgHub", title: "Hub", brand: "brand", rate: "4.8", price: "100"),Item(imgName: "imgKeyBoard", title: "Machenical keyboard", brand: "brand", rate: "5.0", price: "100"), Item(imgName: "imgWatch", title: "Smart Apple Watch SE", brand: "brand", rate: "4.5", price: "100")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackbuttonWithTitle(title: "")
        let searchResultVC = self.storyboard?.instantiateViewController(identifier: "SearchSuggestViewController") as! SearchSuggestViewController
        let searchControll = setUPSearchBar(searchSuggest: searchResultVC)
        searchControll.searchResultsUpdater = self
        searchControll.searchBar.searchTextField.delegate = self
        let collectionViewHistoryDataSource = GeneralCollectionViewDataSource(models: items, reuseIdentifier: ItemCollectionViewCell.identifier) { model, cell in
            (cell as! ItemCollectionViewCell).setup(imgName: model.imgName, price: model.price, title: model.title)
        }
        collectionViewDataSource = collectionViewHistoryDataSource
        collectionViewHistory.dataSource = collectionViewHistoryDataSource
        collectionViewHistory.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        
        popularSearchTableView.register(ItemTableViewCell.nib(), forCellReuseIdentifier: ItemTableViewCell.identifier)
        
        if searchRecents.isEmpty {
            recentView.isHidden = true
        }else{
            recentView.isHidden = false
        }
    }
    

}

extension SearchViewController :  UISearchResultsUpdating, UITextFieldDelegate{
   
    func updateSearchResults(for searchController: UISearchController) {

        return
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        searchRecents.append(text)
        let searhResultVc = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
        self.navigationController?.pushViewController(searhResultVc, animated: true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

}


extension SearchViewController : UICollectionViewDelegate{
 
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.recentSearchTableView {
            return searchRecents.count
        }else{
            return items.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.recentSearchTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell") as! RecentSearchTableViewCell
            cell.setUp(title: searchRecents[indexPath.row])
            cell.didDelete  = { [weak self] in
                guard let self = self else {
                    return
                }
                self.searchRecents.remove(at: indexPath.row)
                self.recentSearchTableView.reloadData()
            }
            cellToReturn = cell
        }
        else if tableView == self.popularSearchTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
            let item = items[indexPath.row]
            cell.setup(imgName: item.imgName, title: item.title, price: item.price)
            cellToReturn = cell
        }
        return cellToReturn
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
