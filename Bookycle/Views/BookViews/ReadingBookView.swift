//
//  ReadingBookView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 14/12/24.
//

import SwiftUI

struct ReadingBookView: View {
    let book: Book
    @Environment(BooksViewModel.self) var booksVM
    var body: some View {
        VStack {
            HStack {
                Image("\(book.imageCoverName)")
                    .resizable()
                    .frame(width: 170, height: 240)
                    .scaledToFit()
                    .border(Color.black, width: 1)
                
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                    Text("\(book.numberOfPages) pages")
                        .font(.footnote)
                }
                .padding(.leading, 10)
            }
            
            Spacer().frame(height: 20)
            
            Button(action: {
                booksVM.markAsCompleted(book: book)
            }) {
                Text("I've finished this book")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 10)
            
            Button(action: {
                booksVM.markAsUnfinished(book: book)
            }) {
                Text("Add to unfinished")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationTitle(book.title)
        .padding()
    }
}
/*
#Preview {
    ReadingBookView()
}
*/
