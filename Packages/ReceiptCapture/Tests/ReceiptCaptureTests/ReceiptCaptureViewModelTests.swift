import XCTest
import SwiftUI
import PhotosUI
@testable import ReceiptCapture

@MainActor
final class ReceiptCaptureViewModelTests: XCTestCase {
    private var viewModel: ReceiptCaptureViewModel!
    private var mockRepository: MockReceiptRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockReceiptRepository()
        viewModel = ReceiptCaptureViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testSaveReceiptSuccess() async {
        viewModel.receiptImageData = Data()
        viewModel.name = "Test"
        viewModel.date = Date()
        viewModel.currency = "USD"
        viewModel.amount = 100.0
        
        viewModel.saveReceipt()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(viewModel.errorDescription)
        XCTAssertNotNil(mockRepository.savedReceipt)
    }
    
    func testSaveReceiptMissingData() async {
        viewModel.receiptImageData = nil
        viewModel.name = "Test"
        viewModel.date = Date()
        viewModel.currency = "USD"
        viewModel.amount = 100.0
        
        viewModel.saveReceipt()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(viewModel.errorDescription)
        XCTAssertNil(mockRepository.savedReceipt)
    }
    
    func testSaveReceiptFailure() async {
        mockRepository.shouldThrowError = true
        viewModel.receiptImageData = Data()
        viewModel.name = "Test"
        viewModel.date = Date()
        viewModel.currency = "USD"
        viewModel.amount = 100.0
        
       viewModel.saveReceipt()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertEqual(viewModel.errorDescription, "Failed to save receipt")
        XCTAssertNil(mockRepository.savedReceipt)
    }
}
