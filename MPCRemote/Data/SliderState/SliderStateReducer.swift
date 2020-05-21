//
//  SliderStateReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 19.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct SliderStateReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: SliderStateAction) {
        switch action {
        case let .setSeekUpdating(isSeekUpdating):
            data.sliderState.isSeekUpdating = isSeekUpdating
        case let .setVolumeUpdating(isVolumeUpdating):
            data.sliderState.isVolumeUpdating = isVolumeUpdating
        }
    }
}
