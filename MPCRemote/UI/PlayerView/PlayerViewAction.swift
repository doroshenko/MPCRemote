//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum PlayerViewAction: ActionType {
    case clear
    case set(PlayerState)
}

struct PlayerViewActionCreator: ActionCreatorType {

    private let provider: PlayerStateProviderType
    private let timerHolder: TimerHolderType
    private let dispatch: (PlayerViewAction) -> Void

    init(provider: PlayerStateProviderType, timerHolder: TimerHolderType, dispatch: @escaping (PlayerViewAction) -> Void) {
        self.provider = provider
        self.timerHolder = timerHolder
        self.dispatch = dispatch
    }
}

extension PlayerViewActionCreator {

    func setup() {
        if provider.hasServer {
            self.startFetch()
        } else {
            provider.findServer {
                self.startFetch()
            }
        }
    }
}

extension PlayerViewActionCreator {

    func startFetch() {
        performGetState()

        timerHolder.schedule {
            self.startFetch()
        }
    }

    func stopFetch() {
        timerHolder.cancel()
    }
}

extension PlayerViewActionCreator {

    func getState() {
        performGetState()
    }

    func post(command: Command) {
        provider.post(command: command) { result in
            self.handlePostResult(result)
        }
    }

    func post(seek: Double) {
        provider.post(seek: seek) { result in
            self.handlePostResult(result)
        }
    }

    func post(volume: Double) {
        provider.post(volume: volume) { result in
            self.handlePostResult(result)
        }
    }
}

private extension PlayerViewActionCreator {

    func performGetState() {
        provider.getState { result in
            self.handleStateResult(result)
        }
    }
}

private extension PlayerViewActionCreator {

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
            startFetch()
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }
}
