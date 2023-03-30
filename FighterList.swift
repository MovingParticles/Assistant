//
//  FighterList.swift
//  Assistant
//
//  Created by Dendarii on 08/02/2023.
//

import SwiftUI

struct FighterList: View {
    @ObservedObject var fighters = Fighters()
    @Binding var selection: String?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List (fighters.fighters, selection: $selection) { fighter in
                    NavigationLink {
                        FighterEditor(fighter: fighter)
                    } label: {
                        FighterRow(fighter: fighter)
                    }
                    .tag(fighter.name)
                }
                
            }
        } detail: {
            if let selectedFighter = selection {
                let fighter = fighters.findFighter(name: selectedFighter)
                FighterEditor(fighter: fighter)
            }
            else {
                Text("Selectionne un Combattant")
                Button("Terminé") {
                    dismiss()
                }
                .buttonStyle(BlueButton())
            }
        }
        .padding()
    }
}

struct FighterList_Previews: PreviewProvider {
    @StateObject static var previewFighters = Fighters()
    @State static var selection = String?("")
    
    static var previews: some View {
        FighterList(fighters: previewFighters, selection: $selection)
    }
}
