//
//  ItemRowView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/27.
//

import SwiftUI

struct ItemRowView<ContentView: View>: View {
    
    let text: String
    let color: Color
    let content: () -> ContentView
    let onTap: () -> Void
    
    var body: some View {
        color
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay {
                
                HStack {
                    VStack(alignment: .leading) {
                        
                        Spacer()
                        
                        Text(text)
                            .foregroundColor(Color.lightGray)
                            .font(.footnote)
                        
                        Text("SnackBar")
                            .foregroundColor(.white)
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
    ItemRowView(text: "Description", color: .lightBlue, content: { EmptyView() }, onTap: {})
}
