//
//  StatCardView.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 17/12/24.
//

import SwiftUI



struct StatCardView: View {
    let title: String
    let value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 242/255, green: 220/255, blue: 177/255), lineWidth: 1)
                .frame(width: 180, height: 90)
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255))
                .frame(width: 180, height: 90)
            
            VStack {
                Text(value)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 169/255, green: 154/255, blue: 123/255))
                Text(title)
                
                
            }
        }
    }
}
