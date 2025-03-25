import Foundation
import DataKit

class ReceiptsListViewModel: ReceiptsListViewModelProtocol {
    @Published public var receipts: [Receipt] = []
    @Published public var errorDescription: String?
    @Published public var isLoading: Bool = false
    
    private let repository: ReceiptRepositoryProtocol
    
    init(repository: ReceiptRepositoryProtocol = DataRepositoryProvider.makeReceiptRepository()) {
        self.repository = repository
    }
    
    func fetchReceipts() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                self.receipts = try await repository.getAll().sorted { $0.date > $1.date }
                self.errorDescription = nil
            } catch {
                self.errorDescription = error.localizedDescription
            }
        }
    }
}
