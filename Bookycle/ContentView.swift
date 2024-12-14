//
//  ContentView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    
   @Environment(BooksViewModel.self) var booksVM
    
    var body: some View {
        NavigationStack{
            TabView {
                HomeView(searchText: "")
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                LibraryView()
                    .tabItem {
                        Label("Library", systemImage: "books.vertical.fill")
                    }
                ChallengeView()
                    .tabItem {
                        Label("Challenge", systemImage: "flag.fill")
                    }
                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.fill")
                    }
            }
            .toolbar {
                          ToolbarItem(placement: .navigationBarTrailing) {
                              NavigationLink(destination: ProfileView()) {
                                  Image("profile")
                                      .resizable()
                                      .frame(width: 40, height: 40)
                                      .clipShape(Circle())
                                      .overlay(
                                          Circle().stroke(Color.gray, lineWidth: 1)
                                      )
                              }
                          }
                      }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
