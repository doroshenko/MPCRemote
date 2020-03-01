//
//  Ping.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

enum PingError: Error {
    case invalidHost
    case startupFailure(Error)
    case sendingFailure(Error)
    case invalidResponse
    case timeout
}

typealias PingResult = (Result<TimeInterval, PingError>) -> Void

final class Ping: AsynchronousOperation {

    private let completionHandler: PingResult
    private let simplePing: SimplePing

    private var timer: Timer?
    private var sendTime: TimeInterval = 0.0

    private static let timeoutInterval: TimeInterval = 5.0

    init(hostName: String, completionHandler: @escaping PingResult) {
        self.completionHandler = completionHandler
        self.simplePing = SimplePing(hostName: hostName)

        super.init()
    }

    deinit {
        logTrace()
    }

    override func start() {
        super.start()

        simplePing.delegate = self
        simplePing.start()
        setupTimer()
    }

    override func cancel() {
        super.cancel()

        simplePing.stop()
        invalidateTimer()
    }

    // MARK: - Setup

    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: Ping.timeoutInterval, repeats: false, block: { [weak self] _ in
            self?.timeout()
        })
        RunLoop.main.add(timer!, forMode: .common)
    }

    // MARK: - Internal methods

    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func timeout() {
        completionHandler(.failure(.timeout))
        cancel()
        finish()
    }
}

// MARK: - SimplePingDelegate

extension Ping: SimplePingDelegate {
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        guard pinger == simplePing else { return }
        sendTime = Date.timeIntervalSinceReferenceDate
        pinger.send(with: nil)
    }

    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        completionHandler(.failure(.startupFailure(error)))
        finish()
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

    func simplePing(_ pinger: SimplePing, didReceiveUnexpectedPacket packet: Data) {
        completionHandler(.failure(.invalidResponse))
        finish()
    }
}
