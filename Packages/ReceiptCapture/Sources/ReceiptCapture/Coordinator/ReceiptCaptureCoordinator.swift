import UIKit
import SwiftUI
import DataKit

class ReceiptCaptureCoordinator: @preconcurrency ReceiptCaptureRouterProtocol {
    private let navigationController: UINavigationController
    private let repository: ReceiptRepositoryProtocol
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = DataRepositoryProvider.makeReceiptRepository()
    }
    
    @MainActor
    func start() -> UIViewController {
        let viewModel = ReceiptCaptureViewModel(repository: repository)
        let view = ReceiptCaptureView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: false)
        return hostingController
    }
}
