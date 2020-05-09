//
//  SliderViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum SliderViewAction: ActionType {
    case set(PlayerState)
}

protocol SliderViewActionCreatorType: ActionCreatorType {
    associatedtype SliderValueType

    func post(_ value: SliderValueType)
}

struct PositionSliderViewActionCreator: SliderViewActionCreatorType {

    private let provider: PlayerStateProviderType
    private let dispatch: (SliderViewAction) -> Void

    init(provider: PlayerStateProviderType, dispatch: @escaping (SliderViewAction) -> Void) {
        self.provider = provider
        self.dispatch = dispatch
    }
}

extension PositionSliderViewActionCreator {

    func post(_ value: Double) {
        provider.post(seek: value) { result in
            self.handlePostResult(result)
        }
    }
}

private extension PositionSliderViewActionCreator {

    func performGetState() {
        provider.getState { result in
            self.handleStateResult(result)
        }
    }
}

private extension PositionSliderViewActionCreator {

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
