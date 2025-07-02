//
//  StorageCategoryRow.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
import SwiftUI

struct StorageCategoryRow: View {
    let category: StorageCategory

    var body: some View {
        HStack {
            Circle()
                .fill(category.color)
                .frame(width: 20, height: 20)
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                Text(String(format: "Kullanılan: %.1f GB, Temizlenebilir: %.1f GB", category.usedSpace, category.cleanableSpace))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}
