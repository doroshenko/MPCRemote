//
//  SettingsService.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

protocol SettingsServiceType {
    var server: Server? { get }
    var servers: [Server] { get }
    var isEmpty: Bool { get }

    @discardableResult
    func add(server: Server) -> [Server]
}

struct SettingsService: SettingsServiceType {
    @ObservedObject private var userSettings = UserSettings()
}

extension SettingsService {

    var server: Server? {
        userSettings.server
    }

    var servers: [Server] {
        userSettings.servers
    }

    var isEmpty: Bool {
        server == nil && servers.isEmpty
    }

    func add(server: Server) -> [Server] {
        userSettings.server = server
        userSettings.servers.appendUnique(server)

        return userSettings.servers
    }
}
