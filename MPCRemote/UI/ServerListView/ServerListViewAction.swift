//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerListViewAction: ActionType {
    case appendServerList(ServerListItem)
    case deleteServerList(ServerListItem)
    case setServerList([ServerListItem])

    case setServer(Server?)

    case setScanning(Bool)
}

struct ServerListViewActionCreator: ActionCreatorType {

    private let provider: ServerListProviderType
    private let dispatch: (ServerListViewAction) -> Void

    init(provider: ServerListProviderType, dispatch: @escaping (ServerListViewAction) -> Void) {
        self.provider = provider
        self.dispatch = dispatch
    }
}

extension ServerListViewActionCreator {

    func setup() {
        logDebug("Server list setup", domain: .ui)
        let servers = provider.getServerList()
        dispatch(.setServerList(servers))

        let server = provider.getServer()
        dispatch(.setServer(server))
    }

    func select(_ serverListItem: ServerListItem) {
        logDebug("Server selected \(serverListItem.server)", domain: .ui)
        let server = provider.select(server: serverListItem.server)
        dispatch(.setServer(server))
        dispatch(.appendServerList(serverListItem.favoriteItem))
    }

    func delete(_ serverListItem: ServerListItem) {
        logDebug("Server deleted \(serverListItem.server)", domain: .ui)

        let server = provider.remove(server: serverListItem.server)
        dispatch(.setServer(server))
        dispatch(.deleteServerList(serverListItem))
    }
}

extension ServerListViewActionCreator {

    func scan() {
        logDebug("Scan started", domain: .ui)
        setup()
        dispatch(.setScanning(true))
        provider.scan(serverFound: { serverListItem in
            logDebug("Server found: \(serverListItem)", domain: .ui)
            self.dispatch(.appendServerList(serverListItem))
        }, scanFinished: {
            logDebug("Scan finished", domain: .ui)
            self.dispatch(.setScanning(false))
        })
    }

    func ping(server: Server, completion: @escaping (Bool) -> Void) {
        logDebug("Ping server \(server)", domain: .ui)
        provider.ping(server: server) { result in
            if case .success = result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func cancel() {
        logDebug("Scan canceled", domain: .ui)
        dispatch(.setScanning(false))
        provider.cancel()
    }
}
