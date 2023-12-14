//
//  Country.swift
//  MyStore
//
//  Created by Long Tran on 08/05/2023.
//

import Foundation


class Country{
    static let  shared = Country()
    
    var dctCountry : [String: [[String:Any]]] = [:]
    var listFirstChar : [String] = []
    
    private init(){
        readJSONFile(forName: "CountryCodes")
    }
    
    func readJSONFile(forName name: String) {
        
        guard let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String else {
            return
        }
       do {
          if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [[String: Any]] {
                 for country in json{
                     let code = country["code"] as! String
                     if code == countryCode{
                        dctCountry["Suggest"] = [country]
                     }
                     let name = country["name"] as! String
                     if dctCountry[String(name.first!)] != nil{
                         dctCountry[String(name.first!)]?.append(country)
                     }else{
                         
                         listFirstChar.append(String(name.first!))
                         dctCountry[String(name.first!)] = [country]
                     }
                 }
                 listFirstChar.sorted{
                     $0 > $1
                 }
                 
                 listFirstChar.insert("Suggest", at: 0)
                    
             } else {
                print("Given JSON is not a valid dictionary object.")
             }
          }
       } catch {
          print(error)
       }

    }
}
