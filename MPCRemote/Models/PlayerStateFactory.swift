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
                    filePath: apiState.filePath,
                    filePathArg: apiState.filePathArg,
                    fileDir: apiState.fileDir,
                    fileDirArg: apiState.fileDirArg,
                    playbackState: PlaybackState(apiState.playbackState) ?? PlayerState.default.playbackState,
                    playbackString: apiState.playbackString,
                    position: UInt64(apiState.position) ?? PlayerState.default.position,
                    positionString: apiState.positionString,
                    duration: UInt64(apiState.duration) ?? PlayerState.default.duration,
                    durationString: apiState.durationString,
                    volume: UInt(apiState.volume) ?? PlayerState.default.volume,
                    muted: Bool(apiState.muted) ?? PlayerState.default.muted,
                    playbackRate: Float(apiState.playbackRate) ?? PlayerState.default.playbackRate,
                    size: apiState.size,
                    reloadTime: apiState.reloadTime,
                    version: apiState.version)
    }
}
