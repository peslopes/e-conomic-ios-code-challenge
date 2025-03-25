import UIKit

public struct ReceiptListFeature {
    public static func coordinator(navigationController: UINavigationController) -> ReceiptsListRouterProtocol {
        return ReceiptsListCoordinator(navigationController: navigationController)
    }
}
