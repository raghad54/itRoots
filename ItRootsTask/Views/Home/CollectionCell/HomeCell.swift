//
//  HomeCell.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 05/06/2025.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.systemGray6
    }

    
    
    func configure(with item: StatusItem) {
        titleLabel.text = item.title
        valueLabel.text = item.value
    }
    
}


