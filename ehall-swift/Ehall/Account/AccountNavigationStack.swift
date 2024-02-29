//
//  AccountNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct AccountNavigationStack: View {
    @State var showLoginView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var score: ScoreViewModel
    
    struct InternalConstant {
        static let offsetHexagon: CGSize = .init(width: -50, height: -100)
        static let offsetBlob: CGSize = .init(width: 200, height: 0)
        static let sizeFontHexagon: Font = .system(size: 200)
        static let sizeFontPerson: Font = .system(size: 32)
    }

    var body: some View {
        NavigationView {
            List {
                nameCard
                // .frame(maxWidth: .infinity)
                entryList
                urlList
                if score.isAvailabe {
                    logoutButton
                } else {
                    loginButton
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: DismissButton(title: "Done", presentationMode: _presentationMode))
        }
    }
    
    var nameCard: some View {
        VStack(spacing: 8) {
            Image(systemName: score.isAvailabe ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.questionmark")
                .symbolVariant(.circle.fill)
                .font(InternalConstant.sizeFontPerson)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    Image(systemName: "hexagon")
                        .symbolVariant(.fill)
                        .foregroundColor(.blue)
                        .font(InternalConstant.sizeFontHexagon)
                        .offset(InternalConstant.offsetHexagon)
                )
                .background(
                    Blob()
                        .offset(InternalConstant.offsetBlob)
                        .scaleEffect(0.6)
                )
            if score.isAvailabe {
                Text(score.info!.data!.userName)
                    .font(.title.weight(.semibold))
                HStack {
                    Image(systemName: "location")
                        .imageScale(.small)
                    Text(score.info!.data!.userDepartment)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("Please Sign In")
                    .font(.title.weight(.semibold))
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
                    Label("Our Homepage", systemImage: "house")
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
    
    var logoutButton: some View {
        Section {
            Button(action: {
                withAnimation(.easeInOut) {
                    self.score.logout()
                }
            }, label: {
                Text("Logout")
                    .foregroundStyle(Color.red)
            })
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
        .environmentObject(ScoreViewModel())
}
