//
//  ServerState.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

typealias ServerStateResult = APIResult<ServerState>
typealias ServerStateHandler = APIHandler<ServerState>

struct ServerState {
    let server: Server
    let state: PlayerState
}
