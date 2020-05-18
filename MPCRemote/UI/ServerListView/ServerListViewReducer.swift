//
//  ServerListViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerListViewReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: ServerListViewAction) {
        switch action {
        case let .serverList(serverListAction):
            composer.action(to: ServerListReducer(), with: serverListAction)
        case let .server(serverAction):
            composer.action(to: ServerReducer(), with: serverAction)
        case let .scanning(scanningAction):
            composer.action(to: ScanningReducer(), with: scanningAction)
        }
    }
}
