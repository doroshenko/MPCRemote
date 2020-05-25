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
    private(set) var nameModel: TextLabelNameViewModel
    private(set) var addressModel: TextLabelAddressViewModel
    private(set) var portModel: TextLabelPortViewModel

    var isNewServer: Bool {
        server == nil
    }

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore) {
        self.server = data.serverListState.editingServer

        nameModel = TextLabelNameViewModel(server)
        addressModel = TextLabelAddressViewModel(server)
        portModel = TextLabelPortViewModel(server)

        data.$serverListState
            .map { $0.editingServer }
            .assign(to: \Self.server, on: self)
            .store(in: &cancellable)
    }
}
