//
//  ItemRowView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/27.
//

import SwiftUI

enum BarType {
    case top
    case bottom
}

struct ItemRowView<ContentView: View>: View {
    
    let text: String
    let textColor: Color
    let color: Color
    let content: () -> ContentView
    let onTap: () -> Void
    
    var body: some View {
        color
            .frame(height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay {
                
                HStack {
                    VStack(alignment: .leading) {
                        
                        Spacer()
                        
                        Text(text)
                            .foregroundColor(textColor)
                            .font(.footnote.bold())
                        
                        Color.gray
                            .frame(width: 80, height: 1)
                        
                        Text("SnackBar")
                            .foregroundColor(textColor)
                            .font(.title2.bold())
                    }
                    .padding(.bottom, 20)
                    .padding(.leading, 32)
                    
                    Spacer()
                    
                    content()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .onTapGesture(perform: onTap)
    }
}

#Preview {
    ItemRowView(text: "Description", textColor: .darkGreen, color: .lightBlue, content: { EmptyView() }, onTap: {})
}
