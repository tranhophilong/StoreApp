//
//  ThumnailCollectionViewCell.swift
//  MyStore
//
//  Created by Long Tran on 15/07/2023.
//

import UIKit

class ThumnailCollectionViewCell: UICollectionViewCell {
    static let indentifier : String = "ThumnailCollectionViewCell"
    static var indexBefore: Int?
    
    static func nib() -> UINib {
        return UINib(nibName: "ThumnailCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var imgThumnail: UIImageView!
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                self.borderWidth = 1
            }else{
                self.borderWidth = 0
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       self.boderColor = UIColor(named: "Secondary")
        self.cornerRadius = 10
    }
    func setup(imgThumnailName: String){
        imgThumnail.image = UIImage(named: imgThumnailName)
        imgThumnail.contentMode = .scaleAspectFit
    }
    
}
