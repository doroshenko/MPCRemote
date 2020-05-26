//
//  ServerEditViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class ServerEditViewModel: ObservableObject {

    private(set) var server: Server?
    private(set) var editingServer: ServerListItem?
    private(set) var nameModel: TextLabelNameViewModel
    private(set) var addressModel: TextLabelAddressViewModel
    private(set) var portModel: TextLabelPortViewModel

    var isNewServer: Bool {
        editingServer == nil
    }

    var isActiveServer: Bool {
        editingServer != nil && server == editingServer?.server
    }

    private var cancellableServer = Set<AnyCancellable>()
    private var cancellableEditingServer = Set<AnyCancellable>()

    init(data: DataStore) {
        self.server = data.server
        self.editingServer = data.serverListState.editingServer

        nameModel = TextLabelNameViewModel(editingServer)
        addressModel = TextLabelAddressViewModel(editingServer)
        portModel = TextLabelPortViewModel(editingServer)

        data.$server
            .assign(to: \Self.server, on: self)
            .store(in: &cancellableServer)

        data.$serverListState
            .map { $0.editingServer }
            .assign(to: \Self.editingServer, on: self)
            .store(in: &cancellableEditingServer)
    }
}
