//
//  ViewController.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/2/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickLoginButton(_ sender: Any) {
        self.setUIEnabled(false)
        guard  let email = tfEmail.text, !email.isEmpty else {
            self.presentAlert(title: "Field required", message: "Please fill your email in"){ (alert) in
                self.setUIEnabled(true)
            }
            return
        }
       
        guard  let password = tfPassword.text, !password.isEmpty else {
            self.presentAlert(title: "Field required", message: "Please fill your password in"){ (alert) in
                self.setUIEnabled(true)
            }
            return
        }
        
        doLogin(email: email, password: password);
    }
    
    @IBAction func onClickSignUpButton(_ sender: Any) {
        MiscUtils.openExternalLink("https://auth.udacity.com/sign-up")
    }
    
    private func doLogin(email: String, password: String){
        NetworkClient.shared.doLogin(email: email, password: password, completion: { (data, error) in
            
            if error != nil {
                
                self.presentAlert(title: "Login Fail", message: error!) { (alert) in
                self.setUIEnabled(true)
                }
                
            }else {
                
               self.completeLogin(data!)
            }
            
        })
    }
    
    private func completeLogin(_ session: AuthSessionModel){
        UserManager.shared.session = session
        NetworkClient.shared.doGetUserInfo(completion: { (data, error) in
            self.setUIEnabled(true)
            if error != nil {
                self.presentAlert(title: "Can not get User Info", message: error!) { (alert) in
                    
                }
                
            }else {
                self.tfEmail.text = ""
                self.tfPassword.text = ""
                UserManager.shared.user = data?.user
                self.performSegue(withIdentifier: "goToMainScreenSegue", sender: nil)
            }
            
        })
         
    }
}

extension AuthenticationViewController {
    private func setUIEnabled(_ enabled: Bool) {
        btnLogin.isEnabled = enabled
        btnLogin.alpha = enabled ? 1.0 : 0.5
        tfEmail.isEnabled = enabled
        tfPassword.isEnabled = enabled
    }
}
