import SwiftUI

struct CategoryDetailView: View {
    let category: StorageCategory
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        VStack {
            if category.name == "Fotoğraflar" {
                List {
                    ForEach(viewModel.analyzedPhotos) { photo in
                        HStack {
                            Text(photo.type == .screenshot ? "Screenshot" : "Normal")
                            Spacer()
                            PhotoThumbnail(asset: photo.asset)
                        }
                    }
                }
                .onAppear {
                    viewModel.analyzePhotos()
                }
            } else {
                Text("\(category.name) için analiz özelliği yakında!")
            }
        }
        .navigationTitle(category.name)
    }
}

