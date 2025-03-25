import UIKit
import SwiftUI
import ReceiptCapture
import ReceiptsList

class AppCoordinator: AppCoordinatorProtocol {
    private let navigationController: UINavigationController
    private var receiptCaptureCoordinator: ReceiptCaptureRouterProtocol?
    private var receiptsListCoordinator: ReceiptsListRouterProtocol?
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let rootViewController = makeRootViewController()
        navigationController.setViewControllers([rootViewController], animated: false)
        return navigationController
    }
    
    func showReceiptCapture() {
        let coordinator = ReceiptCaptureFeature.coordinator(navigationController: navigationController)
        let _ = coordinator.start()
        self.receiptCaptureCoordinator = coordinator
    }
    
    func showReceiptsList() {
        let coordinator = ReceiptListFeature.coordinator(navigationController: navigationController)
        let _ = coordinator.start()
        self.receiptsListCoordinator = coordinator
    }
    
    private func makeRootViewController() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: self)
        let view = HomeView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
