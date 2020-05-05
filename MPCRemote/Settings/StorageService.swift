//
//  SettingsService.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

protocol StorageServiceType {
    var server: Server? { get }
    var servers: [Server] { get }

    func add(server: Server) -> [Server]
}

struct SettingsService: StorageServiceType {
    @ObservedObject var userSettings = UserSettings()
}

extension SettingsService {

    var server: Server? {
        userSettings.server
    }

    var servers: [Server] {
        userSettings.servers
    }

    func add(server: Server) -> [Server] {
        userSettings.server = server
        userSettings.servers.appendUnique(server)

        return userSettings.servers
    }
}
