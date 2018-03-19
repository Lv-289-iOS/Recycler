//
//  RCLMapVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class RCLMapVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mapView: GMSMapView!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 49.841608, longitude: 24.031728, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "RCLMapStyle", withExtension: "json")
            {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        view = mapView
    
        addMarkers()
        addTitleLabel(text: "Public trash cans")
    }
  

    
    private func addMarkers(){
        let parsed = RLCParsingByJSON()
        parsed.temp { (trashList, error) in
            
            let marker = GMSMarker()
            let pos = CLLocationCoordinate2D(latitude: 49.839734, longitude: 24.036009)
            marker.position = pos
            marker.map = self.view as? GMSMapView
//            if error == nil {
//                for trash in trashList! {
//                    let markerImage = #imageLiteral(resourceName: "smallPin")
//                    let marker = GMSMarker()
//                    marker.position = trash.coordinate
//                    marker.title = trash.nameInJson
//                    marker.snippet = "Кількість смітників: \(trash.numberOfRaffleInJson)"
//                    marker.icon = markerImage//GMSMarker.markerImage(with: .red)
//                    marker.map = self.view as? GMSMapView
//
//                }
//            }
            
            print("TrashCount \(String(describing: trashList?.count)) error: \(String(describing: error))")
}
    }

    
}
