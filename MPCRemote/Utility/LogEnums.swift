//
//  LogEnums.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum LogDomain {
    case `default`
    case networking
    case api
    case ui
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
        case .ui:
            return "[UI]"
        }
    }
}

enum LogLevel {
    case debug
    case info
    case warning
    case error
    case critical
}

extension LogLevel: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .debug:
            return "[DEBUG]"
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
