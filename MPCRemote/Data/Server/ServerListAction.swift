//
//  ServerListAction.swift
//  MPCRemote
//
//  Created by doroshenko on 19.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerAction: ActionType {
    case set(Server?)
}

enum ServerListAction: ActionType {
    case append(ServerListItem)
    case delete(ServerListItem)
    case set([ServerListItem])
}
