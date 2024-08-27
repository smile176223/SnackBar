//
//  RowView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/27.
//

import SwiftUI

struct RowView: View {
    
    let text: String
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.black)
                .font(.system(size: 16).bold())
            
            Spacer()
        }
        .padding()
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
        )
        .onTapGesture(perform: onTap)
    }
}

#Preview("Row") {
    RowView(text: "Slide from bottom", onTap: {})
}
