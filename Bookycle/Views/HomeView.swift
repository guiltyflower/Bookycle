//
//  HomeView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 09/12/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(BooksViewModel.self) var booksVM
    @State var searchText: String
    var body: some View {
        ScrollView{
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
            //stats
            VStack(alignment: .leading) {
                Text("Stats")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(width: 180, height: 90)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(red: 245/255, green: 245/255, blue: 220/255))
                            .frame(width: 180, height: 90)
                        
                        
                        VStack{
                            Text("hello")
                            Rectangle()
                                .frame(width: 180,height: 1)
                            Text("254")
                        }
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(width: 180, height: 90)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(red: 245/255, green: 245/255, blue: 220/255))
                            .frame(width: 180, height: 90)
                        
                        
                        VStack{
                            Text("hello")
                            Rectangle()
                                .frame(width: 180,height: 1)
                            Text("254")
                        }
                    }
                }
            }
            
            //all books
            VStack(alignment: .leading) {
                Text("New Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        ForEach(booksVM.books){ book in
                            VStack{
                                NavigationLink{
                                    BookView(book: book)
                                } label: {
                                    Image(book.imageCoverName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 115, height: 170)
                                }
                                
                                
                            }
                        }
                    }.padding(.leading)
                    
                }
            }
            //currently reading
            VStack(alignment: .leading) {
                Text("Currently Reading")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal,showsIndicators: false){
                    if booksVM.readingBooksList.isEmpty {
                        EmptyReadingListView()
                    } else {
                        ReadingBooksSmallView()
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("Favourites Books")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(){
                        VStack{
                            Image("fifthseason")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                            
                        }
                        VStack{
                            Image("obeliskgate")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                            
                            
                        }
                        VStack{
                            Image("stonesky")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                            
                        }
                        VStack{
                            Image("threebody")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                            
                        }
                        
                    }
                    .padding(.leading)
                    
                }
            }
        }
    }
}

#Preview {
    HomeView(searchText: "")
}
