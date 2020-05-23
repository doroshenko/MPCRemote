//
//  ServerEditViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

// TODO: move elsewhere
enum VerifyError: Error {
    case invalidName
    case invalidAddress
    case invalidPort

    var localizedDescription: String {
        switch self {
        case .invalidName:
            return "Invalid server name"
        case .invalidAddress:
            return "Invalid server address"
        case .invalidPort:
            return "Invalid server port"
        }
    }
}

// TODO: move elsewhere
typealias VerifyResult = Result<Server, VerifyError>
typealias VerifyHandler = (VerifyResult) -> Void

enum ServerEditViewAction: ActionType {
    indirect case server(ServerAction)
    indirect case serverListState(ServerListStateAction)

    init(_ serverAction: ServerAction) {
        self = .server(serverAction)
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

    func verify(_ server: Server, completion: @escaping VerifyHandler) {
        logDebug("Server verification \(server)", domain: .ui)
        provider.verify(server: server, completion: completion)
    }

    func save(_ server: Server) {
        logDebug("Server changes saved \(server)", domain: .ui)
        dispatch(ServerEditViewAction(.set(server)))
        dismiss()
    }
}

extension ServerEditViewActionCreator {

    func dismiss() {
        logDebug("View dismissed", domain: .ui)
        dispatch(ServerEditViewAction(.setEditing(false)))
    }
}
