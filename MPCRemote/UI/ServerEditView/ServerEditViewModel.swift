//
//  ServerEditViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class ServerEditViewModel: ObservableObject {

    private(set) var isNewServer: Bool
    private(set) var server: Server

    init(server: Server?) {
        self.isNewServer = server == nil
        self.server = server ?? Server(address: "")
    }
}
