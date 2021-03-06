//
//  Ping.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

final class Ping: AsynchronousOperation {

    private let completionHandler: PingHandler
    private let simplePing: SimplePing

    private var timer: Timer?
    private var sendTime: TimeInterval = 0.0

    init(hostName: String, completion: @escaping PingHandler) {
        self.completionHandler = completion
        self.simplePing = SimplePing(hostName: hostName)

        super.init()
    }

    override func start() {
        super.start()

        simplePing.delegate = self

        DispatchQueue.main.async {
            self.simplePing.start()
        }
    }

    override func cancel() {
        super.cancel()

        stopActivity()
        if isExecuting {
            finish()
        }
    }

    // MARK: - Setup

    private func setupTimer() {
        sendTime = Date.timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(withTimeInterval: .ping, repeats: false, block: { [weak self] _ in
            self?.timeout()
        })
    }

    // MARK: - Internal functions

    private func stopActivity() {
        simplePing.stop()
        timer?.invalidate()
        timer = nil
    }

    private func timeout() {
        completionHandler(.failure(.timeout))
        cancel()
    }
}

// MARK: - SimplePingDelegate

extension Ping: SimplePingDelegate {
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        pinger.send(with: nil)
    }

    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        completionHandler(.failure(.startupFailure(error)))
        finish()
    }

    func simplePing(_ pinger: SimplePing, didSendPacket packet: Data, sequenceNumber: UInt16) {
        setupTimer()
    }

    func simplePing(_ pinger: SimplePing, didFailToSendPacket packet: Data, sequenceNumber: UInt16, error: Error) {
        completionHandler(.failure(.sendingFailure(error)))
        finish()
    }

    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        let duration = Date.timeIntervalSinceReferenceDate - sendTime
        completionHandler(.success(duration))
        finish()
    }
}
