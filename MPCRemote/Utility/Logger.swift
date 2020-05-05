//
//  Logger.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

private struct Logger {

    static var dateFormatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
      formatter.locale = .current
      formatter.timeZone = .current
      return formatter
    }

    static var date: String {
        dateFormatter.string(from: Date())
    }

    static func location(_ file: String, _ line: Int, _ function: String) -> String {
        let file = file.components(separatedBy: "/").last ?? "unknown"
        return "\(file):\(line) \(function)"
    }

    static func text(_ message: String) -> String {
        message.isEmpty ? String() : " -> \(message)"
    }

    static func log(message: String, level: LogLevel, domain: LogDomain, file: String, line: Int, function: String) {
        // swiftlint:disable:next insecure_log
        NSLog("\(date) \(level)\(domain) \(location(file, line, function))\(text(message))")
    }
}

func logDebug(_ message: String = String(), domain: LogDomain = .default, file: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
    Logger.log(message: message, level: .debug, domain: domain, file: file, line: line, function: function)
    #endif
}

func logInfo(_ message: String = String(), domain: LogDomain = .default, file: String = #file, line: Int = #line, function: String = #function) {
    Logger.log(message: message, level: .info, domain: domain, file: file, line: line, function: function)
}

func logWarning(_ message: String = String(), domain: LogDomain = .default, file: String = #file, line: Int = #line, function: String = #function) {
    Logger.log(message: message, level: .warning, domain: domain, file: file, line: line, function: function)
}

func logError(_ message: String = String(), domain: LogDomain = .default, file: String = #file, line: Int = #line, function: String = #function) {
    Logger.log(message: message, level: .error, domain: domain, file: file, line: line, function: function)
}

func logCritical(_ message: String = String(), domain: LogDomain = .default, file: String = #file, line: Int = #line, function: String = #function) {
    Logger.log(message: message, level: .critical, domain: domain, file: file, line: line, function: function)
}
