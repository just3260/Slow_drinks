//
//  APIManager.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import Foundation
import Alamofire

class APIManager {
    static let sharedInstance = APIManager()
    
    let baseUrl = "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201"
    
    let headers: HTTPHeaders = [ "Authorization": "Bearer keyJ7HuUvcwB2hicx",
                                 "Accept": "application/json" ]
    
    
    func getList() {
        AF.request(baseUrl, method: .get, headers: headers).responseJSON { (response) in

            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.timeZone = TimeZone(identifier: "UTC")
            formatter.locale = .current
            decoder.dateDecodingStrategy = .formatted(formatter)

            if let data = response.data {
                do {
                    let results = try decoder.decode(Records.self, from: data)
                    for client in results.records {
                        debug(client)
                        
                        let df = DateFormatter()
                        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        df.timeZone = .current
                        let timeStamp = df.string(from: client.createdTime)
                        debug("list create tiemstamp: \(timeStamp)")
                    }
                } catch {
                    debug("error")
                }
            }
        }
    }
    
    
    func createData() {
        let userDict = ["fields": ["金額": 300, "品項": 20, "性別": Gender.group.rawValue]]
        
        AF.request(baseUrl, method: .post, parameters: userDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            debug(response)
        }
    }
}
