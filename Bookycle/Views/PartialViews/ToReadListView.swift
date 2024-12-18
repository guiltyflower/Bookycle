//
//  ToReadView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 13/12/24.
//

import SwiftUI

struct ToReadListView: View {
    
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
               
                ForEach(viewModel.toReadBooks, id: \.id) { book in
                    VStack {
                        NavigationLink{
                            ToReadBookView(book: book)
                        } label: {
                            Image(book.imageCoverName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115, height: 170)
                                .accessibilityValue("the cover for the book \(book.title)")
                            
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}
/*
#Preview {
    ToReadListView()
}
*/
