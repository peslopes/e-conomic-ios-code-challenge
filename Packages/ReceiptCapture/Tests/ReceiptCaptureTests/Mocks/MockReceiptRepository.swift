import Foundation
import DataKit
@testable import ReceiptCapture

class MockReceiptRepository: ReceiptRepositoryProtocol {
    var shouldThrowError = false
    var savedReceipt: Receipt?
    
    func save(_ receipt: Receipt) async throws {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to save receipt"])
        }
        savedReceipt = receipt
    }
    
    func getAll() async throws -> [DataKit.Receipt] {
        []
    }
    
    func get(_ id: UUID) async throws -> DataKit.Receipt {
        Receipt(imageData: Data(), date: Date(), amount: 0, currency: "")
    }
    
    func delete(_ id: UUID) async throws {}
}
