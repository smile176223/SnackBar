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
        contentView: @escaping () -> ContentView
    ) -> some View {
        self.modifier(
            ContainerModifier(
                isPresented: isPresented,
                contentView: contentView,
                onWillDismiss: {},
                onDismiss: {}
            )
        )
    }
}

