//
//  NetworkService.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol NetworkServiceType {
    func scan(serverFound: @escaping (ServerState) -> Void, scanFinished: (() -> Void)?)
    func ping(address: String, completion: @escaping ServerStateHandler)
    func cancel()
}

struct NetworkService: NetworkServiceType {

    let operationProvider: OperationProviderType

    func scan(serverFound: @escaping (ServerState) -> Void, scanFinished: (() -> Void)?) {
        guard Connectivity.isConnectedToWifi, let addressRange = addressRange else {
            logError("Not connected to LAN", domain: .networking)
            return
        }

        cancel()

        logDebug("Network scan initiated", domain: .networking)

        let scanGroup = DispatchGroup()

        addressRange.forEach { ip in
            scanGroup.enter()
            performPing(address: ip.address, completion: { result in
                scanGroup.leave()
                if case let .success(serverState) = result {
                    serverFound(serverState)
                }
            })
        }

        scanGroup.notify(queue: .main) {
            scanFinished?()
        }
    }

    func ping(address: String, completion: @escaping ServerStateHandler) {
        guard Connectivity.isHostReachable(hostName: address) else {
            logError("Cannot reach host: \(address)", domain: .networking)
            completion(.failure(.invalidEndpoint))
            return
        }

        logDebug("Ping initated for host: \(address)", domain: .networking)
        performPing(address: address, completion: completion)
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

    func performPing(address: String, completion: @escaping ServerStateHandler) {
        operationProvider.queuePing(hostName: address) { pingResult in
            switch pingResult {
            case let .success(duration):
                logDebug("Found host: \(address) after \(Int(duration * 1000)) ms", domain: .networking)
                self.performValidation(hostName: address, completion: completion)
            case .failure:
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                completion(.failure(.invalidEndpoint))
            }
        }
    }

    func performValidation(hostName: String, completion: @escaping ServerStateHandler) {
        let server = Server(address: hostName)
        operationProvider.queueValidation(server: server) { validateResult in
            switch validateResult {
            case let .success(state):
                logInfo("Found MPC server at: \(hostName) with state: \(state)", domain: .networking)
                let serverState = ServerState(server: server, state: state)
                completion(.success(serverState))
            case let .failure(error):
                // Uncomment to debug
                // logDebug(error.localizedDescription, domain: .networking)
                completion(.failure(error))
            }
        }
    }
}
