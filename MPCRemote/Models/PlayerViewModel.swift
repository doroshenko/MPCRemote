//
//  PlayerViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 27.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

final class PlayerViewModel: ObservableObject {
    @Published var playerState: PlayerState = .default
    @Published var seek: Int = 0
    @Published var volume: Int = 0

    lazy var postCompletion: PostResult = { [weak self] result in
        guard case .success() = result else { return }

        self?.refreshPlayerState()
    }

    init() {
        refreshPlayerState()

        Timer.scheduledTimer(withTimeInterval: Timeout.refresh,
                             repeats: true,
                             block: { [weak self] _ in
                                self?.refreshPlayerState()
        })
    }

    func refreshPlayerState() {
        APIService.getState { result in
            switch result {
            case let .success(state):
                self.playerState = state
                self.seek = state.seek
                self.volume = state.volume
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }

    func post(command: Command) {
        APIService.post(command: command, completion: postCompletion)
    }

    func postSeek() {
        APIService.post(seek: seek, completion: postCompletion)
    }

    func postVolume() {
        APIService.post(volume: volume, completion: postCompletion)
    }
}
