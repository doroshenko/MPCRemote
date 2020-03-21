//
//  UserDefault.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

protocol UserDefaultKey {
    var rawValue: String { get }
}

@propertyWrapper
struct UserDefault<Value> {

    let userDefaults: UserDefaults = .standard
    let key: UserDefaultKey
    let defaultValue: Value

    init(_ key: UserDefaultKey, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: Value {
        get { userDefaults.object(forKey: key.rawValue) as? Value ?? defaultValue }
        set { userDefaults.set(newValue, forKey: key.rawValue) }
    }

    func resetValue() {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
