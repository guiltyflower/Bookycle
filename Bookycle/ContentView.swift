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
               /* ChallengeView()
                    .tabItem {
                        Label("Challenge", systemImage: "flag.fill")
                    }
                 StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.fill")
                    }
                */
            }
            .tint(Color(red: 169/255, green: 154/255, blue: 123/255))
            .toolbar {
                          ToolbarItem(placement: .navigationBarTrailing) {
                             
                                  Image("profile")
                                      .resizable()
                                      .frame(width: 40, height: 40)
                                      .clipShape(Circle())
                                      .overlay(
                                          Circle().stroke(Color.gray, lineWidth: 1)
                                      )
                              
                          }
                      }
            .toolbarBackground(Color(red: 242/255, green: 220/255, blue: 177/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
