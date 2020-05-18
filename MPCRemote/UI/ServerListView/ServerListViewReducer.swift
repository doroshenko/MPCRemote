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

struct ServerListReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: ServerListAction) {
        switch action {
        case let .set(servers):
            data.serverList = servers
        case let .append(server):
            data.serverList.updateOrAppend(server)
        case let .delete(server):
            data.serverList.removeAll { $0 == server }
        }
        data.serverList.sort()
    }
}

struct ServerReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: ServerAction) {
        switch action {
        case let .set(server):
            data.server = server
        }
    }
}

struct ScanningReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: ScanningAction) {
        switch action {
        case let .set(isScanning):
            data.isScanning = isScanning
        }
    }
}
