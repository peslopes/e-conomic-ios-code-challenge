import Foundation
import DataKit

protocol ReceiptsListViewModelProtocol: ObservableObject {
    var receipts: [Receipt] { get }
    var errorDescription: String? { get }
    var isLoading: Bool { get }
    
    func fetchReceipts()
}
