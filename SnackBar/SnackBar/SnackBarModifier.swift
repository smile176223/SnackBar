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
    @State private var contentFrame: CGRect = .zero
    @State private var presenterFrame: CGRect = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var actualCurrentOffset = CGPoint.pointFarAwayFromScreen
    
    public init(
        contentView: @escaping () -> ContentView,
        animationCompletedCallback: @escaping () -> (),
        positionIsCalculatedCallback: @escaping () -> (),
        showContent: Bool,
        shouldShowContent: Bool
    ) {
        self.contentView = contentView
        self.animationCompletedCallback = animationCompletedCallback
        self.positionIsCalculatedCallback = positionIsCalculatedCallback
        self.showContent = showContent
        self.shouldShowContent = shouldShowContent
    }
    
    private var screenSize: CGSize {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap { scene -> UIWindow? in
                (scene as? UIWindowScene)?.keyWindow
            }
            .first?
            .frame
            .size ?? .zero
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
            return CGPoint.pointFarAwayFromScreen
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
                .position(x: contentFrame.width / 2 + actualCurrentOffset.x, y: contentFrame.height / 2 + actualCurrentOffset.y)
                .onChange(of: shouldShowContent) { newValue in
                    if actualCurrentOffset == CGPoint.pointFarAwayFromScreen {
                        DispatchQueue.main.async {
                            actualCurrentOffset = hiddenOffset
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
                .position(x: contentFrame.width / 2 + actualCurrentOffset.x, y: contentFrame.height / 2 + actualCurrentOffset.y)
                .onChange(of: targetCurrentOffset) { newValue in
                    if !shouldShowContent, newValue == hiddenOffset { // don't animate initial positioning outside the screen
                        actualCurrentOffset = newValue
                    } else {
                        withAnimation(.spring()) {
                            actualCurrentOffset = newValue
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
        self.actualCurrentOffset = isDisplayAnimation ? CGPointMake(displayOffsetX, displayOffsetY) : hiddenOffset
    }
}

extension CGPoint {
    static var pointFarAwayFromScreen: CGPoint {
        CGPoint(x: UIScreen.main.bounds.width * 2, y: UIScreen.main.bounds.height * 2)
    }
}
