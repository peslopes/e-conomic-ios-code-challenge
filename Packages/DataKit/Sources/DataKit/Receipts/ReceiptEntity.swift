import CoreData

final class ReceiptEntity: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var imageData: Data?
    @NSManaged var date: Date?
    @NSManaged var amount: Double
    @NSManaged var currency: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReceiptEntity> {
        return NSFetchRequest<ReceiptEntity>(entityName: "ReceiptEntity")
    }
}
