//
//  Validation.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class Validation: AsynchronousOperation {

    private let apiService: APIService

    private let server: Server
    private let completionHandler: StateResult

    init(resolver: Resolver, server: Server, completion: @escaping StateResult) {
        apiService = resolver.resolve()
        self.server = server
        completionHandler = completion

        super.init()
    }

    override func start() {
        super.start()

        DispatchQueue.main.async {
            self.apiService.getState(server: self.server) { result in
                self.completionHandler(result)
                self.finish()
            }
        }
    }

    override func cancel() {
        super.cancel()

        if isExecuting {
            finish()
        }
    }
}
