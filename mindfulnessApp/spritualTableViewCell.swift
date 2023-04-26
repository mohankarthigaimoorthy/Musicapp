//
//  spritualTableViewCell.swift
//  mindfulnessApp
//
//  Created by Mohan K on 02/02/23.
//

import UIKit

class spritualTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!

    @IBOutlet weak var tagsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
