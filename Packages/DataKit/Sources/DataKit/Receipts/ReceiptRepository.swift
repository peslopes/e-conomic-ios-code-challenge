import CoreData

class ReceiptRepository: ReceiptRepositoryProtocol {
    private let persistenceController: PersistenceController
    private let modelFactory = ReceiptModelFactory()
    private let backgroundContext: NSManagedObjectContext
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
        
        backgroundContext = persistenceController.persistentContainer.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
    }
    
    func getAll() async throws -> [Receipt] {
        let context = backgroundContext
        return try await context.perform {
            let request = ReceiptEntity.fetchRequest()
            let entities = try context.fetch(request)
            return try entities.compactMap { [weak self] entity in
                try self?.modelFactory.makeModel(fromDataModel: entity)
            }
        }
    }
    
    func get(_ id: UUID) async throws -> Receipt {
        guard let receipt = try await getAll().first(where: { $0.id == id }) else {
            throw DataError.getDataFailed
        }
        return receipt
    }
    
    func save(_ model: Receipt) async throws {
        let context = backgroundContext
        try await context.perform { [weak self] in
            try self?.modelFactory.makeDataModel(fromModel: model, context: context)
            try context.save()
        }
    }
    
    func delete(_ id: UUID) async throws {
        let context = backgroundContext
        try await context.perform {
            let request = ReceiptEntity.fetchRequest()
            let entities = try context.fetch(request)
            
            if let entityToDelete = entities.first(where: { $0.id == id }) {
                context.delete(entityToDelete)
            }
            try context.save()
        }
    }
}
