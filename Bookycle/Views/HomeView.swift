import SwiftUI

struct HomeView: View {
    @Environment(BooksViewModel.self) var booksVM
    @State var searchText: String
    
 
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return booksVM.books
        } else {
            return booksVM.books.filter { book in
                book.title.localizedCaseInsensitiveContains(searchText) ||
                book.author.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            Spacer()
            Spacer()
            
            TextField("SEARCH", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Spacer()
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                )
                .padding(.horizontal)
            
            if !searchText.isEmpty {
                VStack(alignment: .leading) {
                    Text("Search Results")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(filteredBooks, id: \.id) { book in
                                NavigationLink(destination: BookView(book: book)) {
                                    HStack {
                                        Image(book.imageCoverName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 75)
                                            .cornerRadius(5)
                                        
                                        VStack(alignment: .leading) {
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .font(.subheadline)
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    StatCardView(title: "Books Read", value: "\(booksVM.completedBooks.count)")
                    StatCardView(title: "Books Reading", value: "\(booksVM.readingBooksList.count)")
                }
            }
            
            VStack(alignment: .leading) {
                Text("New Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(booksVM.books, id: \.id) { book in
                            NavigationLink {
                                BookView(book: book)
                            } label: {
                                Image(book.imageCoverName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 115, height: 170)
                            }
                        }
                    }.padding(.leading)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Currently Reading")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    if booksVM.readingBooksList.isEmpty {
                        EmptyReadingListView()
                    } else {
                        ReadingBooksListSmallView()
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text("Favourites Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(booksVM.favouriteBooks, id: \.id) { book in
                            Image(book.imageCoverName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                        }
                    }.padding(.leading)
                }
            }
        }
        ZStack{}
    }
}

#Preview {
    let booksVM = BooksViewModel()
    booksVM.books = [
        Book(title: "The Fifth Season", author: "N. K. Jemisin", numberOfPages: 506, imageCoverName: "fifthseason", isFavourite: true, isReading: false, currentPage: 0),
        Book(title: "The Three-Body Problem", author: "Liu Cixin", numberOfPages: 390, imageCoverName: "threebody", isFavourite: false, isReading: true, currentPage: 150)
    ]

    return HomeView(searchText: "")
        .environmentObject(booksVM)
}
