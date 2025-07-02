//
//  StorageCategory.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
//
import Foundation
import SwiftUI

struct StorageCategory: Identifiable {
    let id = UUID()
    let name: String
    let usedSpace: Double // GB
    let cleanableSpace: Double // GB
    let color: Color
}
