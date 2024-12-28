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
    @FocusState private var cpIsFocused: Bool
    
    
    init(book: Book) {
        self.book = book
        _currentPageInput = State(initialValue: "\(book.currentPage)")
    }
    

    private func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: Color.bookBackground, location: 0.55),
                Gradient.Stop(color: .white, location: 0.75),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            .opacity(0.8)
            
            /* old colours
             203,194,175
             Gradient.Stop(color: Color(red: 245 / 255, green: 203 / 255, blue: 175 / 255), location: 0.55)
             Gradient.Stop(color: Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255), location: 0.55)
             
             Gradient.Stop(color: Color(red: 245 / 255, green: 203 / 255, blue: 175 / 255), location: 0.55) this is more yellowish?
             
             */
            VStack {
                ZStack{
                    Image("\(book.imageCoverName)")
                        .resizable()
                        .frame(width: 190, height: 280)
                        .scaledToFit()
                        .border(Color.black, width: 1)
                        .padding(.top)
                        .accessibilityValue("cover of the book")
                    Button(action: {
                        booksVM.toggleFavourite(book: book)
                    }) {
                        Image(systemName: booksVM.favouriteBooks.contains(where: { $0.id == book.id }) ? "heart.fill" : "heart")
                            .foregroundColor(Color(red: 169/255, green: 154/255, blue: 123/255))
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                            .accessibilityValue("tap to add to favourite")
                    }
                    .offset(x:150,y:-120)
                    
                    
                }
                
                HStack {
                    
                    
                    VStack() {
                        Text(book.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                            .foregroundStyle(Color(red: 169/255, green: 154/255, blue: 123/255))
                            .accessibilityValue("title of the book")
                        HStack{
                            Text(book.author)
                                .font(.subheadline)
                                .accessibilityValue("author of the book")
                            
                            Text("\(book.numberOfPages) pages")
                                .font(.footnote)
                                .fontWeight(.light)
                                .accessibilityValue("number of pages of the book")
                        }
                        
                    }
                    .padding(.leading , 10)
                }
                
                Spacer().frame(height: 20)
                
                HStack {
                    Text("Page")
                    TextField("", text: $currentPageInput)
                        .keyboardType(.numberPad)
                        .frame(width: 50)
                        .focused($cpIsFocused)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityValue("insert here the current page. Actually you are at page \(book.currentPage)")
                    Text("of \(book.numberOfPages)")
                    Spacer()
                    if let currentPage = Int(currentPageInput), currentPage <= book.numberOfPages {
                        let perc = Int((Double(currentPage) / Double(book.numberOfPages) * 100).rounded())
                        Text("\(perc)%")
                            .foregroundStyle(Color(red: 169/255, green: 154/255, blue: 123/255))
                        Text("read")
                            .accessibilityValue("percentage of pages readed in the book")
                    }
                }
                .padding()
                
                Button(action: {
                    if let currentPage = Int(currentPageInput), currentPage <= book.numberOfPages {
                        booksVM.updateCurrentPage(for: book, to: currentPage)
                        cpIsFocused = false
                    }
                }) {
                    Text("Update")
                        .foregroundColor(Color(red: 169/255, green: 154/255, blue: 123/255))
                        .padding()
                        .frame(width: 100, height: 50)
                        .background(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 10)
                
                Spacer().frame(height: 20)
                
                
                
                Button(action: {
                    
                    booksVM.markAsCompleted(book: book)
                    dismiss()
                }) {
                    Text("I've finished this book")
                        .foregroundColor(Color(red: 169/255, green: 154/255, blue: 123/255))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    booksVM.markAsUnfinished(book: book)
                    dismiss()
                }) {
                    Text("Add to unfinished")
                        .foregroundColor(Color(red: 169/255, green: 154/255, blue: 123/255))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                /*button for the start reading date
                 if let startDate = book.startDate {
                 Text("Started on: \(startDate.formatted(date: .numeric, time: .omitted))")
                 } else {
                 Button("Set Start Date") {
                 booksVM.setStartDate(for: book)
                 }
                 }
                 */
                Spacer()
            }
            .navigationTitle(book.title)
            .padding()
            .onTapGesture {
                    dismissKeyboard()
                }
        }
    }
}


#Preview {
 let viewModel = BooksViewModel()
 let sampleBook = Book(title: "The Fifth Season", author: "N. K. Jemisin", numberOfPages: 506, imageCoverName: "fifthseason", isFavourite: false, isReading: false, currentPage: 0)
 return ReadingBookView(book: sampleBook)
     .environment(viewModel)
}

