//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mkMapView: MKMapView!
    
    var locations: [StudentInformation]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.onRefreshDataCompleted), name: NSNotification.Name(rawValue: "refreshDataCompleted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.onRefreshDataStarted), name: NSNotification.Name(rawValue: "refreshDataStarted"), object: nil)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locations = UserManager.shared.locations
        showLocations(locations)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        mkMapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let link = view.annotation?.subtitle  {
            MiscUtils.openExternalLink(link)
            
        }
    }
    
    @objc private func onRefreshDataStarted() {
        
    }
    @objc private func onRefreshDataCompleted() {
        locations = UserManager.shared.locations
        showLocations(locations)
    }
    
    private func showLocations(_ locations: [StudentInformation]) {
        mkMapView.removeAnnotations(mkMapView.annotations)
        for location in locations where location.latitude != nil && location.longitude != nil {
            let annotation = MKPointAnnotation()
            annotation.title = (location.firstName == nil ? "" : "\(location.firstName!) ") + (location.lastName == nil ? "" : "\(location.lastName!) ")
            annotation.subtitle = location.mediaURL
            annotation.coordinate = CLLocationCoordinate2DMake(location.latitude!, location.longitude!)
            mkMapView.addAnnotation(annotation)
        }
        mkMapView.showAnnotations(mkMapView.annotations, animated: true)
    }
    
    
}


