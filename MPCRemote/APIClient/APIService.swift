//
//  APIService.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation
import UIKit

enum Endpoint: String {
    case command = "/command.html"
    case status = "/variables.html"
    case snapshot = "/snapshot.jpg"
}

struct APIService {

    static var server: String = String()

    static func sendCommand(_ command: Command) { }

    static func sendCommandVolume(_ volume: UInt) { }

    static func sendCommandSeek(_ seek: UInt) { }

    static func getState() -> State? {
        nil
    }

    static func getSnapshot() -> UIImage? {
        nil
    }
}
