//
//  SunriseApiManager.swift
//  SunriseApp
//
//  Created by Bohdan Dankovych on 11/6/18.
//  Copyright © 2018 Bohdan Dankovych. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class PlaceDetailModelDTO: Mappable {
    
    var sunriseTime: String!
    var sunsetTime: String!
    var dayLength: String!
    
    
    private enum JSONKeys: String {
        case sunriseTime = "results.sunrise"
        case sunsetTime = "results.sunset"
        case dayLength = "results.day_length"
    }
    
    init () {
        
    }
    required init?(map: Map) {
        mapping(map: map)
    }
    
    
    func mapping(map: Map) {
        sunriseTime <- map[JSONKeys.sunriseTime.rawValue]
        sunsetTime <- map[JSONKeys.sunsetTime.rawValue]
        dayLength <- map[JSONKeys.dayLength.rawValue]
    }

}


enum ResponseStatuses: String {
    case ok = "OK"
    case invalidRequest = "INVALID_REQUEST"
    case invalidDate = "INVALID_DATE"
    case unknownError = "UNKNOWN_ERROR"
}

class SunriseApiManager {

    static func loadInfo(for place: PlaceModel, completion: @escaping (Bool, PlaceDetailModelDTO?, Error?) -> Void) {
        let scheme = "https"
        let host = "api.sunrise-sunset.org"
        let path = "/json"
        
        let latitudeItem = URLQueryItem(name: "lat", value: "\(place.latitude!)")
        let longitudeItem = URLQueryItem(name: "lng", value: "\(place.longitude!)")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [latitudeItem, longitudeItem]
        
        let url = urlComponents.url!
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (dataResponse) in
            guard dataResponse.result.isSuccess,
                let data = dataResponse.data,
                dataResponse.error == nil,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let status = json?["status"] as? String,
                status == ResponseStatuses.ok.rawValue,
                let dto = Mapper<PlaceDetailModelDTO>().map(JSON: json ?? [:])
            else {
                completion(false, nil, dataResponse.error)
                return
            }
            completion(true, dto, nil)
        }
    }
    
}
