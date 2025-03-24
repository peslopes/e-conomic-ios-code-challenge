import Foundation

public struct Receipt {
    public let id: UUID
    public let imageData: Data
    public let date: Date
    public let amount: Double
    public let currency: String
}
