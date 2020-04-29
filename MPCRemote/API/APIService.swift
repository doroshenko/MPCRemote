//
//  APIService.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation
import Alamofire

final class APIService {

    static func post(command: Command, server: Server? = StorageService.server, completion: PostResult? = nil) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(command: command)
        performPost(url: url, parameters: parameters, completion: completion)
    }

    static func post(volume: Double, server: Server? = StorageService.server, completion: PostResult? = nil) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(volume: volume)
        performPost(url: url, parameters: parameters, completion: completion)
    }

    static func post(seek: Double, server: Server? = StorageService.server, completion: PostResult? = nil) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(seek: seek)
        performPost(url: url, parameters: parameters, completion: completion)
    }

    static func getState(server: Server? = StorageService.server, completion: @escaping StateResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .state)
        performGetState(url: url, completion: completion)
    }

    static func getSnapshot(server: Server? = StorageService.server, completion: @escaping SnapshotResult) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .snapshot)
        performGetSnapshot(url: url, completion: completion)
    }
}

// MARK: - Internals

private extension APIService {

    static func performPost(url: URL?, parameters: HTTPParameters, completion: PostResult?) {
        guard let url = url else {
            completion?(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a POST request to url: \(url) with parameters: \(parameters)", domain: .api)
        AF.request(url, method: .post, parameters: parameters).validate().response { response in
            switch response.result {
            case .success:
                logDebug("Request successful", domain: .api)
                completion?(.success(()))
            case let .failure(error):
                completion?(.failure(.requestFailed(error)))
            }
        }
    }

    static func performGetState(url: URL?, completion: @escaping StateResult) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a GET request to url: \(url)", domain: .api)
        AF.request(url, method: .get).validate().responseString { response in
            switch response.result {
            case .success(let string):
                guard let state = PlayerStateFactory.make(string: string) else {
                    completion(.failure(.conversionFailed))
                    return
                }

                logDebug("Request successful", domain: .api)
                completion(.success(state))
            case let .failure(error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }

    static func performGetSnapshot(url: URL?, completion: @escaping SnapshotResult) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a GET request to url: \(url)", domain: .api)
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                guard let output = UIImage(data: data) else {
                    completion(.failure(.conversionFailed))
                    return
                }

                logDebug("Request successful: \(response.description)", domain: .api)
                completion(.success(output))
            case let .failure(error):
                completion(.failure(.requestFailed(error)))
            }
        }
    }
}
