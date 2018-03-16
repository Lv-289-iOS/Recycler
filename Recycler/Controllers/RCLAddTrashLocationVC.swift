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

class RCLAddTrashLocationVC: UIViewController {
    
    var trashLocationDelegate: TrashLocationDelegate?
    
    private var locationManager = CLLocationManager()
    private var userLocation = CLLocation()
    private var trashLocation = TrashLocation()
    private var marker = GMSMarker()
    private var geocoder = GMSGeocoder()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addLocationBtn: UIButton!
    
    @IBAction func addLocationBtn(_ sender: UIButton) {
        geocoder.reverseGeocodeCoordinate(marker.position) { (response, error) in
            guard error == nil else { return }
            if let result = response?.firstResult()?.lines?.first {
                self.trashLocation.name = result
                self.trashLocation.latitude = self.marker.position.latitude
                self.trashLocation.longitude = self.marker.position.longitude
                self.completeAddingLocation()
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchLocationBtn(_ sender: UIBarButtonItem) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mapView.isMyLocationEnabled = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        viewDesign()
        loadMap()
        customizeMap()
    }
    
    private func loadMap() {
        mapView.settings.myLocationButton = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        if let locationOfMarker = locationManager.location {
            userLocation = locationOfMarker
            marker.position = userLocation.coordinate
            marker.map = mapView
            animateCameraTo(coordinate: userLocation.coordinate)
        }
    }
    
    private func completeAddingLocation() {
        trashLocationDelegate?.setLocation(location: trashLocation)
    }
    
    private func viewDesign() {
        addLocationBtn.backgroundColor = UIColor.darkModeratePink
        addLocationBtn.layer.cornerRadius = CGFloat.Design.CornerRadius
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 10)
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
    
    private func animateCameraTo(coordinate: CLLocationCoordinate2D, zoom: Float = 16.0) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.animate(to: camera)
    }
}

extension RCLAddTrashLocationVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        animateCameraTo(coordinate: coordinate)
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        marker.position = userLocation.coordinate
        animateCameraTo(coordinate: userLocation.coordinate)
        return true
    }
}

extension RCLAddTrashLocationVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        mapView.reloadInputViews()
        mapView.clear()
        animateCameraTo(coordinate: place.coordinate)
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.map = mapView
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RCLAddTrashLocationVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}
