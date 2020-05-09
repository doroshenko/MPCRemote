//
//  APIState.swift
//  MPCRemote
//
//  Created by doroshenko on 26.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct APIState: Decodable {
    let file: String?
    let filePath: String?
    let filePathArg: String
    let fileDir: String?
    let fileDirArg: String?
    let playbackState: String
    let playbackString: String
    let position: String
    let positionString: String?
    let duration: String
    let durationString: String?
    let volume: String
    let muted: String
    let playbackRate: String?
    let size: String?
    let reloadTime: String?
    let version: String?

    enum CodingKeys: String, CodingKey {
        case file
        case filePath = "filepath"
        case filePathArg = "filepatharg"
        case fileDir = "filedir"
        case fileDirArg = "filedirarg"
        case playbackState = "state"
        case playbackString = "statestring"
        case position
        case positionString = "positionstring"
        case duration
        case durationString = "durationstring"
        case volume = "volumelevel"
        case muted
        case playbackRate = "playbackrate"
        case size
        case reloadTime = "reloadtime"
        case version
    }
}
