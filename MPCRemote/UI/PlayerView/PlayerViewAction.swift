//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum PlayerViewAction: ActionType {
    case set(PlayerState)
}

struct PlayerViewActionCreator: ActionCreatorType {

    private let provider: PlayerStateProviderType
    private let dispatch: (PlayerViewAction) -> Void

    init(provider: PlayerStateProviderType, dispatch: @escaping (PlayerViewAction) -> Void) {
        self.provider = provider
        self.dispatch = dispatch
    }
}

extension PlayerViewActionCreator {

    func setup() {
        if provider.hasServer {
            getState()
        } else {
            provider.findServer { state in
                self.dispatch(.set(state))
            }
        }
    }
}

extension PlayerViewActionCreator {

    func getState() {
        provider.getState { state in
            self.dispatch(.set(state))
        }
    }

    func post(command: Command) {
        provider.post(command: command) { state in
            self.dispatch(.set(state))
        }
    }
}
