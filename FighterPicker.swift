//
//  FighterPicker.swift
//  Assistant
//
//  Created by Dendarii on 10/02/2023.
//

import SwiftUI

struct FighterPicker: View {
    @ObservedObject var fighters : Fighters
    @ObservedObject var fights : Fights
    
    var body: some View {
        VStack {
            List (fighters.fighters) { fighter in
                SelectableBox(fighter: fighter)
            }
        }
    }
}

/*List (fights.fights.last!.fighters.fighters) { fighter in
    FighterRow(fighter: fighter)
}*/


struct FighterPicker_Previews: PreviewProvider {
    
    @StateObject static var previewFighters = Fighters()
    @StateObject static var previewFights = Fights()
    
    static var previews: some View {
        FighterPicker(fighters: previewFighters, fights: previewFights)
    }
}
