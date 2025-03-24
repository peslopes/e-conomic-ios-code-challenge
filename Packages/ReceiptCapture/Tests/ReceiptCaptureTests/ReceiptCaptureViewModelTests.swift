import XCTest
import SwiftUI
import PhotosUI
@testable import ReceiptCapture

@MainActor
final class ReceiptCaptureViewModelTests: XCTestCase {
    private var viewModel: ReceiptCaptureViewModel!
    private var mockRepository: MockReceiptRepository!
    private var mockRouter: MockReceiptRouter!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockReceiptRepository()
        mockRouter = MockReceiptRouter()
        viewModel = ReceiptCaptureViewModel(repository: mockRepository, coordinator: mockRouter)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testSaveReceiptSuccess() async {
        viewModel.receiptImageData = Data()
        viewModel.date = Date()
        viewModel.currency = "USD"
        viewModel.amount = 100.0
        
        await viewModel.saveReceipt()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(viewModel.errorDescription)
        XCTAssertNotNil(mockRepository.savedReceipt)
        XCTAssertTrue(mockRouter.dismissCalled)
    }
    
    func testSaveReceiptMissingData() async {
        viewModel.receiptImageData = nil
        viewModel.date = Date()
        viewModel.currency = "USD"
        viewModel.amount = 100.0
        
        await viewModel.saveReceipt()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(viewModel.errorDescription)
        XCTAssertNil(mockRepository.savedReceipt)
        XCTAssertFalse(mockRouter.dismissCalled)
    }
    
    func testSaveReceiptFailure() async {
        mockRepository.shouldThrowError = true
        viewModel.receiptImageData = Data()
        viewModel.date = Date()
        viewModel.currency = "USD"
        viewModel.amount = 100.0
        
        await viewModel.saveReceipt()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertEqual(viewModel.errorDescription, "Failed to save receipt")
        XCTAssertNil(mockRepository.savedReceipt)
        XCTAssertFalse(mockRouter.dismissCalled)
    }
}
