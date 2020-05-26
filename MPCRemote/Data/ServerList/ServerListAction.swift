//
//  ServerListAction.swift
//  MPCRemote
//
//  Created by doroshenko on 19.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerListAction: ActionType {
    case append(ServerListItem)
    case update(ServerListItem)
    case delete(ServerListItem)
    case set([ServerListItem])
}
