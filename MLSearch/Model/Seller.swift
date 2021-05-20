//
//  Seller.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import Foundation

final class Seller: Codable {
    var id: Int?
    var eshop: EShop?
}

extension Seller {
    
    final class EShop: Codable {
        var nickname: String?
        var logo: String?
        
        enum CodingKeys: String, CodingKey {
            case nickname = "nick_name"
            case logo = "logo"
        }
    }
}
