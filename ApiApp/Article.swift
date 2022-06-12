//
//  Article.swift
//  ApiApp
//
//  Created by 北川 海渡 on 2021/04/27.
//

import Foundation

struct Article: Codable {
    var title: String
    var user: User
    struct User: Codable {
        var id: String
        var iconUrl: String
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case iconUrl = "profile_image_url"
        }
    }
    var url: String
    var tags: [Tag]
    struct Tag: Codable {
        var name: String
    }
}
