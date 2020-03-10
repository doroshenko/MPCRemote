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

    static func post(command: Command, server: Server = StorageService.server) {
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(command: command)

        logInfo(domain: .api)
        postInternal(url: url, parameters: parameters)
    }

    static func post(volume: Int, server: Server = StorageService.server) {
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(volume: volume)

        logInfo(domain: .api)
        postInternal(url: url, parameters: parameters)
    }

    static func post(seek: Int, server: Server = StorageService.server) {
        let url = URLFactory.make(server: server, endpoint: .command)
        let parameters = HTTPParametersFactory.make(seek: seek)

        logInfo(domain: .api)
        postInternal(url: url, parameters: parameters)
    }

    static func getState(server: Server = StorageService.server, completion: @escaping (State?) -> Void) {
        let url = URLFactory.make(server: server, endpoint: .state)

        logInfo(domain: .api)
        getInternal(url: url) { data in
            guard let data = data else {
                logError("Invalid response data", domain: .api)
                completion(nil)
                return
            }

            let state = State(data: data)
            completion(state)
        }
    }

    static func getSnapshot(server: Server = StorageService.server, completion: @escaping (UIImage?) -> Void) {
        let url = URLFactory.make(server: server, endpoint: .snapshot)

        logInfo(domain: .api)
        getInternal(url: url) { data in
            guard let data = data else {
                logError("Invalid response data", domain: .api)
                completion(nil)
                return
            }

            let snapshot = UIImage(data: data)
            completion(snapshot)
        }
    }
}

// MARK: - Internals

private extension APIService {

    static func postInternal(url: URL?, parameters: HTTPParameters) {
        guard let url = url else {
            logError("Invalid endpoint URL", domain: .api)
            return
        }

        logInfo("Making a POST request to url: \(url) with parameters: \(parameters)", domain: .api)
        AF.request(url, method: .post, parameters: parameters).validate().response { response in
            switch response.result {
            case .success:
                logInfo("Request successful", domain: .api)
            case let .failure(error):
                logError("Request failed with error: \(error.localizedDescription)", domain: .api)
            }
        }
    }

    static func getInternal(url: URL?, completion: @escaping (Data?) -> Void) {
        guard let url = url else {
            logError("Invalid endpoint URL", domain: .api)
            return
        }

        logInfo("Making a GET request to url: \(url)", domain: .api)
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success:
                logInfo("Request succeded: \(response.description)", domain: .api)
                completion(response.data)
            case let .failure(error):
                logError("Request failed with error: \(error.localizedDescription)", domain: .api)
                completion(nil)
            }
        }
    }
}
