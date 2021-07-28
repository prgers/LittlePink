//
//  POIVC-Config.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

extension POIViewController {
    func config() {
        tableView.tableFooterView = UIView()
        
        //高德地图
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5
    }
}
