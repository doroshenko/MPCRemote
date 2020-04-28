//
//  PlayerStateFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 26.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class PlayerStateFactory {

    static func make(string: String) -> PlayerState? {
        let regex = try? NSRegularExpression(pattern: #"<p id=\"(?<key>\S+)\">(?<value>.+)</p>"#, options: .caseInsensitive)
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        guard let results = regex?.matches(in: string, range: range) else { return nil }

        let values = results.map { result -> (key: String, value: String) in
            let key = String(string[Range(result.range(withName: "key"), in: string)!])
            let value = String(string[Range(result.range(withName: "value"), in: string)!])
            return (key: key, value: value)
        }

        let dictionary = Dictionary(uniqueKeysWithValues: values)
        guard let json = try? JSONSerialization.data(withJSONObject: dictionary),
            let apiState = try? JSONDecoder().decode(APIState.self, from: json) else { return nil }
        return make(apiState: apiState)
    }

    private static func make(apiState: APIState) -> PlayerState {
        PlayerState(file: apiState.file,
                    state: PlaybackState(apiState.playbackState) ?? PlayerState.default.state,
                    position: (Double(apiState.position) ?? PlayerState.default.position) / 1000,
                    duration: (Double(apiState.duration) ?? PlayerState.default.duration) / 1000,
                    volume: Double(apiState.volume) ?? PlayerState.default.volume,
                    isMuted: Int(apiState.muted) != 0)
    }
}
