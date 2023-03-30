//
//  FighterRow.swift
//  Assistant
//
//  Created by Dendarii on 09/02/2023.
//

import SwiftUI

struct FighterRow: View {
    @ObservedObject var fighter : Fighter
    
    var body: some View {
        HStack {
            Text(fighter.name)
                .padding()
            Spacer()
        }
    }
}


struct FighterRow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        FighterRow(fighter: Fighter(name: "Sylvester WILLIAMS", initiative: 0, state: .attack, actions: 2, level: 2))
    }
}
