import SwiftUI

struct CategoryDetailView: View {
    
    let category: StorageCategory
    @ObservedObject var viewModel: DashboardViewModel
    
    @State private var selectedPhotoIDs = Set<String>()
    @State private var showDeleteAlert = false
    @State private var isLoading = false

    var body: some View {
        VStack {
            if category.name == "Fotoğraflar" {
            if isLoading {
                ProgressView("Fotoğraflar analiz ediliyor...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.analyzedPhotos.isEmpty {
                Text("Gösterilecek fotoğraf yok.")
                    .foregroundColor(.gray)
            } else {
                
                List(viewModel.analyzedPhotos) { photo in
                    HStack {
                        Button(action: {
                            toggleSelection(photo.id)
                        }) {
                            Image(systemName: selectedPhotoIDs.contains(photo.id) ? "checkmark.square.fill" : "square")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Text(photo.type == .screenshot ? "Screenshot" : "Normal")
                        Spacer()
                        PhotoThumbnail(asset: photo.asset)
                    }
                }
                .onAppear {
                    viewModel.analyzePhotos()
                }

                Button("Seçili Fotoğrafları Sil") {
                    showDeleteAlert = true
                }
                .disabled(selectedPhotoIDs.isEmpty)
                .padding()
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Onay"),
                        message: Text("Seçili fotoğraflar silinsin mi?"),
                        primaryButton: .destructive(Text("Sil")) {
                            viewModel.deletePhotos(withIDs: Array(selectedPhotoIDs))
                            selectedPhotoIDs.removeAll()
                        },
                        secondaryButton: .cancel()
                    )
                }
             }
            } else {
                Text("\(category.name) için analiz özelliği yakında!")
            }
        }
        .navigationTitle(category.name)
        .onAppear {
            if category.name == "Fotoğraflar" {
                isLoading = true
                viewModel.analyzePhotos {
                    isLoading = false
                }
            }
        }
    }

    private func toggleSelection(_ id: String) {
        if selectedPhotoIDs.contains(id) {
            selectedPhotoIDs.remove(id)
        } else {
            selectedPhotoIDs.insert(id)
        }
    }
}
