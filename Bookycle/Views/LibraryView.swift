//
//  LibraryView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 10/12/24.
//

import SwiftUI

struct LibraryView: View {
    
    @Environment(BooksViewModel.self) var booksVM
    
    var body: some View {
        ScrollView{
            VStack {
            
            
            //reading book list
            VStack(alignment: .leading) {
                Text("Currently Reading")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal,showsIndicators: false){
                    if booksVM.readingBooksList.isEmpty {
                        EmptyReadingListView()
                    } else {
                        ReadingBooksSmallView()
                    }
                }
            }
            
            //readed book list
            VStack(alignment: .leading) {
                Text("Readed Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal,showsIndicators: false){
                    if booksVM.toReadBooks.isEmpty {
                        EmptyReadingListView()
                    } else {
                        ReadedBooksView()
                    }
                }
            }
                
            //toreAad book list
                VStack(alignment: .leading) {
                    Text("To Read Books")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    ScrollView(.horizontal,showsIndicators: false){
                        if booksVM.toReadBooks.isEmpty {
                            EmptyReadingListView()
                        } else {
                            ToReadView()
                        }
                    }
                }
            
            //favourite books
            VStack(alignment: .leading) {
                Text("Favourite Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal,showsIndicators: false){
                    if booksVM.readingBooksList.isEmpty {
                        EmptyReadingListView()
                    } else {
                        FavouriteBooksView()
                    }
                }
            }
            
            //Not finished books list
                if !booksVM.readingBooksList.isEmpty {
                    UnfinishedBookView()
                }
            
        }}
    }
}

#Preview {
    LibraryView()
}
