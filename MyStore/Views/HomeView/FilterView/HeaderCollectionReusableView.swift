//
//  HeaderCollectionReusableView.swift
//  MyStore
//
//  Created by Long Tran on 29/06/2023.
//

import UIKit

protocol HeaderCollectionReusableViewDelegate: AnyObject{
    func expand(at indexPath: IndexPath?)
}

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var lbl: CustomLabel!
    
    
    var selectedIndexPath : IndexPath?
    var delegate : HeaderCollectionReusableViewDelegate?
    static let identifier :String = "HeaderCollectionReusableView"
    static func nib() -> UINib {
        return UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(text : String){
        lbl.text = text
    }
    
    
    @IBAction func expandAction(_ sender: Any) {
        delegate?.expand(at: selectedIndexPath)
    }
    
}
