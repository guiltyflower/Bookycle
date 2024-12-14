//
//  EmptyReadingListView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 13/12/24.
//

import SwiftUI

struct EmptyReadingListView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 115, height: 170)
                .foregroundStyle(Color.gray)
                .border(Color.black, width: 1)
            Text("Your reading list is empty")
                .frame(width: 115, height: 170)
        }
        .padding(.leading)
    }
}

#Preview {
    EmptyReadingListView()
}
