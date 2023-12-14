//
//  FilterCollectionViewCell.swift
//  MyStore
//
//  Created by Long Tran on 29/06/2023.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl: CustomLabel!
    static let identifier = "FilterCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "FilterCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(text : String){
        lbl.text = text
    }

}
