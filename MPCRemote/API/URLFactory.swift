//
//  APIFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation
import UIKit

final class URLFactory {

    static func make(scheme: Scheme = .http, server: Server?, endpoint: Endpoint) -> URL? {
        guard let server = server else {
            logError("Invalid server", domain: .api)
            return nil
        }

        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = server.ip.address
        components.path = endpoint.rawValue
        components.port = server.port

        return components.url
    }
}
