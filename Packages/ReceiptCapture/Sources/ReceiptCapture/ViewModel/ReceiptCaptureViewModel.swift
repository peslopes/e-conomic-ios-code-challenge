import Combine
import DataKit
import Foundation
import PhotosUI
import SwiftUI

class ReceiptCaptureViewModel: ReceiptCaptureViewModelProtocol {
    @Published var receiptImageData: Data?
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var currency: String = "USD"
    @Published var amount: Double = 0.0
    @Published var errorDescription: String?
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var isSaving: Bool = false
    @Published var isSuccessfullySaved: Bool = false
    
    private let repository: ReceiptRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor
    init(repository: ReceiptRepositoryProtocol = DataRepositoryProvider.makeReceiptRepository()) {
        self.repository = repository
        
        setupBindings()
    }
    
    func saveReceipt() {
        guard let imageData = receiptImageData else { return }
        
        let newReceipt = Receipt(
            name: name,
            imageData: imageData,
            date: date,
            amount: amount,
            currency: currency
        )
        Task {
            self.isSaving = true
            self.isSuccessfullySaved = false
            defer {
                self.isSaving = false
            }
            do {
                try await repository.save(newReceipt)
                await MainActor.run {
                    errorDescription = nil
                    isSuccessfullySaved = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                    self?.isSuccessfullySaved = false
                }
            } catch {
                await MainActor.run {
                    errorDescription = error.localizedDescription
                }
            }
        }
    }
    
    @MainActor
    private func setupBindings() {
        $photoPickerItem
            .sink { [weak self] newItem in
                Task {
                    do {
                        if let data = try await self?.loadImage(from: newItem) {
                            self?.receiptImageData = data
                        }
                    } catch {
                        self?.errorDescription = error.localizedDescription
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadImage(from item: PhotosPickerItem?) async throws -> Data?  {
        return try await item?.loadTransferable(type: Data.self)
    }
}
