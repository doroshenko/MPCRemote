//
//  ServerVerificationService.swift
//  MPCRemote
//
//  Created by doroshenko on 26.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol ServerVerificationServiceType {
    func verify(address: String, port: String, name: String) -> Server?
    func verify(address: String) -> String?
    func verify(port: String) -> UInt16?
    func verify(name: String) -> String?
}

struct ServerVerificationService: ServerVerificationServiceType {

    func verify(address: String, port: String, name: String) -> Server? {
        guard let address = verify(address: address),
            let port = verify(port: port),
            let name = verify(name: name) else {
            return nil
        }

        return Server(address: address, port: port, name: name)
    }

    func verify(address: String) -> String? {
        let address = address.trimmingCharacters(in: .whitespaces)

        guard (1..<Name.maxLength).contains(address.count) else {
            return nil
        }

        guard address.trimmingCharacters(in: .urlHostAllowed).isEmpty else {
            return nil
        }

        return address
    }

    func verify(port: String) -> UInt16? {
        guard let port = UInt16(port), port > 0 else {
            return nil
        }

        return port
    }

    func verify(name: String) -> String? {
        let name = name.trimmingCharacters(in: .whitespaces)

        guard (0..<Name.maxLength).contains(name.count) else {
            return nil
        }

        return name
    }
}
