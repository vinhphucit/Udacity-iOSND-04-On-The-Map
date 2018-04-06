//
//  TabBarLocationsViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/5/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit

class TabBarLocationsViewController: UITabBarController {
    
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(TabBarLocationsViewController.onRefreshData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
        onRefreshData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClickLogoutButton(_ sender: Any) {
        setUIEnabled(false)
        NetworkClient.shared.doLogout(session: UserManager.shared.session!.session!.id!, completion: {(data, error) in
            self.setUIEnabled(true)
            UserManager.shared.session = nil
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    @IBAction func onClickRefreshButton(_ sender: Any) {
        onRefreshData()
    }
    @IBAction func onClickAddButton(_ sender: Any) {
    }
    
    @objc func onRefreshData(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshDataStarted"), object: nil)
        NetworkClient.shared.doGetLocations(completion: { (data, error) in
            if error != nil {
                self.presentAlert(title: "Load Location fail", message: error!) { (alert) in
                    
                }
            }else {
                UserManager.shared.locations = data!.results
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshDataCompleted"), object: nil)
            }
            
        })
    }
}
extension TabBarLocationsViewController {
    private func setUIEnabled(_ enabled: Bool) {
        btnAdd.isEnabled = enabled
        btnLogout.isEnabled = enabled
        btnAdd.isEnabled = enabled
    }
}
