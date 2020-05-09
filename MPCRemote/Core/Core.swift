//
//  Core.swift
//  MPCRemote
//
//  Created by doroshenko on 06.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct Core {
    static let data: DataStore = DataStore()
    static let resolver: Resolver = Dependency()
    static let composer: Composer = Composer(resolver: resolver, data: data)
}