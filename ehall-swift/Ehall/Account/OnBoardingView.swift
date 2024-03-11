//
//  OnBoardingView.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/3/4.
//

import SwiftUI
import RiveRuntime

struct OnBoardingView: View {
    @State var username = ""
    @State var password = ""
    @State var isLoading = false
    
    @EnvironmentObject var score: ScoreViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let button = RiveViewModel(fileName: "button", autoPlay: false)
//    let button = RiveViewModel(fileName: "button", stateMachineName: "active")
    var body: some View {
        ZStack {
            background
            signIn
                .padding()
        }
    }
    
    var signIn: some View {
        VStack(spacing: 16) {
            Text("Log in")
                .font(.largeTitle)
                .bold()
            Text("Access to your score, rank, course table and so on.")
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $username)
                    .customTextField()
            }
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                SecureField("", text: $password)
                    .customTextField()
            }
            Button {
            } label: {
                logInButton
            }
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.1)
                Text("OR").font(.subheadline).foregroundColor(.black.opacity(0.3))
                Rectangle().frame(height: 1).opacity(0.1)
            }
            
            Text("Sign up with Email, Apple, Google")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Spacer()
                Image(systemName: "playstation.logo")
                Spacer()
                Image(systemName: "xbox.logo")
                Spacer()
                Image(systemName: "apple.logo")
                Spacer()
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }
    
    var logInButton: some View {
        button.view()
            .frame(width: 223, height: 64)
            .background(
                Color.black
                    .cornerRadius(30)
                    .blur(radius: 10)
                    .opacity(0.3)
                    .offset(y: 10)
            )
            .overlay(
                Label("Log In", systemImage: "arrow.forward")
                    .offset(x: -4, y: 1)
                    .font(.headline)
                    .foregroundColor(.primary)
            )
            .onTapGesture {
                button.play(animationName: "active")
                let loginInfo = UsernameAndPassword(username: username, password: password)
                
                Task {
                    if await score.login(p: loginInfo, s: .NanjingNormalUniversity) {
                        debugPrint("Login succedded")
                        DispatchQueue.main.async {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        debugPrint("Login failed")
                    }
                }
            }
    }
    
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
            )
    }
    
}

struct CustomTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(15)
//            .padding(.leading, 36)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 1).fill(.black.opacity(0.1)))
//            .overlay(image.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 8))
    }
}

extension View {
    func customTextField() -> some View {
        modifier(CustomTextField())
    }
}

#Preview {
    OnBoardingView()
        .environmentObject(ScoreViewModel())
}
