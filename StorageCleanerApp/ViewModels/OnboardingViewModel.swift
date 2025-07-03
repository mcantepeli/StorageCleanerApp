//
//  OnboardingViewModel.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
//

import SwiftUI
import Photos

class OnboardingViewModel: ObservableObject {
    @Published var permissionGranted = false
    @Published var showPermissionAlert = false
    @AppStorage("didFinishOnboarding") var didFinishOnboarding = false

    func requestPhotoPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized || status == .limited {
                    self.permissionGranted = true
                    self.didFinishOnboarding = true // Onboarding’ı bitir
                } else {
                    self.showPermissionAlert = true
                }
            }
        }
    }
}
