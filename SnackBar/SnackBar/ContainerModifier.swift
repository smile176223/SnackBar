//
//  ContainerModifier.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import SwiftUI

public struct ContainerModifier<ContentView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var contentView: () -> ContentView
    
    @State private var shouldShowContent = false
    @State private var showContent: Bool = false
    @State private var closingIsInProcess = false
    var onWillDismiss: () -> ()
    var onDismiss: () -> ()
    
    private let snackBarQueue = DispatchQueue(label: "snackBarQueue", qos: .utility)
    @State private var snackBarSemaphore = DispatchSemaphore(value: 1)
    @State private var debouncedWorkItem = DispatchWorkItemHolder()
    private var isPresentedRef: ClassReference<Binding<Bool>>?
    
    public init(
        isPresented: Binding<Bool>,
        contentView: @escaping () -> ContentView,
        onWillDismiss: @escaping () -> (),
        onDismiss: @escaping () -> ()
    ) {
        _isPresented = isPresented
        self.contentView = contentView
        self.onDismiss = onDismiss
        self.onWillDismiss = onWillDismiss
        self.isPresentedRef = ClassReference(isPresented)
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if showContent {
                Color.clear
                    .modifier(snackBarModifier())
            }
        }
        .onChange(of: isPresented) { newValue in
            snackBarQueue.async {
                snackBarSemaphore.wait()
                closingIsInProcess = !newValue
                appearAction(newValue)
            }
        }
        .onAppear {
            if isPresented {
                appearAction(true)
            }
        }
    }
    
    private func snackBarModifier() -> SnackBarModifier<ContentView> {
        SnackBarModifier(
            contentView: contentView,
            onAnimationComplete: onAnimationCompleted,
            onPositionChanged: {
                if !closingIsInProcess {
                    DispatchQueue.main.async {
                        shouldShowContent = true
                    }
                    
                    debouncedWorkItem.work?.cancel()

                    debouncedWorkItem.work = DispatchWorkItem(block: { [weak isPresentedRef] in
                        isPresentedRef?.value.wrappedValue = false
                        debouncedWorkItem.work = nil
                    })
                    if isPresented, let work = debouncedWorkItem.work {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: work)
                    }
                }
            },
            showContent: showContent,
            shouldShowContent: shouldShowContent
        )
    }
    
    private func appearAction(_ isPresented: Bool) {
        if isPresented {
            showContent = true
        } else {
            closingIsInProcess = true
            onWillDismiss()
            debouncedWorkItem.work?.cancel()
            shouldShowContent = false
        }
    }
    
    private func onAnimationCompleted() -> () {
        if shouldShowContent {
            snackBarSemaphore.signal()
            return
        }
        showContent = false
        onDismiss()
        snackBarSemaphore.signal()
    }
}
