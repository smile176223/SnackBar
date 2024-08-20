//
//  NonAnimationFullScreenModifier.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import SwiftUI

private struct FullScreenClearBackgroundView: UIViewRepresentable {
    
    private class View: UIView {
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
        }
    }
    
    func makeUIView(context: Context) -> some UIView {
        return View()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct NonAnimationFullScreenModifier<ContentView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var contentView: () -> ContentView
    var disappear: () -> ()
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { isPresented in
                UIView.setAnimationsEnabled(false)
            }
            .fullScreenCover(isPresented: $isPresented) {
                ZStack {
                    contentView()
                }
                .background {
                    FullScreenClearBackgroundView()
                }
                .onAppear {
                    enableAnimations()
                }
                .onDisappear {
                    disappear()
                    enableAnimations()
                }
            }
    }
    
    private func enableAnimations() {
        if !UIView.areAnimationsEnabled {
            UIView.setAnimationsEnabled(true)
        }
    }
}
