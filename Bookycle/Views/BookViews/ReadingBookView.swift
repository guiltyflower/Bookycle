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
                booksVM.markAsCompleted(book: book)
                dismiss()
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
                dismiss()
            }) {
                Text("Add to unfinished")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            Button(action: {
                            booksVM.toggleFavourite(book: book)
                dismiss()
                        }) {
                            Image(systemName: booksVM.favouriteBooks.contains(where: { $0.id == book.id }) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
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

#Preview {
 let viewModel = BooksViewModel()
 let sampleBook = Book(title: "The Fifth Season", author: "N. K. Jemisin", numberOfPages: 506, imageCoverName: "fifthseason", isFavourite: false, isReading: false, currentPage: 0)
 return ReadingBookView(book: sampleBook)
     .environment(viewModel)
}

