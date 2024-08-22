//
//  FrameReader.swift
//  SnackBar
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI

extension View {
    func readFrame(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameModifier(frame: frame))
    }
}

struct FrameModifier: ViewModifier {

    @Binding var frame: CGRect

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    DispatchQueue.main.async {
                        let rect = proxy.frame(in: .global)
                        
                        if rect.integral != frame.integral {
                            frame = rect
                        }
                    }
                    
                    return Color.clear
                }
            )
    }
}
