//
//  PingError.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum PingError: Error {
    case startupFailure(Error)
    case sendingFailure(Error)
    case timeout

    var localizedDescription: String {
        switch self {
        case .startupFailure(let error), .sendingFailure(let error):
            return error.localizedDescription
        case .timeout:
            return "Timeout"
        }
    }
}
