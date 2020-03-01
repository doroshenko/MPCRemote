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
}

extension LogDomain: CustomStringConvertible {
    var description: String {
        switch self {
        case .default:
            return "[DEFAULT]"
        case .networking:
            return "[NETWORKING]"
        }
    }
}

enum LogLevel {
    case info
    case warning
    case error
    case critical
}

extension LogLevel: CustomStringConvertible {
    var description: String {
        switch self {
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
