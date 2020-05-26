//
//  Server.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct Server {
    let address: String
    let port: UInt16
    let name: String

    init(address: String, port: UInt16 = Port.default, name: String? = nil) {
        self.address = address
        self.port = port

        if let name = name, !name.isEmpty {
            self.name = name
        } else {
            self.name = address
        }
    }
}

extension Server: Codable, Equatable { }

extension Server: Identifiable {
    var id: String {
        "\(address):\(port.portDescription)"
    }
}

extension Server: Comparable {
    static func < (lhs: Server, rhs: Server) -> Bool {
        lhs.name.compare(rhs.name, options: .numeric) == .orderedAscending
    }
}
