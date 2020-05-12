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
        logDebug("New seek value \(value)", domain: .ui)
        provider.post(seek: value) { state in
            self.dispatch(.set(state))
        }
    }

    func set(_ isUpdating: Bool) {
        logDebug("Seek slider updating \(isUpdating)", domain: .ui)
        dispatch(.setSeekUpdating(isUpdating))
    }
}
