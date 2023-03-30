//
//  FightShowdown.swift
//  Assistant
//
//  Created by Dendarii on 29/03/2023.
//

import SwiftUI

struct FightShowdown: View {
    @ObservedObject var fighters : Fighters
    @StateObject var NPCs = Fighters()
    @StateObject var players = Fighters()
    @Binding var showInitNPC : Bool
    @Binding var showInitPlayer : Bool
    
    var body: some View {
        VStack {
            HStack {
                ForEach(fighters.fighters, id: \.self) { fighter in
                    if fighter.player != "PNJ" {
                        FighterCard(fighter: fighter, sizeCard: 120, showInit: $showInitPlayer)
                            .onTapGesture(count: 2) {
                                showInitPlayer.toggle()
                            }
                            .simultaneousGesture(
                                LongPressGesture()
                                    .onEnded({ _ in
                                        fighter.isSelected.toggle()
                                        //UpdateMenu()
                                    })
                            )
                    }
                }
            }
            Spacer()
            HStack {
                ForEach(fighters.fighters, id: \.self) { fighter in
                    if fighter.player == "PNJ" {
                        FighterCard(fighter: fighter, sizeCard: 120, showInit: $showInitNPC)
                            .onTapGesture(count: 2) {
                                showInitNPC.toggle()
                            }
                            .simultaneousGesture(
                                LongPressGesture()
                                    .onEnded({ _ in
                                        fighter.isSelected.toggle()
                                        //UpdateMenu()
                                    })
                            )
                    }
                }
            }
        }
        .onAppear {
            //UpdateMenu()
        }
    }
}

struct FightShowdown_Previews: PreviewProvider {
    @StateObject static var previewFighters = Fighters()
    @State static var previewShowInitNPC = true
    @State static var previewShowInitPlayer = false
    
    static var previews: some View {
        FightShowdown(fighters: previewFighters, showInitNPC: $previewShowInitNPC, showInitPlayer: $previewShowInitPlayer)
    }
}
