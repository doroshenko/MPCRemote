//
//  NetworkService.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class NetworkService {

    static func scan() {
        guard Connectivity.isConnectedToWifi else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        guard let addressRange = addressRange else { return }

        cancel()

        logDebug("Network scan initiated", domain: .networking)
        addressRange.forEach { ip in
            performPing(hostName: ip.address)
        }
    }

    static func ping(hostName: String) {
        guard Connectivity.isHostReachable(hostName: hostName) else {
            logError("Cannot reach host: \(hostName)", domain: .networking)
            return
        }

        logDebug("Ping initated for host: \(hostName)", domain: .networking)
        performPing(hostName: hostName)
    }

    static func cancel() {
        logDebug("All active operations canceled", domain: .networking)
        NetworkService.operationQueue.cancelAllOperations()
    }
}

// MARK: - Internals

private extension NetworkService {

    static var addressRange: CountableClosedRange<IPv4>? {
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

    static func performPing(hostName: String) {
        pingOperation(hostName: hostName) { pingResult in
            switch pingResult {
            case let .success(duration):
                logDebug("Found host: \(hostName) after \(Int(duration * 1000)) ms", domain: .networking)
                performValidation(hostName: hostName)
            case .failure:
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                break
            }
        }
    }

    static func performValidation(hostName: String) {
        let server = Server(address: hostName)
        validationOperation(server: server) { validateResult in
            switch validateResult {
            case let .success(state):
                logInfo("Found MPC server at: \(hostName) with state: \(state)", domain: .networking)
            case .failure:
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                break
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

    static func pingOperation(hostName: String, completion: @escaping PingResult) {
        let ping = Ping(hostName: hostName, completion: completion)
        NetworkService.operationQueue.addOperation(ping)
    }

    static func validationOperation(server: Server, completion: @escaping StateResult) {
        let validation = Validation(server: server, completion: completion)
        NetworkService.operationQueue.addOperation(validation)
    }
}
