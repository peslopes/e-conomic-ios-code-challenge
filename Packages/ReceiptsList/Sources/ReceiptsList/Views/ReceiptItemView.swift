import SwiftUI

struct ReceiptItemView: View {
    private let imageData: Data?
    private let name: String
    private let date: Date
    private let amount: Double
    private let currency: String
    private let dateFormatter: DateFormatter
    
    init(imageData: Data? = nil, name: String = "", date: Date = Date(), amount: Double = 0, currency: String = "") {
        self.imageData = imageData
        self.name = name
        self.date = date
        self.amount = amount
        self.currency = currency
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .medium
    }
    
    var body: some View {
        HStack {
            if let imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
            }
            VStack(alignment: .leading) {
                Text("Name: \(name)")
                Text("Date: \(date, formatter: dateFormatter)")
                Text("Amount: \(String(format: "%.2f", amount)) \(currency)")
            }
        }
    }
}

#Preview {
    ReceiptItemView()
}
