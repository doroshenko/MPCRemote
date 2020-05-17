//
//  ServerListViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerListViewReducer: ReducerType {

    func reduce(_ data: DataStore, _ action: ServerListViewAction) {
        switch action {
        case let .setServerList(servers):
            data.serverList = servers
        case let .appendServerList(server):
            data.serverList.updateOrAppend(server)
        case let .deleteServerList(server):
            data.serverList.removeAll { $0 == server }
        case let .setServer(server):
            data.server = server
        case let .setScanning(isScanning):
            data.isScanning = isScanning
        }

        data.serverList.sort()
    }
}
