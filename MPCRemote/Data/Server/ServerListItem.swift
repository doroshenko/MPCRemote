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

extension ServerListItem: Comparable {
    static func < (lhs: ServerListItem, rhs: ServerListItem) -> Bool {
        guard lhs.isFavorite == rhs.isFavorite else {
            return lhs.isFavorite && !rhs.isFavorite
        }

        guard lhs.isOnline == rhs.isOnline else {
            return lhs.isOnline && !rhs.isOnline
        }

        return lhs.server < rhs.server
    }
}
