//
//  POICell.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var poi = ["",""] {
        didSet {
            nameLabel.text = poi.first
            addressLabel.text = poi.last
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
