//
//  Bundle+Convenience.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

extension Bundle {
    var displayName: String {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? String()
    }
}
