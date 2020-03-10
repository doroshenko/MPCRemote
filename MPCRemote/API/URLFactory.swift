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

    static func make(scheme: Scheme = .http, server: Server, endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = server.address
        components.path = endpoint.rawValue
        components.port = server.port

        return components.url
    }
}
