//
//  APIFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation
import UIKit

final class APIFactory {

    static func URL(scheme: Scheme = .https, server: Server, endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = server.address
        components.path = endpoint.rawValue
        components.port = server.port

        return components.url
    }

    static func parameters(command: Command, value: Int? = nil) -> [String: String]? {
        switch command {
        case .seek, .volume:
            guard let value = value else {
                logError("Missing value for command: \(command)", domain: .api)
                return nil
            }

            guard (Parameter.Percent.min...Parameter.Percent.max).contains(value) else {
                logError("Invalid value: \(value) for command: \(command)", domain: .api)
                return nil
            }

            return [Parameter.Command.name: "\(command)",
                    Parameter.Percent.name: "\(value)"]
        default:
            return [Parameter.Command.name: "\(command)"]
        }
    }

    static func state(_ data: Data) -> State {
        State.default
    }

    static func snapshot(_ data: Data) -> UIImage? {
        UIImage(data: data)
    }
}
