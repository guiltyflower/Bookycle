//
//  ReadedBooksView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 13/12/24.
//

import SwiftUI

struct ReadedBooksListView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
               
                ForEach(viewModel.completedBooks, id: \.id) { book in
                    VStack {
                        NavigationLink{
                            FinishedBookView(book: book)
                        } label: {
                            Image(book.imageCoverName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    ReadedBooksListView()
        .environmentObject(BooksViewModel())
}
