//
//  MessageBubble.swift
//  MyChatApp
//
//  Created by youngjun kim on 2021/04/07.
//

import UIKit

class MessageBubble: UITableViewCell {

    @IBOutlet var bubble: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var rightImage: UIImageView!
    @IBOutlet var leftImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubble.layer.cornerRadius = bubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
