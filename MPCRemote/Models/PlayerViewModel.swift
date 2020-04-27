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
    @Published var seek: Float = 0
    @Published var volume: Float = 0

    private var seekInternal: Int {
        get {
            Int(seek.clamped(to: Parameter.Seek.floatRange))
        }
        set {
            seek = Float(newValue)
        }
    }

    private var volumeInternal: Int {
        get {
            Int(volume.clamped(to: Parameter.Volume.floatRange))
        }
        set {
            volume = Float(newValue)
        }
    }

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
                self.seekInternal = state.seek
                self.volumeInternal = state.volume
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }

    func post(command: Command) {
        APIService.post(command: command, completion: postCompletion)
    }

    func postSeek() {
        APIService.post(seek: seekInternal, completion: postCompletion)
    }

    func postVolume() {
        APIService.post(volume: volumeInternal, completion: postCompletion)
    }
}
