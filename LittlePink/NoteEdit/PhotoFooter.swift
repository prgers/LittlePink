//
//  PhotoFooter.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/26.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.layer.borderWidth = 0.5
        addBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
}
