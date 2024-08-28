//
//  BarView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

struct BarView: View {
    
    let type: BarType
    
    var body: some View {
        VStack {
            
            switch type {
            case .top:
                bar()
                    .padding(.top, 20)
                Spacer()
                
            case .bottom:
                Spacer()
                bar()
                    .padding(.bottom, 20)
            }
        }
    }
    
    @ViewBuilder
    private func bar() -> some View {
        Color.gray
            .opacity(0.9)
            .frame(width: 150, height: 20)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.trailing, 32)
    }
}

#Preview {
    BarView(type: .bottom)
}
