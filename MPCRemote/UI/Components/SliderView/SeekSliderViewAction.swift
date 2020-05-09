//
//  SeekSliderViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct SeekSliderViewActionCreator: SliderViewActionCreatorType {

    private let provider: PlayerStateProviderType
    private let dispatch: (SliderViewAction) -> Void

    init(provider: PlayerStateProviderType, dispatch: @escaping (SliderViewAction) -> Void) {
        self.provider = provider
        self.dispatch = dispatch
    }
}

extension SeekSliderViewActionCreator {

    func post(_ value: Double) {
        provider.post(seek: value) { state in
            self.dispatch(.set(state))
        }
    }

    func set(_ isUpdating: Bool) {
        dispatch(.setSeekUpdating(isUpdating))
    }
}
