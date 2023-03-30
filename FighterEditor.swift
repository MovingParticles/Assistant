//
//  FighterEditor.swift
//  Assistant
//
//  Created by Dendarii on 08/02/2023.
//

import SwiftUI

struct FighterEditor: View {
    @ObservedObject var fighter = Fighter()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    let stateWord = ["Actif", "Réactif", "Neutre"]
    @State var stateInt = Int(0)
    
    var body: some View {
        VStack (alignment: .center){
            Form {
                Section {
                    TextField(fighter.name, text: $fighter.name)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    TextField(fighter.player, text: $fighter.player)
                        .multilineTextAlignment(.center)
                }
                Section {
                    Picker("État", selection: $stateInt) {
                        ForEach(0..<3) {
                            Text(stateWord[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                    .onAppear {
                        stateInt = fighter.state.rawValue-1
                    }
                    .onChange(of: stateInt, perform: { index in
                        fighter.changeFighterState(stateInt: index+1)
                    })
                }
                
                Section {
                    Picker("Rang", selection: $fighter.level) {
                        ForEach(0..<11) {
                            Text("Rang \($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                LabeledContent {
                    TextField(String(fighter.initiative), value: $fighter.initiative, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(width: 40)
                } label: {
                    HStack {
                        Button("Générer une initiative"){
                            fighter.setInitiativeSPS()
                        }
                        .buttonStyle(BlueButton())
                        Spacer()
                    }
                }
            }
            Button("Terminé") {
                dismiss()
            }
            .buttonStyle(BlueButton())
            .offset(y: -70)
        }
    }
}

struct FighterEditor_Previews: PreviewProvider {
    static let fighters = Fighters()
    
    static var previews: some View {
        FighterEditor(fighter: fighters.fighters[0])
            .environmentObject(Fighters())
    }
}
