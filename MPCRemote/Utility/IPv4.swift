//
//  IPv4.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

typealias IPv4 = UInt32

extension IPv4 {
    private static let octetCount = Self.bitWidth / UInt8.bitWidth

    init?(octets: [UInt8]) {
        guard octets.count == IPv4.octetCount else { return nil }

        self = UInt32(bigEndianBytes: octets)
    }

    init?(string: String) {
        let components = string.components(separatedBy: ".")

        guard components.count == IPv4.octetCount else { return nil }

        let octets = components.compactMap { UInt8($0) }
        self.init(octets: octets)
    }
}

extension IPv4 {
    func baseAddress(with mask: IPv4) -> IPv4 {
        self & mask
    }

    func broadcastAddress(with mask: IPv4) -> IPv4 {
        self | ~mask
    }

    func firstUsableAddress(with mask: IPv4) -> IPv4 {
        baseAddress(with: mask) + 1
    }

    func lastUsableAddress(with mask: IPv4) -> IPv4 {
        broadcastAddress(with: mask) - 1
    }

    func usableAddressRange(with mask: IPv4) -> CountableClosedRange<IPv4> {
        firstUsableAddress(with: mask)...lastUsableAddress(with: mask)
    }
}

extension IPv4 {
    var address: String {
        bigEndianBytes.map { String(describing: $0) }.joined(separator: ".")
    }
}

extension FixedWidthInteger {
    init<I>(bigEndianBytes iterator: inout I) where I: IteratorProtocol, I.Element == UInt8 {
        self = stride(from: 0, to: Self.bitWidth, by: UInt8.bitWidth).reversed().reduce(into: 0) {
            $0 |= Self(truncatingIfNeeded: iterator.next()!) &<< $1
        }
    }

    init<C>(bigEndianBytes bytes: C) where C: Collection, C.Element == UInt8 {
        precondition(bytes.count == (Self.bitWidth + 7)/UInt8.bitWidth)
        var iter = bytes.makeIterator()
        self.init(bigEndianBytes: &iter)
    }

    var bigEndianBytes: [UInt8] {
        stride(from: 0, to: Self.bitWidth, by: UInt8.bitWidth).reversed().map {
            UInt8(truncatingIfNeeded: self >> $0)
        }
    }
}
