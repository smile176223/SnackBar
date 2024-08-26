//
//  DeviceRotationViewModifier.swift
//
//
//  Created by Liam on 2024/8/26.
//

import SwiftUI

extension View {
    func onRotate(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(onRotate: action))
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    
    @State private var orientation: UIDeviceOrientation = .portrait
    let onRotate: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    updateOrientation()
                }
                updateOrientation()
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
            .onChange(of: orientation) { _ in
                onRotate()
            }
    }
    
    private func updateOrientation() {
        DispatchQueue.main.async {
            let newOrientation = UIDevice.current.orientation
            
            if orientation != newOrientation {
                orientation = newOrientation
            }
        }
    }
}
