//
//  LoginView.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAnimating: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("User Name", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.top, 40)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            ZStack {
                Button(action: {
                    self.isAnimating = true
                    let loginInfo = PasswordLoginInfo(username: username, password: password)
                    Task {
                        guard let authToken = await requestAuthToken(.NanjingNormalUniversity, loginInfo) else {
                            print("empty0")
                            return
                        }
//                        if !ehallData.isEmpty {
//                            ehallData[0].userData.authToken = authToken.auth_token
//                        } else {
//                            print("empty1")
//                        }
//                        guard let userInfo = await requestUserInfo(authToken: authToken.auth_token) else {
//                            print("empty2")
//                            return
//                        }
//                        if !ehallData.isEmpty {
//                            ehallData[0].userData.userInfo = userInfo
//                        } else {
//                            print("empty3")
//                        }
                        self.isAnimating = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    }
                }) {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                .opacity(isAnimating ? 0 : 1)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
                    .opacity(isAnimating ? 1 : 0)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
