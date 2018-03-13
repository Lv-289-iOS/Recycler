//
//  RCLParsingByJSON.swift
//  Recycler
//
//  Created by Володимир Смульський on 3/13/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreLocation

struct TrashFromJson {
    var nameInJson:String = ""
    var longitudeInJson:Double = 0
    var latitudeInJson:Double = 0
    var numberOfRaffleInJson:Double = 1
    var idInJson: Double = 0
}


extension TrashFromJson {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitudeInJson, longitude: self.longitudeInJson)
    }
}

class RLCParsingByJSON {
    
    let idIndex = 0
    let latitudeIndex = 4
    let longitudeIndex = 5
    let numberOfraffleIndex = 6
    let arrayOfLinks = ["https://firebasestorage.googleapis.com/v0/b/recycler032.appspot.com/o/Divided%20trashmap(.json)%2FBigDiv4%20(2).json?alt=media&token=9840c3cb-c231-44f4-8e50-8e960c7a5138"]
    
    func temp(){
        for i in 0..<arrayOfLinks.count {
            Alamofire.request( arrayOfLinks[i], method: .get).validate().responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        return
                    }
                    
                    DispatchQueue.global().async {
                        let str = String.init(data: data, encoding: String.Encoding.utf8)
                        let json = JSON.init(parseJSON: str!)
                        var trashDictionary = [String:TrashFromJson]()
                        
                        for trashJson in json["Placemark"].arrayValue {
                            var trash = TrashFromJson()
                            trash.nameInJson = trashJson["name"].string ?? ""
                            
                            if let lat = trashJson["ExtendedData"]["Data"][self.latitudeIndex]["value"].string {
                                trash.latitudeInJson = Double(lat) ?? 0
                            }
                            if let long = trashJson["ExtendedData"]["Data"][self.longitudeIndex]["value"].string {
                                trash.longitudeInJson = Double(long) ?? 0
                            }
                            if let name = trashDictionary [trash.nameInJson] {
                                trash.nameInJson = name.nameInJson
                            }
                            
                            if let numberOfRaffle = trashJson["ExtendedData"]["Data"][6]["value"].string {
                                trash.numberOfRaffleInJson = Double(numberOfRaffle) ?? 0
                            }
                            
                            if let id = trashJson["ExtendedData"]["Data"][self.idIndex]["value"].string {
                                trash.idInJson = Double(id) ?? 0
                            }
                            
                            print("name = \(trash.nameInJson),coordinates: latitude = \(trash.latitudeInJson), longitude = \(trash.longitudeInJson), numberOfRaffle = \(trash.numberOfRaffleInJson),id = \(trash.idInJson)\n")
                            
                            trashDictionary[trash.nameInJson] = trash
                        }
                        print(trashDictionary.count)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
