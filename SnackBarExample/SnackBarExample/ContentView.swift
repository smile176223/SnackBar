//
//  ContentView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI
import SnackBar

struct ContentView: View {
    
    @State var topSlide: Bool = false
    @State var bottomSlide: Bool = false
    @State var retryBar: Bool = false
    
    var body: some View {
        List {
            Section {
                RowView(text: "Slide from bottom") {
                    bottomSlide.toggle()
                }
                
                RowView(text: "Slide from top") {
                    topSlide.toggle()
                }
                
                RowView(text: "Slide from bottom with Buttom") {
                    retryBar.toggle()
                }
            } header: {
                Text("SnackBar Example")
                    .bold()
                    .font(.title)
            }
        }
        .listStyle(PlainListStyle())
        .modifier(NormalViewModifier(isPresented: $bottomSlide, position: .bottom))
        .modifier(NormalViewModifier(isPresented: $topSlide, position: .top))
        .modifier(RetryViewModifier(isPresented: $retryBar, position: .bottom))
    }
}

#Preview {
    ContentView()
}
