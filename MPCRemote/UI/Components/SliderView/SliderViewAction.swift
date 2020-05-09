//
//  SliderViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum SliderViewAction: ActionType {
    case set(PlayerState)
    case setSeekUpdating(Bool)
    case setVolumeUpdating(Bool)
}

protocol SliderViewActionCreatorType: ActionCreatorType {
    func post(_ value: Double)
    func set(_ isUpdating: Bool)
}
