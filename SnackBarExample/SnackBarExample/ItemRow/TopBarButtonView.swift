//
//  TopBarButtonView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

struct TopBarButtonView: View {
    var body: some View {
        VStack {
            
            Color.gray
                .opacity(0.9)
                .frame(width: 150, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    HStack{
                        
                        Spacer()
                        
                        Color.lightPurple
                            .frame(width: 20, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .padding(.trailing, 10)
                    }
                }
                .padding(.trailing, 32)
                .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    TopBarView()
}
