//
//  ChannelViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

import UIKit
import XLPagerTabStrip

class ChannelViewController: ButtonBarPagerTabStripViewController {
    
    var channelDelegate: ChannelVCDelegate?

    override func viewDidLoad() {
        
        //MARK: 设置顶部的bar
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.selectedBarHeight = 2
        
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        settings.style.buttonBarItemLeftRightMargin = 0
        
        super.viewDidLoad()

    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs: [UIViewController] = []
        for i in kChannels.indices {
            let vc = storyboard?.instantiateViewController(identifier: kChannelTableVC) as! ChannelTableViewController
            vc.channel = kChannels[i]
            vc.subChancels = kAllSubChannels[i]
            vcs.append(vc)
        }
        return vcs
    }
}
