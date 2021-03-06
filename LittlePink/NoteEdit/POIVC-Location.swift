//
//  POIVC-Location.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/28.
//

extension POIViewController {
    
    //定位
    func requestLocation() {
        showLoadHUD()
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            let weakSelf = self!
            if let location = location {
                weakSelf.latitude = location.coordinate.latitude
                weakSelf.longitude = location.coordinate.longitude
                weakSelf.footer.setRefreshingTarget(weakSelf, refreshingAction: #selector(weakSelf.aroundSearchPullToRefresh))
                weakSelf.makeAroundSearch()
            }
                
            if let reGeocode = reGeocode {
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else {return}
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province
                
                let address = "\(province.unwrappedText)\(reGeocode.city.unwrappedText)\(reGeocode.district.unwrappedText)\(reGeocode.street.unwrappedText)\(reGeocode.number.unwrappedText)"
                
                weakSelf.pois.append([reGeocode.poiName ?? kNoPOIPH, address])
                weakSelf.aroundSearchedPOIs.append([reGeocode.poiName ?? kNoPOIPH, address])
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                }
            }
        })
    }
}

extension POIViewController {
    func makeAroundSearch(_ page: Int = 1) {
        aroundSearchRequest.page = page
        mapSearch?.aMapPOIAroundSearch(aroundSearchRequest)
    }
}

extension POIViewController {
    @objc private func aroundSearchPullToRefresh() {
        currentAroundPage += 1
        makeAroundSearch(currentAroundPage)
        if currentAroundPage < pageCount {
            footer.endRefreshing()
        }else {
            footer.endRefreshingWithNoMoreData()
        }
    }
}
