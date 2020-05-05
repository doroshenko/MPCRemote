//
//  NetworkService.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol NetworkServiceType {
    func scan(complete: Bool, completion: @escaping (Server) -> Void)
    func ping(hostName: String, completion: @escaping ServerHandler)
    func cancel()
}

struct NetworkService: NetworkServiceType {

    let operationProvider: OperationProviderType

    func scan(complete: Bool, completion: @escaping (Server) -> Void) {
        guard Connectivity.isConnectedToWifi, let addressRange = addressRange else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        cancel()

        logDebug("Network scan initiated", domain: .networking)

        var found: Bool = false
        addressRange.forEach { ip in
            performPing(hostName: ip.address, completion: { serverResult in
                if case let .success(server) = serverResult, complete || !found {
                    found = true
                    completion(server)
                }
            })
        }
    }

    func ping(hostName: String, completion: @escaping ServerHandler) {
        guard Connectivity.isHostReachable(hostName: hostName) else {
            logError("Cannot reach host: \(hostName)", domain: .networking)
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Ping initated for host: \(hostName)", domain: .networking)
        performPing(hostName: hostName, completion: completion)
    }

    func cancel() {
        logDebug("All active operations canceled", domain: .networking)
        operationProvider.cancel()
    }
}

// MARK: - Internals

private extension NetworkService {

    var addressRange: CountableClosedRange<IPv4>? {
        logDebug(domain: .networking)
        let localAddress = Connectivity.localIPAddress
        guard let addressString = localAddress.address, let ip = IPv4(string: addressString) else {
            logError("Invalid local IP address", domain: .networking)
            return nil
        }

        guard let maskString = localAddress.mask, let mask = IPv4(string: maskString) else {
            logError("Invalid network mask", domain: .networking)
            return nil
        }

        return ip.usableAddressRange(with: mask)
    }

    func performPing(hostName: String, completion: @escaping ServerHandler) {
        operationProvider.queuePing(hostName: hostName) { pingResult in
            switch pingResult {
            case let .success(duration):
                logDebug("Found host: \(hostName) after \(Int(duration * 1000)) ms", domain: .networking)
                self.performValidation(hostName: hostName, completion: completion)
            case .failure:
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                completion(.failure(.invalidEndpoint))
            }
        }
    }

    func performValidation(hostName: String, completion: @escaping ServerHandler) {
        let server = Server(address: hostName)
        operationProvider.queueValidation(server: server) { validateResult in
            switch validateResult {
            case let .success(state):
                logInfo("Found MPC server at: \(hostName) with state: \(state)", domain: .networking)
                completion(.success(server))
            case let .failure(error):
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                completion(.failure(error))
            }
        }
    }
}
