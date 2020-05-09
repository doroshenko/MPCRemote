//
//  ServerListModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class ServerListViewModel: ObservableObject {

    @Published private(set) var serverList: [Server]

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore) {
        self.serverList = data.serverList

        // One-way binding to the value in DataStore
        data.$serverList
            .removeDuplicates()
            .assign(to: \Self.serverList, on: self)
            .store(in: &cancellable)
    }
}