import SwiftUI

@main
struct MyApp: App {
    private let coordinator: AppCoordinatorProtocol
    
    init() {
        self.coordinator = AppCoordinator()
    }
    
    var body: some Scene {
        WindowGroup {
            UIViewControllerRepresentableWrapper(viewController: coordinator.start())
                .ignoresSafeArea()
        }
    }
}
