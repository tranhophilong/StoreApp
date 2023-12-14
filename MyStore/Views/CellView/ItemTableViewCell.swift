//
//  ItemTableViewCell.swift
//  MyStore
//
//  Created by Long Tran on 19/06/2023.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPrice: CustomLabel!
    @IBOutlet weak var lblBrand: CustomLabel!
    @IBOutlet weak var lblTitle: CustomLabel!
    @IBOutlet weak var img: UIImageView!
    static let identifier =  "ItemTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ItemTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(imgName : String, title : String, price: String){
        img.image = UIImage(named: imgName)
        lblTitle.text = title
        lblPrice.text = price
        lblBrand.text = "brand"
    } 
    
}
