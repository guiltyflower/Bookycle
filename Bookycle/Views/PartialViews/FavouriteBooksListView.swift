//
//  FavouriteBooksView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 13/12/24.
//

import SwiftUI

struct FavouriteBooksListView: View {
    
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
                ForEach(viewModel.favouriteBooks, id: \.id) { book in
                    VStack {
                        NavigationLink{
                            BookView(book: book)
                        } label: {
                            Image(book.imageCoverName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                                .accessibilityValue("the cover for the book \(book.title)")
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    FavouriteBooksListView()
}
