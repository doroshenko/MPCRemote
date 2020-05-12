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
        case .clear:
            data.serverList = []
        case let .set(servers):
            data.serverList = servers
        case let .append(server):
            data.serverList.updateOrAppend(server)
        case let .delete(server):
            data.serverList.removeAll { $0 == server }
        case let .setScanning(isScanning):
            data.isScanning = isScanning
        }

        data.serverList.sort()
    }
}
