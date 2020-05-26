//
//  ServerListItem+Server.swift
//  MPCRemote
//
//  Created by doroshenko on 12.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

extension Collection where Element == Server {

    func serverList(_ isFavorite: Bool = true) -> [ServerListItem] {
        compactMap { ServerListItem(server: $0, isFavorite: isFavorite, isOnline: false) }
    }
}
