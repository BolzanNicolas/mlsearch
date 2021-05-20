//
//  Requests.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import Foundation

extension APIClient {
    
    struct Search: APIRequest {
        typealias ResponseType = SearchResult
        
        var keyword: String
        
        var method : HTTPMethod { return .get }
        var path : String {
            return "sites/MLA/search?q=\(keyword.replacingOccurrences(of: " ", with: "%20"))"
            
        }
    }
    
}

