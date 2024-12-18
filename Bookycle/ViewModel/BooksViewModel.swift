//
//  BookViewModel.swift
//  Bookycle
//
//  Created by Giovanni Fioretto on 09/12/24.
//

import Foundation
import SwiftUI


@Observable
class BooksViewModel: ObservableObject {
    var books = [
        Book(title: "The Fifth Season", author: "N. K. Jemisin", numberOfPages: 506, imageCoverName: "fifthseason", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "The Obelisk Gate", author: "N. K. Jemisin", numberOfPages: 444, imageCoverName: "obeliskgate", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "The Stone Sky", author: "N. K. Jemisin", numberOfPages: 444, imageCoverName: "stonesky", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "The Three-Body Problem", author: "Liu Cixin", numberOfPages: 390, imageCoverName: "threebody", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "The Dark Forest", author: "Liu Cixin", numberOfPages: 400, imageCoverName: "darkforest", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "Death's End", author: "Liu Cixin", numberOfPages: 400, imageCoverName: "deathsend", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "Time Traveler's Wife", author: "Audrey Niffenegger", numberOfPages: 503, imageCoverName: "timetraveler", isFavourite: false, isReading: false, currentPage: 0),
        Book(title: "Full Moon Coffee Shop", author: "Mai Mochizuki", numberOfPages: 304, imageCoverName: "fullmoon", isFavourite: false, isReading: false, currentPage: 0)
    ]
    
    private(set) var toReadBooks: [Book] = []
    private(set) var readingBooksList: [Book] = []
    private(set) var unfinishedBooks: [Book] = []
    private(set) var completedBooks: [Book] = []
    private(set) var favouriteBooks: [Book] = []

    
    private var persistenceURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("booksData.json")
    }

    
    init() {
        loadData()
    }

    
    func saveData() {
        let dataToSave = [
            "toReadBooks": toReadBooks,
            "readingBooksList": readingBooksList,
            "unfinishedBooks": unfinishedBooks,
            "completedBooks": completedBooks,
            "favouriteBooks": favouriteBooks
        ]
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(dataToSave)
            try data.write(to: persistenceURL, options: .atomic)
            print("Data saved successfully")
        } catch {
            print("Error saving data: \(error)")
        }
    }

  
    func loadData() {
        do {
            let data = try Data(contentsOf: persistenceURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([String: [Book]].self, from: data)
            
            toReadBooks = decodedData["toReadBooks"] ?? []
            readingBooksList = decodedData["readingBooksList"] ?? []
            unfinishedBooks = decodedData["unfinishedBooks"] ?? []
            completedBooks = decodedData["completedBooks"] ?? []
            favouriteBooks = decodedData["favouriteBooks"] ?? []
            print("Data loaded successfully")
        } catch {
            print("Error loading data: \(error)")
        }
    }

    
    func addToToReadBooks(book: Book) {
        guard !toReadBooks.contains(where: { $0.id == book.id }) else { return }
        toReadBooks.append(book)
        saveData()
    }

   
    func startReadingBook(book: Book) {
        if let index = toReadBooks.firstIndex(where: { $0.id == book.id }) {
            toReadBooks.remove(at: index)
        }
        guard !readingBooksList.contains(where: { $0.id == book.id }) else { return }
        readingBooksList.append(book)
        saveData()
    }

    
    func markAsUnfinished(book: Book) {
        if let index = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            readingBooksList.remove(at: index)
        }
        guard !unfinishedBooks.contains(where: { $0.id == book.id }) else { return }
        unfinishedBooks.append(book)
        saveData()
    }

    
    func markAsCompleted(book: Book) {
        if let index = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            readingBooksList.remove(at: index)
        }
        if let index = unfinishedBooks.firstIndex(where: { $0.id == book.id }) {
            unfinishedBooks.remove(at: index)
        }
        if let index = toReadBooks.firstIndex(where: { $0.id == book.id }) {
            toReadBooks.remove(at: index)
        }
        completedBooks.append(book)
        saveData()
    }

    
    func toggleFavourite(book: Book) {
        if let index = favouriteBooks.firstIndex(where: { $0.id == book.id }) {
            favouriteBooks.remove(at: index)
        } else {
            favouriteBooks.append(book)
        }
        saveData()
    }

  
    func updateCurrentPage(for book: Book, to page: Int) {
        guard let index = books.firstIndex(where: { $0.id == book.id }) else { return }
        books[index].currentPage = page

        if let readingIndex = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            readingBooksList[readingIndex].currentPage = page
        }

        if let toReadIndex = toReadBooks.firstIndex(where: { $0.id == book.id }) {
            toReadBooks[toReadIndex].currentPage = page
        }

        if let unfinishedIndex = unfinishedBooks.firstIndex(where: { $0.id == book.id }) {
            unfinishedBooks[unfinishedIndex].currentPage = page
        }

        if let completedIndex = completedBooks.firstIndex(where: { $0.id == book.id }) {
            completedBooks[completedIndex].currentPage = page
        }

        saveData()
    }
}
