//
//  UnfinishedBookView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 14/12/24.
//

import SwiftUI

struct UnfinishedBookView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Unfinished Books")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false){
               
            }
        }
    }
}

#Preview {
    UnfinishedBookView()
}
