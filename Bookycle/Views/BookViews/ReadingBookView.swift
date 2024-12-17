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
    @State private var currentPageInput: String
    
    init(book: Book) {
        self.book = book
        _currentPageInput = State(initialValue: "\(book.currentPage)")
    }
    
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
            
            HStack {
                Text("Page")
                TextField("", text: $currentPageInput)
                    .keyboardType(.numberPad)
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("of \(book.numberOfPages)")
            }
            .padding()
            
            if let currentPage = Int(currentPageInput), currentPage <= book.numberOfPages {
                let perc = Int((Double(currentPage) / Double(book.numberOfPages) * 100).rounded())
                Text("\(perc)% read")
            }
            
            Spacer().frame(height: 20)
            
            Button(action: {
                if let currentPage = Int(currentPageInput), currentPage <= book.numberOfPages {
                      booksVM.updateCurrentPage(for: book, to: currentPage)
                }
            }) {
                Text("Update")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 100, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 10)
            
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
            
            if let startDate = book.startDate {
                Text("Started on: \(startDate.formatted(date: .numeric, time: .omitted))")
            } else {
                Button("Set Start Date") {
                    booksVM.setStartDate(for: book)
                }
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

