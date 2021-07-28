//
//  ChannelTableViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

import UIKit
import XLPagerTabStrip

class ChannelTableViewController: UITableViewController {
    
    var channel = ""
    var subChancels: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subChancels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCellID", for: indexPath)
        cell.textLabel?.text = "# \(subChancels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = parent as! ChannelViewController
        channelVC.channelDelegate?.updateChannel(channel: channel, subChannel: subChancels[indexPath.row])
        dismiss(animated: true)
    }

}

extension ChannelTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
