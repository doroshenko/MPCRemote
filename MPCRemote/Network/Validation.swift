//
//  Validation.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

final class Validation: AsynchronousOperation {

    private let apiService: APIServiceType

    private let server: Server
    private let completionHandler: StateHandler

    init(apiService: APIServiceType, server: Server, completion: @escaping StateHandler) {
        self.apiService = apiService
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
