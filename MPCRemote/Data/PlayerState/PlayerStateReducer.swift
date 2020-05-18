//
//  PlayerStateReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 19.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct PlayerStateReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: PlayerStateAction) {
        switch action {
        case let .set(playerState):
            data.playerState = playerState
        }
    }
}
