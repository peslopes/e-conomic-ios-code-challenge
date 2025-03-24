import CoreData

protocol ModelFactoryProtocol {
    associatedtype Model
    associatedtype DataModel
    
    func makeModel(fromDataModel dataModel: DataModel) throws -> Model
    func makeDataModel(fromModel model: Model, context: NSManagedObjectContext) throws
}
