//
//  NetworkManager.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

struct RequestPararm {
    let path: EndPoints
    let queryParams: [String: String]?
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case noData
    case decodingFailed(Error)
    case network(Error)
    case apiError(code: Int, message: String)
    case unknownError
    case networkError // New case for no internet
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.noData, .noData),
             (.unknownError, .unknownError),
             (.networkError, .networkError):
            return true
        case let (.apiError(lhsCode, lhsMessage), .apiError(rhsCode, rhsMessage)):
            return lhsCode == rhsCode && lhsMessage == rhsMessage
        default:
            return false
        }
    }
}


struct ApiErrorResponse: Decodable {
    struct ErrorDetail: Decodable {
        let code: Int
        let message: String
    }
    let error: ErrorDetail
}


protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        requestPararm: RequestPararm,
        method: HTTPMethod,
        body: Data? ,
        headers: [String: String]?,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}


import Foundation
import Network

class NetworkManager: NetworkManagerProtocol {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    // Function to check network connectivity
    private func isNetworkAvailable() -> Bool {
        var isAvailable = false
        monitor.pathUpdateHandler = { path in
            isAvailable = path.status == .satisfied
        }
        monitor.start(queue: queue)
        return isAvailable
    }
    
    func request<T: Decodable>(
        requestPararm: RequestPararm,
        method: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        // Check if network is available
        guard isNetworkAvailable() else {
            completion(.failure(.networkError)) // New error case for no internet
            return
        }
        
        let completeUrl = Domain.completeUrl(endPoints: requestPararm.path)
        
        guard var urlComponents = URLComponents(string: completeUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        if let queryParams = requestPararm.queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        let finalHeaders = HeaderManager.shared.mergedHeaders(with: headers)
        finalHeaders.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.network(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            } else {
                do {
                    // Attempt to decode error response
                    let errorResponse = try JSONDecoder().decode(ApiErrorResponse.self, from: data)
                    let networkError = NetworkError.apiError(code: errorResponse.error.code, message: errorResponse.error.message)
                    completion(.failure(networkError))
                } catch {
                    completion(.failure(.unknownError))
                }
            }
        }
        
        task.resume()
    }
}
