//
//  TimeFormatter.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class TextFormatter {
    static func formatedTime(from timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]

        let formatedTime = formatter.string(from: timeInterval)
        return formatedTime ?? "-"
    }

    static func formattedVolume(from volume: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0

        let formattedVolume = formatter.string(from: NSNumber(value: volume))
        return formattedVolume ?? "-"
    }
}
