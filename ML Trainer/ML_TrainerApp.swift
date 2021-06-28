//
//  ML_TrainerApp.swift
//  ML Trainer
//
//  Created by Casey Pollock on 6/20/21.
//

import SwiftUI

@main
struct ML_TrainerApp: App {
    var body: some Scene {
        WindowGroup {
            MLTrainerApp(userSettings: UserSettings())
        }
    }
}
