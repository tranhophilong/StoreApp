//
//  DetailViewController.swift
//  MyStore
//
//  Created by Long Tran on 13/07/2023.
//

import UIKit

class DetailViewController: UIViewController, DetailThumnailViewDelegate{
   

    @IBOutlet weak var collectionViewThumnail: UICollectionView!
    @IBOutlet weak var scrollViewThumnail: UIScrollView!
    @IBOutlet weak var pageControlThumnail: UIPageControl!
    
    @IBOutlet weak var collectionViewRelateItem: UICollectionView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    
   private var firstLayout: Bool = true
   private  var imgChars : [String] = ["imgChar5", "imgChar4", "imgChar4"]
   private var indexBefore : Int?
   private var scrollViewThumnailDelegate = ScrollViewThumnailDelegate()
   private let  categories : [Category] = [Category(title: "Developer", imgName: "imgDev", numberSuggestedItem: "21"), Category(title: "PhotoGrapher", imgName: "imgPhotographer", numberSuggestedItem: "20"), Category(title: "Creative", imgName: "imgCreative", numberSuggestedItem: "30")]
    private let items : [Item] = [Item(imgName: "imgHub", title: "Hub", brand: "brand", rate: "4.8", price: "100"),Item(imgName: "imgKeyBoard", title: "Machenical keyboard", brand: "brand", rate: "5.0", price: "100"), Item(imgName: "imgLaptop", title: "Huawei Laptop", brand: "Huaway", rate: "4.5", price: "1000")]
    var currentIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItemOrderOnNav()
        let searchBar = setupSearchBarOnNav()
        searchBar.searchTextField.delegate = self
//        setup scrollview
        scrollViewThumnailDelegate.collectionViewThumnail = collectionViewThumnail
        scrollViewThumnailDelegate.pageControll = pageControlThumnail
        scrollViewThumnailDelegate.scrollViewThumnail = scrollViewThumnail
        scrollViewThumnail.delegate = scrollViewThumnailDelegate
        scrollViewThumnail.isPagingEnabled = true

//        setup pagecontroll
        pageControlThumnail.numberOfPages = imgChars.count
        pageControlThumnail.isUserInteractionEnabled = false
        pageControlThumnail.currentPageIndicatorTintColor = UIColor(named: "Btncolor")
        pageControlThumnail.pageIndicatorTintColor = UIColor.white
        
//        setup collectionview

        collectionViewThumnail.delegate = self
        collectionViewThumnail.dataSource = self
        collectionViewRelateItem.delegate = self
        collectionViewRelateItem.dataSource = self
        collectionViewThumnail.allowsMultipleSelection = false
        collectionViewThumnail.isMultipleTouchEnabled = false
        collectionViewThumnail.selectItem(at: IndexPath(item: currentIndex ?? 0, section: 0), animated: false, scrollPosition: .bottom)
        collectionViewThumnail.register(ThumnailCollectionViewCell.nib(), forCellWithReuseIdentifier: ThumnailCollectionViewCell.indentifier)
        let nibCategoryCollectionViewHori = UINib(nibName: "CategoryCollectionViewCellHorizontal", bundle: nil)
        collectionViewCategory.register(nibCategoryCollectionViewHori, forCellWithReuseIdentifier: "CategoryCollectionViewCellHorizontal")
        collectionViewCategory.dataSource = self
        collectionViewRelateItem.register(ItemCollectionViewCell2.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell2.identifier)
        
//        addtap to scrollview
        let tap = UITapGestureRecognizer(target: self, action: #selector(navToDetailThumnail))
        scrollViewThumnail.addGestureRecognizer(tap)
       
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        let optionsItemVC = OptionsItemViewController()
        optionsItemVC.modalPresentationStyle = .overFullScreen
        optionsItemVC.show(sender: self)
    }
    
    
    @objc func navToDetailThumnail() {
        let detailThumnailVC = self.storyboard?.instantiateViewController(identifier: "DetailThumnailViewController") as! DetailThumnailViewController
        detailThumnailVC.modalPresentationStyle = .fullScreen
        detailThumnailVC.modalTransitionStyle = .crossDissolve
        detailThumnailVC.imgThumnails = imgChars
        detailThumnailVC.currentIndex = pageControlThumnail.currentPage
        detailThumnailVC.delegate = self
        self.navigationController?.present(detailThumnailVC, animated: true)
        
    }
    
    func setCurrentIndex(index: Int) {
        collectionViewThumnail.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .bottom)
        scrollViewThumnail.contentOffset = CGPointMake(CGFloat(index) * scrollViewThumnail.frame.width, 0)
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.backgroundColor = UIColor(named: "white shade")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.backgroundColor = nil
    }
    
    override func viewDidLayoutSubviews() {
        if firstLayout{
            firstLayout = false
            let scrollViewThumnailSize = scrollViewThumnail.bounds.size
            scrollViewThumnail.contentSize = CGSizeMake(scrollViewThumnailSize.width * CGFloat(imgChars.count), scrollViewThumnailSize.height)
            print("ssssssssss")
            print(scrollViewThumnailSize)
            scrollViewThumnail.showsHorizontalScrollIndicator = false
            scrollViewThumnail.showsVerticalScrollIndicator = false
            scrollViewThumnail.contentMode = .scaleAspectFill

            for index in 0...imgChars.count - 1 {
                let imgView = UIImageView(frame: CGRect(x: CGFloat(index) * scrollViewThumnailSize.width, y: 0, width: scrollViewThumnailSize.width , height: scrollViewThumnailSize.height))
                let imageThumnail = UIImage(named: imgChars[index])  
                imgView.image = imageThumnail
                imgView.contentMode = .scaleAspectFit
                scrollViewThumnail.addSubview(imgView)
            }
        }
    }
    
}
extension DetailViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showSearchVc()
        return false
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewThumnail{
            return imgChars.count
        }
        else if collectionView == self.collectionViewCategory{
            return categories.count
        }else{
            return items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       var cellToReturn = UICollectionViewCell()
        if collectionView == self.collectionViewThumnail{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumnailCollectionViewCell.indentifier, for: indexPath) as! ThumnailCollectionViewCell
            cell.setup(imgThumnailName: imgChars[indexPath.item])
            cellToReturn = cell
        }
        else if collectionView == self.collectionViewCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCellHorizontal", for: indexPath) as! CategoryCollectionViewCell
            let model = categories[indexPath.item]
            cell.setup(nameImg: model.imgName, title: model.title, numberSuggested: model.numberSuggestedItem)
            cellToReturn = cell
        }else if collectionView == self.collectionViewRelateItem{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell2.identifier, for: indexPath) as! ItemCollectionViewCell2
            let model = items[indexPath.item]
            cell.setup(imgName: model.imgName, price: model.price, title: model.title, brand: model.brand)
            cellToReturn = cell
        }
        return cellToReturn
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewThumnail{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3)
        }
        else if collectionView == self.collectionViewCategory{
            return CGSize(width: collectionView.frame.width / 2 , height:collectionView.frame.height)
        }else{
            return CGSize(width: collectionView.frame.width / 2 , height:collectionView.frame.height)
        }
  
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollViewThumnail.contentOffset = CGPointMake(CGFloat(indexPath.item) * scrollViewThumnail.frame.width, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.borderWidth = 0
    }
    
    
    
}
