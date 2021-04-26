//
//  Airtable.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/26.
//

import Foundation
import Moya

// 由於我們在輸入網址時，有時會有中文在字串中，如果沒有加以轉換，url 會無法使用
extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum Airtable {
    case getRecords
    case createRecords(withOrder: Client)
}

extension Airtable: TargetType {
    var baseURL: URL { return URL(string: "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201")! }
    
    // 即 endpoint
    var path: String {
        switch self {
        case .getRecords:
            return ""
        case .createRecords(withOrder: let withOrder):
            return ""
        }
    }
    
    // Moya.Method 是 typealias of Alamofire.HTTPMethod
    var method: Moya.Method {
        return .post
    }
    
    // 這邊可以決定你要如何執行你的 task
    // 可以指定要 request data -> 回傳 data
    // request plain -> 只有回傳 status code，可能用於更新使用者名稱等等不需要 response data 的 task
    // 或者帶有 parameters 的 task
    var task: Task {
        switch self {
        case .getRecords:
            return .requestPlain
        case .createRecords(withOrder: let order):
            let userDict = ["fields": ["總金額": order.amount, "心亂如麻": order.sesame, "極白乳韻": order.latte, "美莓": order.plumWine, "茶琴": order.teaGin, "冷泡茶": order.tea, "性別": order.gender.rawValue]]
            return .requestParameters(parameters: userDict, encoding: JSONEncoding.default)
        }
    }
    
    // 其他要含帶的資訊
    var headers: [String : String]? {
        return [ "Authorization": "Bearer keyJ7HuUvcwB2hicx",
                 "Accept": "application/json" ]
    }
    
    // 可以拿來測試的 stubs data
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
}

