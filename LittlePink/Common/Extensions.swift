//
//  Extensions.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/26.
//

import UIKit

extension String{
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String{
    var unwrappedText: String { self ?? "" }
}

extension Bundle {
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("加载\(type)类型的view失败")
    }
}

extension UITextField{
    var unwrappedText: String { text ?? "" }
}

extension UIView {
    @IBInspectable
    var radius: CGFloat {
        
        set {
            layer.cornerRadius = newValue
        }
        get {
            layer.cornerRadius
        }
    }
}

extension UIViewController {
    
    //MARK: 加载框--手动隐藏
    func showLoadHUD(_ title: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    
    func hideLoadHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    //MARK: 提示框--自动隐藏
    func showTextHUD(_ title: String, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //保证tap手势不会影响到其他touch类控件的手势
        //若不设，则本页面有tableview时，点击cell不会触发didSelectRowAtIndex（除非长按）
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
