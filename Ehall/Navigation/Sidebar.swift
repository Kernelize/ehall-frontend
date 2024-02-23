//
//  Sidebar.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            #if os(iOS)
            content
                .navigationTitle("Learn")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            #else
            content
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {}) {
                            Image(systemName: "person.crop.circle")
                        }
                    }
                }
            #endif
            CourseView()
        }
    }
    
    var content: some View {
        List {
            NavigationLink(destination: DContentView()) {
                Label("Courses", systemImage: "book.closed")
            }
            NavigationLink(destination: CourseView()) {
                Label("Tutorials", systemImage: "list.bullet.rectangle")
            }
            Label("Livestreams", systemImage: "tv")
            Label("Certificates", systemImage: "mail.stack")
            Label("Search", systemImage: "magnifyingglass")
        }
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_PreViews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
