//
//  SnackBarView.swift
//  SnackBar
//
//  Created by Liam on 2024/8/16.
//

import SwiftUI

public extension View {
    func snackBar(_ isPresented: Binding<Bool>) -> some View {
        ZStack {
            self
            VStack {
                Spacer()
                SnackBarView(isPresented: isPresented)
            }
        }
    }
}

public struct SnackBarView: View {
    
    @Binding public var isPresented: Bool
    
    public init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }
    
    public var body: some View {
        if isPresented {
            ZStack {
                HStack {
                    Image(systemName: "network")
                        .foregroundColor(.white)
                    
                    Text("No internet connect...")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(16)
            }
            .frame(width: UIScreen.main.bounds.width - 32)
            .background(Color.black.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .transition(.move(edge: .bottom))
            .animation(.default)
        }
    }
}

#Preview {
    
    struct TestView: View {
        
        @State var isPresented: Bool = false
        
        var body: some View {
            ZStack {
                Color.red
                    .snackBar($isPresented)
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("test")
                }
            }
        }
    }
    
    return TestView()
}

