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

    @Published var file = String()
    @Published var state = PlaybackState.stopped
    @Published var position = PlayerState.default.position
    @Published var duration = PlayerState.default.duration
    @Published var isMuted = PlayerState.default.isMuted

    @Published var volume: Double = 0 {
        willSet {
            if isVolumeSliding {
                post(volume: newValue)
            }
            didChange.send(self)
        }
    }

    private var seek: Double {
        Parameter.Seek.range.doubleRange.upperBound * position/duration
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

    var durationRange: ClosedRange<Double> {
        0...duration
    }

    init() {
        updateProperties()
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

    private func updateProperties(with playerState: PlayerState = .default) {
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
