//
//  ServerListViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerListViewReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: ServerListViewAction) {
        switch action {
        case let .serverList(serverListAction):
            dispatcher.dispatch(action: serverListAction, to: ServerListReducer())
        case let .server(serverAction):
            dispatcher.dispatch(action: serverAction, to: ServerReducer())
        case let .scanning(scanningAction):
            dispatcher.dispatch(action: scanningAction, to: ScanningReducer())
        }
    }
}
