//
//  FightInterface.swift
//  Assistant
//
//  Created by Dendarii on 08/02/2023.
//

import SwiftUI

struct FightInterface: View {
    @Environment(\.dismiss) var dismiss
    
    var fighters : Fighters
    var NPCs = Fighters()
    var players = Fighters()
    @State private var fightersOrder : [Fighter] = []
    @State private var selection = String?(nil)
    @State private var showInitNPC = true
    @State private var showInitPlayer = false
    @State private var start = false
    
    var body: some View {
        GeometryReader { fullView in
            ZStack {
                FightShowdown(fighters: fighters, showInitNPC: $showInitNPC, showInitPlayer: $showInitPlayer)
                HStack {
                    VStack {
                        Button("Initiative") {
                            fighters.allInitiativeSPS()
                            fighters.arrangeFighters()
                            //UpdateMenu()
                        }
                        .buttonStyle(BigBlueButton())
                        Button("Retour") {
                            dismiss()
                        }
                        .buttonStyle(BigBlueButton())
                        NavigationLink("Modifier") {
                            FighterList(fighters: fighters, selection: $selection)
                                .navigationBarBackButtonHidden(true)
                        }
                        .buttonStyle(BigBlueButton())
                        Button("Commencer") {
                            fighters.deselectFighters()
                            fightersOrder = fighters.fightersOrder(fighters: fighters)
                            //fightersOrder = fighters.fighters
                            print(fightersOrder.count)
                            start = true
                        }
                        .buttonStyle(BigBlueButton())
                    }
                    Spacer()
                    if start {FightMenu(fightersOrder: $fightersOrder)}
                
                }
                .frame(height: fullView.size.height/2)
            }
        }
    }
    /*func UpdateMenu() {
        NPCs.fighters = fighters.fighters
        NPCs.NPCs()
        players.fighters = fighters.fighters
        players.Players()
    }*/
    
}

struct FightInterface_Previews: PreviewProvider {
    @StateObject static var previewFighters = Fighters()
    
    static var previews: some View {
        FightInterface(fighters: previewFighters)
    }
}
