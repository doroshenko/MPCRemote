//
//  APIError.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidEndpoint
    case requestFailed(AFError)
    case emptyResponse
    case conversionFailed
}

extension APIError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint URL"
        case .requestFailed(let error):
            return "Request failed with error: \(error.localizedDescription) "
        case .emptyResponse:
            return "Empty response data"
        case .conversionFailed:
            return "Response data conversion failed"
        }
    }
}

typealias PostResult = (Result<Void, APIError>) -> Void
typealias GetResult = (Result<Data, APIError>) -> Void
typealias StateResult = (Result<State, APIError>) -> Void
typealias SnapshotResult = (Result<UIImage, APIError>) -> Void
