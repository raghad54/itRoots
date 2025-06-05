//
//  PostCell.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(post:Post) {
        
        let titlePrefix = NSAttributedString(
            string: "Title: ",
            attributes: [.foregroundColor: UIColor.systemBlue, .font: UIFont.boldSystemFont(ofSize: 16)]
        )
        let titleText = NSAttributedString(
            string: post.title,
            attributes: [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 16)]
        )
        let titleCombined = NSMutableAttributedString()
        titleCombined.append(titlePrefix)
        titleCombined.append(titleText)
        titleLabel.attributedText = titleCombined

        let bodyPrefix = NSAttributedString(
            string: "Body: ",
            attributes: [.foregroundColor: UIColor.systemRed, .font: UIFont.boldSystemFont(ofSize: 14)]
        )
        let bodyText = NSAttributedString(
            string: post.body,
            attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 14)]
        )
        let bodyCombined = NSMutableAttributedString()
        bodyCombined.append(bodyPrefix)
        bodyCombined.append(bodyText)
        detailsLabel.attributedText = bodyCombined

    }
}
