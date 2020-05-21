//
//  PlayerViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct PlayerViewReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: PlayerViewAction) {
        switch action {
        case let .playerState(playerStateAction):
            dispatcher.dispatch(action: playerStateAction, to: PlayerStateReducer())
        }
    }
}
