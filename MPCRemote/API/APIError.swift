//
//  APIError.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Alamofire

enum APIError: Error {
    case invalidEndpoint
    case requestFailed(AFError)
    case conversionFailed

    var localizedDescription: String {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint URL"
        case .requestFailed(let error):
            return error.localizedDescription
        case .conversionFailed:
            return "Response data conversion failed"
        }
    }
}
