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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
