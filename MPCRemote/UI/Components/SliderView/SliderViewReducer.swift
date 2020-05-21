//
//  SliderViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct SliderViewReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: SliderViewAction) {
        switch action {
        case let .playerState(playerStateAction):
            dispatcher.dispatch(action: playerStateAction, to: PlayerStateReducer())
        case let .sliderState(sliderStateAction):
            dispatcher.dispatch(action: sliderStateAction, to: SliderStateReducer())
        }
    }
}
