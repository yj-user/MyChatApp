//
//  RegisterViewController.swift
//  MyChatApp
//
//  Created by youngjun kim on 2021/04/07.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let safeError = error {
                    print(safeError)
                } else {
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
        
    }
    
}

