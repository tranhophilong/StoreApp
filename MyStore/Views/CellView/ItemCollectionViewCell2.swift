//
//  ItemCollectionViewCell2.swift
//  MyStore
//
//  Created by Long Tran on 24/07/2023.
//

import UIKit

class ItemCollectionViewCell2: UICollectionViewCell {

    @IBOutlet weak var lblPrice: CustomLabel!
    @IBOutlet weak var lblBrand: CustomLabel!
    @IBOutlet weak var lblTitle: CustomLabel!
    @IBOutlet weak var img: UIImageView!
    static let identifier : String = "ItemCollectionViewCell2"
    static func nib() -> UINib{
        return UINib(nibName: "ItemCollectionViewCell2", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(imgName: String, price: String, title: String, brand: String){
        img.image = UIImage(named: imgName)
        lblPrice.text = "$ " + price
        lblTitle.text = title
        lblBrand.text = brand
    }

}
