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
    var userWillDismissCallback: () -> ()
    var userDismissCallback: () -> ()
    
    private let snackBarQueue = DispatchQueue(label: "snackBarQueue", qos: .utility)
    @State private var snackBarSemaphore = DispatchSemaphore(value: 1)
    @State private var dispatchWorkHolder = DispatchWorkHolder()
    private var isPresentedRef: ClassReference<Binding<Bool>>?
    
    public init(
        isPresented: Binding<Bool>,
        contentView: @escaping () -> ContentView,
        userWillDismissCallback: @escaping () -> (),
        userDismissCallback: @escaping () -> ()
    ) {
        _isPresented = isPresented
        self.contentView = contentView
        self.userDismissCallback = userDismissCallback
        self.userWillDismissCallback = userWillDismissCallback
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
//        .onAppear {
//            if isPresented {
//                appearAction(true)
//            }
//        }
    }
    
    private func snackBarModifier() -> SnackBarModifier<ContentView> {
        SnackBarModifier(
            contentView: contentView,
            animationCompletedCallback: onAnimationCompleted,
            positionIsCalculatedCallback: {
                if !closingIsInProcess {
                    DispatchQueue.main.async {
                        shouldShowContent = true
                    }
                    
                    dispatchWorkHolder.work?.cancel()

                    dispatchWorkHolder.work = DispatchWorkItem(block: { [weak isPresentedRef] in
                        isPresentedRef?.value.wrappedValue = false
                        dispatchWorkHolder.work = nil
                    })
                    if isPresented, let work = dispatchWorkHolder.work {
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
            userWillDismissCallback()
            dispatchWorkHolder.work?.cancel()
            shouldShowContent = false
        }
    }
    
    private func onAnimationCompleted() -> () {
        if shouldShowContent {
            snackBarSemaphore.signal()
            return
        }
        showContent = false
        userDismissCallback()
        snackBarSemaphore.signal()
    }
}

final class DispatchWorkHolder {
    var work: DispatchWorkItem?
}

final class ClassReference<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}
