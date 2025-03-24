import UIKit
import SwiftUI
import DataKit

class ReceiptCoordinator: @preconcurrency ReceiptRouterProtocol {
    private let navigationController: UINavigationController
    private let repository: ReceiptRepositoryProtocol
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = DataRepositoryProvider.makeReceiptRepository()
    }
    
    @MainActor
    func start() -> UIViewController {
        let viewModel = ReceiptCaptureViewModel(repository: repository, coordinator: self)
        let view = ReceiptCaptureView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: false)
        return hostingController
    }
    
    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
}
