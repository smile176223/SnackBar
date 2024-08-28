//
//  TopBarView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        VStack {
            
            Color.gray
                .opacity(0.9)
                .frame(width: 150, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.trailing, 32)
                .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    TopBarView()
}
