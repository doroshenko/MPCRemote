//
//  ServerEditViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerEditViewAction: ActionType {
    indirect case server(ServerAction)
    indirect case serverList(ServerListAction)
    indirect case serverListState(ServerListStateAction)

    init(_ serverAction: ServerAction) {
        self = .server(serverAction)
    }

    init(_ serverListAction: ServerListAction) {
        self = .serverList(serverListAction)
    }

    init(_ serverListStateAction: ServerListStateAction) {
        self = .serverListState(serverListStateAction)
    }
}

struct ServerEditViewActionCreator: ActionCreatorType {

    private let provider: ServerListProviderType
    private let dispatch: (ServerEditViewAction) -> Void

    init(provider: ServerListProviderType, dispatch: @escaping (ServerEditViewAction) -> Void) {
        self.provider = provider
        self.dispatch = dispatch
    }
}

extension ServerEditViewActionCreator {

    func verify(address: String, port: String, name: String, completion: @escaping ServerVerifyHandler) {
        logDebug("Verifying server address: \(address), port: \(port), name: \(name)", domain: .ui)
        provider.verify(address: address, port: port, name: name, completion: completion)
    }

    func save(_ server: Server, editingServer: ServerListItem?, isActive: Bool) {
        delete(editingServer)

        logDebug("Saving new or updated server: \(server)", domain: .ui)
        let serverListItem = ServerListItem(server: server, isFavorite: true, isOnline: false)
        provider.add(server: server)
        if isActive {
            dispatch(ServerEditViewAction(.set(server)))
        }
        dispatch(ServerEditViewAction(.append(serverListItem)))
        dismiss()
    }

    func delete(_ serverListItem: ServerListItem?) {
        guard let serverListItem = serverListItem else { return }

        logDebug("Deleting old server from the list: \(String(describing: serverListItem.server))", domain: .ui)
        provider.remove(server: serverListItem.server)
        dispatch(ServerEditViewAction(.delete(serverListItem)))
    }
}

extension ServerEditViewActionCreator {

    func dismiss() {
        logDebug("View dismissed", domain: .ui)
        dispatch(ServerEditViewAction(.setEditing(false, nil)))
    }
}
