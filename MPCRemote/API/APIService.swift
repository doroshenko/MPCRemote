//
//  APIService.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation
import Alamofire

typealias HTTPParameters = [String: String]

final class APIService {

    static func post(command: Command, server: Server? = StorageService.server, completion: @escaping PostResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(command: command)
        postInternal(url: url, parameters: parameters, completion: completion)
    }

    static func post(volume: Int, server: Server? = StorageService.server, completion: @escaping PostResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(volume: volume)
        postInternal(url: url, parameters: parameters, completion: completion)
    }

    static func post(seek: Int, server: Server? = StorageService.server, completion: @escaping PostResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(seek: seek)
        postInternal(url: url, parameters: parameters, completion: completion)
    }

    static func getState(server: Server? = StorageService.server, completion: @escaping StateResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .state)
        getInternal(url: url, conversion: stateConversion, completion: completion)
    }

    static func getSnapshot(server: Server? = StorageService.server, completion: @escaping SnapshotResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .snapshot)
        getInternal(url: url, conversion: imageConversion, completion: completion)
    }
}

// MARK: - Internals

private extension APIService {

    static func postInternal(url: URL?, parameters: HTTPParameters, completion: @escaping PostResult) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a POST request to url: \(url) with parameters: \(parameters)", domain: .api)
        AF.request(url, method: .post, parameters: parameters).validate().response { response in
            switch response.result {
            case .success:
                logDebug("Request successful", domain: .api)
                completion(.success(()))
            case let .failure(error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }

    static func getInternal<Value>(url: URL?, conversion: @escaping (Data) -> Value?, completion: @escaping APIResult<Value>) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a GET request to url: \(url)", domain: .api)
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(.failure(.emptyResponse))
                    return
                }

                guard let output = conversion(data) else {
                    completion(.failure(.conversionFailed))
                    return
                }

                logDebug("Request succeded: \(response.description)", domain: .api)
                completion(.success(output))
            case let .failure(error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }
}

// MARK: - Data conversion functions

private extension APIService {

    static func imageConversion(data: Data) -> UIImage? {
        UIImage(data: data)
    }

    static func stateConversion(data: Data) -> State? {
        State(data: data)
    }
}
