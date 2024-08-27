//
//  File.swift
//  
//
//  Created by Liam on 2024/8/26.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func addTapGesture(onTap: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            TapGesture()
                .onEnded {
                    onTap()
                }
        )
    }
}

extension View {
    
    @ViewBuilder
    func addDragGesture(value: GestureState<CGSize>, onEnded action: @escaping (DragGesture.Value) -> Void) -> some View {
        self.simultaneousGesture(
            DragGesture()
                .updating(value) { dragValue, state, _ in
                    state = dragValue.translation
                }
                .onEnded(action)
        )
    }
}
