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
    @EnvironmentObject var score: ScoreViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
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
                            if await score.loginWithPassword(p: loginInfo, s: .NanjingNormalUniversity) {
                                DispatchQueue.main.async {
                                    self.isAnimating = false
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.isAnimating = false
                                }
                            }
                        }
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
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarItems(trailing: DismissButton(title: "Cancel", presentationMode: _presentationMode))
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ScoreViewModel())
}
