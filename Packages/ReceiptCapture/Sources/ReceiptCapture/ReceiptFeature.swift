import UIKit

public struct ReceiptFeature {
    public static func coordinator(navigationController: UINavigationController) -> ReceiptRouterProtocol {
        return ReceiptCoordinator(navigationController: navigationController)
    }
}
