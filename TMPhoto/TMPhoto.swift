//
//  TMPhoto.swift
//  TMPhoto
//
//  Created by Jason Tsai on 2017/4/19.
//  Copyright © 2017年 YomStudio. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMPhoto {
    static let shared = TMPhoto()
    
    func compress(image: UIImage, compressionQuality: CGFloat) -> UIImage {
        var actualHeight        = image.size.height
        var actualWidth         = image.size.width
        let maxHeight:CGFloat   = 600.0
        let maxWidth:CGFloat    = 800.0
        var imgRatio            = actualWidth/actualHeight
        let maxRatio            = maxWidth/maxHeight
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            } else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            } else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData = UIImageJPEGRepresentation(img, compressionQuality)
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    func compress(image: UIImage, lessThan size: Int) -> UIImage {
        var imgSize = NSData(data: UIImagePNGRepresentation(image)!).length
        var newImg = image
        while imgSize > size {
            newImg = self.compress(image: image, compressionQuality: 0.7)
            imgSize = NSData(data: UIImagePNGRepresentation(newImg)!).length
        }
        return newImg
    }
    
    func imagesHandler(_ success: @escaping ()->()) {
//        for i in 0..<providedShopPhotos.count {
//            // 檢查DB是否已有照片
//            let roImage: ROImage? = ImageRealmer.sharedInstance.find(id: providedShopPhotos[i].image_public_id!)
//            if roImage != nil {
//                // 若已有照片，將Data轉為UIImage
//                let image = UIImage.init(data: roImage!.image as! Data)
//                self.providedShopPhotos[i].image = FNObjCLib().compressImage(image, lessThan: 4000*1024)
//                self.skPhotos.append(self.createSKPhoto(shopPhoto: self.providedShopPhotos[i]))
//                if i == self.providedShopPhotos.count - 1 {
//                    success()
//                }
//            }else {
//                // 若沒有照片，新增至DB
//                self.writeToRealmDB(shopPoho: providedShopPhotos[i], success: { roImage in
//                    let image = UIImage.init(data: roImage.image as! Data)
//                    self.providedShopPhotos[i].image = image
//                    self.skPhotos.append(self.createSKPhoto(shopPhoto: self.providedShopPhotos[i]))
//                    if i == self.providedShopPhotos.count - 1 {
//                        success()
//                    }
//                })
//            }
//        }
    }
    
    func downloadImage(url: String, success: @escaping (UIImage)->(), failure: @escaping (Any)->()) {
        SDWebImageDownloader.shared().downloadImage(with: URL(string: url), options: .useNSURLCache, progress: nil, completed: {(downloadImage, error, cacheType, finished) in
            if downloadImage != nil {
                success(downloadImage!)
            }else {
                failure(error as Any)
            }
        })
    }
//        SDWebImageDownloader.shared().downloadImage(with: URL(string: shopPoho.image_url!), options: .useNSURLCache, progress: nil, completed: {(downloadImage, error, cacheType, finished) in
//            if finished {
//                let newRoImage = ROImage()
//                let compImage = FNObjCLib().compressImage(downloadImage, lessThan: 4000*1024)
//                let imageData = UIImagePNGRepresentation(compImage!)!
//                newRoImage.id = shopPoho.image_public_id!
//                newRoImage.image_url = shopPoho.image_url!
//                newRoImage.image_type = shopPoho.image_type!
//                newRoImage.image = imageData as NSData?
//                DispatchQueue.main.async {
//                    ImageRealmer.sharedInstance.write(newRoImage)
//                    success(newRoImage)
//                }
//            }else {
//                print("下載照片時發生異常")
//            }
//            
//        })
//    }
}
