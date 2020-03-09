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

        cancel()

        logInfo("Network scan initiated", domain: .networking)
        for hostName in enumerateHosts() {
            performPing(hostName: hostName) { result in
                if case let .success(duration) = result {
                    logInfo("Found host: \(hostName) after \(Int(duration * 1000)) ms", domain: .networking)
                }
            }
        }

        logInfo("Network scan finished", domain: .networking)
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

    static func enumerateHosts() -> [String] {
        var hosts: [String] = []

        logInfo("Hosts enumeration started", domain: .networking)
        let localAddress = Connectivity.localIPAddress
        guard let address = localAddress.address, let mask = localAddress.mask else {
            logError("Couldn't retrieve local IP address and network mask", domain: .networking)
            return []
        }

        let addressComponents = address.components(separatedBy: ".").compactMap { UInt8($0) }
        let maskComponents = mask.components(separatedBy: ".").compactMap { UInt8($0) }
        let componentCount = 4

        guard addressComponents.count == componentCount, maskComponents.count == componentCount else {
            logError("Invalid local IP address and network mask", domain: .networking)
            return []
        }

        var baseAddress: [UInt8] = []
        for index in 0...3 {
            baseAddress.append(addressComponents[index] & maskComponents[index])
        }

        logInfo("Base IP address: \(baseAddress)", domain: .networking)
        let maxIndex: UInt8 = 254

        if baseAddress[2] == 0 {
            for thirdIndex in 1...maxIndex {
                for fourthIndex in 1...maxIndex {
                    hosts.append("\(baseAddress[0]).\(baseAddress[1]).\(thirdIndex).\(fourthIndex)")
                }
            }
        } else {
            for fourthIndex in 1...maxIndex {
                hosts.append("\(baseAddress[0]).\(baseAddress[1]).\(baseAddress[2]).\(fourthIndex)")
            }
        }

        logInfo("Hosts enumeration finished", domain: .networking)
        return hosts
    }

    static func performPing(hostName: String, completion: @escaping PingResult) {
        let ping = Ping(hostName: hostName) { result in
            completion(result)
        }

        NetworkService.operationQueue.addOperation(ping)
    }
}
