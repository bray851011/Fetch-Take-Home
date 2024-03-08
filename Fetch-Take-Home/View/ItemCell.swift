//
//  ItemCell.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import UIKit

/// A custom table view cell for displaying an item.
class ItemCell: UITableViewCell {

    /// The label for displaying the list ID of the item.
    @IBOutlet weak var listId: UILabel!
    
    /// The label for displaying the ID of the item.
    @IBOutlet weak var id: UILabel!
    
    /// The label for displaying the name of the item.
    @IBOutlet weak var name: UILabel!
    
    /// The container view that holds the cell's content.
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
