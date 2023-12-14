//
//  Model.swift
//  MyStore
//
//  Created by Long Tran on 07/07/2023.
//

import Foundation
import UIKit

//struct HeaderItem: Hashable{
//    let tittle : String
//}

struct PillItem : Hashable{
    let tille : String
}

struct Section: Hashable{
    let id = UUID()
    var isExpand : Bool = true
    let title: String
    let pills: [PillItem]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool{
       return  lhs.id == rhs.id
    }
}


