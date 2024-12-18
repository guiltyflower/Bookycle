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
                            ReadingBooksListSmallView()
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
                        if booksVM.completedBooks.isEmpty {
                            EmptyReadingListView()
                        } else {
                            ReadedBooksListView()
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
                            ToReadListView()
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
                        if booksVM.favouriteBooks.isEmpty {
                            EmptyReadingListView()
                        } else {
                            FavouriteBooksListView()
                        }
                    }
                }
                
                //Not finished books list
                if !booksVM.unfinishedBooks.isEmpty {
                    UnfinishedBookListView()
                }
                
            }}
    }
}

#Preview {
    LibraryView()
}
