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
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private var locationManager = CLLocationManager()
    private var userLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleLabel(text: "Public trash cans")
        addMarkers()
        customizeMap()
        loadMap()
    }
    
    private func loadMap() {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        if let locationOfUser = locationManager.location {
            userLocation = locationOfUser
            animateCameraTo(coordinate: userLocation.coordinate)
        }
    }
    
    private func animateCameraTo(coordinate: CLLocationCoordinate2D, zoom: Float = 16.0) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.animate(to: camera)
    }
    
    private func customizeMap() {
        do {
            if let styleURL = Bundle.main.url(forResource: "RCLMapStyle", withExtension: "json")
            {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    private func addMarkers(){
        let parsed = RLCParsingByJSON()
        parsed.temp { (trashList, error) in
            if error == nil {
                for trash in trashList! {
                    let markerImage = #imageLiteral(resourceName: "smallPin")
                    let marker = GMSMarker()
                    marker.position = trash.coordinate
                    marker.title = trash.nameInJson
                    marker.snippet = "Кількість смітників: \(trash.numberOfRaffleInJson)"
                    marker.icon = markerImage
                    marker.map = self.mapView
                }
            }
            print("TrashCount \(String(describing: trashList?.count)) error: \(String(describing: error))")
        }
    }
}
