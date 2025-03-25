import UIKit

public struct ReceiptCaptureFeature {
    public static func coordinator(navigationController: UINavigationController) -> ReceiptCaptureRouterProtocol {
        return ReceiptCaptureCoordinator(navigationController: navigationController)
    }
}
