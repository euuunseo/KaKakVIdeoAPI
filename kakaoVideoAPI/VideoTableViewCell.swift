//
//  VideoTableViewCell.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

   // static let identifier = "VideoTableViewCell"
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentsLabel.font = .systemFont(ofSize: 13)
        contentsLabel.numberOfLines = 2
        thumbnailImageView.contentMode = .scaleToFill
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
