//
//  UserSettings.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

class UserSettings: ObservableObject {

    private enum Key: String, UserDefaultKey {
        case server
        case servers
    }

    @UserDefault(UserSettings.Key.server, defaultValue: nil)
    var server: Server?

    @UserDefault(UserSettings.Key.servers, defaultValue: [])
    var servers: [Server]
}

extension UserSettings {

    func add(server: Server) -> [Server] {
        self.server = server
        self.servers.updateOrAppend(server)

        return servers
    }
}
