//
//  RCLAddTrashLocationVC.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 09.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation

class RCLAddTrashLocationVC: UIViewController,GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
    }
    
    
    lazy var currentPlace = GMSPlace()
    var isOnEnter = true
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var selectedLocation = CLLocation()
    lazy var geocoder = GMSGeocoder()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var marker = GMSMarker()
    var radiusCircle = GMSCircle()
    let defaultCamera = GMSCameraPosition.camera(withLatitude: 49.8383,
                                                 longitude: 24.0232,
                                                 zoom: 12.0)
    var isAddLocationTapped = false
    var isGeocodeCompleted = false
    
   
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addLocationBtn: UIButton!
    
    @IBAction func addLocationBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
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
        animateCameraTo(coordinate: userLocation.coordinate)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        if let loc = locationManager.location {
            userLocation = loc
            animateCameraTo(coordinate: userLocation.coordinate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        marker.position = userLocation.coordinate
        marker.map = mapView
    }
    
    private func animateCameraTo(coordinate: CLLocationCoordinate2D, zoom: Float = 14.0) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.animate(to: camera)
    }
}

extension RCLAddTrashLocationVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}

extension RCLAddTrashLocationVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        animateCameraTo(coordinate: userLocation.coordinate)
        return true
    }
}

extension RCLAddTrashLocationVC: UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}
