//
//  ServerListReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 19.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: ServerAction) {
        switch action {
        case let .set(server):
            data.server = server
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
