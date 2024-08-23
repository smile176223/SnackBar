//
//  View+Extension.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import SwiftUI

// MARK: - Display SnackBar
public extension View {
    func snackBar<ContentView: View>(
        _ isPresented: Binding<Bool>,
        view: @escaping () -> ContentView,
        onWillDismiss: @escaping () -> Void = {},
        onDismiss: @escaping () -> Void = {},
        configure: @escaping (SnackBarParameters) -> SnackBarParameters = { $0 }
    ) -> some View {
        return self.modifier(
            ContainerModifier(
                isPresented: isPresented,
                contentView: view,
                onWillDismiss: onWillDismiss,
                onDismiss: onDismiss,
                parameters: configure(SnackBarParameters())
            )
        )
    }
}

