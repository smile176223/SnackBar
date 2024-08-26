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
            TapGesture().onEnded {
                onTap()
            }
        )
    }
}
