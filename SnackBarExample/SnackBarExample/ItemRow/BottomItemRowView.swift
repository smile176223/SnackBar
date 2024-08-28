//
//  BottomItemRowView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

struct BottomItemRowView: View {
    
    let text: String
    let color: Color
    let onTap: () -> Void
    
    var body: some View {
        
        ItemRowView(text: text, color: color, content: {
            VStack {
                
                Spacer()
                
                Color.black
                    .opacity(0.7)
                    .frame(width: 150, height: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.trailing, 32)
                    .padding(.bottom, 20)
                
            }
        }, onTap: onTap)
    }
}

#Preview {
    BottomItemRowView(text: "Description", color: .lightBlue, onTap: {})
}
