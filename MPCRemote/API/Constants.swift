//
//  Constants.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum Scheme: String {
    case http
    case https
}

enum Endpoint: String {
    case command = "/command.html"
    case state = "/variables.html"
    case snapshot = "/snapshot.jpg"
}

enum Parameter {
    enum Command {
        static let name = "wm_command"
    }

    enum Seek {
        static let name = "percent"
        static let range: ClosedRange<Double> = 0...100
    }

    enum Volume {
        static let name = "volume"
        static let range: ClosedRange<Double> = 0...100
    }
}

enum Name {
    static let maxLength = 254
}

enum Port {
    static let `default`: UInt16 = 13579
}

extension TimeInterval {
    static let ping: TimeInterval = 1.0
    static let timeout: TimeInterval = 2.0
    static let fetch: TimeInterval = 1.0
}

enum Command: Int {
    case seek = -1
    case volume = -2

    case play = 887
    case pause = 888
    case playPause = 889

    case seekBackwardKey = 897
    case seekForwardKey = 898
    case seekBackwardSmall = 899
    case seekForwardSmall = 900
    case seekBackwardMedium = 901
    case seekForwardMedium = 902
    case seekBackwardLarge = 903
    case seekForwardLarge = 904

    case skipBackwardFile = 919
    case skipForwardFile = 920
    case skipBackward = 921
    case skipForward = 922

    case mute = 909
    case audioNext = 952
    case subtitleNext = 954
    case fullscreen = 830
}
