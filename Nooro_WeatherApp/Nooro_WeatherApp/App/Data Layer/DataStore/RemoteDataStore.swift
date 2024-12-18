//
//  RemoteDataStore.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

protocol RemoteDataStoreProtocol {
    func request<T: Decodable>(
        requestPararm: RequestPararm,
        method: HTTPMethod,
        body: Data? ,
        headers: [String: String]?,
        responseType: T.Type
    ) async throws -> T?

}

struct RemoteDataStore: RemoteDataStoreProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func request<T: Decodable>(
        requestPararm: RequestPararm,
        method: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T? {
        return try await withCheckedThrowingContinuation { continuation in
            networkManager.request(
                requestPararm: requestPararm,
                method: method,
                body: body,
                headers: headers,
                responseType: responseType
            ) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
