//
//  EditCards.swift
//  Flashzilla
//
//  Created by Landon Cayia on 9/20/22.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var cards = Cards()
    
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField {
        case prompt, answer
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $cards.newPrompt)
                        .focused($focusedField, equals: .prompt)
                    TextField("Answer", text: $cards.newAnswer)
                        .focused($focusedField, equals: .answer)
                    Button("Add card") {
                        Task {
                            cards.addCard()
                        }
                        focusedField = nil
                    }
                }
                .onSubmit {
                    if focusedField == .prompt {
                        focusedField = .answer
                    } else {
                        focusedField = nil
                    }
                }
                
                Section {
                    ForEach(cards.allCards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: cards.removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
        }
    }
    
    func done() {
        dismiss()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
