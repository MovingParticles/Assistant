//
//  ContentView.swift
//  Assistant
//
//  Created by Dendarii on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fights = Fights()
    
    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink("Nouveau Combat") {
                    FightEditor(fighters: fighters, fights: fights)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    fighters.deselectFighters()
                })
                .font(.system(size: 50, weight: .heavy))
                NavigationLink("Charger un combat") {
                    //FightLauncher(fighters: fighters, fights: fights)
                    FightList(fighters: fighters, fights: fights)
                }
                .font(.system(size: 50, weight: .heavy))
            }
            .environmentObject(fights)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(Fighters())
    }
}


