//
//  ChatViewController.swift
//  MyChatApp
//
//  Created by youngjun kim on 2021/04/07.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var chatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Chat"
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }
    
}
