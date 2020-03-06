//
//  State.swift
//  MPCRemote
//
//  Created by doroshenko on 05.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct State {
    enum PlaybackState {
        case stopped
        case playing
        case paused
    }

    var fileName: String
    var filePath: String
    var filePathArg: String
    var fileDir: String
    var fileDirArg: String
    var playbackState: PlaybackState
    var playbackStateString: String
    var position: UInt64
    var positionString: String
    var duration: UInt64
    var durationString: String
    var volume: UInt8
    var muted: Bool
    var playbackRate: Float
    var size: String
    var reloadTime: String // TODO: verify this
    var version: String
}
