//
//  PlayerViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 27.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI
import Combine

final class PlayerViewModel: ObservableObject {

    let didChange = PassthroughSubject<PlayerViewModel, Never>()

    @Published var playerState: PlayerState = .default
    @Published var seek: Double = 0
    @Published var volume: Double = 0 {
        willSet {
            if isVolumeSliding {
                post(volume: newValue)
            }
            didChange.send(self)
        }
    }

    private var isSeekSliding: Bool = false
    private var isVolumeSliding: Bool = false

    lazy var onSeekChanged: (Bool) -> Void = { [weak self] isSliding in
        guard let strongSelf = self else { return }

        strongSelf.isSeekSliding = isSliding

        if !isSliding {
            strongSelf.post(seek: strongSelf.seek)
        }
    }

    lazy var onVolumeChanged: (Bool) -> Void = { [weak self] isSliding in
        guard let strongSelf = self else { return }

        strongSelf.isVolumeSliding = isSliding

        if !isSliding {
            strongSelf.post(volume: strongSelf.volume)
        }
    }

    init() {
        playerStateRefresh()

        Timer.scheduledTimer(withTimeInterval: Interval.refresh,
                             repeats: true,
                             block: { [weak self] _ in
                                self?.playerStateRefresh()
        })
    }

    func playerStateRefresh() {
        APIService.getState { result in
            switch result {
            case let .success(state):
                self.playerState = state
                if !self.isSeekSliding {
                    self.seek = Double(state.seek)
                }
                if !self.isVolumeSliding {
                    self.volume = Double(state.volume)
                }
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }
}

extension PlayerViewModel {

    func post(command: Command) {
        APIService.post(command: command) { _ in
            self.playerStateRefresh()
        }
    }

    func post(seek: Double) {
        APIService.post(seek: seek) { _ in
            self.playerStateRefresh()
        }
    }

    func post(volume: Double) {
        APIService.post(volume: volume) { _ in
            self.playerStateRefresh()
        }
    }
}
