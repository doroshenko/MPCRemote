//
//  PlayerViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct PlayerViewReducer: ReducerType {

    func reduce(_ data: DataStore, _ action: PlayerViewAction) {
        let playerState: PlayerState
        switch action {
        case .clear:
            playerState = PlayerState()
        case let .set(newValue):
            playerState = newValue
        }

        data.playerState = playerState
    }
}
