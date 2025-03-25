import PhotosUI
import SwiftUI
import Foundation

protocol ReceiptCaptureViewModelProtocol: ObservableObject {
    var receiptImageData: Data? { get set }
    var name: String { get set }
    var date: Date { get set }
    var amount: Double { get set }
    var currency: String { get set }
    var errorDescription: String? { get set }
    var photoPickerItem: PhotosPickerItem? { get set }
    var isSaving: Bool { get set }
    var isSuccessfullySaved: Bool { get set }
    
    func saveReceipt()
}
