//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerListViewAction: ActionType {
    case clear
    case append(Server)
    case set([Server])
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

    func add(server: Server) {
        let servers = provider.add(server: server)
        dispatch(.set(servers))
    }

    func scan() {
        provider.scan(complete: true) { server in
            self.dispatch(.append(server))
        }
    }

    func cancel() {
        provider.cancel()
    }
}
