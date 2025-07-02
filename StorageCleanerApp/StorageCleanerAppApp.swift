//
//  StorageCleanerAppApp.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
//

import SwiftUI

@main
struct StorageCleanerAppApp: App {
    @AppStorage("didFinishOnboarding") var didFinishOnboarding = false

    var body: some Scene {
        WindowGroup {
            if didFinishOnboarding {
                DashboardView() // veya ana ekranınız
            } else {
                OnboardingView()
            }
        }
    }
}
