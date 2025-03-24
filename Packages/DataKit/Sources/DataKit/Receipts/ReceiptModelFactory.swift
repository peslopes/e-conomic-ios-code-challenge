import CoreData

class ReceiptModelFactory: ModelFactoryProtocol {
    typealias Model = Receipt
    typealias DataModel = ReceiptEntity
    
    func makeModel(fromDataModel dataModel: DataModel) throws -> Model {
        guard let id = dataModel.id,
              let imageData = dataModel.imageData,
              let date = dataModel.date,
              let currency = dataModel.currency else {
            throw DataError.makeModelFailed
        }
        return Receipt(
            id: id,
            imageData: imageData,
            date: date,
            amount: dataModel.amount,
            currency: currency
        )
    }
    
    func makeDataModel(fromModel model: Model, context: NSManagedObjectContext) throws {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "ReceiptEntity", in: context) else {
            throw DataError.makeDataModelFailed
        }
        let entity = ReceiptEntity(entity: entityDescription, insertInto: context)
        entity.setValuesForKeys([
            "id": model.id,
            "imageData": model.imageData,
            "date": model.date,
            "amount": model.amount,
            "currency": model.currency
        ])
    }
}
