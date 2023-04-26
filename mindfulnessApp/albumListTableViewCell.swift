//
//  albumListTableViewCell.swift
//  mindfulnessApp
//
//  Created by Mohan K on 02/02/23.
//

import UIKit

class albumListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var albumImg: UIImageView!
    
    @IBOutlet weak var trackTitle: UILabel!
    
    
    @IBOutlet weak var artistName: UILabel!
    
    static let identifier = "albumListTableViewCell"
    
    static  func nib() -> UINib {
        return UINib(nibName: "albumListTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumImg.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
