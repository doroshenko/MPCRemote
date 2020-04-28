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

    @Published var file: String
    @Published var state: PlaybackState
    @Published var position: Double
    @Published var duration: Double
    @Published var isMuted: Bool
    @Published var volume: Double {
        willSet {
            if isVolumeSliding {
                post(volume: newValue)
            }
            didChange.send(self)
        }
    }

    private var seek: Double {
        guard duration != 0 else { return 0 }

        return Parameter.Seek.range.upperBound * position / duration
    }

    var isSeekSliding: Bool = false {
        didSet {
            if !isSeekSliding {
                post(seek: seek)
            }
        }
    }

    var isVolumeSliding: Bool = false {
        didSet {
            if !isVolumeSliding {
                post(volume: volume)
            }
        }
    }

    init(playerState: PlayerState = .placeholder) {
        file = playerState.file
        state = playerState.state
        position = playerState.position
        duration = playerState.duration
        isMuted = playerState.isMuted
        volume = playerState.volume

        playerStateRefresh()

        Timer.scheduledTimer(withTimeInterval: Interval.refresh,
                             repeats: true,
                             block: { [weak self] _ in
                                self?.playerStateRefresh()
        })
    }

    private func playerStateRefresh() {
        APIService.getState { result in
            switch result {
            case let .success(state):
                self.updateProperties(with: state)
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }

    private func updateProperties(with playerState: PlayerState) {
        file = playerState.file
        state = playerState.state
        duration = playerState.duration
        isMuted = playerState.isMuted

        if !isSeekSliding {
            position = playerState.position
        }

        if !isVolumeSliding {
            volume = playerState.volume
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
