//
//  SliderViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum SliderViewAction: ActionType {
    indirect case playerState(PlayerStateAction)
    indirect case sliderState(SliderStateAction)

    init(_ playerStateAction: PlayerStateAction) {
        self = .playerState(playerStateAction)
    }

    init(_ sliderStateAction: SliderStateAction) {
        self = .sliderState(sliderStateAction)
    }
}

protocol SliderViewActionCreatorType: ActionCreatorType {
    func post(_ value: Double)
    func set(_ isUpdating: Bool)
}
