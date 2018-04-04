//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit

class AddLocationViewController: UIViewController {
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
             self.performSegue(withIdentifier: "goToConfirmAddLocationSegue", sender: nil)
    }
}


