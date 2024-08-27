//
//  ContentView.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI
import SnackBar

struct ContentView: View {
    
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

#Preview {
    ContentView()
}
