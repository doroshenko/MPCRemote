//
//  ServerListModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

final class ServerListModel: ObservableObject {

    private let networkService: NetworkService
    private let storageService: StorageService

    @Published var servers: [Server]

    init(resolver: Resolver) {
        self.networkService = resolver.resolve()
        self.storageService = resolver.resolve()
        self.servers = self.storageService.servers
    }

    func set(server: Server) {
        storageService.server = server
        storageService.servers.appendUnique(server)
    }

    func scan() {
        networkService.scan(complete: true, completion: { server in
            self.servers.appendUnique(server)
        })
    }

    func cancel() {
        networkService.cancel()
    }
}
