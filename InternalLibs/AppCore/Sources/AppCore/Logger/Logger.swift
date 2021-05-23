//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation

struct Logger : Loggable {

    static var isAppCode: Bool = false
    var logLevel: LogLevel = .verbose

    var infoIcon = "⚪️"
    var warningIcon = "🔵"
    var errorIcon = "🔴"
    
    init() {}
    
    func info<T>(_ object: T) {

        if logLevel == .verbose || logLevel == .info {
            if Logger.isAppCode {
                print("\u{1b}[37m\(nullable: object)\u{1b}[39m")
            } else {
                print("\(infoIcon)\(nullable: object)")
            }
        }
    }
    
    func warning<T>(_ object: T) {
        if logLevel == .warning || logLevel == .verbose {
            if Logger.isAppCode {
                print("\u{1b}[93m\(nullable: object)\u{1b}[39m")
            } else {
                print("\(warningIcon)\(nullable: object)")
            }
        }
    }
    
    func error<T>(_ object: T) {
        if logLevel == .error || logLevel == .verbose {
            if Logger.isAppCode {
                print("\u{1b}[31m\(nullable: object)\u{1b}[39m")
            } else {
                print("\(errorIcon)\(nullable: object)")
            }
        }
    }
}
