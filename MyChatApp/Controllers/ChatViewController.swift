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
    
    var message: [Messages] = [
        Messages(sender: "1@2.com", body: "This is hard"),
        Messages(sender: "1@2.com", body: "but it's worth it")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        title = "My Chat"
        navigationItem.hidesBackButton = true
        
        chatTableView.register(UINib(nibName: "MessageBubble", bundle: nil), forCellReuseIdentifier: "ReusableCell")
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

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageBubble
        
        cell.messageLabel.text = message[indexPath.row].body
        return cell
    }
    
    
}
