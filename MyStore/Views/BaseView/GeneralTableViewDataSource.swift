//
//  GeneralTableViewDataSource.swift
//  MyStore
//
//  Created by Long Tran on 23/07/2023.
//

import Foundation
import UIKit

class GeneralTableViewDataSource<Model> :NSObject, UITableViewDataSource{

    
    typealias ConfigureCell  = (Model, UITableViewCell) -> Void
    
    var models : [Model]
    private var reuseIdentifier : String
    private var cellConfigure : ConfigureCell
    
    
    init(models: [Model], reuseIdentifier: String, cellConfigure: @escaping ConfigureCell) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigure = cellConfigure
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let model = models[indexPath.row]
        cellConfigure(model, cell)
        return cell
    }
    
    
    
    
    
}
