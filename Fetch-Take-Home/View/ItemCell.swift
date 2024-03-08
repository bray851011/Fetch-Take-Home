//
//  ItemCell.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var listId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
