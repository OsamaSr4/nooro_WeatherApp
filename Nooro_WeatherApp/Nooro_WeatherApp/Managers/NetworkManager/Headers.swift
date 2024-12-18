//
//  Headers.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

class HeaderManager {
    
    
    static let shared = HeaderManager()
    private init() {}
    
    
    private var defaultHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "key" : Domain.getApiKey()
    ]
    
    func setDefaultHeader(value: String, for field: String) {
        defaultHeaders[field] = value
    }
    

    func removeDefaultHeader(for field: String) {
        defaultHeaders.removeValue(forKey: field)
    }
    
   
    func mergedHeaders(with customHeaders: [String: String]?) -> [String: String] {
        var headers = defaultHeaders
        customHeaders?.forEach { key, value in
            headers[key] = value
        }
        return headers
    }
}
