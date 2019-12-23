//
//  Logger.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import CocoaLumberjack

struct Logger {
    static var shared: Logger = Logger()
    let fileLogger: DDFileLogger
    var logLevel: DDLogLevel = .info
    func log(_ message: String) {
        self.fileLogger.loggerQueue.async {
            self.fileLogger.log(message: DDLogMessage(message: message,
                                                 level: self.logLevel,
                                                 flag: .debug,
                                                 context: 0,
                                                 file: "",
                                                 function: nil,
                                                 line: #line,
                                                 tag: nil,
                                                 options: .dontCopyMessage,
                                                 timestamp: Date()))
        }
    }

    init() {
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log

        fileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)

    }
}

