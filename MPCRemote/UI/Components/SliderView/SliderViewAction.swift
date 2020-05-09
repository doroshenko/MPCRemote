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
        provider.post(seek: value) { result in
            self.handlePostResult(result)
        }
    }

    func set(_ isUpdating: Bool) {
        dispatch(.setSeekUpdating(isUpdating))
    }
}

private extension SeekSliderViewActionCreator {

    func performGetState() {
        provider.getState { result in
            self.handleStateResult(result)
        }
    }
}

private extension SeekSliderViewActionCreator {

    func handleStateResult(_ result: StateResult) {
        switch result {
        case let .success(state):
            self.dispatch(.set(state))
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }

    func handlePostResult(_ result: PostResult) {
        switch result {
        case .success:
            performGetState()
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }
}

struct VolumeSliderViewActionCreator: SliderViewActionCreatorType {

    private let provider: PlayerStateProviderType
    private let dispatch: (SliderViewAction) -> Void

    init(provider: PlayerStateProviderType, dispatch: @escaping (SliderViewAction) -> Void) {
        self.provider = provider
        self.dispatch = dispatch
    }
}

extension VolumeSliderViewActionCreator {

    func post(_ value: Double) {
        provider.post(volume: value) { result in
            self.handlePostResult(result)
        }
    }

    func set(_ isUpdating: Bool) {
        dispatch(.setVolumeUpdating(isUpdating))
    }
}

private extension VolumeSliderViewActionCreator {

    func performGetState() {
        provider.getState { result in
            self.handleStateResult(result)
        }
    }
}

private extension VolumeSliderViewActionCreator {

    func handleStateResult(_ result: StateResult) {
        switch result {
        case let .success(state):
            self.dispatch(.set(state))
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }

    func handlePostResult(_ result: PostResult) {
        switch result {
        case .success:
            performGetState()
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }
}
