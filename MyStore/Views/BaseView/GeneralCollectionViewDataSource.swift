//
//  ItemCollectionViewDataSource.swift
//  MyStore
//
//  Created by Long Tran on 22/07/2023.
//

import Foundation
import UIKit

class GeneralCollectionViewDataSource<Model> : NSObject, UICollectionViewDataSource{
    typealias CellConfigure = (Model, UICollectionViewCell) -> Void
    
    
    var models : [Model]
    private var reuseIdentifier : String
    private var cellConfigure : CellConfigure
    
    init(models: [Model], reuseIdentifier: String, cellConfigure: @escaping CellConfigure) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigure = cellConfigure
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                let model = models[indexPath.item]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                cellConfigure(model, cell)
                return cell
        
            }
 
    }

  
