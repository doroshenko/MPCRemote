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
    var file: String = "..."
    var state: PlaybackState = .stopped
    var position: Double = 0
    var duration: Double = 0
    var volume: Double = 0
    var isMuted: Bool = false
}
