import Foundation
import Photos

struct AnalyzedPhoto: Identifiable {
    let id: String
    let asset: PHAsset
    let type: PhotoType

    enum PhotoType {
        case screenshot, normal
    }
}

class PhotoLibraryService: ObservableObject {
    @Published var analyzedPhotos: [AnalyzedPhoto] = []

    func fetchPhotos(completion: @escaping ([PHAsset]) -> Void) {
        var assets: [PHAsset] = []
        let fetchOptions = PHFetchOptions()
        let results = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        results.enumerateObjects { asset, _, _ in
            assets.append(asset)
        }
        completion(assets)
    }

    func analyzePhotos() {
        fetchPhotos { [weak self] assets in
            var analyzed: [AnalyzedPhoto] = []
            for asset in assets {
                let type: AnalyzedPhoto.PhotoType = asset.mediaSubtypes.contains(.photoScreenshot) ? .screenshot : .normal
                let analyzedPhoto = AnalyzedPhoto(id: asset.localIdentifier, asset: asset, type: type)
                analyzed.append(analyzedPhoto)
            }
            DispatchQueue.main.async {
                self?.analyzedPhotos = analyzed
            }
        }
    }
}

