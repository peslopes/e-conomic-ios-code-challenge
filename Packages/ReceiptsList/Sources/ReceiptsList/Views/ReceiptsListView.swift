import SwiftUI

struct ReceiptsListView<ViewModel: ReceiptsListViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let error = viewModel.errorDescription {
                Text(error)
                    .foregroundStyle(Color.red)
                    .padding()
            } else if viewModel.receipts.isEmpty && !viewModel.isLoading {
                Text("No receipts found")
                    .foregroundStyle(Color.gray)
                    .padding()
            } else if viewModel.isLoading {
                placeholderLoading
            } else {
                List(viewModel.receipts, id: \.id) { receipt in
                    ReceiptItemView(
                        imageData: receipt.imageData,
                        name: receipt.name,
                        date: receipt.date,
                        amount: receipt.amount,
                        currency: receipt.currency
                    )
                }
            }
        }
        .onAppear {
            viewModel.fetchReceipts()
        }
    }
    
    var placeholderLoading: some View {
        VStack {
            ForEach(0..<5) { _ in
                ReceiptItemView()
                    .redacted(reason: .placeholder)
            }
        }
    }
}

#Preview {
    ReceiptsListView(viewModel: ReceiptsListViewModel())
}
