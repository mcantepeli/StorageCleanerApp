//
//  DashboardViewModel.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
import Foundation

class DashboardViewModel: ObservableObject {
    @Published var categories: [StorageCategory] = [
        StorageCategory(name: "Fotoğraflar", usedSpace: 12.5, cleanableSpace: 3.2, color: .orange),
        StorageCategory(name: "Videolar", usedSpace: 8.0, cleanableSpace: 1.5, color: .red),
        StorageCategory(name: "Uygulamalar", usedSpace: 15.0, cleanableSpace: 4.0, color: .blue),
        StorageCategory(name: "Önbellek", usedSpace: 3.5, cleanableSpace: 2.0, color: .purple),
        StorageCategory(name: "Büyük Dosyalar", usedSpace: 5.0, cleanableSpace: 1.0, color: .green)
    ]
    
    let totalCapacity: Double = 64.0 // Örnek cihaz kapasitesi GB
    
    var totalUsed: Double {
        categories.reduce(0) { $0 + $1.usedSpace }
    }

    // Fotoğraf analiz servisi
    @Published var analyzedPhotos: [AnalyzedPhoto] = []
    let photoService = PhotoLibraryService()
    
    func analyzePhotos() {
        photoService.analyzePhotos()
        photoService.$analyzedPhotos
            .receive(on: DispatchQueue.main)
            .assign(to: &$analyzedPhotos)
    }
    
    func performSmartClean() {
        print("Akıllı temizleme başlatıldı.")
    }
}
