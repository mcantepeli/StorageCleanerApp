import SwiftUI
import Photos

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(spacing: 30) {
            Text("Gizlilik Önceliğimiz")
                .font(.largeTitle)
                .bold()
            Text("Tüm analizler cihazınızda yapılır, verileriniz asla dışarı çıkmaz.")
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                viewModel.requestPhotoPermission()
            }) {
                Text("Fotoğraflara Erişime İzin Ver")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            if viewModel.permissionGranted {
                Text("İzin verildi! Şimdi uygulamayı keşfedin.")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
        .alert(isPresented: $viewModel.showPermissionAlert) {
            Alert(
                title: Text("İzin Gerekli"),
                message: Text("Fotoğraflara erişim izni olmadan bazı özellikler kullanılamaz."),
                dismissButton: .default(Text("Tamam"))
            )
        }
    }
}

