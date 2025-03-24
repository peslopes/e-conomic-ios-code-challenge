public struct DataRepositoryProvider {
    public static func makeReceiptRepository(persistenceInMemory: Bool = false) -> ReceiptRepositoryProtocol {
        let persistenceController = persistenceInMemory ? PersistenceController(inMemory: true) : PersistenceController.shared
        return DataKit.ReceiptRepository(persistenceController: persistenceController)
    }
}
