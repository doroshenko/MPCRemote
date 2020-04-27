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
    let filePath: String
    let filePathArg: String
    let fileDir: String
    let fileDirArg: String
    let playbackState: PlaybackState
    let playbackString: String
    let position: UInt64
    let positionString: String
    let duration: UInt64
    let durationString: String
    let volume: Int
    let muted: Bool
    let playbackRate: Float
    let size: String
    let reloadTime: String
    let version: String

    var isPlaying: Bool {
        playbackState == .playing
    }

    var seek: Int {
        Int(UInt64(Parameter.Seek.range.upperBound) * position/duration)
    }
}

extension PlayerState {
    static var `default`: PlayerState {
        PlayerState(file: String(),
                    filePath: String(),
                    filePathArg: String(),
                    fileDir: String(),
                    fileDirArg: String(),
                    playbackState: .stopped,
                    playbackString: String(),
                    position: 0,
                    positionString: "00:00:00",
                    duration: 1,
                    durationString: "00:00:00",
                    volume: 0,
                    muted: false,
                    playbackRate: 1.0,
                    size: String(),
                    reloadTime: String(),
                    version: "1.0.0.0")
    }
}
