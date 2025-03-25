import XCTest
import DataKit
@testable import ReceiptsList

@MainActor
final class ReceiptsListViewModelTests: XCTestCase {
    private var viewModel: ReceiptsListViewModel!
    private var mockRepository: MockReceiptRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockReceiptRepository()
        viewModel = ReceiptsListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchReceiptsSuccess() {
        let expectation = XCTestExpectation(description: "Receipts should be fetched")
        let mockReceipt = Receipt(id: UUID(), name: "Test", imageData: Data(), date: Date(), amount: 100.0, currency: "USD")
        mockRepository.mockReceipts = [mockReceipt]
        
        viewModel.fetchReceipts()
        
        let cancellable = viewModel.$receipts
            .dropFirst()
            .sink { receipts in
                XCTAssertEqual(receipts.count, 1)
                XCTAssertEqual(receipts.first?.id, mockReceipt.id)
                XCTAssertNil(self.viewModel.errorDescription)
                expectation.fulfill()
            }
        
        XCTAssertTrue(viewModel.isLoading)
        
        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
    
    func testFetchReceiptsFailure() {
        let expectation = XCTestExpectation(description: "Error should be set")
        mockRepository.shouldThrowError = true
        
        viewModel.fetchReceipts()
        
        let cancellable = viewModel.$errorDescription
            .dropFirst()
            .sink { error in
                XCTAssertTrue(self.viewModel.receipts.isEmpty)
                XCTAssertEqual(error, "Failed to fetch receipts")
                expectation.fulfill()
            }
        
        XCTAssertTrue(viewModel.isLoading)
        
        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
}
