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
    @State var retryTopBar: Bool = false
    @State var retryBottomBar: Bool = false
    
    var body: some View {
        List {
            Section {
                ItemRowView(
                    text: "Bottom",
                    textColor: .darkBlue,
                    color: .lightBlue
                ) {
                    BottomBarView()
                } onTap: {
                    bottomSlide.toggle()
                }
                
                ItemRowView(
                    text: "Top",
                    textColor: .darkGreen,
                    color: .lightGreen
                ) {
                    TopBarView()
                } onTap: {
                    topSlide.toggle()
                }

                ItemRowView(
                    text: "Bottom\nCustom button",
                    textColor: .darkYellow,
                    color: .lightYellow
                ) {
                    BottomBarButtonView()
                } onTap: {
                    retryBottomBar.toggle()
                }
                
                ItemRowView(
                    text: "Top\nCustom button",
                    textColor: .darkPurple,
                    color: .lightPurple
                ) {
                    TopBarButtonView()
                } onTap: {
                    retryTopBar.toggle()
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
        .modifier(RetryViewModifier(isPresented: $retryBottomBar, position: .bottom))
        .modifier(RetryViewModifier(isPresented: $retryTopBar, position: .top))
    }
}

#Preview {
    ContentView()
}
