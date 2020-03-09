//
//  Constants.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

enum Scheme: String {
    case http
    case https
}

enum Endpoint: String {
    case command = "/command.html"
    case state = "/variables.html"
    case snapshot = "/snapshot.jpg"
}

struct Parameter {
    struct Command {
        static let name = "wm_command"
    }

    struct Percent {
        static let name = "percent"
        static let min = 0
        static let max = 100
    }
}

enum Command: Int {
    case seek = -1
    case volume = -2

    case play = 887
    case pause = 888
    case playPause = 889
}

extension Command: CustomStringConvertible {
    var description: String {
        switch self {
        case .seek:
            return "Seek"
        case .volume:
            return "Volume"
        case .play:
            return "Play"
        case .pause:
            return "Pause"
        case .playPause:
            return "Play/Pause"
        }
    }
}
