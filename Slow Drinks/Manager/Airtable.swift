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

protocol DecodableResponseTargetType: TargetType {
    associatedtype ResponseType: Decodable
}

protocol AirtableTargetType: DecodableResponseTargetType {}

extension AirtableTargetType {
    var baseURL: URL {
        return URL(string: "https://api.airtable.com/v0/appj0XaBDz5v4Y8OG/Table%201")!
    }

    var headers: [String: String]? {
        return [ "Authorization": "Bearer keyJ7HuUvcwB2hicx",
                 "Accept": "application/json" ]
    }
    
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
}

enum Airtable {
    struct CreateRecords: AirtableTargetType {
        typealias ResponseType = Fields

        var method: Moya.Method { return .post }
        var path: String { return "" }
        var task: Task {
            let userDict = ["fields": ["總金額": order.amount, "心亂如麻": order.sesame, "極白乳韻": order.latte, "美莓": order.plumWine, "茶琴": order.teaGin, "冷泡茶": order.tea, "性別": order.gender.rawValue]]
            return .requestParameters(parameters: userDict, encoding: JSONEncoding.default)
        }

        private let order: Client

        init(order: Client) {
            self.order = order
        }
    }
}
