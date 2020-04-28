//
//  Server.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct Server: Codable {
    let address: String
    let port: UInt16
    let name: String

    init(address: String, port: UInt16 = Port.default, name: String? = nil) {
        self.address = address
        self.port = port
        self.name = name ?? "\(address):\(port)"
    }
}