//
//  Book.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 09/12/24.
//

import Foundation
import SwiftUI


struct Book: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var author: String
    var numberOfPages: Int
    var imageCoverName: String
    var isFavourite: Bool
    var isReading: Bool
    var currentPage: Int
    var startDate: Date? 
    var endDate: Date?
}
