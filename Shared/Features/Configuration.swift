//
//  Configuration.swift
//
//

import Foundation

public struct ConfigurationKey: ExpressibleByStringLiteral, RawRepresentable, Hashable {
    public let rawValue: String

    public init(stringLiteral value: String) {
        rawValue = value
    }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
        
}

public enum Configuration {
    public static func value<T>(for configurationKey: ConfigurationKey) -> T {
        guard let value = Bundle.main.infoDictionary?[configurationKey.rawValue] as? T else {
            fatalError("Invalid or missing Info.plist key: \(configurationKey.rawValue)")
        }
        
        return value
    }
}
