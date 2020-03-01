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

        hosts.forEach { Ping(hostName: $0, completionHandler: { _ in })}
    }
}
