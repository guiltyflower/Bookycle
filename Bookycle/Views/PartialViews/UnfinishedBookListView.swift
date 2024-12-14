//
//  UnfinishedBookView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 14/12/24.
//

import SwiftUI

struct UnfinishedBookListView: View {
    
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Unfinished Books")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false){
                HStack {
                   
                    ForEach(viewModel.unfinishedBooks, id: \.id) { book in
                        VStack {
                            NavigationLink{
                                UnfinishedBookView(book: book)
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
}

#Preview {
    UnfinishedBookListView()
}
