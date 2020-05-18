//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ScanningAction: ActionType {
    case set(Bool)
}

enum ServerListViewAction: ActionType {
    indirect case serverList(ServerListAction)
    indirect case server(ServerAction)
    indirect case scanning(ScanningAction)

    init(_ serverListAction: ServerListAction) {
        self = .serverList(serverListAction)
    }

    init(_ serverAction: ServerAction) {
        self = .server(serverAction)
    }

    init(_ scanningAction: ScanningAction) {
        self = .scanning(scanningAction)
    }
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
        dispatch(ServerListViewAction(.set(servers)))

        let server = provider.getServer()
        dispatch(ServerListViewAction(.set(server)))
    }

    func select(_ serverListItem: ServerListItem) {
        logDebug("Server selected \(serverListItem.server)", domain: .ui)
        let server = provider.select(server: serverListItem.server)
        dispatch(.server(.set(server)))
        dispatch(.serverList(.append(serverListItem.favoriteItem)))
    }

    func delete(_ serverListItem: ServerListItem) {
        logDebug("Server deleted \(serverListItem.server)", domain: .ui)

        let server = provider.remove(server: serverListItem.server)
        dispatch(ServerListViewAction(.set(server)))
        dispatch(ServerListViewAction(.delete(serverListItem)))
    }
}

extension ServerListViewActionCreator {

    func scan() {
        logDebug("Scan started", domain: .ui)
        setup()
        dispatch(ServerListViewAction(.set(true)))
        provider.scan(serverFound: { serverListItem in
            logDebug("Server found: \(serverListItem)", domain: .ui)
            self.dispatch(ServerListViewAction(.append(serverListItem)))
        }, scanFinished: {
            logDebug("Scan finished", domain: .ui)
            self.dispatch(ServerListViewAction(.set(false)))
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
        dispatch(ServerListViewAction(.set(false)))
        provider.cancel()
    }
}
