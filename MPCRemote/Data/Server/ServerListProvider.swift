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

    func scan(serverFound: @escaping (ServerState) -> Void, scanFinished: (() -> Void)?)
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

    func fetch() -> [Server] {
        settingsService.servers
    }

    @discardableResult
    func add(server: Server) -> [Server] {
        settingsService.add(server: server)
    }
}

extension ServerListProvider {

    func scan(serverFound: @escaping (ServerState) -> Void, scanFinished: (() -> Void)?) {
        networkService.scan(serverFound: serverFound, scanFinished: scanFinished)
    }

    func ping(server: Server, completion: @escaping ServerStateHandler) {
        networkService.ping(address: server.address, completion: completion)
    }

    func cancel() {
        networkService.cancel()
    }
}
