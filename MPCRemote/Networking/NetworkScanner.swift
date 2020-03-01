//
//  NetworkScanner.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class NetworkScanner {

    private static let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "network_scanner_queue"
        queue.maxConcurrentOperationCount = 50
        return queue
    }()

    private var isConnectedToLAN: Bool {
        true
    }

    // MARK: - Public API

    func scan() {
        guard isConnectedToLAN else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        logInfo("Network scan initiated", domain: .networking)

        let hosts = enumerateHosts()
        hosts.forEach { performPing(hostName: $0, errorLogging: false) }

        logInfo("Network scan finished", domain: .networking)
    }

    func ping(hostName: String) {
        logInfo("Ping initated for host: \(hostName)", domain: .networking)

        performPing(hostName: hostName, errorLogging: true)
    }
    func cancel() {
        logInfo("All active operations canceled", domain: .networking)
        NetworkScanner.operationQueue.cancelAllOperations()
    }

    // MARK: - Internal functions

    private func enumerateHosts() -> [String] {
        var hosts: [String] = []

        logInfo("Hosts enumeration started", domain: .networking)
        for firstIndex in 1...1 {
            for secondIndex in 1...254 {
                hosts.append("192.168.\(firstIndex).\(secondIndex)")
            }
        }

        logInfo("Hosts enumeration finished", domain: .networking)
        return hosts
    }

    private func performPing(hostName: String, errorLogging: Bool) {
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

        NetworkScanner.operationQueue.addOperation(ping)
    }
}
