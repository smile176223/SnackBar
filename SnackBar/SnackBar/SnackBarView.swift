//
//  SnackBarView.swift
//  SnackBar
//
//  Created by Liam on 2024/8/16.
//

import SwiftUI

public extension View {
    func snackBar(_ isPresented: Binding<Bool>, scheduler: Scheduler = DispatchQueue.main) -> some View {
        ZStack {
            self
            VStack {
                Spacer()
                SnackBarView(isPresented: isPresented, scheduler: scheduler)
            }
        }
    }
}

public protocol Scheduler {
    func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) -> DispatchWorkItem
}

extension DispatchQueue: Scheduler {
    public func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: execute)
        self.asyncAfter(deadline: deadline, execute: workItem)
        return workItem
    }
}

public struct SnackBarView: View {
    
    @Binding private var isPresented: Bool
    private let scheduler: Scheduler
    @State private var dismissWorkItem: DispatchWorkItem?
    
    public init(isPresented: Binding<Bool>, scheduler: Scheduler) {
        _isPresented = isPresented
        self.scheduler = scheduler
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
            .onTapGesture {
                isPresented = false
            }
            .onAppear {
                dismissWorkItem = scheduler.asyncAfter(deadline: .now() + 1) {
                    isPresented = false
                }
            }
            .onDisappear {
                dismissWorkItem?.cancel()
            }
        }
    }
}

#Preview {
    
    struct TestView: View {
        
        @State var isPresented: Bool = false
        
        var body: some View {
            ZStack {
                Color.clear
                    .snackBar($isPresented)
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("SHOW")
                        .bold()
                }
            }
        }
    }
    
    return TestView()
}

