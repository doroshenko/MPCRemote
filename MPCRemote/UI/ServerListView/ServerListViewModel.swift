//
//  ServerListModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class ServerListViewModel: ObservableObject {

    @Published private(set) var serverList: [ServerListItem]
    @Published private(set) var server: Server?
    @Published private(set) var serverListState: ServerListState

    private var cancellableServerList = Set<AnyCancellable>()
    private var cancellableServer = Set<AnyCancellable>()
    private var cancellableServerListState = Set<AnyCancellable>()

    init(data: DataStore) {
        self.serverList = data.serverList
        self.server = data.server
        self.serverListState = data.serverListState

        data.$serverList
            .removeDuplicates()
            .assign(to: \Self.serverList, on: self)
            .store(in: &cancellableServerList)

        data.$server
            .removeDuplicates()
            .assign(to: \Self.server, on: self)
            .store(in: &cancellableServer)

        data.$serverListState
            .assign(to: \Self.serverListState, on: self)
            .store(in: &cancellableServerListState)
    }
}
