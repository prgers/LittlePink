//
//  NoteEditViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/26.
//

import UIKit

class NoteEditViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos:[UIImage] = []
    
    var photoCount: Int{photos.count}
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleCountLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //界面相关配置
        config()
    }

    
    @IBAction func tfEditingBegin(_ sender: UITextField) {
        titleCountLab.isHidden = false
    }
    
    @IBAction func tfEditingEnd(_ sender: UITextField) {
        titleCountLab.isHidden = true
    }
    
    //点击return
    @IBAction func tfEndOnExit(_ sender: UITextField) {}
    
    
    @IBAction func tfEditingChange(_ sender: UITextField) {
        //判断是否高亮状态
        guard sender.markedTextRange == nil else {return}
        if sender.unwrappedText.count > kMaxNoteTitleCount {
            sender.text = String(sender.unwrappedText.prefix(kMaxNoteTitleCount)) //截取最大字数文本
            showTextHUD("最多输入\(kMaxNoteTitleCount)个字符")
            DispatchQueue.main.async {
                //获取最后的文本位置
                let end = sender.endOfDocument
                //将光标移动到最后
                sender.selectedTextRange = sender.textRange(from: end, to: end)
                
            }
        }
        titleCountLab.text = "\(kMaxNoteTitleCount - textField.unwrappedText.count)"
    }
    
}

//extension NoteEditViewController: UITextFieldDelegate {
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let isExceed = range.location >= kMaxNoteTitleCount || (string.count + textField.unwrappedText.count) > kMaxNoteTitleCount
//
//        if isExceed {
//            showTextHUD("最多输入\(kMaxNoteTitleCount)个字符")
//        }
//        return !isExceed
//    }
//}
