//
//  OfferToDoTableViewCell.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import UIKit
import Kingfisher

class OfferToDoTableViewCell: UITableViewCell {
    static let Identifier: String = "OfferToDoTableViewCellReuse"
    var cellData: OfferToDo? = nil {
        didSet {
            self.cellTitle.text = self.cellData?.text
            let url = URL(string: (self.cellData?.imageUrl)!)
            cellImage.kf.setImage(with: url)
        }
    }

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
