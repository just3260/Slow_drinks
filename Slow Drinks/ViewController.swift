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
    
    
    let listUrl = "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201"
    
    let createUrl = "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201"
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer keyJ7HuUvcwB2hicx",
        "Accept": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getList()
    }
    
    
    
    func getList() {
        
        
        AF.request(listUrl, method: .get, headers: headers).responseJSON { (response) in

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
    
    
    
    @IBAction func createBtn(_ sender: UIButton) {
//        let client = Client(gender: "男", amount: 1000, list: nil, item: 10)
//        let para: [String: AnyObject] = ["records": [client]]
//            
//        AF.request(createUrl, method: .post, parameters: <#T##Parameters?#>, headers: headers).responseJSON { (response) in
//            <#code#>
//        }
    }
    
    
}

