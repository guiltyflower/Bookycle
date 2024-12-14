//
//  ReadingBooksSmallView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 13/12/24.
//

import SwiftUI

struct ReadingBooksSmallView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
               
                ForEach(viewModel.readingBooksList, id: \.id) { book in
                    VStack {
                        Image(book.imageCoverName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 115, height: 170)
                    }
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    ReadingBooksSmallView()
        .environmentObject(BooksViewModel())
}
