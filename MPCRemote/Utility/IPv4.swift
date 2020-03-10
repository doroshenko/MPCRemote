//
//  IPv4.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct IPv4: Codable, Equatable, Hashable {
    let blocks: [UInt8]

    private static let blockCount = 4

    enum FormatError: Error {
        case invalidBlockCount
        case outOfBounds
    }

    init(blocks: [UInt8]) throws {
        guard blocks.count == IPv4.blockCount else {
            throw FormatError.outOfBounds
        }

        self.blocks = blocks
    }

    init(string: String) throws {
        let components = string.components(separatedBy: ".")

        guard components.count == IPv4.blockCount else {
            throw FormatError.invalidBlockCount
        }

        let blocks = components.compactMap { UInt8($0) }
        try self.init(blocks: blocks)
    }
}

extension IPv4 {
    func baseAddress(with mask: IPv4) -> IPv4? {
        var baseAddress: [UInt8] = []
        for index in 0..<IPv4.blockCount {
            baseAddress.append(blocks[index] & mask.blocks[index])
        }

        return try? IPv4(blocks: baseAddress)
    }

    func firstUsableAddress(with mask: IPv4) -> IPv4? {
        var base = baseAddress(with: mask)
        return base?.next()
    }
}

extension IPv4: IteratorProtocol {
    typealias Element = IPv4

    mutating func next() -> IPv4? {
        var blocks = self.blocks

        for index in stride(from: IPv4.blockCount, to: 0, by: -1) {
            if blocks[index] == UInt8.max {
                if index > 0 {
                    blocks[index] = 0
                } else {
                    return nil
                }
            } else {
                blocks[index] += 1
                break
            }
        }

        return try? IPv4(blocks: blocks)
    }
}

extension IPv4: CustomStringConvertible {
    var description: String {
        blocks.map { String(describing: $0) }.joined(separator: ".")
    }
}
