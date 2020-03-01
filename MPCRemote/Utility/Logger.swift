//
//  Logger.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

struct Logger {

    private static var dateFormatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
      formatter.locale = .current
      formatter.timeZone = .current
      return formatter
    }

    private static var date: String {
        dateFormatter.string(from: Date())
    }

    private static var location: String {
        let file = #file.components(separatedBy: "/").last ?? "unknown"
        return "\(file):\(#line) \(#function)"
    }

    static func log(message: String, level: LogLevel, domain: LogDomain) {
        #if DEBUG
        // swiftlint:disable:next insecure_log
        print("\(date) \(domain.description) \(location) : \(level.description) \(message)")
        #endif
    }
}

func logInfo(message: String, domain: LogDomain = .default) {
    Logger.log(message: message, level: .info, domain: domain)
}

func logWarning(message: String, domain: LogDomain = .default) {
    Logger.log(message: message, level: .warning, domain: domain)
}

func logError(message: String, domain: LogDomain = .default) {
    Logger.log(message: message, level: .error, domain: domain)
}

func logCritical(message: String, domain: LogDomain = .default) {
    Logger.log(message: message, level: .critical, domain: domain)
}
