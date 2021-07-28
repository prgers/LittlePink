//
//  TextViewIAView.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/27.
//

import UIKit

class TextViewIAView: UIView {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentTextCount = 0{
        didSet {
            if currentTextCount <= kMaxNoteTextCount {
                doneBtn.isHidden = false
                textCountStackView.isHidden = true
            }else {
                doneBtn.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }
}
