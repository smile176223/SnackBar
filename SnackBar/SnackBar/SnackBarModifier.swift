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
    
    var contentView: () -> ContentView
    
    var animationCompletedCallback: () -> ()
    var positionIsCalculatedCallback: () -> ()
    var showContent: Bool
    var shouldShowContent: Bool
    private var useSafeAreaInset: Bool = true
    private var verticalPadding: CGFloat = 10
    private let screenSize: CGSize
    @State private var contentFrame: CGRect = .zero
    @State private var presenterFrame: CGRect = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var currentOffset = CGPoint.outOfScreenPoint
    
    public init(
        contentView: @escaping () -> ContentView,
        animationCompletedCallback: @escaping () -> (),
        positionIsCalculatedCallback: @escaping () -> (),
        showContent: Bool,
        shouldShowContent: Bool,
        screenSize: CGSize = UIApplication.screenSize
    ) {
        self.contentView = contentView
        self.animationCompletedCallback = animationCompletedCallback
        self.positionIsCalculatedCallback = positionIsCalculatedCallback
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
    
    private var targetCurrentOffset: CGPoint {
        shouldShowContent ? CGPoint(x: displayOffsetX, y: displayOffsetY) : hiddenOffset
    }
    
    private var hiddenOffset: CGPoint {
        if contentFrame.isEmpty {
            return CGPoint.outOfScreenPoint
        }

        return CGPoint(x: displayOffsetX, y: screenSize.height)
    }
    
    public func body(content: Content) -> some View {
        content
            .readFrame(for: $presenterFrame)
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
        if #available(iOS 17.0, *) {
            ZStack {
                VStack {
                    contentView()
                }
                .readFrame(for: $contentFrame)
                .position(x: contentFrame.width / 2 + currentOffset.x, y: contentFrame.height / 2 + currentOffset.y)
                .onChange(of: shouldShowContent) { newValue in
                    if currentOffset == CGPoint.outOfScreenPoint {
                        DispatchQueue.main.async {
                            currentOffset = hiddenOffset
                        }
                    }
                    
                    DispatchQueue.main.async {
                        withAnimation(.spring()) {
                            changeParamsWithAnimation(newValue)
                        } completion: {
                            animationCompletedCallback()
                        }
                    }
                }
                .onChange(of: contentFrame.size) { _ in
                    positionIsCalculatedCallback()
                }
            }
        } else {
            ZStack {
                VStack {
                    contentView()
                }
                .readFrame(for: $contentFrame)
                .position(x: contentFrame.width / 2 + currentOffset.x, y: contentFrame.height / 2 + currentOffset.y)
                .onChange(of: targetCurrentOffset) { newValue in
                    if !shouldShowContent, newValue == hiddenOffset { // don't animate initial positioning outside the screen
                        currentOffset = newValue
                    } else {
                        withAnimation(.spring()) {
                            currentOffset = newValue
                        }
                    }
                }
                .onChange(of: contentFrame.size) { _ in
                    positionIsCalculatedCallback()
                }
            }
        }
    }
    
    func changeParamsWithAnimation(_ isDisplayAnimation: Bool) {
        self.currentOffset = isDisplayAnimation ? CGPointMake(displayOffsetX, displayOffsetY) : hiddenOffset
    }
}
