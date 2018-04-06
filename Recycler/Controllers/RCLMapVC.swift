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

class RCLMapVC: UIViewController,CLLocationManagerDelegate {
    
    private var clusterManager: GMUClusterManager?
    private var locationManager = CLLocationManager()
    private var userLocation = CLLocation()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleLabel(text: "Public trash cans")
        customMap()
        initMarkers()
        initCluster()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initMap()
    }
    
    private func initMap() {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        if let locationOfMarker = locationManager.location {
            userLocation = locationOfMarker
            animateCameraTo(coordinate: userLocation.coordinate)
        }
    }
    
    private func initCluster() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager?.setDelegate(self, mapDelegate: self)
        clusterManager?.cluster()
    }
    
    private func initMarkers() {
        let parsed = RLCParsingByJSON()
        parsed.temp { (trashList, error) in
            if error == nil {
                for trash in trashList! {
               let lat = trash.coordinate.latitude
                    let lng = trash.coordinate.longitude
                    let name = trash.nameInJson
                    let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name)
                    self.clusterManager?.add(item)
                }
            }
            self.animateCameraTo(coordinate: self.userLocation.coordinate, zoom: 17)
        }
    }
    
    private func customMap() {
        do {
            if let styleURL = Bundle.main.url(forResource: "RCLMapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL) } else {
                NSLog("Unable to find style.json")}
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")}
    }
    
    private func animateCameraTo(coordinate: CLLocationCoordinate2D, zoom: Float = 16.0) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.animate(to: camera)
    }
}

extension RCLMapVC : GMUClusterManagerDelegate {
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return false
    }
}

extension RCLMapVC : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? POIItem {
            NSLog("Did tap marker for cluster item \(poiItem.name)")
        } else {
            NSLog("Did tap a normal marker")
        }
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        animateCameraTo(coordinate: userLocation.coordinate)
        return true
    }
}
