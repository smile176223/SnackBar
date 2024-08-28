//
//  BottomBarButtonView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

struct BarButtonView: View {
    
    let type: BarType
    let color: Color
    
    var body: some View {
        VStack {
            
            switch type {
            case .top:
                barButton()
                    .padding(.top, 20)
                Spacer()
                
            case .bottom:
                Spacer()
                barButton()
                    .padding(.bottom, 20)
            }
        }
    }
    
    @ViewBuilder
    private func barButton() -> some View {
        Color.gray
            .opacity(0.9)
            .frame(width: 150, height: 20)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {
                HStack{
                    
                    Spacer()
                    
                    color
                        .frame(width: 20, height: 10)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(.trailing, 10)
                }
            }
            .padding(.trailing, 32)
    }
}

#Preview {
    BarButtonView(type: .bottom, color: .lightBlue)
}
