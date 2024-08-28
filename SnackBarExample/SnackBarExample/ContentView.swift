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
                BottomItemRowView(text: "Slide from bottom", color: .lightBlue) {
                    bottomSlide.toggle()
                }
                
                BottomItemRowView(text: "Slide from top", color: .orange) {
                    topSlide.toggle()
                }
                
                BottomItemRowView(text: "Slide from bottom\nCustom button", color: .purple) {
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
