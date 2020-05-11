//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerListViewAction: ActionType {
    case clear
    case append(ServerListItem)
    case set([ServerListItem])
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
        let servers = provider.fetch()
        dispatch(.set(servers))
    }

    func select(serverListItem: ServerListItem) {
        provider.select(server: serverListItem.server)
        // TODO: toggle Favorite status
        dispatch(.append(serverListItem))
    }

    func scan() {
        setup()
        dispatch(.setScanning(true))
        provider.scan(serverFound: { serverState in
            let serverListItem = ServerListItem(server: serverState.server, isFavorite: false, isOnline: true)
            self.dispatch(.append(serverListItem))
        }, scanFinished: {
            self.dispatch(.setScanning(false))
        })
    }

    func ping(server: Server, completion: @escaping (Bool) -> Void) {
        provider.ping(server: server) { result in
            if case .success = result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func cancel() {
        dispatch(.setScanning(false))
        provider.cancel()
    }
}
