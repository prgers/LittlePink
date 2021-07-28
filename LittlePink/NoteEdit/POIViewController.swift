//
//  PoiViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

import UIKit

class POIViewController: UIViewController {
    
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var request: AMapPOIAroundSearchRequest = {
        
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.requireExtension = true
        return request
    }()
    
    
    var pois = [["不显示位置", ""]]
    var latitude = 0.0
    var longitude = 0.0
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //配置
        config()
        
        //定位
        requestLocation()
        
        //搜索
        mapSearch?.delegate = self
    }

}

extension POIViewController: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        hideLoadHUD()
        if response.count == 0 {
            return
        }
        
        response.pois.forEach { (poi) in
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" : poi.address
            
            let temp = [
                poi.name ?? "",
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"
            ]
            pois.append(temp)
        }
        
        tableView.reloadData()
    }
}

extension POIViewController: UITableViewDelegate {
    
}

extension POIViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPoiCellID, for: indexPath) as! POICell
        cell.poi = pois[indexPath.row]
        return cell
        
    }
    
    
}
