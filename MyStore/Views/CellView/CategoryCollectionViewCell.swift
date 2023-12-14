//
//  CategoryCollectionViewCell.swift
//  MyStore
//
//  Created by Long Tran on 22/07/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
//    static let identifier : String = "CategoryCollectionViewCell"
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblNumberSuggestedItem : UILabel!
    
    func setup(nameImg : String, title: String, numberSuggested : String){
        img.image = UIImage(named: nameImg)
        lblTitle.text = title
        lblNumberSuggestedItem.text = numberSuggested + " " + "suggested items"
    }
}
