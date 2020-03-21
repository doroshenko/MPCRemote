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

    var localizedDescription: String {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint URL"
        case .requestFailed(let error):
            return error.localizedDescription
        case .emptyResponse:
            return "Empty response data"
        case .conversionFailed:
            return "Response data conversion failed"
        }
    }
}

typealias APIResult<Value> = (Result<Value, APIError>) -> Void
typealias PostResult = APIResult<Void>
typealias StateResult = APIResult<State>
typealias SnapshotResult = APIResult<UIImage>
