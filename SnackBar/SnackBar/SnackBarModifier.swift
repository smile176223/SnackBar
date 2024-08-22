//
//  SnackBarModifier.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import Foundation
import SwiftUI

// TODO: 1. Keyboard
// TODO: 2. Orientation
// TODO: 3. Tap to dismiss

public struct SnackBarModifier<ContentView: View>: ViewModifier {
    
    private var contentView: () -> ContentView
    private var onAnimationComplete: () -> ()
    private var onPositionChanged: () -> ()
    private var showContent: Bool
    private var shouldShowContent: Bool
    private var useSafeAreaInset: Bool = true
    private var verticalPadding: CGFloat = 10
    private let screenSize: CGSize
    @State private var contentFrame: CGRect = .zero
    @State private var presenterFrame: CGRect = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var currentOffset = CGPoint.outOfScreenPoint
    
    public init(
        contentView: @escaping () -> ContentView,
        onAnimationComplete: @escaping () -> (),
        onPositionChanged: @escaping () -> (),
        showContent: Bool,
        shouldShowContent: Bool,
        screenSize: CGSize = UIApplication.screenSize
    ) {
        self.contentView = contentView
        self.onAnimationComplete = onAnimationComplete
        self.onPositionChanged = onPositionChanged
        self.showContent = showContent
        self.shouldShowContent = shouldShowContent
        self.screenSize = screenSize
    }
    
    private var displayOffsetY: CGFloat {
        presenterFrame.height
        - contentFrame.height
        - verticalPadding
        + safeAreaInsets.bottom
        - (useSafeAreaInset ? safeAreaInsets.bottom : 0)
    }
    
    private var displayOffsetX: CGFloat {
        return (presenterFrame.width - contentFrame.width) / 2
    }
    
    private var hiddenOffset: CGPoint {
        if contentFrame.isEmpty {
            return CGPoint.outOfScreenPoint
        }
        
        return CGPoint(x: displayOffsetX, y: screenSize.height)
    }
    
    public func body(content: Content) -> some View {
        content
            .readFrame($presenterFrame)
            .readSafeArea($safeAreaInsets)
            .overlay(
                Group {
                    if showContent, presenterFrame != .zero {
                        snackBar()
                    }
                }
            )
    }
    
    @ViewBuilder
    private func snackBar() -> some View {
        ZStack {
            VStack {
                contentView()
            }
            .readFrame($contentFrame)
            .position(x: contentFrame.width / 2 + currentOffset.x, y: contentFrame.height / 2 + currentOffset.y)
            .onChange(of: shouldShowContent, perform: moveWithAnimation)
            .onChange(of: contentFrame.size) { _ in onPositionChanged() }
        }
    }
    
    private func moveWithAnimation(_ value: Bool) {
        if currentOffset == CGPoint.outOfScreenPoint {
            DispatchQueue.main.async {
                currentOffset = hiddenOffset
            }
        }
        
        if #available(iOS 17.0, *) {
            DispatchQueue.main.async {
                withAnimation(.spring()) {
                    moveOffset(value)
                } completion: {
                    onAnimationComplete()
                }
            }
        } else {
            DispatchQueue.main.async {
                withAnimation(.spring()) {
                    moveOffset(value)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                onAnimationComplete()
            }
        }
    }
    
    private func moveOffset(_ value: Bool) {
        currentOffset = value ? CGPointMake(displayOffsetX, displayOffsetY) : hiddenOffset
    }
}
