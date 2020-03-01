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

typealias PingResult = (Result<Bool, PingError>) -> Void

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

    init(hostName: String, completionHandler: @escaping PingResult) {
        self.completionHandler = completionHandler
        self.hostName = hostName

        simplePing = SimplePing(hostName: hostName)
        simplePing.delegate = self
        simplePing.start()

        setupTimer()
    }

    func cancel() {
        simplePing.stop()

        timer?.invalidate()
        timer = nil
    }

    private func verifyHost() {
        if hostName.isEmpty {
            completionHandler(.failure(.invalidHost))
        }
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
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        
    }
    
    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        <#code#>
    }
    
    func simplePing(_ pinger: SimplePing, didSendPacket packet: Data, sequenceNumber: UInt16) {
        <#code#>
    }
    
    func simplePing(_ pinger: SimplePing, didFailToSendPacket packet: Data, sequenceNumber: UInt16, error: Error) {
        <#code#>
    }
    
    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        <#code#>
    }
    
    func simplePing(_ pinger: SimplePing, didReceiveUnexpectedPacket packet: Data) {
        <#code#>
    }
    
}
