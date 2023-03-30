//
//  FightLauncher.swift
//  Assistant
//
//  Created by Dendarii on 08/02/2023.
//

import SwiftUI

struct FightLauncher: View {
    @ObservedObject var fighters : Fighters
    @ObservedObject var fights : Fights
    
    var body: some View {
        FightList(fighters: fighters, fights: fights)
    }
}

struct FightLauncher_Previews: PreviewProvider {
    @StateObject static var previewFighters = Fighters()
    @StateObject static var previewFights = Fights()
    
    static var previews: some View {
        FightLauncher(fighters: previewFighters, fights: previewFights)
    }
}
