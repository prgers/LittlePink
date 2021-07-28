//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/27.
//

import Foundation

extension NoteEditViewController {
    func config() {
        collectionView.dragInteractionEnabled = true //允许拖拽
        
        hideKeyboardWhenTappedAround() //添加点击空白界面隐藏键盘
        
        titleCountLab.text = "\(kMaxNoteTitleCount)"
        //去除上下左右边距
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        
        textView.placeholder = "请输入内容"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)
        
        //设置文本间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        textView.typingAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        
        //修改光标颜色
        textView.tintColor = UIColor.init(named: "main")
        textView.tintColorDidChange()
        
        let textViewIAView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.maxTextCountLabel.text = "/\(kMaxNoteTextCount)"
        textView.inputAccessoryView = textViewIAView
        
    }
}

extension NoteEditViewController {
    
    @objc private func resignTextView() {
        textView.endEditing(true)
    }
}
