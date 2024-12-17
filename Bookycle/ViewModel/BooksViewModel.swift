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

   
    func addToToReadBooks(book: Book) {
        guard !toReadBooks.contains(where: { $0.id == book.id }) else { return }
        toReadBooks.append(book)
    }

  
    func startReadingBook(book: Book) {
        if let index = toReadBooks.firstIndex(where: { $0.id == book.id }) {
            toReadBooks.remove(at: index) 
        }
        guard !readingBooksList.contains(where: { $0.id == book.id }) else { return }
        readingBooksList.append(book)
    }

    /*
     FOr the unfinished book, I remove one from the reading
     and I add one to the unfinished books
     */
    func markAsUnfinished(book: Book) {
        if let index = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            readingBooksList.remove(at: index)
        }
        guard !unfinishedBooks.contains(where: { $0.id == book.id }) else { return }
        unfinishedBooks.append(book)
    }

    /*
     To add a book that the user has finished.
     I'll remove it from the reading list (also checking the unfinished one)
     
     */
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
        guard !completedBooks.contains(where: { $0.id == book.id }) else { return }
        completedBooks.append(book)
    }

    func toggleFavourite(book: Book) {
        if let index = favouriteBooks.firstIndex(where: { $0.id == book.id }) {
            favouriteBooks.remove(at: index)
        } else {
            favouriteBooks.append(book)
        }
    }
    
    // UPDATE READING DATE
   /*old one func setStartDate(for book: Book) {
        if let index = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            readingBooksList[index].startDate = Date() // Imposta la data di oggi
        }
    }*/
    func setStartDate(for book: Book) {
        var updatedBook = book
        updatedBook.startDate = Date() // Imposta la data di oggi
        updateBookInAllLists(updatedBook)
    }

    
    func setEndDate(for book: Book) {
        if let index = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            readingBooksList[index].endDate = Date() // Imposta la data di oggi
        }
        
        
        if let index = readingBooksList.firstIndex(where: { $0.id == book.id }) {
            var completedBook = readingBooksList.remove(at: index)
            completedBook.endDate = Date()
            completedBooks.append(completedBook)
        }
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
    }

    
    /* NON ANCORA IMPLEMENTATA*/
/*
    func removeBookFromTracking(book: Book) {
        toReadBooks.removeAll { $0.id == book.id }
        readingBooksList.removeAll { $0.id == book.id }
        unfinishedBooks.removeAll { $0.id == book.id }
        completedBooks.removeAll { $0.id == book.id }
    }
*/
    
    func syncWithBooksData() {
        toReadBooks = toReadBooks.filter { book in books.contains(where: { $0.id == book.id }) }
        readingBooksList = readingBooksList.filter { book in books.contains(where: { $0.id == book.id }) }
        unfinishedBooks = unfinishedBooks.filter { book in books.contains(where: { $0.id == book.id }) }
        completedBooks = completedBooks.filter { book in books.contains(where: { $0.id == book.id }) }
    }
    private func updateBookInAllLists(_ updatedBook: Book) {
        if let index = toReadBooks.firstIndex(where: { $0.id == updatedBook.id }) {
            toReadBooks[index] = updatedBook
        }
        if let index = readingBooksList.firstIndex(where: { $0.id == updatedBook.id }) {
            readingBooksList[index] = updatedBook
        }
        if let index = unfinishedBooks.firstIndex(where: { $0.id == updatedBook.id }) {
            unfinishedBooks[index] = updatedBook
        }
        if let index = completedBooks.firstIndex(where: { $0.id == updatedBook.id }) {
            completedBooks[index] = updatedBook
        }
    }
}
