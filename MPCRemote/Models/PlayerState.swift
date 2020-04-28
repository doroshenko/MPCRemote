//
//  PlaybackState.swift
//  MPCRemote
//
//  Created by doroshenko on 05.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

enum PlaybackState: Int, Codable {
    case stopped
    case paused
    case playing

    init?(_ string: String) {
        if let intValue = Int(string) {
            self.init(rawValue: intValue)
        } else {
            return nil
        }
    }
}

extension PlaybackState: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .stopped:
            return "Stopped"
        case .paused:
            return "Paused"
        case .playing:
            return "Playing"
        }
    }
}

struct PlayerState: Codable {
    let file: String
    let state: PlaybackState
    let position: Double
    let duration: Double
    let volume: Double
    let isMuted: Bool
}

extension PlayerState {
    static var `default`: PlayerState {
        PlayerState(file: String(),
                    state: .stopped,
                    position: 0,
                    duration: 1,
                    volume: 0,
                    isMuted: false)
    }
}
