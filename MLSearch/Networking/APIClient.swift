//
//  APIClient.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import Foundation
import RxSwift

struct APIClient {

    static var BASE_URL: String {
        return "https://api.mercadolibre.com/"
    }

}

protocol APIRequest {
    associatedtype ResponseType: Codable
    
    var method: HTTPMethod { get }
    var path: String { get }
    
    var parameters: [String : Any?]? { get }
}

extension APIRequest {
    var method        : HTTPMethod { return .get }
    var parameters    : [String: Any?]? { return nil }
    
    func dispatch(showError: Bool = true) -> Single<ResponseType> {
        
        return Single<ResponseType>.create { (observer) -> Disposable in
            
            guard let url = URL(string: APIClient.BASE_URL + self.path) else {
                fatalError("Could not get url")
            }
            
            let params = parameters ?? [:]
            
            var urlRequest = URLRequest(url: url)
            if method != .get {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
            urlRequest.httpMethod = method.rawValue
            
            #if DEBUG
            self.logRequest(params: params)
            #endif
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse
                    , let `data` = data else {
                    
                    DispatchQueue.main.async {
                        observer(.failure(URLError(.badServerResponse)))
                    }
                    return
                }
                
                #if DEBUG
                logResponse(data: data, response: httpResponse)
                #endif
                
                if !(200...299 ~= httpResponse.statusCode) {
                    DispatchQueue.main.async {
                        observer(.failure(URLError(.badServerResponse)))
                    }
                }
                
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        observer(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        observer(.failure(error))
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
        
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
