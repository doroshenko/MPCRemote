//
//  HTTPParametersFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class HTTPParametersFactory {

    static func make(command: Command) -> HTTPParameters {
        [Parameter.Command.name: "\(command.rawValue)"]
    }

    static func make(volume: Int) -> HTTPParameters {
        [Parameter.Command.name: "\(Command.volume.rawValue)",
         Parameter.Volume.name: "\(volume.clamped(to: Parameter.Volume.range))"]
    }

    static func make(seek: Int) -> HTTPParameters {
        [Parameter.Command.name: "\(Command.seek.rawValue)",
         Parameter.Seek.name: "\(seek.clamped(to: Parameter.Seek.range))"]
    }
}