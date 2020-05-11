//
//  ArrayTests.swift
//  MPCRemoteTests
//
//  Created by doroshenko on 11.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import XCTest
@testable import MPCRemote

class ArrayTests: XCTestCase {

    var array = [ServerListItem]()

    override func setUp() {
        super.setUp()
        array = [ServerList.offline, ServerList.online, ServerList.favorite]
    }

    override func tearDown() {
        super.tearDown()
        array = []
    }

    func testAppend() {
        let newItem = ServerListItem(server: Server(address: "192.0.2.3"), isFavorite: true, isOnline: true)
        array.updateOrAppend(newItem)

        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array[0], ServerList.offline)
        XCTAssertEqual(array[1], ServerList.online)
        XCTAssertEqual(array[2], ServerList.favorite)
        XCTAssertEqual(array[3], newItem)
    }

    func testUpdateFirst() {
        let newItem = ServerListItem(server: Server(address: "192.0.2.0"), isFavorite: true, isOnline: true)
        array.updateOrAppend(newItem)

        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0], newItem)
        XCTAssertEqual(array[1], ServerList.online)
        XCTAssertEqual(array[2], ServerList.favorite)
    }

    func testUpdateMiddle() {
        let newItem = ServerListItem(server: Server(address: "192.0.2.1"), isFavorite: true, isOnline: true)
        array.updateOrAppend(newItem)

        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0], ServerList.offline)
        XCTAssertEqual(array[1], newItem)
        XCTAssertEqual(array[2], ServerList.favorite)
    }

    func testUpdateLast() {
        let newItem = ServerListItem(server: Server(address: "192.0.2.2"), isFavorite: false, isOnline: false)
        array.updateOrAppend(newItem)

        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0], ServerList.offline)
        XCTAssertEqual(array[1], ServerList.online)
        XCTAssertEqual(array[2], newItem)
    }
}

private extension ArrayTests {

    enum ServerList {
        static let offline = ServerListItem(server: Server(address: "192.0.2.0"), isFavorite: false, isOnline: false)
        static let online = ServerListItem(server: Server(address: "192.0.2.1"), isFavorite: false, isOnline: true)
        static let favorite = ServerListItem(server: Server(address: "192.0.2.2"), isFavorite: true, isOnline: true)
    }
}
