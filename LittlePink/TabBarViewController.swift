//
//  TabBarViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/23.
//

import UIKit
import YPImagePicker

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PublishViewController {
            
            //待做(这里需要登录判断)
            
            var config = YPImagePickerConfiguration()
            
            //MARK: 通用配置
            config.isScrollToChangeModesEnabled = false
            config.onlySquareImagesFromCamera = false
            config.albumName = "小粉书"
            config.startOnScreen = .library
            config.screens = [.library, .video, .photo]
            
            //MARK: 相册配置
            config.library.defaultMultipleSelection = false
            config.library.maxNumberOfItems = kMaxPhotoCount
            
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("取消操作")
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        }
        return true
    }

}
