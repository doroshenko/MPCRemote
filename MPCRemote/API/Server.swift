//
//  Server.swift
//  MPCRemote
//
//  Created by doroshenko on 09.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct Server: Codable {
    let name: String
    let address: String
    let port: Int
}
