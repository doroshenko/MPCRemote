//
//  ServerListStateAction.swift
//  MPCRemote
//
//  Created by doroshenko on 23.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerListStateAction: ActionType {
    case setEditing(Bool, Server?)
    case setScanning(Bool)
}
