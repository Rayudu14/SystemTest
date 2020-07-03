//
//  NetworkManager.swift
//  WiproTest
//
//  Created by Raidu on 7/2/20.
//  Copyright © 2020 Raidu. All rights reserved.
//

import Foundation

enum URLError : Error {
    case unformatedURL
    case dataNotFound
}
// A global container for URL
struct URLConstants {
    static let rowsURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

class Network {
    
    /// Get API Call
    static func getApiCallWithRequestString(requestString: String, completionBlock: @escaping((Result<Data, Error>) -> Void)) {
        
        guard let url = URL(string: requestString) else {
            completionBlock(.failure(URLError.unformatedURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (responseData, httpResponse, error) in
            
            if let err = error {
                completionBlock(.failure(err))
                return
            }
            
            guard let response = responseData else {
                completionBlock(.failure(URLError.dataNotFound))
                return
            }
            
            completionBlock(.success(response))
        }
        dataTask.resume();
    }
}
