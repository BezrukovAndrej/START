//
//  UserSettingsManager.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 01.11.2023.
//

import Foundation

final class UserSettingsManager {
    
    static let shared = UserSettingsManager()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var hasShowOnboarding: Bool {
        get {
            return defaults.bool(forKey: "hasShownOnboarding")
        }
        set {
            return defaults.set(newValue, forKey: "hasShownOnboarding")
        }
    }
}
