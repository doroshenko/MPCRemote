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

    static func postCommand(server: Server, command: Command) {
        let url = APIFactory.URL(server: server, endpoint: .command)
        let parameters = APIFactory.parameters(command: command)

        logInfo("Posting command: \(command) with parameters: \(String(describing: parameters))", domain: .api)
        postInternal(url: url, parameters: parameters)
    }

    static func postCommandVolume(server: Server, volume: Int) {
        let url = APIFactory.URL(server: server, endpoint: .command)
        let parameters = APIFactory.parameters(command: .volume, value: volume)

        logInfo("Posting command: \(Command.volume) with parameters: \(String(describing: parameters))", domain: .api)
        postInternal(url: url, parameters: parameters)
    }

    static func postCommandSeek(server: Server, seek: Int) {
        let url = APIFactory.URL(server: server, endpoint: .command)
        let parameters = APIFactory.parameters(command: .seek, value: seek)

        logInfo("Posting command: \(Command.seek) with parameters: \(String(describing: parameters))", domain: .api)
        postInternal(url: url, parameters: parameters)
    }

    static func getState(server: Server, completion: @escaping (State?) -> Void) {
        let url = APIFactory.URL(server: server, endpoint: .state)

        logInfo("Requesting state", domain: .api)
        getInternal(url: url) { data in
            guard let data = data else {
                logError("Invalid response data", domain: .api)
                completion(nil)
                return
            }

            let state = APIFactory.state(data)
            completion(state)
        }
    }

    static func getSnapshot(server: Server, completion: @escaping (UIImage?) -> Void) {
        let url = APIFactory.URL(server: server, endpoint: .snapshot)

        logInfo("Requesting snapshot", domain: .api)
        getInternal(url: url) { data in
            guard let data = data else {
                logError("Invalid response data", domain: .api)
                completion(nil)
                return
            }

            let snapshot = APIFactory.snapshot(data)
            completion(snapshot)
        }
    }
}

// MARK: - Internals

private extension APIService {

    static func postInternal(url: URL?, parameters: [String: String]?) {
        guard let url = url else {
            logError("Invalid endpoint URL", domain: .api)
            return
        }

        guard let parameters = parameters else {
            logError("Empty parameters list", domain: .api)
            return
        }

        AF.request(url, method: .post, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success:
                logInfo("Request successful", domain: .api)
            case let .failure(error):
                logError("Request failed with error: \(error)", domain: .api)
            }
        }
    }

    static func getInternal(url: URL?, completion: @escaping (Data?) -> Void) {
        guard let url = url else {
            logError("Invalid endpoint URL", domain: .api)
            return
        }

        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success:
                logInfo("Request succeded: \(response.description)", domain: .api)
                completion(response.data)
            case let .failure(error):
                logError("Request failed with error: \(error)", domain: .api)
                completion(nil)
            }
        }
    }
}
