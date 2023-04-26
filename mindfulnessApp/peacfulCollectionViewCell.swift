//
//  peacfulCollectionViewCell.swift
//  mindfulnessApp
//
//  Created by Mohan K on 02/02/23.
//

import UIKit

class peacfulCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var lineLbl: UILabel!
    
    
    @IBOutlet weak var concernLbl: UILabel!
//    var calm = [Peace]()

    var cornerRadius: CGFloat  = 9.0
    
    static let identifier =  "peacfulCollectionViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "peacfulCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
//        layer.shadowRadius = 8.0
    }

    
    
    
    
}
