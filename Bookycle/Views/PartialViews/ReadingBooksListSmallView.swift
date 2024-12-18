//
//  ReadingBooksSmallView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 13/12/24.
//

import SwiftUI

struct ReadingBooksListSmallView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
               
                ForEach(viewModel.readingBooksList, id: \.id) { book in
                    VStack {
                        NavigationLink{
                            ReadingBookView(book: book)
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
    ReadingBooksListSmallView()
        .environmentObject(BooksViewModel())
}
