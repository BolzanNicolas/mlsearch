//
//  MLItem.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import Foundation

final class MLItem: Codable {
    var title: String?
    var seller: Seller?
    var price: Double?
    var thumbnail: String?
    var availableQuantity: Int?
    var shipping: Shipping?
    var attributes: [Attribute]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case seller = "seller"
        case price = "price"
        case thumbnail = "thumbnail"
        case availableQuantity = "available_quantity"
        case shipping = "shipping"
        case attributes = "attributes"
    }
}

extension MLItem {
    
    final class Shipping: Codable {
        var freeShipping: Bool?
        
        enum CodingKeys: String, CodingKey {
            case freeShipping = "free_shipping"
        }
    }
    
    final class Attribute: Codable {
        var name: String?
        var values: [Value]?
        
        final class Value: Codable {
            var name: String?
        }
    }
}
