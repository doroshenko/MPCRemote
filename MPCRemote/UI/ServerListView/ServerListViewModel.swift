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
    @Published private(set) var isScanning: Bool

    private var cancellableServerList = Set<AnyCancellable>()
    private var cancellableScanning = Set<AnyCancellable>()

    init(data: DataStore) {
        self.serverList = data.serverList
        self.isScanning = data.isScanning

        data.$serverList
            .removeDuplicates()
            .assign(to: \Self.serverList, on: self)
            .store(in: &cancellableServerList)

        data.$isScanning
            .removeDuplicates()
            .assign(to: \Self.isScanning, on: self)
            .store(in: &cancellableScanning)
    }
}
