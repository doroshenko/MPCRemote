//
//  Validation.swift
//  MPCRemote
//
//  Created by doroshenko on 21.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class Validation: AsynchronousOperation {

    private let completionHandler: StateResult
    private let server: Server

    init(server: Server, completion: @escaping StateResult) {
        self.completionHandler = completion
        self.server = server

        super.init()
    }

    override func start() {
        super.start()

        DispatchQueue.main.async {
            APIService.getState(server: self.server) { result in
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
