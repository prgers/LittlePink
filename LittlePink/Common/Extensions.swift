//
//  Extensions.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/26.
//

import UIKit

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
    
    //MARK: 提示框--自动隐藏
    func showTextHUD(_ title: String, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
}
