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
        content: @escaping () -> ContentView,
        configure: @escaping (SnackBarParameters) -> SnackBarParameters = { $0 },
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        return self.modifier(
            ContainerModifier(
                isPresented: isPresented,
                contentView: content,
                onDismiss: onDismiss,
                parameters: configure(SnackBarParameters())
            )
        )
    }
}

