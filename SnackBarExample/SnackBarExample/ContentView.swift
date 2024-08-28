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
                ItemRowView(text: "Slide from bottom", color: .lightBlue) {
                    BottomBarView()
                } onTap: {
                    bottomSlide.toggle()
                }
                
                ItemRowView(text: "Slide from top", color: .orange) {
                    TopBarView()
                } onTap: {
                    topSlide.toggle()
                }

                ItemRowView(text: "Slide from bottom\nCustom button", color: .purple) {
                    BottomBarView()
                } onTap: {
                    retryBar.toggle()
                }
            } header: {
                Text("Demo")
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
