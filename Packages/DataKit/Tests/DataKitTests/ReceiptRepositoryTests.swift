import XCTest
@testable import DataKit

final public class ReceiptRepositoryTests: XCTestCase {
    public func testSaveAndFetchReceiptsSuccess() async throws {
        let repository = DataRepositoryProvider.makeReceiptRepository(persistenceInMemory: true)
        
        let receipt = Receipt(id: UUID(), name: "test", imageData: Data(count: 1), date: Date(), amount: 50.0, currency: "EUR")
        
        try await repository.save(receipt)
        let fetched = try await repository.getAll()
        
        XCTAssertFalse(fetched.isEmpty, "Fetched receipts should not be empty")
        XCTAssertEqual(fetched.count, 1, "Should have exactly one receipt")
        XCTAssertEqual(fetched.first?.amount, 50.0, "Amount should match saved value")
        XCTAssertEqual(fetched.first?.currency, "EUR", "Currency should match saved value")
    }
    
    public func testSaveAndFetchOneReceiptSuccess() async throws {
        let repository = DataRepositoryProvider.makeReceiptRepository(persistenceInMemory: true)
        
        let id = UUID()
        let receipt1 = Receipt(id: id, name: "test1", imageData: Data(count: 1), date: Date(), amount: 50.0, currency: "EUR")
        let receipt2 = Receipt(id: UUID(), name: "test2", imageData: Data(count: 2), date: Date(), amount: 70.0, currency: "EUR")
        
        try await repository.save(receipt1)
        try await repository.save(receipt2)
        let fetched = try await repository.get(id)
        
        XCTAssertEqual(fetched.amount, 50.0, "Amount should match saved value")
        XCTAssertEqual(fetched.currency, "EUR", "Currency should match saved value")
    }
    
    public func testSaveAndDeleteOneReceiptSuccess() async throws {
        let repository = DataRepositoryProvider.makeReceiptRepository(persistenceInMemory: true)
        
        let id = UUID()
        let receipt1 = Receipt(id: id, name: "test1", imageData: Data(count: 1), date: Date(), amount: 50.0, currency: "EUR")
        let receipt2 = Receipt(id: UUID(), name: "test2", imageData: Data(count: 2), date: Date(), amount: 70.0, currency: "EUR")
        
        try await repository.save(receipt1)
        try await repository.save(receipt2)
        try await repository.delete(id)
        let fetched = try await repository.getAll()
        
        XCTAssertFalse(fetched.isEmpty, "Fetched receipts should not be empty")
        XCTAssertEqual(fetched.count, 1, "Should have exactly one receipt")
        XCTAssertEqual(fetched.first?.amount, 70.0, "Amount should match saved value")
        XCTAssertEqual(fetched.first?.currency, "EUR", "Currency should match saved value")
    }
    
    public func testFetchEmptyRepository() async throws {
        let repository = DataRepositoryProvider.makeReceiptRepository(persistenceInMemory: true)
        let fetched = try await repository.getAll()
        
        XCTAssertTrue(fetched.isEmpty, "Fetched receipts should be empty in a new repository")
    }
}
