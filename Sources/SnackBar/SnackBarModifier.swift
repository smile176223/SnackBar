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

public struct SnackBarModifier<ContentView: View>: ViewModifier {
    
    private var contentView: () -> ContentView
    private var onAnimationComplete: () -> ()
    private var onAppear: () -> ()
    private var onTap: () -> ()
    private var parameters: SnackBarParameters
    private var isVisible: Bool
    private var shouldShowContent: Bool
    private let screenSize: CGSize
    @State private var contentFrame: CGRect = .zero
    @State private var presenterFrame: CGRect = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var currentOffset = CGPoint.outOfScreenPoint
    
    public init(
        contentView: @escaping () -> ContentView,
        onAnimationComplete: @escaping () -> (),
        onAppear: @escaping () -> (),
        onTap: @escaping () -> (),
        parameters: SnackBarParameters,
        isVisible: Bool,
        shouldShowContent: Bool,
        screenSize: CGSize = UIApplication.screenSize
    ) {
        self.contentView = contentView
        self.onAnimationComplete = onAnimationComplete
        self.onAppear = onAppear
        self.onTap = onTap
        self.parameters = parameters
        self.isVisible = isVisible
        self.shouldShowContent = shouldShowContent
        self.screenSize = screenSize
    }
    
    private var displayOffsetY: CGFloat {
        switch parameters.position {
        case .top:
            return parameters.padding
        case .bottom:
            return presenterFrame.height - contentFrame.height - parameters.padding
        }
    }
    
    private var displayOffsetX: CGFloat {
        return (presenterFrame.width - contentFrame.width) / 2
    }
    
    private var hiddenOffset: CGPoint {
        if contentFrame.isEmpty {
            return CGPoint.outOfScreenPoint
        }
        
        switch parameters.position {
        case .top:
            return CGPoint(
                x: displayOffsetX,
                y: -presenterFrame.minY - safeAreaInsets.top - contentFrame.height
            )
        case .bottom:
            return CGPoint(
                x: displayOffsetX,
                y: screenSize.height
            )
        }
    }
    
    private var snackBarPosition: CGPoint {
        CGPoint(
            x: contentFrame.width / 2 + currentOffset.x,
            y: contentFrame.height / 2 + currentOffset.y
        )
    }
    
    public func body(content: Content) -> some View {
        content
            .readFrame($presenterFrame)
            .readSafeArea($safeAreaInsets)
            .overlay(
                Group {
                    if isVisible, presenterFrame != .zero {
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
                    .addTapGesture(onTap: onTap)
            }
            .readFrame($contentFrame)
            .position(snackBarPosition)
            .onChange(of: shouldShowContent, perform: moveWithAnimation)
            .onAppear(perform: onAppear)
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
                withAnimation(parameters.animation) {
                    moveOffset(value)
                } completion: {
                    onAnimationComplete()
                }
            }
        } else {
            DispatchQueue.main.async {
                withAnimation(parameters.animation) {
                    moveOffset(value)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                onAnimationComplete()
            }
        }
    }
    
    private func moveOffset(_ value: Bool) {
        currentOffset = value ? CGPoint(x: displayOffsetX, y: displayOffsetY) : hiddenOffset
    }
}

extension View {
    
    @ViewBuilder
    func addTapGesture(onTap: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            TapGesture().onEnded {
                onTap()
            }
        )
    }
}

