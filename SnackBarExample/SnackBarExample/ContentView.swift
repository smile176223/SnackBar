//
//  ContentView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI
import SnackBar

struct SnackBarView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("SHOW")
                    .bold()
            }
        }
        .snackBar($isPresented, content: {
            ZStack {
                HStack {
                    Image(systemName: "wifi.exclamationmark")
                        .foregroundColor(.white)
                    
                    Text("No internet connection")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(16)
            }
            .frame(width: UIScreen.main.bounds.width - 32)
            .background(Color.black.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }, configure: { parameters in
            parameters
                .position(.bottom)
                .padding(20)
                .animation(Animation.easeInOut(duration: 0.3))
        })
    }
}

struct RowView: View {
    
    let text: String
    
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
    }
}

#Preview("Row") {
    RowView(text: "Slide from bottom")
}


struct ContentView: View {
    
    var body: some View {
        List {
            Section {
                RowView(text: "Slide from bottom")
                RowView(text: "Slide from top")
            } header: {
                Text("SnackBar Example")
                    .bold()
                    .font(.title)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("SnackBar Example")
    }
}

#Preview {
    ContentView()
}
