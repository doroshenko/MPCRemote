//
//  ServerListViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerListViewReducer: ReducerType {

    func reduce(_ data: DataStore, _ action: ServerListViewAction) {
        var serverList: [Server]
        switch action {
        case .clear:
            serverList = []
        case let .set(servers):
            serverList = servers
        case let .append(server):
            serverList = data.serverList
            serverList.appendUnique(server)
        }

        data.serverList = serverList
    }
}
