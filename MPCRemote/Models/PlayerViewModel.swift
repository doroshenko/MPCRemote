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

    var position: String {
        let timeInterval: Double
        if isSeekSliding {
            timeInterval = (seek * Double(playerState.duration)) / (Double(Parameter.Seek.range.upperBound) * 1000)
        } else {
            timeInterval = Double(playerState.position) / 1000
        }
        return TextFormatter.formatedTime(from: timeInterval)
    }

    var duration: String {
        let timeInterval = Double(playerState.duration) / 1000
        return TextFormatter.formatedTime(from: timeInterval)
    }

    var currentVolume: String {
        TextFormatter.formattedVolume(from: volume)
    }

    init() {
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
