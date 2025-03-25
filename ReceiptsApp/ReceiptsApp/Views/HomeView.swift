import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
        
    public init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Text("Welcome to Receipts Manager")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                viewModel.showReceiptCapture()
            }, label: {
                Text("Capture Receipt")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
            })
            
            Button(action: {
                viewModel.showReceiptsList()
            }, label: {
                Text("View Receipts")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
            })
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
