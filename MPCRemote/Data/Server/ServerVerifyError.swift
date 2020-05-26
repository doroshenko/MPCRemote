//
//  ServerVerifyError.swift
//  MPCRemote
//
//  Created by doroshenko on 26.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

enum ServerVerifyError: Error {
    case invalidName
    case invalidAddress
    case invalidPort

    var localizedDescription: String {
        switch self {
        case .invalidName:
            return "Invalid server name"
        case .invalidAddress:
            return "Invalid server address"
        case .invalidPort:
            return "Invalid server port"
        }
    }
}

typealias ServerVerifyResult = Result<Server, ServerVerifyError>
typealias ServerVerifyHandler = (ServerVerifyResult) -> Void
