//
//  APIService.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Alamofire

protocol APIServiceType {
    func post(command: Command, server: Server?, completion: @escaping PostHandler)
    func post(volume: Double, server: Server?, completion: @escaping PostHandler)
    func post(seek: Double, server: Server?, completion: @escaping PostHandler)
    func getState(server: Server?, completion: @escaping StateHandler)
    func getSnapshot(server: Server?, completion: @escaping SnapshotHandler)
}

struct APIService: APIServiceType {

    func post(command: Command, server: Server?, completion: @escaping PostHandler) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(command: command)
        performPost(url: url, parameters: parameters, completion: completion)
    }

    func post(volume: Double, server: Server?, completion: @escaping PostHandler) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(volume: volume)
        performPost(url: url, parameters: parameters, completion: completion)
    }

    func post(seek: Double, server: Server?, completion: @escaping PostHandler) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(seek: seek)
        performPost(url: url, parameters: parameters, completion: completion)
    }

    func getState(server: Server?, completion: @escaping StateHandler) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .state)
        performGetState(url: url, completion: completion)
    }

    func getSnapshot(server: Server?, completion: @escaping SnapshotHandler) {
        logDebug(domain: .api)
        let url = URLFactory.make(server: server, endpoint: .snapshot)
        performGetSnapshot(url: url, completion: completion)
    }
}

// MARK: - Internals

private extension APIService {

    func performPost(url: URL?, parameters: HTTPParameters, completion: @escaping PostHandler) {
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

    func performGetState(url: URL?, completion: @escaping StateHandler) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Making a GET request to url: \(url)", domain: .api)
        AF.request(url, method: .get).validate().responseString(encoding: .utf8) { response in
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

    func performGetSnapshot(url: URL?, completion: @escaping SnapshotHandler) {
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
