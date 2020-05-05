//
//  TextFormatter.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

final class TextFormatter {
    static var time: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }

    static var plainNumber: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }
}

extension Double {
    var seekDescription: String {
        TextFormatter.time.string(from: self) ?? String()
    }
}

extension UInt16 {
    var portDescription: String {
        TextFormatter.plainNumber.string(from: self as NSNumber) ?? String()
    }
}
