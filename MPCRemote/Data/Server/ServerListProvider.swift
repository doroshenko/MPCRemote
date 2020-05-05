//
//  ServerListProvider.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol ServerListProviderType {
    func fetch() -> [Server]
    func add(server: Server) -> [Server]

    func scan(complete: Bool, completion: @escaping (Server) -> Void)
    func cancel()
}

struct ServerListProvider: ServerListProviderType {
    private let networkService: NetworkServiceType
    private let settingsService: SettingsServiceType

    init(networkService: NetworkServiceType, settingsService: SettingsServiceType) {
        self.networkService = networkService
        self.settingsService = settingsService
    }
}

extension ServerListProvider {

    func fetch() -> [Server] {
        settingsService.servers
    }

    @discardableResult
    func add(server: Server) -> [Server] {
        settingsService.add(server: server)
    }
}

extension ServerListProvider {

    func scan(complete: Bool, completion: @escaping (Server) -> Void) {
        networkService.scan(complete: true, completion: completion)
    }

    func cancel() {
        networkService.cancel()
    }
}
