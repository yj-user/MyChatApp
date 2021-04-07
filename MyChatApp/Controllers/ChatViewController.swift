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
        
        db.collection("users").order(by: "time").addSnapshotListener { (querySnapshot, error) in
            
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
                                
                                let i = IndexPath(row: self.message.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: i, at: .top, animated: true)
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
            "time": Date().timeIntervalSince1970
        ]) { error in
            if let safeError = error {
                print("Error adding document: \(safeError)")
            } else {
                print("data saved")
                self.chatTextField.text = ""
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
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
        
        let content = message[indexPath.row]
        cell.messageLabel.text = content.body
        
        let sender = content.sender
        let body = content.body
        
        if sender == Auth.auth().currentUser?.email {
            cell.bubble.backgroundColor = UIColor(named: "yellow")
            cell.messageLabel.textColor = UIColor.black
            cell.rightImage.isHidden = false
            cell.leftImage.isHidden = true
        } else {
            cell.bubble.backgroundColor = UIColor(named: "BrandLightBlue")
            cell.messageLabel.textColor = UIColor.black
            cell.rightImage.isHidden = true
            cell.leftImage.isHidden = false
        }
        
        return cell
    }
    
    
}
