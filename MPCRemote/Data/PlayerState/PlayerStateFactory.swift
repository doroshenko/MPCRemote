//
//  PlayerStateFactory.swift
//  MPCRemote
//
//  Created by doroshenko on 26.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

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
}

private extension PlayerStateFactory {

    static func make(apiState: APIState) -> PlayerState {
        guard let playbackState = PlaybackState(apiState.playbackState),
            let position = Double(apiState.position),
            let duration = Double(apiState.duration),
            let volume = Double(apiState.volume) else {
                return PlayerState()
        }

        let fallbackFile = String(apiState.filePath?.split(separator: "\\").last ?? "...")
        let file = apiState.file ?? fallbackFile
        let isMuted = Int(apiState.muted) != 0

        return PlayerState(file: file,
                           state: playbackState,
                           position: position / 1000,
                           duration: duration / 1000,
                           volume: volume,
                           isMuted: isMuted)
    }
}
