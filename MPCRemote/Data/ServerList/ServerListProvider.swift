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

    @discardableResult func add(server: Server) -> Server?
    @discardableResult func remove(server: Server) -> Server?

    func scan(serverFound: @escaping (ServerListItem) -> Void, scanFinished: (() -> Void)?)
    func ping(server: Server, completion: @escaping ServerStateHandler)
    func cancel()

    func verify(address: String, port: String, name: String) -> Server?
    func verify(address: String) -> String?
    func verify(port: String) -> UInt16?
    func verify(name: String) -> String?
}

struct ServerListProvider: ServerListProviderType {
    private let networkService: NetworkServiceType
    private let settingsService: SettingsServiceType
    private let serverVerificationService: ServerVerificationServiceType

    init(networkService: NetworkServiceType, settingsService: SettingsServiceType, serverVerificationService: ServerVerificationServiceType) {
        self.networkService = networkService
        self.settingsService = settingsService
        self.serverVerificationService = serverVerificationService
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

    func add(server: Server) -> Server? {
        settingsService.add(server: server)
    }

    func remove(server: Server) -> Server? {
        settingsService.remove(server: server)
    }
}

extension ServerListProvider {

    func verify(address: String, port: String, name: String) -> Server? {
        serverVerificationService.verify(address: address, port: port, name: name)
    }

    func verify(address: String) -> String? {
        serverVerificationService.verify(address: address)
    }

    func verify(port: String) -> UInt16? {
        serverVerificationService.verify(port: port)
    }

    func verify(name: String) -> String? {
        serverVerificationService.verify(name: name)
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
