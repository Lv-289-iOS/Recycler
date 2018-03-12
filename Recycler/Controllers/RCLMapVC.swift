//
//  RCLMapVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import GoogleMaps

class RCLMapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 49.838138, longitude: 24.044102, zoom: 12.0)
       let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
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
        
        // Creates a marker in the center of the map.
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 49.838138, longitude: 24.044102)
        marker.title = "Чернігівська 15"
        marker.snippet = "Кількість смітників: "
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: .red)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
