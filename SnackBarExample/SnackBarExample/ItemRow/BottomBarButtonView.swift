//
//  BottomBarButtonView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

struct BottomBarButtonView: View {
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Color.black
                .opacity(0.7)
                .frame(width: 150, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    HStack{
                        
                        Spacer()
                        
                        Color.purple
                            .frame(width: 20, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .padding(.trailing, 10)
                    }
                }
                .padding(.trailing, 32)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    BottomBarButtonView()
}
