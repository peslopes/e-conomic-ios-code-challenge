import Foundation

public protocol ReceiptRepositoryProtocol {
    func getAll() async throws -> [Receipt]
    func get(_ id: UUID) async throws -> Receipt
    func save(_ model: Receipt) async throws
    func delete(_ id: UUID) async throws
}
