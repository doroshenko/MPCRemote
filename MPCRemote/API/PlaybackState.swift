//
//  PlaybackState.swift
//  MPCRemote
//
//  Created by doroshenko on 05.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct PlaybackState {
    enum Playback: String {
        case stopped
        case playing
        case paused
    }

    let fileName: String
    let filePath: String
    let filePathArg: String
    let fileDir: String
    let fileDirArg: String
    let playback: Playback
    let playbackString: String
    let position: UInt64
    let positionString: String
    let duration: UInt64
    let durationString: String
    let volume: UInt
    let muted: Bool
    let playbackRate: Float
    let size: String
    let reloadTime: String // TODO: verify this
    let version: String

    static var `default`: PlaybackState {
        PlaybackState()
    }

    init() {
        fileName = String()
        filePath = String()
        filePathArg = String()
        fileDir = String()
        fileDirArg = String()
        playback = .stopped
        playbackString = String(describing: Playback.stopped)
        position = 0
        positionString = "00:00:00"
        duration = 0
        durationString = "00:00:00"
        volume = 0
        muted = false
        playbackRate = 1.0
        size = "0"
        reloadTime = String()
        version = "1.0.0.0"
    }

    init?(string: String) {
        // TODO
        self = PlaybackState.default
    }
}
