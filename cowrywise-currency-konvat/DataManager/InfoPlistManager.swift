//
//  InfoPlistManager.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import Foundation

enum PlistManager {
    static subscript(key: PlistKey) -> String {
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("Could not find value for: \(key)")
        }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}

enum PlistKey: String {
    case baseUrl = "BaseUrl"
    case apiKey = "ApiKey"
    case appName = "CFBundleName"
    case appVersion = "CFBundleShortVersionString"
    case buildNumber = "CFBundleVersion"
}
