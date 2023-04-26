//
//  listTypeCollectionViewCell.swift
//  mindfulnessApp
//
//  Created by Mohan K on 03/02/23.
//

import UIKit

class listTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headingTopic: UILabel!
    
    @IBOutlet weak var subTopics: UILabel!
    
    var cornerRadius:   CGFloat = 9.0
    
    static let identifier = "listTypeCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "listTypeCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }

}
