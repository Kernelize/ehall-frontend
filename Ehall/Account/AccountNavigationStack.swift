//
//  AccountNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct AccountNavigationStack: View {
    @State var showLoginView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                nameCard
                // .frame(maxWidth: .infinity)
                entryList
                urlList
                loginButton
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
        }
    }
    
    var nameCard: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    Image(systemName: "hexagon")
                        .symbolVariant(.fill)
                        .foregroundColor(.blue)
                        .font(.system(size: 200))
                        .offset(x: -50, y: -100)
                )
//            if userName != nil {
//                Text(userName!)
//                    .font(.title.weight(.semibold))
//            } else {
//                Text("Not logged in")
//                    .font(.title.weight(.semibold))
//            }
//                if let userInfo = ehallData[0].userData.userInfo {
//                    if let data = userInfo.data {
//                        Text(data.userName)
//                                .font(.title.weight(.semibold))
//                    }
//                }
//                    .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("California, USA")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

    var entryList: some View {
        Section {
            entry(destination: EmptyView(), label: "Settings", systemImage: "gear")
            entry(destination: EmptyView(), label: "Billing", systemImage: "creditcard")
            entry(destination: EmptyView(), label: "Help", systemImage: "questionmark")
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }

    var urlList: some View {
        Section {
            Link(destination: URL(string: "https://github.com/Kernelize")!) {
                HStack {
                    Label("Homepage", systemImage: "house")
                    Spacer()
                    Image(systemName: "link")
                }
            }
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var loginButton: some View {
        Section {
            Button(action: {
                self.showLoginView.toggle()
            }, label: {
                Text("Login")
            })
            .sheet(isPresented: $showLoginView) {
                LoginView()
            }
        }
    }

    func entry(destination: some View, label: String, systemImage: String) -> some View {
        NavigationLink(destination: destination) {
            Label(label, systemImage: systemImage)
        }
    }
}

#Preview {
    AccountNavigationStack()
}
