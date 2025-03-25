import SwiftUI
import PhotosUI

struct ReceiptCaptureView<ViewModel: ReceiptCaptureViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @State private var showingCamera = false
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    if let imageData = viewModel.receiptImageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    Button(action: {
                        showingCamera = true
                    }, label: {
                        Label("Take Picture", systemImage: "camera")
                    })
                    .sheet(isPresented: $showingCamera) {
                        CameraPickerView(imageData: $viewModel.receiptImageData)
                    }
                    
                    PhotosPicker(
                        selection: $viewModel.photoPickerItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Select from Gallery", systemImage: "photo")
                    }
                }
                
                Section {
                    DatePicker(
                        "Date",
                        selection: $viewModel.date,
                        in: ...Date.now,
                        displayedComponents: .date
                    )
                    
                    TextField(
                        "Name",
                        text: $viewModel.name
                    )
                    
                    TextField(
                        "Amount",
                        value: $viewModel.amount,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                    
                    TextField(
                        "Currency",
                        text: $viewModel.currency
                    )
                }
                
                if let error = viewModel.errorDescription {
                    Section {
                        Text(error)
                            .foregroundStyle(Color.red)
                    }
                } else if viewModel.isSuccessfullySaved {
                    Section {
                        Text("Receipt Saved!")
                            .foregroundStyle(Color.green)
                    }
                }
                
                Section {
                    Button {
                        Task {
                            await viewModel.saveReceipt()
                        }
                    } label: {
                        Text("Save")
                    }
                    .disabled(viewModel.receiptImageData == nil)
                }
            }
            
            if viewModel.isSaving {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                Text("Saving...")
                        .foregroundStyle(.white)
            }
        }
        
    }
}

#Preview {
    ReceiptCaptureView(viewModel: ReceiptCaptureViewModel())
}
