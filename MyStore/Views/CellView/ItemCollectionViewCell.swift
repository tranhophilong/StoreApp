//
//  ItemCollectionViewCell.swift
//  MyStore
//
//  Created by Long Tran on 17/06/2023.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: CustomLabel!
    @IBOutlet weak var lblTitle: CustomLabel!
    @IBOutlet weak var img: UIImageView!
    static let identifier : String = "ItemCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ItemCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(imgName : String, price : String, title : String){
        lblPrice.text = "$ " + price
        lblTitle.text = title
        img.image = UIImage(named: imgName)
    }

}
