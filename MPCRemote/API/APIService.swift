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
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(command: command)

        logInfo(domain: .api)
        postInternal(url: url, parameters: parameters, completion: completion)
    }

    static func post(volume: Int, server: Server? = StorageService.server, completion: @escaping PostResult) {
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(volume: volume)

        logInfo(domain: .api)
        postInternal(url: url, parameters: parameters, completion: completion)
    }

    static func post(seek: Int, server: Server? = StorageService.server, completion: @escaping PostResult) {
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(seek: seek)

        logInfo(domain: .api)
        postInternal(url: url, parameters: parameters, completion: completion)
    }

    static func getState(server: Server? = StorageService.server, completion: @escaping StateResult) {
        let url = URLFactory.make(server: server, endpoint: .state)

        logInfo(domain: .api)
        getInternal(url: url) { result in
            switch result {
            case let .success(data):
                if let state = State(data: data) {
                    logDebug("Request successful", domain: .api)
                    completion(.success(state))
                } else {
                    completion(.failure(.conversionFailed))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    static func getSnapshot(server: Server? = StorageService.server, completion: @escaping SnapshotResult) {
        let url = URLFactory.make(server: server, endpoint: .snapshot)

        logInfo(domain: .api)
        getInternal(url: url) { result in
            switch result {
            case let .success(data):
                if let snapshot = UIImage(data: data) {
                    logDebug("Request successful", domain: .api)
                    completion(.success(snapshot))
                } else {
                    completion(.failure(.conversionFailed))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
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

    static func getInternal(url: URL?, completion: @escaping GetResult) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a GET request to url: \(url)", domain: .api)
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    logDebug("Request succeded: \(response.description)", domain: .api)
                    completion(.success(data))
                } else {
                    completion(.failure(.emptyResponse))
                }
            case let .failure(error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }
}
