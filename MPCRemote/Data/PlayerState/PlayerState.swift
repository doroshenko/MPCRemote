//
//  PlayerState.swift
//  MPCRemote
//
//  Created by doroshenko on 05.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

final class PlayerState: ObservableObject {
    @Published var file: String
    @Published var state: PlaybackState
    @Published var position: Double
    @Published var duration: Double
    @Published var volume: Double
    @Published var isMuted: Bool

    init(file: String = "...", state: PlaybackState = .stopped, position: Double = 0, duration: Double = 0, volume: Double = 0, isMuted: Bool = false) {
        self.file = file
        self.state = state
        self.position = position
        self.duration = duration
        self.volume = volume
        self.isMuted = isMuted
    }
}
