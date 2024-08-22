//
//  FrameReader.swift
//  SnackBar
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI

extension View {
    func readFrame(
        in coordinateSpace: CoordinateSpace = .global,
        for reader: Binding<CGRect>
    ) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: proxy.frame(in: coordinateSpace)
                    )
                    .onPreferenceChange(FramePreferenceKey.self) { value in
                        reader.wrappedValue = value
                    }
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
