//
//  Server.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct Server: Codable {
    let address: String
    let port: UInt16
    let name: String
    let favorite: Bool

    init(address: String, port: UInt16 = Port.default, name: String? = nil, favorite: Bool = false) {
        self.address = address
        self.port = port
        self.name = name ?? address
        self.favorite = favorite
    }
}

extension Server: Identifiable {
    var id: String {
        "\(address):\(port.portDescription)"
    }
}

extension Array where Element == Server {

    mutating func appendUnique(_ newElement: Element) {
        guard !contains(where: { $0.id == newElement.id }) else {
            return
        }

        append(newElement)
    }
}
