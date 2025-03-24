import Combine
import DataKit
import Foundation
import PhotosUI
import SwiftUI

class ReceiptCaptureViewModel: ReceiptCaptureViewModelProtocol {
    @Published var receiptImageData: Data?
    @Published var date: Date = Date()
    @Published var currency: String = "USD"
    @Published var amount: Double = 0.0
    @Published var errorDescription: String?
    @Published var photoPickerItem: PhotosPickerItem?
    
    private let repository: ReceiptRepositoryProtocol
    private let coordinator: ReceiptRouterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor
    init(
        repository: ReceiptRepositoryProtocol = DataRepositoryProvider.makeReceiptRepository(),
        coordinator: ReceiptRouterProtocol
    ) {
        self.repository = repository
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    func saveReceipt() async {
        guard let imageData = receiptImageData else { return }
        
        let newReceipt = Receipt(imageData: imageData, date: date, amount: amount, currency: currency)
        do {
            try await repository.save(newReceipt)
            coordinator.dismiss()
        } catch {
            errorDescription = error.localizedDescription
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
