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
        ["192.168.1.1"]
    }

    func scan() {
        guard isConnectedToLAN else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        logInfo("Network scan started", domain: .networking)

        let hosts = enumerateHosts()

        hosts.forEach { performPing(hostName: $0) }
    }

    private func performPing(hostName: String) {
        Ping(hostName: hostName) { result in
            switch result {
            case .success(let hostName):
                logInfo("Found host: \(hostName)", domain: .networking)
            case .failure(let error):
                logError("Couldn't ping host: \(hostName) with error: \(error)", domain: .networking)
            }
        }
    }
}
