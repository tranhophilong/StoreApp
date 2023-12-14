//
//  CountryViewController.swift
//  MyStore
//
//  Created by Long Tran on 08/05/2023.
//

import UIKit

protocol CountryViewControllerDelegate: AnyObject {
    func setImageAndCountryCode(image: String,  dialCode: String)
}

class CountryViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var titleVc: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    let countrySuggest = Country.shared.dctCountry[Country.shared.listFirstChar[0]]![0]
    weak var delegate : CountryViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        self.tableView.sectionIndexColor = UIColor.gray
        tableView.delegate = self
        tableView.dataSource  = self
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setUpNav(){
        navBar.borderWidth = 0.2
        navBar.tintColor = UIColor.black
        navBar.barTintColor = UIColor(named: "Btncolor")
        titleVc.title = "Choose Nation"
    }
    

}

extension CountryViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Country.shared.listFirstChar.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Country.shared.dctCountry[Country.shared.listFirstChar[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let country = Country.shared.dctCountry[Country.shared.listFirstChar[indexPath.section]]![indexPath.row]
        
        
        cell.textLabel?.text = (country["name"] as! String)
        cell.tintColor = UIColor.green
//        
        if indexPath == [0,0] {
            cell.accessoryType = .checkmark
            
        }else if country["code"] as! String == countrySuggest["code"] as! String{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        cell.imageView?.image = UIImage(named: country["code"] as! String)
        
        return cell
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var arrSectionIndex = Country.shared.listFirstChar
        arrSectionIndex.remove(at: 0)
        return arrSectionIndex
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return String(Country.shared.listFirstChar[section])
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let country = Country.shared.dctCountry[Country.shared.listFirstChar[indexPath.section]]![indexPath.row]
            if let cell = tableView.cellForRow(at: indexPath){
                if cell.accessoryType == .none{
                    cell.accessoryType = .checkmark
                    if  Country.shared.dctCountry[Country.shared.listFirstChar[0]]?.count == 2{
                        Country.shared.dctCountry[Country.shared.listFirstChar[0]]?.remove(at: 0)
                    }
                    Country.shared.dctCountry[Country.shared.listFirstChar[0]]?.insert(country, at: 0)
                    
                    if Country.shared.dctCountry[Country.shared.listFirstChar[0]]?[0]["code"] as! String == Country.shared.dctCountry[Country.shared.listFirstChar[0]]?[1]["code"] as! String{
                        Country.shared.dctCountry[Country.shared.listFirstChar[0]]?.remove(at: 0)

                    }
                                    
                    tableView.reloadData()
                    
                    delegate?.setImageAndCountryCode(image: country["code"] as! String, dialCode: country["dial_code"] as! String)
                }
//
            }

            
            dismiss(animated: true)
            
        }
        
    }

