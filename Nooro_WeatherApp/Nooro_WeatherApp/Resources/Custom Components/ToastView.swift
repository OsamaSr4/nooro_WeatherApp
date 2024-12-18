//
//  ToastView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI


struct ToastView: View {
    var message: String
    var isShowing: Bool
    var onDismiss: () -> Void
    
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            if isShowing {
                VStack {
                    Text(message)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .transition(.move(edge: .top))
                        .padding(.top, 10)
                        .onTapGesture {
                            onDismiss()
                        }
                }
                .animation(.easeInOut(duration: 0.5), value: isShowing)
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

#Preview {
    ToastView(
        message: "No Location Found",
        isShowing: true,
        onDismiss: {}
    )
}
