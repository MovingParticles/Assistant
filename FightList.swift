//
//  FightList.swift
//  Assistant
//
//  Created by Dendarii on 10/02/2023.
//

import SwiftUI

struct FightList: View {
    @ObservedObject var fighters : Fighters
    @EnvironmentObject var fights : Fights
    
    
    
    var body: some View {
        NavigationStack {
            List (fights.fights) { fight in
                NavigationLink {
                    FightInterface(fighters: fight.fighters)
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Text(fight.name)
                }
            }
        }
        .environmentObject(fights)
    }
}

struct FightList_Previews: PreviewProvider {
    @StateObject static var previewFighters = Fighters()
    @EnvironmentObject static var previewFights
    
    static var previews: some View {
        FightList(fighters: previewFighters, fights: previewFights)
    }
}

