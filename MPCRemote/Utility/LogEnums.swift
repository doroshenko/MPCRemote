//
//  LogEnums.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

enum LogDomain {
    case `default`
    case networking
    case api
}

extension LogDomain: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .default:
            return "[DEFAULT]"
        case .networking:
            return "[NETWORKING]"
        case .api:
            return "[API]"
        }
    }
}

enum LogLevel {
    case trace
    case info
    case warning
    case error
    case critical
}

extension LogLevel: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .trace:
            return "[TRACE]"
        case .info:
            return "[INFO]"
        case .warning:
            return "[WARNING]"
        case .error:
            return "[ERROR]"
        case .critical:
            return "[CRITICAL]"
        }
    }
}
