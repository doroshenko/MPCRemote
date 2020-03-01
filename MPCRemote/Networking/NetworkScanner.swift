//
//  NetworkScanner.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class NetworkScanner {

    func isConnectedToLAN() -> Bool {
        true
    }

    func enumerateHosts() -> [String] {
        []
    }

    func scan() {
        let hosts = enumerateHosts()

        hosts.forEach { performPing(hostName: $0) }
    }

    private func performPing(hostName: String) {
        Ping(hostName: hostName) { result in
            switch result {
            case .success(let hostName):
                logInfo("Found host: \(hostName)", domain: .networking)
            case .failure(let error):
                logError("Error pinging host: \(hostName) due to: \(error.localizedDescription)")
            }
        }
    }
}
