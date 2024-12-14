//
//  UnfinishedBookView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 14/12/24.
//

import SwiftUI

struct UnfinishedBookView: View {
    
    let book: Book
    @Environment(BooksViewModel.self) var booksVM
    @Environment(\.dismiss) private var dismiss
    
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
                booksVM.startReadingBook(book: book)
                dismiss()
            }) {
                Text("Add to reading")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 10)
            
            Button(action: {
                booksVM.markAsCompleted(book: book)
                dismiss()
            }) {
                Text("I've red this book")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
           
            
            Button(action: {
                            booksVM.toggleFavourite(book: book)
                        }) {
                            Image(systemName: booksVM.favouriteBooks.contains(where: { $0.id == book.id }) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
        }
        .navigationTitle(book.title)
        .padding()
    }
}
/*
#Preview {
    UnfinishedBookView()
}
*/
