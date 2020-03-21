//
//  State.swift
//  MPCRemote
//
//  Created by doroshenko on 05.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct State {
    enum PlaybackState: String {
        case stopped
        case playing
        case paused
    }

    let fileName: String
    let filePath: String
    let filePathArg: String
    let fileDir: String
    let fileDirArg: String
    let playbackState: PlaybackState
    let playbackStateString: String
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

    static var `default`: State {
        State()
    }

    init() {
        fileName = String()
        filePath = String()
        filePathArg = String()
        fileDir = String()
        fileDirArg = String()
        playbackState = .stopped
        playbackStateString = String(describing: PlaybackState.stopped)
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

    init?(data: Data) {
        // TODO
        self = State.default
    }
}
