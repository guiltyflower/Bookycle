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
                .foregroundStyle(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                .border(Color(red: 169/255, green: 154/255, blue: 123/255), width: 1)
            Text("Your reading list is empty")
                .frame(width: 115, height: 170)
                .foregroundStyle(Color(red: 169/255, green: 154/255, blue: 123/255))
        }
        .padding(.leading)
    }
}

#Preview {
    EmptyReadingListView()
}
