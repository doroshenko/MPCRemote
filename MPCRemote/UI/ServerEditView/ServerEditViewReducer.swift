//
//  ServerEditViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerEditViewReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: ServerEditViewAction) {
        switch action {
        case let .server(serverAction):
            dispatcher.dispatch(action: serverAction, to: ServerReducer())
        case let .serverListState(serverListStateAction):
            dispatcher.dispatch(action: serverListStateAction, to: ServerListStateReducer())
        }
    }
}
