//
//  DetailThumnailViewController.swift
//  MyStore
//
//  Created by Long Tran on 16/07/2023.
//

import UIKit

protocol DetailThumnailViewDelegate : AnyObject{
    func setCurrentIndex(index : Int)
}

class DetailThumnailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var collectionViewThumnail: UICollectionView!
    @IBOutlet weak var scrollViewThumnail: UIScrollView!
    
    var imgThumnails : [String]?
    var photoZooms : [UIImageView] = []
    var frontScrollViews : [UIScrollView] = []
    private var firstLayout : Bool = true
    var currentIndex : Int?
    weak var delegate : DetailThumnailViewDelegate?
    var scaleZoom : CGFloat = 0.5
    private var scrollViewThumnaillDelegate = ScrollViewThumnailDelegate()
    private var collectionViewThumnailDatasource : GeneralCollectionViewDataSource<String>?

    
    private var collectionViewDataSource : GeneralCollectionViewDataSource<Any>?
    override func viewDidLoad() {
        super.viewDidLoad()
//        setup pagecontroll
        pageControll.pageIndicatorTintColor = UIColor.white
        pageControll.currentPageIndicatorTintColor = UIColor(named: "Btncolor")
//        setup scrollview
        scrollViewThumnaillDelegate.collectionViewThumnail = collectionViewThumnail
        scrollViewThumnaillDelegate.pageControll = pageControll
        scrollViewThumnaillDelegate.scrollViewThumnail = scrollViewThumnail
        scrollViewThumnail.delegate = scrollViewThumnaillDelegate
        scrollViewThumnail.isPagingEnabled = true
        
//        setup collectionview
        
        guard let imgThumnails = self.imgThumnails else {
            return
        }
        let collectionViewDatasource = GeneralCollectionViewDataSource(models: imgThumnails, reuseIdentifier: ThumnailCollectionViewCell.indentifier) { model, cell in
            (cell as! ThumnailCollectionViewCell).setup(imgThumnailName: model)
        }
        self.collectionViewThumnailDatasource = collectionViewDatasource
        collectionViewThumnail.delegate = self
        collectionViewThumnail.dataSource = collectionViewDatasource
        collectionViewThumnail.register(ThumnailCollectionViewCell.nib(), forCellWithReuseIdentifier: ThumnailCollectionViewCell.indentifier)

    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if firstLayout{
            guard let imgThumnails = imgThumnails else{
                return
            }
            firstLayout = false
            let scrollViewThumnailSize = scrollViewThumnail.bounds.size
            scrollViewThumnail.contentSize = CGSizeMake(scrollViewThumnailSize.width * CGFloat(imgThumnails.count), scrollViewThumnailSize.height)
            scrollViewThumnail.showsHorizontalScrollIndicator = false
            scrollViewThumnail.showsVerticalScrollIndicator = false
            scrollViewThumnail.contentMode = .scaleAspectFill
            for index in 0...imgThumnails.count - 1 {
                let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
                tap.numberOfTapsRequired = 1
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
                tap.require(toFail: doubleTap)
                doubleTap.numberOfTapsRequired  = 2
                let frontScrollView = UIScrollView(frame: CGRect(x: CGFloat(index) * scrollViewThumnailSize.width, y: 0, width: scrollViewThumnailSize.width, height: scrollViewThumnailSize.height))
                let imgView = UIImageView(frame: CGRect(x: 0 , y: 0, width: frontScrollView.frame.width , height: frontScrollView.frame.height))
                let imageThumnail = UIImage(named: imgThumnails[index])
                imgView.image = imageThumnail
                imgView.contentMode = .center
                imgView.isUserInteractionEnabled = true
                imgView.addGestureRecognizer(tap)
                imgView.addGestureRecognizer(doubleTap)
                frontScrollView.addSubview(imgView)
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollViews.append(frontScrollView)
                photoZooms.append(imgView)
                scrollViewThumnail.addSubview(frontScrollView)
            }
            
            if let currentIndex = currentIndex{
                collectionViewThumnail.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
                scrollViewThumnail.contentOffset = CGPointMake(CGFloat(currentIndex) * scrollViewThumnail.frame.width, 0)
            }

        }
    }
    
    @objc func tap(sender : UIGestureRecognizer){
        self.dismissAction(self)
    }
    
    @objc func doubleTap(sender : UIGestureRecognizer){
        if scaleZoom == 0.5 {
            scaleZoom = 1.5
        }else{
            scaleZoom = 0.5
        }
        let position = sender.location(in: photoZooms[pageControll.currentPage])
        zoomRectForScale(scale: scaleZoom, center: position, frontScrollView: frontScrollViews[pageControll.currentPage])
    }
    
    func zoomRectForScale(scale : CGFloat, center :CGPoint, frontScrollView : UIScrollView){
        var rect = CGRect()
        rect.size.width = scrollViewThumnail.bounds.width / scale
        rect.size.height = scrollViewThumnail.bounds.height / scale
        rect.origin.x = center.x - rect.size.width / 2
        rect.origin.y = center.y - rect.size.height / 2
        frontScrollView.zoom(to: rect, animated: true)
    }
    

    @IBAction func dismissAction(_ sender: Any) {
            delegate?.setCurrentIndex(index: pageControll.currentPage)
            self.dismiss(animated: true)
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoZooms[pageControll.currentPage]
    }
}

extension DetailThumnailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollViewThumnail.contentOffset = CGPointMake(CGFloat(indexPath.item) * scrollViewThumnail.frame.width, 0)
    }
    
    
}
