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
