//
//  ScannerService.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct ScannerService {

    private static let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "network_scanner_queue"
        queue.maxConcurrentOperationCount = 50
        return queue
    }()

    // MARK: - Public API

    static func scan() {
        guard Connectivity.isConnectedToWifi else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        logInfo("Network scan initiated", domain: .networking)

        let hosts = enumerateHosts()
        hosts.forEach { performPing(hostName: $0, errorLogging: false) }

        logInfo("Network scan finished", domain: .networking)
    }

    static func ping(hostName: String) {
        guard Connectivity.isHostReachable(hostName: hostName) else {
            logError("Cannot reach host: \(hostName)", domain: .networking)
            return
        }

        logInfo("Ping initated for host: \(hostName)", domain: .networking)

        performPing(hostName: hostName, errorLogging: true)
    }

    static func cancel() {
        logInfo("All active operations canceled", domain: .networking)
        ScannerService.operationQueue.cancelAllOperations()
    }

    // MARK: - Internal functions

    private static func enumerateHosts() -> [String] {
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

    private static func performPing(hostName: String, errorLogging: Bool) {
        let ping = Ping(hostName: hostName) { result in
            switch result {
            case .success(let duration):
                let msValue = Int(duration * 1000)
                logInfo("Found host: \(hostName) after \(msValue) ms", domain: .networking)
            case .failure(let error):
                guard errorLogging else { return }
                logError("Couldn't ping host: \(hostName) with error: \(error)", domain: .networking)
            }
        }

        ScannerService.operationQueue.addOperation(ping)
    }
}
