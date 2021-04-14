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
    
    
    let airtableUrl = "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201"
    
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer keyJ7HuUvcwB2hicx",
        "Accept": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getList()
    }
    
    
    
    func getList() {
        
        
        AF.request(airtableUrl, method: .get, headers: headers).responseJSON { (response) in

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
//        let userDict = ["fields": ["金額": 300, "品項": 20, "性別": "男"]]
//
//        AF.request(listUrl, method: .post, parameters: userDict, headers: headers).responseJSON { (response) in
//            debug(response)
//        }
        
        
        
        let movieBody = RequestBody(records: [.init(fields: .init(gender: "男", amount: 300, list: nil, item: 10))])
        
        
        if let url = URL(string: airtableUrl) {
            var request = URLRequest(url: url)
            request.setValue("Bearer keyJ7HuUvcwB2hicx", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let encoder = JSONEncoder()
            request.httpBody = try? encoder.encode(movieBody)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data,
                   let content = String(data: data, encoding: .utf8) {
                    print(content)
                }
            }.resume()
        }
        
    }
    
    
}

