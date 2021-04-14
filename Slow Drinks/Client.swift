//
//  Client.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/13.
//

import Foundation

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
    var gender: String
    var amount: Int
    var list: Int?
    var item: Int
    
    enum CodingKeys: String, CodingKey {
        case gender = "性別"
        case amount = "金額"
        case list = "List"
        case item = "品項"
    }
}


struct Record: Codable {
    let fields: Client
}

struct RequestBody: Codable {
    let records: [Record]
}

