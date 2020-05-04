//
//  StorageService.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class StorageService: Service, ObservableObject {

    let objectWillChange = PassthroughSubject<Void, Never>()

    private enum Key: String, UserDefaultKey {
        case server
        case state
        case servers
    }

    @UserDefault(StorageService.Key.server, defaultValue: nil)
    var server: Server? {
        willSet {
            objectWillChange.send()
        }
    }

    @UserDefault(StorageService.Key.state, defaultValue: PlayerState())
    var state: PlayerState {
        willSet {
            objectWillChange.send()
        }
    }

    @UserDefault(StorageService.Key.servers, defaultValue: [])
    var servers: [Server] {
        willSet {
            objectWillChange.send()
        }
    }
}
