//
//  MultipleSelectableRow.swift
//  Assistant
//
//  Created by Dendarii on 11/02/2023.
//

import SwiftUI

struct SelectableBox: View {
    @ObservedObject var fighter: Fighter
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack (spacing: 50) {
            Button(
                action: {
                    fighter.isSelected.toggle()
                }, label: {
                    Image(systemName: fighter.isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                })
            Text(fighter.name)
            
                .fontWeight(.semibold)
            Text(fighter.player)
                .fontWeight(.light)
                .italic()
        }
        .padding()
    }
}

struct SelectableBox_Previews: PreviewProvider {

    @StateObject static var previewFighter: Fighter = Fighter(name: "Sylvester WILLIAMS", player: "Éric", initiative: 0, state: .attack, actions: 2, level: 1, isSelected: false)
    
    static var previews: some View {
        //container()
        SelectableBox(fighter: previewFighter)
    }
}

