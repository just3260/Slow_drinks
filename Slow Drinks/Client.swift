//
//  Client.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/13.
//

import Foundation


enum Gender: String, Codable {
    case male = "男"
    case female = "女"
    case group = "團體"
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.client = try container.decode(Client.self, forKey: .client)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = .current
        let dateString = try container.decode(String.self, forKey: .createdTime)
        self.createdTime = formatter.date(from: dateString)!
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
    
    init(list:Int?, gender: Gender, sesame: Int, latte: Int, plumWine: Int, teaGin: Int, tea: Int, amount: Int) {
        self.list = list
        self.gender = gender
        self.sesame = sesame
        self.latte = latte
        self.plumWine = plumWine
        self.teaGin = teaGin
        self.tea = tea
        self.amount = amount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.list = try container.decode(Int.self, forKey: .list)
        self.gender = try container.decode(Gender.self, forKey: .gender)
        self.sesame = try container.decode(Int.self, forKey: .sesame)
        self.latte = try container.decode(Int.self, forKey: .latte)
        self.plumWine = try container.decode(Int.self, forKey: .plumWine)
        self.teaGin = try container.decode(Int.self, forKey: .teaGin)
        self.tea = try container.decode(Int.self, forKey: .tea)
        self.amount = try container.decode(Int.self, forKey: .amount)
    }
}
