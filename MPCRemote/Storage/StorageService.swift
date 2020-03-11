//
//  StorageService.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class StorageService {

    private enum Key: String {
        case server
        case state
    }

    private static var userDefaults: UserDefaults {
        .standard
    }

    static var server: Server {
        userDefaults.object(forKey: Key.server.rawValue) as? Server ?? Server(name: "", ip: IPv4(string: "192.168.1.1")!, port: 0)
    }
}
