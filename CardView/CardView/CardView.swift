//
//  CardView.swift
//  CardView
//
//  Created by petrut alexandra on 28.08.2023.
//

import SwiftUI

public final class Card: ObservableObject {
    
    @Published public var isFlipped = false
    @Published public var isMatched = false
    public let id: UUID
    public let simbol: String

    fileprivate let backgroundColor: Color
    fileprivate let initialSymbol: String
    
    public init(initialSymbol: String, simbol: String, backgroundColor: Color) {
        self.backgroundColor = backgroundColor
        self.initialSymbol = initialSymbol
        self.simbol = simbol
        self.id = UUID()
    }
}

public struct CardView: View {
    
    @ObservedObject var card: Card
    
    public init(card: Card) {
        self.card = card
    }
    
    public var body: some View {
        let rotationAngle: Double = card.isFlipped ? 180 : 0
        
        return RoundedRectangle(cornerRadius: 10)
            .foregroundColor(card.backgroundColor)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            .aspectRatio(0.7, contentMode: .fit)
            .overlay(
                Text(card.isFlipped ? card.simbol: card.initialSymbol)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
            )
            .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
            .opacity(card.isMatched ? 0 : 1)
            .animation(.spring(), value: card.isFlipped)
    }
}
