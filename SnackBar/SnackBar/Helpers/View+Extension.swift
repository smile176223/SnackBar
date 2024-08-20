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
            SnackBarModifier(isPresented: isPresented, contentView: contentView)
        )
    }
}

// MARK: - Get frame size
extension View {
    func readFrame(in coordinateSpace: CoordinateSpace = .global, for reader: Binding<CGRect>) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: geometry.frame(in: coordinateSpace)
                    )
                    .onPreferenceChange(FramePreferenceKey.self, perform: { value in
                        reader.wrappedValue = value
                    })
            }
        )
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
