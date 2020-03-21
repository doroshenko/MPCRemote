//
//  StorageService.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class StorageService {

    private enum Key: String, UserDefaultKey {
        case server
        case state
        case servers
    }

    @UserDefault(StorageService.Key.server, defaultValue: nil)
    static var server: Server?

    @UserDefault(StorageService.Key.state, defaultValue: State.default)
    static var state: State

    @UserDefault(StorageService.Key.servers, defaultValue: [])
    static var servers: [Server]
}
