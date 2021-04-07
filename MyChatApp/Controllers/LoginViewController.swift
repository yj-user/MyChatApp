//
//  LoginViewController.swift
//  MyChatApp
//
//  Created by youngjun kim on 2021/04/07.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let safeError = error {
                    print(safeError)
                } else {
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
            }
        }
        
        
    }
    
}
