import UIKit
import SwiftUI
import ReceiptCapture

class AppCoordinator: AppCoordinatorProtocol {
    private let navigationController: UINavigationController
    private var receiptCoordinator: ReceiptRouterProtocol?
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let rootViewController = makeRootViewController()
        navigationController.setViewControllers([rootViewController], animated: false)
        return navigationController
    }
    
    func showReceiptCapture() {
        let coordinator = ReceiptFeature.coordinator(navigationController: navigationController)
        let viewController = coordinator.start()
        self.receiptCoordinator = coordinator
    }
    
    private func makeRootViewController() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: self)
        let view = HomeView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
