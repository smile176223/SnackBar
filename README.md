# <img src="https://github.com/smile176223/SnackBar/blob/develop/Resources/Snackbar-icon.png" width="38"> SnackBar

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platform-iOS-lightgray)](https://developer.apple.com/swift)
[![License](https://img.shields.io/cocoapods/l/LFAlertController.svg?style=flat)](https://opensource.org/licenses/MIT)

A SwiftUI library designed to display a snack bar.

<img src="https://github.com/smile176223/SnackBar/blob/develop/Resources/demo02.gif" width="300" height="300"> <img src="https://github.com/smile176223/SnackBar/blob/develop/Resources/demo01.gif" width="300" height="300">

## Features

- [x] Display `SnackBar`
- [X] Customizable design
- [X] Handle tap events
- [X] Handle device rotate events
- [X] Handle drag events

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
struct YourView: View {

    @State var isPresented: Bool = false

    var body: some View {
        View()
            .snackBar($isPresented, content: {
                // Custom content view
                ContentView()
            }, configure: {
                // Custom configure
                $0.position(.bottom)
            })
    }
}
```
