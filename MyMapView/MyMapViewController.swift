//
//  MyMapViewController.swift//  MyMapView
//
//  Created by Никита on 22.01.2024.
//

import UIKit
import MapKit
import CoreLocation

class MyMapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    lazy var localButton: UIButton = {
        let locButton = UIButton()
        locButton.backgroundColor = .systemGreen
        locButton.setTitle("Loc", for: .normal)
        locButton.addTarget(self, action: #selector(centerAction), for: .touchUpInside)
        locButton.translatesAutoresizingMaskIntoConstraints = false
        return locButton
    }()
    
    lazy var removeButton: UIButton = {
        let remButton = UIButton()
        remButton.backgroundColor = .systemGreen
        remButton.setTitle("Rem", for: .normal)
        remButton.addTarget(self, action: #selector(removeAnnotations), for: .touchUpInside)
        remButton.translatesAutoresizingMaskIntoConstraints = false
        return remButton
    }()
    
    var mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupConstraints()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        let pickGesture = UITapGestureRecognizer(target: self, action: #selector(tapMapGesture))
        mapView.addGestureRecognizer(pickGesture)
    }
    
    @objc func tapMapGesture(_ gr: UITapGestureRecognizer) {
        let point = gr.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "My location"
        mapView.addAnnotation(annotation)
        guard let startLocation = locationManager.location?.coordinate else {return}
        mapView.showRouteOnMap(pickupCoordinate: startLocation, destinationCoordinate: coordinate)
    }
    
    @objc func centerAction() {
        mapCenter()
    }
    
    @objc func removeAnnotations() {
        // Removing annotations
        let annotations = mapView.annotations.filter({ !($0 is MKUserLocation) })
        mapView.removeAnnotations(annotations)
        // Removing routes
        for overlay in mapView.overlays
        {
            mapView.removeOverlay(overlay)
        }
    }
    
    func mapCenter() {
        locationManager.startUpdatingLocation()
        guard let location = locationManager.location?.coordinate else {return}
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(mapView)
        mapView.addSubview(localButton)
        mapView.addSubview(removeButton)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            localButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            localButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20),
            
            removeButton.trailingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 55),
            removeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20)
        ])
    }
    
    
    
}

extension MyMapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            print(location.latitude, location.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
}

extension MKMapView {
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}
