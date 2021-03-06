//
//  ServerListState.swift
//  MPCRemote
//
//  Created by doroshenko on 23.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerListStateReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: ServerListStateAction) {
        switch action {
        case let .setEditing(isEditing, editingServer):
            data.serverListState.isEditing = isEditing
            data.serverListState.editingServer = editingServer
        case let .setScanning(isScanning):
            data.serverListState.isScanning = isScanning
        }
    }
}
