//
//  Client.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/13.
//

import Foundation


enum Gender: Int, Codable {
    case male = 0
    case female
    case group
    
    func toString() -> String {
        switch self {
        case .male:
            return "男"
        case .female:
            return "女"
        case .group:
            return "團體"
        }
    }
}


struct Records: Codable {
    var records: [Fields]
}

struct Fields: Codable {
    var id: String
    var client: Client
    var createdTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case client = "fields"
        case createdTime = "createdTime"
    }
}

struct Client: Codable {
    var list: Int?
    var gender: Gender
    var sesame: Int
    var latte: Int
    var plumWine: Int
    var teaGin: Int
    var tea: Int
    var amount: Int
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
        case gender = "性別"
        case sesame = "心亂如麻"
        case latte = "極白乳韻"
        case plumWine = "美莓"
        case teaGin = "茶琴"
        case tea = "冷泡茶"
        case amount = "總金額"
    }
}
