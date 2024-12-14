//
//  BookycleApp.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 09/12/24.
//

import SwiftUI

@main
struct BookycleApp: App {
    @StateObject private var booksVM = BooksViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(booksVM)
        }
    }
}
