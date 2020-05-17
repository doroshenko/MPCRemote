//
//  ServerListProvider.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol ServerListProviderType {
    func getServer() -> Server?
    func getServerList() -> [ServerListItem]

    func select(server: Server) -> Server?
    func remove(server: Server) -> Server?

    func scan(serverFound: @escaping (ServerListItem) -> Void, scanFinished: (() -> Void)?)
    func ping(server: Server, completion: @escaping ServerStateHandler)
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

    func getServer() -> Server? {
        settingsService.server
    }

    func getServerList() -> [ServerListItem] {
        settingsService.servers.serverList()
    }
}

extension ServerListProvider {

    func select(server: Server) -> Server? {
        settingsService.add(server: server)
    }

    func remove(server: Server) -> Server? {
        settingsService.remove(server: server)
    }
}

extension ServerListProvider {

    func scan(serverFound: @escaping (ServerListItem) -> Void, scanFinished: (() -> Void)?) {
        networkService.scan(serverFound: { serverState in
            let server = serverState.server
            let serverListItem = ServerListItem(server: server, isFavorite: self.isFavorite(server), isOnline: true)
            serverFound(serverListItem)
        }, scanFinished: scanFinished)
    }

    func ping(server: Server, completion: @escaping ServerStateHandler) {
        networkService.ping(address: server.address, completion: completion)
    }

    func cancel() {
        networkService.cancel()
    }
}

private extension ServerListProvider {

    func isFavorite(_ server: Server) -> Bool {
        settingsService.servers.contains(server)
    }
}
