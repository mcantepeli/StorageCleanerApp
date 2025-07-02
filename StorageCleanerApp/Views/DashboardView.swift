//
//  DashboardView.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
//
import SwiftUI

struct DashboardView: View {
    
    @State private var showCleanResult = false
    @StateObject private var viewModel = DashboardViewModel()
    @State private var selectedCategory: StorageCategory?
    @State private var showCategoryDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    Text("Toplam Kullanılan Alan")
                        .font(.headline)
                    ProgressView(value: viewModel.totalUsed / viewModel.totalCapacity)
                        .accentColor(.blue)
                    Text(String(format: "%.1f GB / %.0f GB", viewModel.totalUsed, viewModel.totalCapacity))
                        .font(.subheadline)
                }
                .padding()
                
                List(viewModel.categories) { category in
                    Button {
                        selectedCategory = category
                        showCategoryDetail = true
                    } label: {
                        StorageCategoryRow(category: category)
                    }
                }
                
                Button(action: {
                    viewModel.performSmartClean()
                    showCleanResult = true
                }) {
                    Text("Akıllı Temizle")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .alert(isPresented: $showCleanResult ) {
                    Alert(
                        title: Text("Başarılı!"),
                        message: Text("Gereksiz dosyalar temizlendi."),
                        dismissButton: .default(Text("Tamam"))
                    )
                }
                .padding()
            }
            .navigationTitle("Depolama Temizleyici")
            .sheet(isPresented: $showCategoryDetail) {
                if let category = selectedCategory {
                    CategoryDetailView(category: category, viewModel: viewModel)
                }
            }
        }
    }
}
