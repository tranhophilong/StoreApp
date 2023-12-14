//
//  ScrollViewThumnailDelegate.swift
//  MyStore
//
//  Created by Long Tran on 19/07/2023.
//

import Foundation
import UIKit

class ScrollViewThumnailDelegate : NSObject, UIScrollViewDelegate{
    
    var scrollViewThumnail : UIScrollView!
    var collectionViewThumnail : UICollectionView!
    var pageControll  : UIPageControl!
    private  var indexBefore : Int!

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
  
        
        let halfWidthImg = scrollViewThumnail.contentSize.width / CGFloat(pageControll.numberOfPages * 2)
        let index = Int((scrollViewThumnail.contentOffset.x + halfWidthImg) / scrollViewThumnail.frame.width)
        
        if let indexBefore = indexBefore{
            collectionViewThumnail.cellForItem(at: IndexPath(item: indexBefore, section: 0))?.isSelected = false
        }
        collectionViewThumnail.cellForItem(at: IndexPath(item: index, section: 0))?.isSelected = true
        pageControll.currentPage = index
        collectionViewThumnail.scrollToItem(at: IndexPath(item: pageControll.currentPage, section: 0), at: UICollectionView.ScrollPosition.centeredVertically, animated: true)
        indexBefore = pageControll.currentPage

    }
    

}
