//
//  APIService.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

private let kBaseURL = "https://api-v2.olx.com"
private let kSearchEndPoint = "/items?"

private var _sharedInstance = APIService()

class APIService {
    
    class var sharedInstance: APIService {
        return _sharedInstance
    }
    
    init() {
        
    }
    
    func getResultsForSearchWith(parameters : String, completion : @escaping ((_ responseObject : [[String:Any]]?) -> Void)) {
        
        let urlString = (kBaseURL + kSearchEndPoint + parameters.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)
        let url = URL(string : urlString)
        print("url--->" + urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        resultForUrl(request: request) { (data) -> Void in
            
            guard data != nil else {
                completion(nil)
                return
            }
            do
            {
                let dictionary : [String:Any]? = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String:Any]
                if let dataDictionary = dictionary?["data"] as? [[String:Any]] {
                    completion(dataDictionary)
                }else {
                    completion(nil)
                }
            }catch
            {
                completion(nil)
            }
        }
    }
    
    private func resultForUrl(request : URLRequest, completion : @escaping ((_ data : Data?) -> Void)) {
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard error == nil else {
                completion(nil)
                return
            }
            if data != nil {
                completion(data)
            }
        }).resume()
    }
}
