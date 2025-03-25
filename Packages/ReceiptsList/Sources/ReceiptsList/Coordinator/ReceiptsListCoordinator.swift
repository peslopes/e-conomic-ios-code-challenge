import UIKit
import SwiftUI
import DataKit

class ReceiptsListCoordinator: ReceiptsListRouterProtocol {
    private let navigationController: UINavigationController
    private let repository: ReceiptRepositoryProtocol
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = DataRepositoryProvider.makeReceiptRepository()
    }
    
    func start() -> UIViewController {
        let viewModel = ReceiptsListViewModel(repository: repository)
        let view = ReceiptsListView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: false)
        return hostingController
    }
}
