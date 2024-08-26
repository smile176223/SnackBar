//
//  ContainerModifier.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import SwiftUI

public struct ContainerModifier<ContentView: View>: ViewModifier {
    
    @Binding private var isPresented: Bool
    private var contentView: () -> ContentView
    private var onDismiss: () -> ()
    private let parameters: SnackBarParameters
    
    @State private var shouldShowContent = false
    @State private var isSnackBarVisible = false
    
    private let snackBarQueue = DispatchQueue(label: "snackBarQueue", qos: .utility)
    private var snackBarSemaphore = DispatchSemaphore(value: 1)
    private var debouncedWorkItem = DispatchWorkItemHolder()
    
    public init(
        isPresented: Binding<Bool>,
        contentView: @escaping () -> ContentView,
        onDismiss: @escaping () -> (),
        parameters: SnackBarParameters
    ) {
        _isPresented = isPresented
        self.contentView = contentView
        self.onDismiss = onDismiss
        self.parameters = parameters
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isSnackBarVisible {
                Color.clear
                    .modifier(snackBarModifier())
            }
        }
        .onChange(of: isPresented, perform: handlePresentationChange)
    }
    
    private func snackBarModifier() -> SnackBarModifier<ContentView> {
        SnackBarModifier(
            contentView: contentView,
            onAnimationComplete: handleAnimationComplete,
            onAppear: handleSnackBarAppear,
            parameters: parameters,
            isVisible: isSnackBarVisible,
            shouldShowContent: shouldShowContent
        )
    }
    
    private func handlePresentationChange(_ isPresented: Bool) {
        snackBarQueue.async {
            snackBarSemaphore.wait()
            
            if isPresented {
                presentSnackBar()
            } else {
                dismissSnackBar()
            }
        }
    }
    
    private func presentSnackBar() {
        isSnackBarVisible = true
    }
    
    private func dismissSnackBar() {
        debouncedWorkItem.work?.cancel()
        shouldShowContent = false
    }
    
    private func handleSnackBarAppear() {
        shouldShowContent = true
        debouncedWorkItem.work?.cancel()
        debouncedWorkItem.work = DispatchWorkItem(block: {
            isPresented = false
            debouncedWorkItem.work = nil
        })
        
        if isPresented, let work = debouncedWorkItem.work {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: work)
        }
    }
    
    private func handleAnimationComplete() {
        guard !shouldShowContent else {
            snackBarSemaphore.signal()
            return
        }
        
        isSnackBarVisible = false
        onDismiss()
        snackBarSemaphore.signal()
    }
}
