//
//  LocationsViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit

class LocationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableviewLocations: UITableView!
    
    var locations: [StudentInformation]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LocationsViewController.onRefreshDataCompleted), name: NSNotification.Name(rawValue: "refreshDataCompleted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LocationsViewController.onRefreshDataStarted), name: NSNotification.Name(rawValue: "refreshDataStarted"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locations = UserManager.shared.locations
        self.tableviewLocations.reloadData()
    }
    @objc private func onRefreshDataStarted() {
        
    }
    @objc private func onRefreshDataCompleted() {
        self.locations = UserManager.shared.locations
        self.tableviewLocations.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "LocationCellIdentifier"
        let location = self.locations[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LocationViewCell!
        
        /* Set cell defaults */
        cell?.lblLocationName!.text = (location.firstName == nil ? "" : "\(location.firstName!) ") + (location.lastName == nil ? "" : "\(location.lastName!) ")
        if let mediaURL = location.mediaURL {
            cell?.lblLocationUrl!.text = mediaURL
        }else{
            cell?.lblLocationUrl!.text = ""
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mediaURL = locations[indexPath.row].mediaURL {
            MiscUtils.openExternalLink(mediaURL)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


