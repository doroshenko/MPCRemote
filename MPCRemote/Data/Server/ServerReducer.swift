//
//  ServerReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 26.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: ServerAction) {
        switch action {
        case let .set(server):
            data.server = server
        }
    }
}
