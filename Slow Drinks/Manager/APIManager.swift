//
//  APIManager.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import Foundation
import Alamofire
import Moya

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
    
    
    func createData(with order: Client, completion: @escaping (_ success: Bool) -> Void) {
        
//        let userDict = ["fields": ["總金額": order.amount, "心亂如麻": order.sesame, "極白乳韻": order.latte, "美莓": order.plumWine, "茶琴": order.teaGin, "冷泡茶": order.tea, "性別": order.gender.toString()]]
        
//        AF.request(baseUrl, method: .post, parameters: userDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
//
//            if let data = response.data {
//                do {
//                    let result = try JSONDecoder().decode(Fields.self, from: data)
//                    debug(result)
//                } catch {
//                    debug(error)
//                }
//            }
//            completion(response.response?.statusCode == 200)
//        }
        
        
        MoyaProvider<Airtable>().request(.createRecords(withOrder: order)) { (result) in
            switch result {
            case let .success(response):
                
                do {
                    let result = try JSONDecoder().decode(Fields.self, from: response.data)
                    debug(result)
                } catch {
                    debug(error)
                }
                completion(response.statusCode == 200)
                
            case let .failure(error):
                debug(error)
                completion(false)
            }
        }
        
        
    }
}
