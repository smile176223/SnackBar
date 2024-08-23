//
//  SafeAreaModifier.swift
//  SnackBar
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI

extension View {
    func readSafeArea(_ safeArea: Binding<EdgeInsets>) -> some View {
        modifier(SafeAreaReader(safeArea: safeArea))
    }
}

struct SafeAreaReader: ViewModifier {

    @Binding var safeArea: EdgeInsets

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    DispatchQueue.main.async {
                        let area = proxy.safeAreaInsets
                        
                        if area != safeArea {
                            safeArea = area
                        }
                    }
                    
                    return Color.clear
                }
            )
    }
}
