//
//  NetworkService.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class NetworkService {

    let factory: Factory

    init(factory: Factory) {
        self.factory = factory
    }

    func scan(complete: Bool, completion: @escaping (Server) -> Void) {
        guard Connectivity.isConnectedToWifi, let addressRange = addressRange else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        cancel()

        logDebug("Network scan initiated", domain: .networking)

        var found: Bool = false
        addressRange.forEach { ip in
            performPing(hostName: ip.address, completion: { serverResult in
                if case let .success(server) = serverResult, complete || !found {
                    found = true
                    completion(server)
                }
            })
        }
    }

    func ping(hostName: String, completion: @escaping ServerResult) {
        guard Connectivity.isHostReachable(hostName: hostName) else {
            logError("Cannot reach host: \(hostName)", domain: .networking)
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Ping initated for host: \(hostName)", domain: .networking)
        performPing(hostName: hostName, completion: completion)
    }

    func cancel() {
        logDebug("All active operations canceled", domain: .networking)
        NetworkService.operationQueue.cancelAllOperations()
    }
}

// MARK: - Internals

private extension NetworkService {

    var addressRange: CountableClosedRange<IPv4>? {
        logDebug(domain: .networking)
        let localAddress = Connectivity.localIPAddress
        guard let addressString = localAddress.address, let ip = IPv4(string: addressString) else {
            logError("Invalid local IP address", domain: .networking)
            return nil
        }

        guard let maskString = localAddress.mask, let mask = IPv4(string: maskString) else {
            logError("Invalid network mask", domain: .networking)
            return nil
        }

        return ip.usableAddressRange(with: mask)
    }

    func performPing(hostName: String, completion: @escaping ServerResult) {
        pingOperation(hostName: hostName) { pingResult in
            switch pingResult {
            case let .success(duration):
                logDebug("Found host: \(hostName) after \(Int(duration * 1000)) ms", domain: .networking)
                self.performValidation(hostName: hostName, completion: completion)
            case .failure:
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                completion(.failure(.invalidEndpoint))
            }
        }
    }

    func performValidation(hostName: String, completion: @escaping ServerResult) {
        let server = Server(address: hostName)
        validationOperation(server: server) { validateResult in
            switch validateResult {
            case let .success(state):
                logInfo("Found MPC server at: \(hostName) with state: \(state)", domain: .networking)
                completion(.success(server))
            case let .failure(error):
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Operations

private extension NetworkService {

    static let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "network_scanner_queue"
        queue.maxConcurrentOperationCount = 50
        return queue
    }()

    func pingOperation(hostName: String, completion: @escaping PingResult) {
        let ping = Ping(hostName: hostName, completion: completion)
        NetworkService.operationQueue.addOperation(ping)
    }

    func validationOperation(server: Server, completion: @escaping StateResult) {
        let validation = factory.validation(server: server, completion: completion)
        NetworkService.operationQueue.addOperation(validation)
    }
}
