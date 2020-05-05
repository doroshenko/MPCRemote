//
//  APIFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

final class URLFactory {

    static func make(scheme: Scheme = .http, server: Server?, endpoint: Endpoint) -> URL? {
        guard let server = server else {
            logError("Invalid server", domain: .api)
            return nil
        }

        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = server.address
        components.path = endpoint.rawValue
        components.port = Int(server.port)

        return components.url
    }
}
