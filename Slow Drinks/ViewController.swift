//
//  ViewController.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/13.
//

import UIKit
import Alamofire


struct Login: Encodable {
    let email: String
    let password: String
}

class ViewController: UIViewController {
    
    
    let url = "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer keyJ7HuUvcwB2hicx",
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { (response) in
            print(response)
            
            
//            let decoder = JSONDecoder()
//            if let loadedPerson = try? decoder.decode(Records.self, from: response) {
//
//            }
            
            
//            if response.result.isSuccess {
                
                let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
                
                if let result = response.data, let results = try? decoder.decode(Records.self, from: result) {
                    for client in results.records {
                        print(client)
                    }
                }
//            }
            
            
//            do {
//                let data = try JSONSerialization.data(withJSONObject:response, options: .prettyPrinted)
//                let str = String(data:data, encoding: .utf8)
//                print(str)
//            } catch {
//                print("JSON error")
//            }
        }
        
        
    }
    
    
}

