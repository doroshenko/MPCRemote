//
//  IPv4Tests.swift
//  UnitTests
//
//  Created by doroshenko on 28.02.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import XCTest
@testable import MPCRemote

class IPv4Tests: XCTestCase {

    func testIPv4InitOctets() {
        guard let ip = IPv4(octets: [192, 168, 1, 200]) else {
            XCTFail("IPv4 init returned nil")
            return
        }

        XCTAssertEqual(ip.address, "192.168.1.200")
    }

    func testIPv4InitOctetsTooMany() {
        let ip = IPv4(octets: [192, 168, 1, 200, 100])
        XCTAssertNil(ip)
    }

    func testIPv4InitBlocksTooLittle() {
        let ip = IPv4(octets: [192, 168, 1])
        XCTAssertNil(ip)
    }

    func testIPv4InitString() {
        guard let ip = IPv4(string: "192.168.1.200") else {
            XCTFail("IPv4 init returned nil")
            return
        }

        XCTAssertEqual(ip.address, "192.168.1.200")
    }

    func testIPv4InitStringTooLong() {
        let ip = IPv4(string: "192.168.1.200.100")
        XCTAssertNil(ip)
    }

    func testIPv4InitStringTooShort() {
        let ip = IPv4(string: "192.168.1")
        XCTAssertNil(ip)
    }

    func testIPv4InitStringInvalidSymbols() {
        let ip = IPv4(string: "192.168.±.r5")
        XCTAssertNil(ip)
    }

    func testIPv4InitOutOfBounds() {
        let ip = IPv4(string: "192.168.1.500")
        XCTAssertNil(ip)
    }

    func testIPv4Iterator() {
        var ip = IPv4(string: "10.0.0.1")! + 1
        XCTAssertEqual(ip.address, "10.0.0.2")

        ip = IPv4(string: "10.0.0.255")! + 1
        XCTAssertEqual(ip.address, "10.0.1.0")

        ip = IPv4(string: "10.0.255.255")! + 1
        XCTAssertEqual(ip.address, "10.1.0.0")

        ip = IPv4(string: "10.255.255.255")! + 1
        XCTAssertEqual(ip.address, "11.0.0.0")
    }

    func testIPv4ClassANetwork() {
        let ip = IPv4(string: "10.0.0.1")!
        let mask = IPv4(string: "255.224.0.0")!

        let base = ip.baseAddress(with: mask)
        let first = ip.firstUsableAddress(with: mask)
        let last = ip.lastUsableAddress(with: mask)
        let broadcast = ip.broadcastAddress(with: mask)
        XCTAssertEqual(base.address, "10.0.0.0")
        XCTAssertEqual(first.address, "10.0.0.1")
        XCTAssertEqual(last.address, "10.31.255.254")
        XCTAssertEqual(broadcast.address, "10.31.255.255")
    }

    func testIPv4ClassBNetwork() {
        let ip = IPv4(string: "172.16.0.50")!
        let mask = IPv4(string: "255.255.252.0")!

        let base = ip.baseAddress(with: mask)
        let first = ip.firstUsableAddress(with: mask)
        let last = ip.lastUsableAddress(with: mask)
        let broadcast = ip.broadcastAddress(with: mask)
        XCTAssertEqual(base.address, "172.16.0.0")
        XCTAssertEqual(first.address, "172.16.0.1")
        XCTAssertEqual(last.address, "172.16.3.254")
        XCTAssertEqual(broadcast.address, "172.16.3.255")
    }

    func testIPv4BaseClassCNetwork() {
        let ip = IPv4(string: "192.168.1.200")!
        let mask = IPv4(string: "255.255.255.0")!

        let base = ip.baseAddress(with: mask)
        let first = ip.firstUsableAddress(with: mask)
        let last = ip.lastUsableAddress(with: mask)
        let broadcast = ip.broadcastAddress(with: mask)
        XCTAssertEqual(base.address, "192.168.1.0")
        XCTAssertEqual(first.address, "192.168.1.1")
        XCTAssertEqual(last.address, "192.168.1.254")
        XCTAssertEqual(broadcast.address, "192.168.1.255")
    }
}
