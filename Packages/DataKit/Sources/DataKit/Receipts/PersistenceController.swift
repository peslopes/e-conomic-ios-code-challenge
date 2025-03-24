import CoreData
import CoreDataModelDescription

struct PersistenceController {
    static let shared = PersistenceController()
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        let modelDescription = CoreDataModelDescription(
            entities: [
                .entity(
                    name: "ReceiptEntity",
                    managedObjectClass: ReceiptEntity.self,
                    attributes: [
                        .attribute(name: "id", type: .UUIDAttributeType, isOptional: true),
                        .attribute(name: "imageData", type: .binaryDataAttributeType, isOptional: true),
                        .attribute(name: "date", type: .dateAttributeType, isOptional: true),
                        .attribute(name: "amount", type: .doubleAttributeType, isOptional: false),
                        .attribute(name: "currency", type: .stringAttributeType, isOptional: true)
                    ]
                )
            ]
        )
        
        let model = modelDescription.makeModel()
        persistentContainer = NSPersistentContainer(name: "ReceiptsModel", managedObjectModel: model)
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
