//
//  FighterDetail.swift
//  Assistant
//
//  Created by Dendarii on 08/02/2023.
//

import SwiftUI

struct FighterCard: View {
    @ObservedObject var fighter = Fighter()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    var sizeCard : CGFloat
    @Binding var showInit : Bool
    
    var body: some View {
        VStack {
            Text(fighter.player.components(separatedBy: " ").first!)
                .frame(height: 60, alignment: .bottom)
                .font(.callout)
                .foregroundColor(ColorCard(state: fighter.state))
            Text(fighter.name.components(separatedBy: " ").first!)
                .foregroundColor(ColorCard(state: fighter.state))
                .frame(width: sizeCard, height: 25, alignment: .center)
                .font(.title)
                .overlay(
                    Circle()
                        .stroke(ColorCard(state: fighter.state), lineWidth: 5)
                        .frame(width: sizeCard, height: sizeCard)
                    )
            Text(DisplayChoice(showInit: showInit))
                .frame(width: sizeCard/2, height: sizeCard/3, alignment: .top)
                .multilineTextAlignment(.center)
                .font(.callout)
                .foregroundColor(ColorCard(state: fighter.state))
                .contentShape(Circle())
        }
        .frame(width: sizeCard+10, height: sizeCard+10)
        .offset(y: -14)
    }
    
    func DisplayChoice(showInit : Bool) -> String {
        if showInit {
            return String(fighter.initiative)
        } else {
            return "Rang "+String(fighter.level)
        }
    }
    
    func ColorCard(state: STATE) -> Color {
        switch state {
        case .attack:
            return .red
        case .neutral:
            return (colorScheme == .dark ? .white : .black)
        case .defense:
            return .blue
        }
    }
}

struct FighterCard_Previews: PreviewProvider {
    static var previewFighter = Fighter(name: "Patrick POITOU", player: "Luc", state: .attack, level: 3)
    @State static var previewShowInit = false

    static var previews: some View {
        FighterCard(fighter: previewFighter, sizeCard: 120, showInit: $previewShowInit)
    }
}


