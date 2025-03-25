# e-conomic-ios-code-challenge

## Overview

ReceiptsApp is an iOS application developed in SwiftUI for capturing, saving, and listing receipts. Users can take photos of receipts, input details such as date, amount, and currency, and view a list of saved receipts. The project is organized into modular packages to enhance maintainability and scalability.

## Features
### Receipt Capture

- Take a photo of a receipt or select an image from the gallery.
- Enter details like name, date, amount, and currency.

### Receipt List
- Displays a list of saved receipts with image, name, date, and formatted amount.

### Testing
- Unit test for the ReceiptsList, ReceiptCapture and DataKit packages.

## Project Structure
### App layer (ReceiptsApp)
- The main application that integrates the packages and initializes the AppCoordinator.

### Feature layer (ReceiptCapture, ReceiptList)
- Contains the Views, ViewModels and Coordinator for each feature

### Data layer (DataKit)
- Contains the Receipt model and connects to Core Data
- Used by both ReceiptsList and ReceiptCapture to ensure consistency in data structures.

## Architecture
- MVVM-C (Model-View-ViewModel-Coordinator): Separates presentation logic from the user interface.
- Modularity: Separate packages for better maintainability and reusability.
- Async/Await: Used for asynchronous operations like saving and fetching receipts.
- SwiftUI: Used for building the user interface.

## Requirements
- Xcode: version 16.0 or later
- ios: 17.0 or later
- Swift: 5.9 or later

## Setup Instructions
1. Clone the repository
   ```bash
   git clone https://github.com/peslopes/e-conomic-ios-code-challenge.git
   cd e-conomic-ios-code-challenge
   cd ReceiptsApp
    ```
2. Open the Project in Xcode
3. Build and Run `Cmd + R`

## Running Tests
1. Use the test navigator in Xcode to run specific test suites:
  - ReceiptsListTests: Tests for the ReceiptsList package.
  - ReceiptCaptureTests: Tests for the ReceiptCapture package.
  - AppLayerTests: Integration tests for the AppLayer package.
  - DataKitTests (if applicable): Tests for the DataKit package.
