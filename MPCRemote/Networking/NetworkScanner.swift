//
//  NetworkScanner.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class NetworkScanner {

    var isConnectedToLAN: Bool {
        true
    }

    func enumerateHosts() -> [String] {
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

    private func performPing(hostName: String, errorLogging: Bool) {
        Ping(hostName: hostName) { result in
            switch result {
            case .success(let duration):
                logInfo("Found host: \(hostName) with ping \(duration)", domain: .networking)
            case .failure(let error):
                guard errorLogging else { return }
                logError("Couldn't ping host: \(hostName) with error: \(error)", domain: .networking)
            }
        }
    }
}
