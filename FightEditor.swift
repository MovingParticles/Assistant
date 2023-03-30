//
//  FightEditor.swift
//  Assistant
//
//  Created by Dendarii on 10/02/2023.
//

import SwiftUI

struct FightEditor: View {
    @Environment(\.colorScheme) var colorScheme
    @State var newFight = Fight(name: "Entrez le nom du combat")
    @StateObject private var newFighters = Fighters()
    @ObservedObject var fighters : Fighters
    @EnvironmentObject var fights : Fights
    @State private var selection = String?(nil)
    @State private var fightName = String("")
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                VStack {
                    FighterPicker(fighters: newFighters, fights: fights)
                }
                NavigationLink {
                    FightInterface(fighters: newFighters)
                        .navigationTitle(fights.fights.last!.name)
                        .navigationBarBackButtonHidden(true)
                        .onAppear {
                            //newFighters.fighters = fighters.fighters
                            newFighters.sortFighters()
                            newFight.fighters.fighters = newFighters.fighters
                            newFight.name = fightName
                            fights.fights.append(Fight(name: fightName, fighters: newFighters))
                        }
                } label: {
                    Text("Lancer le Combat")
                        .padding()
                        .background(fightName != "" ? Color(red: 0, green: 0, blue: 0.5) : Color(red: 0.2, green: 0.2, blue: 0.2))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .fontWeight(.bold)
                        .font(.title)
                        /*.simultaneousGesture(
                            TapGesture()
                                .onEnded({ _ in
                                    
                                })
                            )*/
                }
                .offset(y: -100)
                .disabled(fightName == "")
            }
        }
        .onAppear {
            fighters.fighters.removeAll { value in
                return value == fighters.findFighter(name: "Nouveau Combattant")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                TextField(newFight.name, text: $fightName)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: 400)
                    .font(.title.weight(.semibold))
                    .textFieldStyle(.roundedBorder)
            })
            ToolbarItem {
                NavigationLink("Modifier") {
                    FighterList(fighters: fighters, selection: $selection)
                        .navigationBarBackButtonHidden(true)
                }
                .buttonStyle(BlueButton())
            }
            ToolbarItem {
                NavigationLink("Nouveau Combattant") {
                    FighterList(fighters: fighters, selection: $selection)
                        .navigationBarBackButtonHidden(true)
                        /*.onDisappear {
                            newFighters.saveFirstFighter(fileName: "FighterData")
                        }*/
                }
                .buttonStyle(BlueButton())
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            @State var newFighter = Fighter(name: "Nouveau Combattant")
                            fighters.fighters.insert(newFighter, at: 0)
                            fights.fights[0].fighters.fighters = fighters.fighters
                            selection = newFighter.name
                            //newFighters.saveFirstFighter(fileName: "FighterData")
                        }
                    )
            }
        }
        .environmentObject(fights)
    }
}

struct FightEditor_Previews: PreviewProvider {
    @StateObject static var previewFighters = Fighters()
    @StateObject static var previewFights = Fights()
    
    static var previews: some View {
        FightEditor(fighters : previewFighters, fights: previewFights)
    }
}
