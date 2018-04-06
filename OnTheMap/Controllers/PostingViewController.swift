//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class PostingViewController
: UIViewController {
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var tfLink: UITextField!
    
    @IBOutlet weak var btnFindLocation: UIButton!
    var clGeocoder = CLGeocoder()
    var studentInformation: StudentInformation?
    var locationName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func onClickFindLocationButton(_ sender: Any) {
        
        let location = tfLocation.text!
        let link = tfLink.text!
        
        if location.isEmpty || link.isEmpty {
            self.presentAlert(title: "Field required", message: "Please enter the location name") { (alert) in
                
            }
            
            return
        }
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
            self.presentAlert(title: "Field required", message: "Please enter the link") { (alert) in
                
            }
            
            return
        }
        
        findLocationByName(locationName: tfLocation.text!)

    }
    
    private func findLocationByName(locationName: String){
        clGeocoder.geocodeAddressString(locationName) { (placemarkers, error) in
            self.setUIEnabled(true)
            if let error = error {
                self.presentAlert(title: "Error", message: error.localizedDescription){ (alert) in
                }
                
            } else {
                
                var location: CLLocation?
                
                if let placemarks = placemarkers, placemarks.count > 0 {
                    location = placemarks.first?.location
                    self.locationName = ""
                    
                    if let name = placemarks.first?.name {
                        self.locationName = "\(name) "
                    }
                    if let city = placemarks.first?.administrativeArea {
                        self.locationName! += "\(city) "
                    }
                    
                    if let country = placemarks.first?.country {
                        self.locationName! += "\(country)"
                    }
                    
                    self.tfLocation.text = self.locationName!
                }
                
                if let location = location {
                    self.studentInformation = self.buildStudentInfo(location.coordinate)
                    self.performSegue(withIdentifier: "goToConfirmAddLocationSegue", sender: nil)
                    
                } else {
                    self.presentAlert(title: "Error", message: "Could not found your location"){ (alert) in
                    }
                    
                }
            }
        }
    }
    
    private func buildStudentInfo(_ coordinate: CLLocationCoordinate2D) -> StudentInformation {
        let studentInfo = [
            "uniqueKey": UserManager.shared.session?.account?.key,
            "firstName": UserManager.shared.user?.firstName! ?? "",
            "lastName": UserManager.shared.user?.lastName! ?? "",
            "mapString": tfLocation.text!,
            "mediaURL": tfLink.text!,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            ] as [String: AnyObject]
        return StudentInformation(studentInfo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToConfirmAddLocationSegue") {
            let vc = segue.destination as! ConfirmPostingViewController
            vc.studentInformation = self.studentInformation
            vc.locationName = self.locationName
        }
    }
    
}

extension PostingViewController
 {
    private func setUIEnabled(_ enabled: Bool) {
        tfLocation.isEnabled = enabled
        tfLink.isEnabled = enabled
        btnFindLocation.isEnabled = enabled
    }
}

