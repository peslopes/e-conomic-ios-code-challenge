import Foundation

class HomeViewModel: ObservableObject {
    private let coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol = AppCoordinator()) {
        self.coordinator = coordinator
    }
    
    func showReceiptCapture() {
        coordinator.showReceiptCapture()
    }
    
    func showReceiptsList() {
        coordinator.showReceiptsList()
    }
}
