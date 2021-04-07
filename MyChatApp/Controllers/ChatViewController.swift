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
    
    let db = Firestore.firestore()
    
    var message: [Messages] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        title = "My Chat"
        navigationItem.hidesBackButton = true
        
        chatTableView.register(UINib(nibName: "MessageBubble", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadData()
    }
    
    func loadData() {
        
        db.collection("users").getDocuments() { (querySnapshot, error) in
            
            self.message = []
            
            if let safeError = error {
                print("Error getting documents: \(safeError)")
            } else {
                if let rawData = querySnapshot?.documents {
                    for doc in rawData {
                        let pureData = doc.data()
                        if let messageSender = pureData["sender"] as? String, let messageBody = pureData["body"] as? String {
                            let newMessage = Messages(sender: messageSender, body: messageBody)
                            self.message.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        db.collection("users").addDocument(data: [
            "sender": Auth.auth().currentUser?.email,
            "body": chatTextField.text,
            
        ]) { error in
            if let safeError = error {
                print("Error adding document: \(safeError)")
            } else {
                print("data saved")
            }
        }
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
