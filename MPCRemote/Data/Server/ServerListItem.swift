//
//  ServerListItem.swift
//  MPCRemote
//
//  Created by doroshenko on 11.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ServerListItem {
    let server: Server
    let isFavorite: Bool
    let isOnline: Bool
}

extension ServerListItem: Equatable { }

extension ServerListItem: Identifiable {
    var id: String {
        server.id
    }
}
