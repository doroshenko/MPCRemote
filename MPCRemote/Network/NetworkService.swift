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

        logInfo("Network scan initiated", domain: .networking)
        for ip in addressRange {
            performPing(hostName: ip.address) { result in
                if case let .success(duration) = result {
                    logInfo("Found host: \(ip.address) after \(Int(duration * 1000)) ms", domain: .networking)
                }
            }
        }
    }

    static func ping(hostName: String) {
        guard Connectivity.isHostReachable(hostName: hostName) else {
            logError("Cannot reach host: \(hostName)", domain: .networking)
            return
        }

        logInfo("Ping initated for host: \(hostName)", domain: .networking)
        performPing(hostName: hostName) { result in
            switch result {
            case .success(let duration):
                let msValue = Int(duration * 1000)
                logInfo("Found host: \(hostName) after \(msValue) ms", domain: .networking)
            case .failure(let error):
                logError("Couldn't ping host: \(hostName) with error: \(error)", domain: .networking)
            }
        }
    }

    static func cancel() {
        logInfo("All active operations canceled", domain: .networking)
        NetworkService.operationQueue.cancelAllOperations()
    }
}

// MARK: - Internals

private extension NetworkService {

    static let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "network_scanner_queue"
        queue.maxConcurrentOperationCount = 50
        return queue
    }()

    static var addressRange: CountableClosedRange<IPv4>? {
        logInfo(domain: .networking)
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

    static func performPing(hostName: String, completion: @escaping PingResult) {
        let ping = Ping(hostName: hostName) { result in
            completion(result)
        }

        NetworkService.operationQueue.addOperation(ping)
    }
}
