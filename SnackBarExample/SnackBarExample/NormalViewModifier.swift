//
//  NormalViewModifier.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/27.
//

import SwiftUI
import SnackBar

struct NormalViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let position: SnackBarParameters.Position
    
    func body(content: Content) -> some View {
        content
            .snackBar($isPresented, content: {
                ZStack {
                    HStack {
                        Image(systemName: "wifi.exclamationmark")
                            .foregroundColor(.white)
                        
                        Text("No internet connection")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(16)
                }
                .frame(width: UIScreen.main.bounds.width - 32)
                .background(Color.black.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }, configure: { parameters in
                parameters
                    .position(position)
                    .padding(20)
                    .animation(Animation.easeInOut(duration: 0.3))
            })
    }
}
