//
//  DashboardViewModel.swift
//  StorageCleanerApp
//
//  Created by Can on 27.06.2025.
import Photos

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
    
    // Temizlik sonrası açılan alanı tutmak için:
    @Published var lastCleanedSpace: Double = 0
    
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
        
        // Temizlikten önce toplam temizlenebilir alanı hesapla
        let cleaned = categories.reduce(0) { $0 + $1.cleanableSpace }
        lastCleanedSpace = cleaned
        
        categories = categories.map { category in
            StorageCategory(
                name: category.name,
                usedSpace: max(0, category.usedSpace - category.cleanableSpace),
                cleanableSpace: 0,
                color: category.color
            )
        }
        
    }
    
    func deletePhotos(withIDs ids: [String]) {
        let assetsToDelete = analyzedPhotos.filter { ids.contains($0.id) }.map { $0.asset }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(assetsToDelete as NSArray)
        }, completionHandler: { success, error in
            DispatchQueue.main.async {
                if success {
                    self.analyzedPhotos.removeAll { ids.contains($0.id) }
                }
                // Hata yönetimi ekleyebilirsiniz
            }
        })
    }
    
}
