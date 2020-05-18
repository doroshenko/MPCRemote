//
//  SliderViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct SliderViewReducer: ReducerType {

    func reduce(_ composer: Composer, _ data: DataStore, _ action: SliderViewAction) {
        switch action {
        case let .playerState(playerStateAction):
            composer.action(to: PlayerStateReducer(), with: playerStateAction)
        case let .sliderState(sliderStateAction):
            composer.action(to: SliderStateReducer(), with: sliderStateAction)
        }
    }
}
