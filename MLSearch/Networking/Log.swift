//
//  Log.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import Foundation

extension APIRequest {
    
    func logRequest(params: [String: Any?]) {
        print("Dispatching request to => \(APIClient.BASE_URL + path)")
        print("Method => \(method.rawValue)")
        print("Parameters => \(jsonStringify(params as AnyObject))")
        print("-------------------------------------------------------")
    }
    
    func logResponse(data: Data, response: HTTPURLResponse) {
        print("Response received from => \(response.url?.description ?? "")")
        print("Status code => \(response.statusCode)")
        
        if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("Received JSON => \(jsonStringify(responseJSON as AnyObject))")
        } else {
            print("Received JSON => null")
        }
        print("-------------------------------------------------------")
    }
    
    func jsonStringify(_ value: AnyObject) -> String {
        
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted)
                return String(data: data, encoding: .utf8) ?? ""
                
            } catch {
                print("Invalid JSON")
            }
        }
        return ""
    }

}
