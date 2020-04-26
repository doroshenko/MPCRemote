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
struct UserDefault<Value: Codable> {

    let userDefaults: UserDefaults = .standard
    let key: UserDefaultKey
    let defaultValue: Value

    init(_ key: UserDefaultKey, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: Value {
        get {
            guard let data = userDefaults.data(forKey: key.rawValue),
                let decodedValue = try? JSONDecoder().decode(Value.self, from: data) else {
                    return defaultValue
            }
            return decodedValue
        }
        set {
            guard let encodedValue = try? JSONEncoder().encode(newValue) else { return }
            userDefaults.set(encodedValue, forKey: key.rawValue)
        }
    }

    func resetValue() {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
