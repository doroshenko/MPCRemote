//
//  PlaybackState.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

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
