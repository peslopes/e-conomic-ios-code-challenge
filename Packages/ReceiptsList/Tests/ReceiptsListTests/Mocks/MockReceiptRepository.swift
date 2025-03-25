import DataKit
import Foundation
@testable import ReceiptsList

class MockReceiptRepository: ReceiptRepositoryProtocol {
    var shouldThrowError = false
    var mockReceipts: [Receipt] = []
    
    func getAll() async throws -> [DataKit.Receipt] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch receipts"])
        }
        return mockReceipts
    }
    
    func save(_ receipt: Receipt) async throws { }
    
    func get(_ id: UUID) async throws -> DataKit.Receipt {
        Receipt(name: "Test", imageData: Data(), date: Date(), amount: 100.0, currency: "USD")
    }
    
    func delete(_ id: UUID) async throws { }
}
