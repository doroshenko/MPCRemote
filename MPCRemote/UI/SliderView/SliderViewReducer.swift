//
//  SliderViewReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct SliderViewReducer: ReducerType {

    func reduce(_ data: DataStore, _ action: SliderViewAction) {
        switch action {
        case let .setSeekUpdating(isSeekUpdating):
            data.sliderState.isSeekUpdating = isSeekUpdating
        case let .setVolumeUpdating(isVolumeUpdating):
            data.sliderState.isVolumeUpdating = isVolumeUpdating
        case let .set(playerState):
            data.playerState = playerState
        }
    }
}
