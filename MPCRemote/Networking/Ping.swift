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

final class Ping: NSObject {

    private var hostName: String {
        didSet {
            verifyHost()
        }
    }

    private let completionHandler: PingResult
    private let simplePing: SimplePing
    private var timer: Timer?

    static let timeoutInterval: TimeInterval = 5.0

    @discardableResult
    init(hostName: String, completionHandler: @escaping PingResult) {
        self.completionHandler = completionHandler
        self.hostName = hostName
        self.simplePing = SimplePing(hostName: hostName)

        super.init()

        setupPing()
        setupTimer()
    }

    func cancel() {
        simplePing.stop()

        timer?.invalidate()
        timer = nil
    }

    private func verifyHost() {
        if hostName.isEmpty {
            logError("Couldn't verify host: \(hostName)", domain: .networking)
            completionHandler(.failure(.invalidHost))
        }
    }

    private func setupPing() {
        simplePing.delegate = self
        simplePing.start()
    }

    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: Ping.timeoutInterval,
                                     target: self,
                                     selector: #selector(timeout),
                                     userInfo: nil,
                                     repeats: false)
        RunLoop.main.add(timer!, forMode: .common)
    }

    @objc private func timeout() {
        completionHandler(.failure(.timeout))
        cancel()
    }
}

// MARK: - SimplePingDelegate

extension Ping: SimplePingDelegate {
    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        completionHandler(.failure(.startupFailure(error)))
    }

    func simplePing(_ pinger: SimplePing, didFailToSendPacket packet: Data, sequenceNumber: UInt16, error: Error) {
        completionHandler(.failure(.sendingFailure(error)))
    }

    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        let duration = timer?.timeInterval ?? Ping.timeoutInterval
        completionHandler(.success(duration))
    }

    func simplePing(_ pinger: SimplePing, didReceiveUnexpectedPacket packet: Data) {
        completionHandler(.failure(.invalidResponse))
    }
}
