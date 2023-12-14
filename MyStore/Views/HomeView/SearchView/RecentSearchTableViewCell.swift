//
//  RecentSearchTableViewCell.swift
//  MyStore
//
//  Created by Long Tran on 15/06/2023.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSearchTitle: UILabel!
    
    @IBOutlet weak var btnDelete: CustommButton!
    
    @IBOutlet weak var imgTime: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgTime.image?.withTintColor(UIColor.lightGray, renderingMode: UIImage.RenderingMode.alwaysTemplate)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnDelete.addTarget(self, action: #selector(didTapDelete), for: UIControl.Event.touchUpInside)
    }
    
    var didDelete : () -> () = {}
    
    func setUp(title: String){
        lblSearchTitle.text = title
    }
    
    @objc func didTapDelete(){
        didDelete()
    }
    
    
    

    

}
