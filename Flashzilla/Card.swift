//
//  Card.swift
//  Flashzilla
//
//  Created by Landon Cayia on 9/19/22.
//

import Foundation

struct Card: Codable, Hashable, Identifiable {
    var id: UUID
    let prompt: String
    let answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

class Cards: ObservableObject {
    @Published private(set) var allCards: [Card] = []
    @Published var newPrompt = ""
    @Published var newAnswer = ""
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedCards")
    
    init() {
        loadData()
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(allCards)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save card data.")
        }
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            let decodedData = try JSONDecoder().decode([Card].self, from: data)
            allCards = decodedData
        } catch {
            allCards = []
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
        allCards.insert(card, at: 0)
        newPrompt = ""
        newAnswer = ""
        saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        allCards.remove(atOffsets: offsets)
        saveData()
    }
}
