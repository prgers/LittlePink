//
//  NoteEditVC-CollectionView.swift
//  LittlePink
//
//  Created by 潘小懒 on 2021/7/27.
//

import YPImagePicker
import MBProgressHUD
import SKPhotoBrowser

extension NoteEditViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var images:[SKPhoto] = []
        for photo in photos {
            images.append(SKPhoto.photoWithImage(photo))
        }

        let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
        browser.delegate = self
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayDeleteButton = true
        present(browser, animated: true, completion: {})
    }
    
}

extension NoteEditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            footer.addBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return footer
        default:
            fatalError("collectionView的header出错了")
        }
    }
}

extension NoteEditViewController: SKPhotoBrowserDelegate {
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        
        photos.remove(at: index)
        collectionView.reloadData()
        reload()
    }
}

extension NoteEditViewController {
    @objc private func addPhoto() {
        if photoCount < kMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            
            //MARK: 通用配置
            config.albumName = "小粉书"
            config.screens = [.library]
            
            //MARK: 相册配置
            config.library.defaultMultipleSelection = false
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                for item in items {
                    if case let .photo(photo) = item {
                        self.photos.append(photo.image)
                    }
                }
                
                self.collectionView.reloadData()
                picker.dismiss(animated: true)
                
            }
            present(picker, animated: true)
        } else {
            showTextHUD("最多只能选择\(kMaxPhotoCount)张图片")
        }
    }
}
