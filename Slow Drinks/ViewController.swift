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

            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.timeZone = TimeZone.init(identifier: "UTC")
            formatter.locale = Locale(identifier: "zh_Hant_TW")
            decoder.dateDecodingStrategy = .formatted(formatter)

                
            if let data = response.data {
                do {
                    let results = try decoder.decode(Records.self, from: data)
                    for client in results.records {
                        print(client)
                    }
                } catch {
                    print("error")
                }
            }
        }
        
    }
    
}

