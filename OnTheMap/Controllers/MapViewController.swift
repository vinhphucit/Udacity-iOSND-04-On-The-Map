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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView(){
        mkMapView.delegate = self
    }
}


