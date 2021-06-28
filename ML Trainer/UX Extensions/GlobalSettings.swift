//
//  AllSettings.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/23/21.
//

import Foundation

class UserSettings : ObservableObject {
    @Published var showGuides = UserDefaults.standard.bool(forKey: "showGuides")
    @Published var showCrosshairs = UserDefaults.standard.bool(forKey: "showCrosshairs")
    @Published var hideStatusBar = UserDefaults.standard.bool(forKey: "hideStatusBar")
    @Published var loopSetting = UserDefaults.standard.integer(forKey: "loopSetting")
    @Published var loopTab = UserDefaults.standard.integer(forKey: "loopTab")
    @Published var scansRemaining = 0
}
