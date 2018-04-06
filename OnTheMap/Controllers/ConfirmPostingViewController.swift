//
//  ConfirmPostingViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/5/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ConfirmPostingViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var btnFinish: UIButton!
    
    var studentInformation: StudentInformation?
    var locationName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        mkMapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    private func showLocation() {
        mkMapView.removeAnnotations(mkMapView.annotations)
        if let student = self.studentInformation {
            let annotation = MKPointAnnotation()
            if let locationName = locationName{
            annotation.title = locationName
            }
            annotation.coordinate = CLLocationCoordinate2DMake(student.latitude!, student.longitude!)
            mkMapView.addAnnotation(annotation)
        }
        mkMapView.showAnnotations(mkMapView.annotations, animated: true)
    }
    
    @IBAction func onClickFinishButton(_ sender: Any) {
        self.setUIEnabled(false)
        NetworkClient.shared.doPostStudentLocation(student: self.studentInformation!, completion: { (data, error) in
            self.setUIEnabled(true)
            if error != nil {
                self.presentAlert(title: "Can post user to server", message: error!) { (alert) in
                    
                }
                
            }else {
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
            
        })
    }
}
extension ConfirmPostingViewController {
    private func setUIEnabled(_ enabled: Bool) {
        btnFinish.isEnabled = enabled
        btnFinish.alpha = enabled ? 1.0 : 0.5
    }
}
