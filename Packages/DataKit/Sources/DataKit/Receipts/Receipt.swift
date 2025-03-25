import Foundation

public struct Receipt {
    public let id: UUID
    public let name: String
    public let imageData: Data
    public let date: Date
    public let amount: Double
    public let currency: String
    
    public init(
        id: UUID = UUID(),
        name: String,
        imageData: Data,
        date: Date,
        amount: Double,
        currency: String
    ) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.date = date
        self.amount = amount
        self.currency = currency
    }
}
