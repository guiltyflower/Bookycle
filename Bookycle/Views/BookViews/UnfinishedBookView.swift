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
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: Color.bookBackground, location: 0.55),
                Gradient.Stop(color: .white, location: 0.75),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
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
                        HStack{
                            Text(book.author)
                                .font(.subheadline)
                            
                            Text("\(book.numberOfPages) pages")
                                .font(.footnote)
                                .fontWeight(.light)
                        }
                        
                    }
                    .padding(.leading , 10)
                }
                
                Spacer().frame(height: 90)
              /*  TextField("", text: $currentPageInput)
                    .keyboardType(.numberPad)
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("of \(book.numberOfPages)")
                */
                Button(action: {
                    booksVM.startReadingBook(book: book)
                    dismiss()
                }) {
                    Text("Add to reading")
                        .foregroundColor(Color(red: 169/255, green: 154/255, blue: 123/255))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    booksVM.markAsCompleted(book: book)
                    dismiss()
                }) {
                    Text("I've red this book")
                        .foregroundColor(Color(red: 169/255, green: 154/255, blue: 123/255))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                Spacer()
                
            }
            .navigationTitle(book.title)
            .padding()
        }
    }
}
/*#Preview {
    let viewModel = BooksViewModel()
    let sampleBook = Book(title: "The Fifth Season", author: "N. K. Jemisin", numberOfPages: 506, imageCoverName: "fifthseason", isFavourite: false, isReading: false, currentPage: 0)
    return UnfinishedBookView(book: sampleBook)
        .environment(viewModel)
}
*/

