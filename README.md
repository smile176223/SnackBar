# SnackBar

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/cocoapods/l/LFAlertController.svg?style=flat)](https://opensource.org/licenses/MIT)

A SwiftUI library designed to display a snack bar.

## Features

- [x] Display `SnackBar`
- [X] Customizable design
- [X] Handle tap events
- [X] Handle device rotate events
- [ ] Handle drag events

## Requirements

- iOS 15

## Installation

### Swift Package Manager (SPM)

```swift
dependencies: [
    .package(url: "https://github.com/smile176223/SnackBar.git")
]
```
## How to use
```swift
Strcut YourView: View {

    @State var isPresented: Bool = false

    var body: some View {
        View()
            .snackBar($isPresented, view: {
                // Custom Content View
                ContentView()
            }, configure: {
                // Custom configure
                $0.position(.bottom)
            })
    }
}
```
