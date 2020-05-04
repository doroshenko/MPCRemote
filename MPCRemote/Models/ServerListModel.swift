//
//  ServerListModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

final class ServerListModel: ObservableObject {

    @Published var servers: [Server]

    init() {
        servers = StorageService.servers
    }

    func scanAction() {
        NetworkService.scan(complete: true, completion: { server in
            self.servers.appendUnique(server)
        })
    }

    func cancelAction() {
        NetworkService.cancel()
    }
}
