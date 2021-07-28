//
//  PoiViewController.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

import UIKit

class POIViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        request.requireExtension = true
        request.types = "风景名胜"
        return request
    }()
    
    lazy var keywordsSearchRequest : AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        return request
    }()
    
    lazy var footer = MJRefreshAutoNormalFooter()
    
    
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr
    
    var latitude = 0.0
    var longitude = 0.0
    var keyboards = ""
    var currentAroundPage = 1 //周边搜索的当前页数
    var currentKeywordsPage = 1 //关键字搜索的当前页数
    var pageCount = 1 //所有搜索的总页数

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

extension POIViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            pois = aroundSearchedPOIs
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank  else {return}
        
        keyboards = searchText
        keywordsSearchRequest.keywords = keyboards
        
        pois.removeAll()
        showLoadHUD()
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
    
}

extension POIViewController: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        hideLoadHUD()
        let poiCount = response.count
        print(poiCount)
        if response.count == 0 {
            return
        }
        
        response.pois.forEach { (poi) in
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.district == poi.address ? "" : poi.address
            
            let temp = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"
            ]
            pois.append(temp)
            
            if request is AMapPOIAroundSearchRequest {
                aroundSearchedPOIs.append(temp)
            }
        }
        
        if poiCount > kPOIsOffset {
            pageCount = poiCount / kPOIsOffset + 1
        }else {
            footer.endRefreshingWithNoMoreData()
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
