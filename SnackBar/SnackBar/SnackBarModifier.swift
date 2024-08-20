//
//  SnackBarModifier.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import Foundation
import SwiftUI

public struct SnackBarModifier<ContentView: View>: ViewModifier {
    
    @Binding private var isPresented: Bool
    var contentView: () -> ContentView
    
    @State private var contentFrame: CGRect = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    
    @State private var currentOffset = CGPoint(x: UIScreen.main.bounds.width * 2, y: UIScreen.main.bounds.height * 2)
    
    private var displayOffsetY: CGFloat {
        UIScreen.main.bounds.height
        - contentFrame.height
        - safeAreaInsets.bottom
    }
    
    private var displayOffsetX: CGFloat {
        (UIScreen.main.bounds.width - contentFrame.width) / 2
    }
    
    public init(isPresented: Binding<Bool>, contentView: @escaping () -> ContentView) {
        _isPresented = isPresented
        self.contentView = contentView
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            Color.clear
                .overlay(
                    Group {
                        if isPresented {
                            contentView()
                                .onChange(of: isPresented) { _ in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        isPresented = false
                                    }
                                }
                                .readFrame(for: $contentFrame)
                                .position(
                                    x: contentFrame.width / 2 + currentOffset.x,
                                    y: contentFrame.height / 2 + currentOffset.y
                                )
                                .onChange(of: isPresented) { newValue in
                                    
                                    DispatchQueue.main.async {
                                        withAnimation(.easeOut(duration: 0.3)) {
                                            currentOffset = CGPointMake(displayOffsetX, displayOffsetY)
                                        }
                                    }
                                }
                        }
                    }
                )
        }
    }
}
