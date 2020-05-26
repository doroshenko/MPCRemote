//
//  ServerEditViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class ServerEditViewModel: ObservableObject {

    private(set) var editingServer: ServerListItem?
    private(set) var nameModel: TextLabelNameViewModel
    private(set) var addressModel: TextLabelAddressViewModel
    private(set) var portModel: TextLabelPortViewModel

    var isNewServer: Bool {
        editingServer == nil
    }

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore) {
        self.editingServer = data.serverListState.editingServer

        nameModel = TextLabelNameViewModel(editingServer)
        addressModel = TextLabelAddressViewModel(editingServer)
        portModel = TextLabelPortViewModel(editingServer)

        data.$serverListState
            .map { $0.editingServer }
            .assign(to: \Self.editingServer, on: self)
            .store(in: &cancellable)
    }
}
