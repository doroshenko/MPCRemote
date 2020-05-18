//
//  PlayerViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum PlayerViewAction: ActionType {
    indirect case playerState(PlayerStateAction)

    init(_ playerStateAction: PlayerStateAction) {
        self = .playerState(playerStateAction)
    }
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
        logDebug("Player view setup", domain: .ui)
        if provider.hasServer {
            getState()
        } else {
            provider.findServer { state in
                self.dispatch(PlayerViewAction(.set(state)))
            }
        }
    }
}

extension PlayerViewActionCreator {

    func getState() {
        //logDebug("New player state requested", domain: .ui)
        provider.getState { state in
            self.dispatch(PlayerViewAction(.set(state)))
        }
    }

    func post(command: Command) {
        logDebug("Player command posted \(command)", domain: .ui)
        provider.post(command: command) { state in
            self.dispatch(PlayerViewAction(.set(state)))
        }
    }
}
