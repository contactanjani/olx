//
//  ImageCache.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import UIKit

enum ImageCacheType {
    case fileSystemCache
    case memoryCache
    case noCache
}

private let ImageCacheClearCacheAfterHours = 10
private let _ImageCacheSharedInstance = ImageCache()

class ImageCache: NSObject {
    
    fileprivate let memoryCache = NSCache<AnyObject, AnyObject>()
    
    class var instance: ImageCache {
        return _ImageCacheSharedInstance
    }
    
    override init() {
        super.init()
        
        clearCaheIfCacheIsOld()
    }
    
    /**
     Method which will download image and cache in filesystem or NSCache based on the cacheType if not in the cache.
     If the image is ther in the cache, just load from the cache and call the completion block
     
     - parameter imageUrl:   String? URL of the image
     - parameter size:       CGSize - Size to which the image is resized. If size is CGSizeZero, will not resise. Will use the original image size
     - parameter cacheType: ImageCacheType - Whether to use FileSystem cahce, Memory cache or no cache(Simply NSURLCache)
     - parameter completion: Block which will called with image once the image is loaded from url or cache.
     */
    func getImage(_ imageUrl: String, size: CGSize, cacheType: ImageCacheType, completion: @escaping (_ image: UIImage?) -> Void) {
        
        switch cacheType {
        case .fileSystemCache:
            self.getImageFromFileSystem(imageUrl, size: size, completion: completion)
        case .memoryCache:
            self.getImageFromMemory(imageUrl, size: size, completion: completion)
        case .noCache:
            self.getImageFromUrl(imageUrl, size: size, completion: completion)
        }
    }
    
    class func getUniqueFileName(_ fileUrl: String, size: CGSize) -> String {
        
        var uniquePath = "";
        if(fileUrl.range(of: "http://") != nil) {
            uniquePath = fileUrl.replacingOccurrences(of: "http://", with: "");
        } else if(fileUrl.range(of: "https://") != nil) {
            uniquePath = fileUrl.replacingOccurrences(of: "https://", with: "");
        } else {
            uniquePath = fileUrl
        }
        
        uniquePath = "a\(size.width)x\(size.height)_\(uniquePath)"
        uniquePath = uniquePath.replacingOccurrences(of: "/", with: "")
        
        return uniquePath;
    }
    
    // Will resize the uiimage with the given size.
    class func resizeImage(_ image: UIImage, scaleSize: CGSize) -> UIImage {
        
        let widthRatio = scaleSize.width/image.size.width;
        let heightRatio = scaleSize.height/image.size.height;
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: image.size.width*heightRatio,height: image.size.height*heightRatio);
        } else {
            newSize = CGSize(width: image.size.width*widthRatio,height: image.size.height*widthRatio);
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale);
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage!;
    }
    
    fileprivate func loadFromUrl(_ imageUrl: String, size: CGSize, completion: @escaping (_ image: UIImage?) -> Void) {
        
        let url = URL(string: imageUrl)
        if url == nil {
            completion(nil)
            return
        }
        let request = URLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60.0)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            var image: UIImage?
            if data != nil {
                image = UIImage(data: data!)
                if image == nil {
                    print("img found with error")
                }
                else if(size.width != 0) {
                    image = ImageCache.resizeImage(image!, scaleSize: size)
                }
            } else {
                print("img not found")
            }
            completion(image)
        })
        task.resume()
    }
    
    fileprivate func saveInFileSystem(_ image: UIImage?, imageUrl: String, size: CGSize) {
        
        if image != nil {
            
            let fileName = ImageCache.getUniqueFileName(imageUrl, size: size)
            let uniquePath = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileName)
            // Is it PNG or JPG/JPEG?
            // Running the image representation function writes the data from the image to a file
            if(imageUrl.lowercased().range(of: ".png") != nil) {
                try? UIImagePNGRepresentation(image!)!.write(to: URL(fileURLWithPath: uniquePath), options: [.atomic])
            } else if(imageUrl.lowercased().range(of: ".jpg") != nil || imageUrl.lowercased().range(of: ".jpeg") != nil) {
                try? UIImageJPEGRepresentation(image!,100)!.write(to: URL(fileURLWithPath: uniquePath), options: [.atomic])
            }
        }
    }
    
    fileprivate func getImageFromFileSystem(_ imageUrl: String, size: CGSize, completion: @escaping (_ image: UIImage?) -> Void) {
        
        let fileName = ImageCache.getUniqueFileName(imageUrl, size: size)
        let uniquePath = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileName)
        // Load the image from filesystem if exist else load from service and add to documents/temp folder
        if(FileManager.default.fileExists(atPath: uniquePath)) {
            
            let image = UIImage(contentsOfFile: uniquePath)
            completion(image)
            
        } else {
            self.loadFromUrl(imageUrl, size: size, completion: { (image: UIImage?) -> Void in
                
                completion(image)
                self.saveInFileSystem(image, imageUrl: imageUrl, size: size)
            })
        }
    }
    
    fileprivate func getImageFromMemory(_ imageUrl: String, size: CGSize, completion: @escaping (_ image: UIImage?) -> Void) {
        
        let uniquePath = ImageCache.getUniqueFileName(imageUrl, size: size)
        
        // Load the image from NSCache if exists else load from server and add to NSCache
        if let image = self.memoryCache.object(forKey: uniquePath as AnyObject) as? UIImage {
            completion(image)
        } else {
            self.loadFromUrl(imageUrl, size: size, completion: { (image: UIImage?) -> Void in
                
                completion(image)
                if image != nil {
                    self.memoryCache.setObject(image!, forKey: uniquePath as AnyObject)
                }
            })
        }
    }
    
    fileprivate func getImageFromUrl(_ imageUrl: String, size: CGSize, completion: @escaping (_ image: UIImage?) -> Void) {
        
        self.loadFromUrl(imageUrl, size: size, completion: { (image: UIImage?) -> Void in
            
            completion(image)
        })
    }
    
    func clearCaheIfCacheIsOld() {
        
        let defaults = UserDefaults.standard
        if let lastCacheClearedDate = defaults.object(forKey: "lastCacheClearedDate") as? Date {
            
            let currentDate = Date()
            let secondsInDays: TimeInterval = Double(ImageCacheClearCacheAfterHours) * 60 * 60
            let dateWithDaysAdded = lastCacheClearedDate.addingTimeInterval(secondsInDays)
            if currentDate.compare(dateWithDaysAdded) == ComparisonResult.orderedDescending {
                clearCache()
                defaults.set(Date(), forKey: "lastCacheClearedDate")
            }
        } else {
            defaults.set(Date(), forKey: "lastCacheClearedDate")
        }
        defaults.synchronize()
    }
    
    fileprivate func clearCache() {
        
        let fileManager = FileManager.default
        let folderPath = NSTemporaryDirectory()
        do {
            let files = try fileManager.contentsOfDirectory(atPath: folderPath)
            for file in files {
                try fileManager.removeItem(atPath: "\(folderPath)\(file)")
            }
        } catch {
            
        }
    }
}
