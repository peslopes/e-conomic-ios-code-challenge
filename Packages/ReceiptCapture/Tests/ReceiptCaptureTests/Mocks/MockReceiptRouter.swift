import Foundation
import UIKit
@testable import ReceiptCapture

class MockReceiptRouter: ReceiptRouterProtocol {
    var dismissCalled = false
    
    func dismiss() {
        dismissCalled = true
    }
    
    func start() -> UIViewController {
        UIViewController()
    }
}
