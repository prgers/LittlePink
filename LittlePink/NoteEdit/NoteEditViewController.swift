//
//  NoteEditViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/26.
//

import UIKit

class NoteEditViewController: UIViewController {

    var photos:[UIImage] = []
    lazy var locationManager = CLLocationManager()
    
    var photoCount: Int{photos.count}
    var textViewIAView: TextViewIAView {textView.inputAccessoryView as! TextViewIAView}
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleCountLab: UILabel!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //界面相关配置
        config()
        
        locationManager.requestWhenInUseAuthorization()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelViewController {
            channelVC.channelDelegate = self
        }
    }
    
}

extension NoteEditViewController: ChannelVCDelegate {
    func updateChannel(channel: String, subChannel: String) {
        channelIcon.tintColor = blueColor
        channelLabel.text = subChannel
        channelLabel.textColor = blueColor
        channelPlaceholderLabel.isHidden = true
    }
}

extension NoteEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else {return}
        textViewIAView.currentTextCount = textView.text.count
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
