//
//  OperationFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 06.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol OperationProviderType {
    func queuePing(hostName: String, completion: @escaping PingHandler)
    func queueValidation(server: Server, completion: @escaping StateHandler)
    func cancel()
}

struct OperationProvider: OperationProviderType {

    private let apiService: APIServiceType
    private let operationQueue: OperationQueue

    init(apiService: APIServiceType, maxConcurrentOperations: Int = 50) {
        self.apiService = apiService

       operationQueue = {
           let queue = OperationQueue()
           queue.name = "network_operation_queue"
           queue.maxConcurrentOperationCount = maxConcurrentOperations
           return queue
       }()
    }
}

extension OperationProvider {

    func queuePing(hostName: String, completion: @escaping PingHandler) {
        let ping = Ping(hostName: hostName, completion: completion)
        operationQueue.addOperation(ping)
    }

    func queueValidation(server: Server, completion: @escaping StateHandler) {
        let validation = Validation(apiService: apiService, server: server, completion: completion)
        operationQueue.addOperation(validation)
    }

    func cancel() {
        operationQueue.cancelAllOperations()
    }
}
