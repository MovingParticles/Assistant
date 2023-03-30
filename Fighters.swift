//
//  Fighter.swift
//  Assistant
//
//  Created by Dendarii on 08/02/2023.
// Définitions de l'objet "Fighter" et publication de la liste "fighters"

import Foundation
import SwiftUI

enum STATE: Int/*, Codable, Identifiable, CaseIterable*/ {
    case attack = 1
    case defense
    case neutral
    //var id: Int { return self.rawValue }
}

struct Fighters: Identifiable {
    
    var id: ObjectIdentifier
    var fighters = [Fighter()]
    init(fighters: [Fighter] = Fighter.allFighters) {
        self.fighters = fighters
    }
}

struct Fighter: Identifiable {
    
    enum CodingKeys: CodingKey {
        case name, player, initiative, state, actions, level, isSelected, id
    }
    
    var name : String = ""
    var player : String = ""
    var initiative : Int = 0
    var state : STATE = .neutral
    var actions : Int = 0
    var level : Int = 0
    var isSelected : Bool = false
    var id = UUID()
    
    //Pour les récupérer depuis FighterData.json
    //static let allFighters: [Fighter] = Bundle.main.decode([Fighter].self, from: "FighterData.json")
    static let allFighters: [Fighter] = [
        Fighter(name: "Sylvester WILLIAMS", player: "PNJ", initiative: 0, state: .neutral, actions: 0, level: 0, isSelected: false, id: UUID()),
        Fighter(name: "Louis TANGALOA", player: "Éric", initiative: 0, state: .neutral, actions: 0, level: 0, isSelected: false, id: UUID()),
        Fighter(name: "Émiliano SANCHEZ", player: "Luc", initiative: 0, state: .neutral, actions: 0, level: 0, isSelected: false, id: UUID()),
        Fighter(name: "Léna ROSAY", player: "Mehdi", initiative: 0, state: .neutral, actions: 0, level: 0, isSelected: false, id: UUID()),
        Fighter(name: "Dimitri VOLSKOFF", player: "Corinne", initiative: 0, state: .neutral, actions: 0, level: 0, isSelected: false, id: UUID()),
                                        ]
    
    init(name: String = "", player: String = "", initiative: Int = 0, state: STATE = .neutral, actions: Int = 0, level: Int = 0, isSelected: Bool = false, id: UUID = UUID()) {
        self.name = name
        self.player = player
        self.initiative = initiative
        self.state = state
        self.actions = actions
        self.level = level
        self.isSelected = isSelected
        self.id = id
    }
    
    //Pour respecter le protocole "Hashable"
    /*static func ==(lhs: Fighter, rhs: Fighter) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }*/
    
    //Pour respecter le protocole "Codable"
    /*
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(player, forKey: .player)
        try container.encode(initiative, forKey: .initiative)
        try container.encode(state, forKey: .state)
        try container.encode(actions, forKey: .actions)
        try container.encode(level, forKey: .level)
        try container.encode(isSelected, forKey: .isSelected)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            name = try container.decode(String.self, forKey: .name)
        } catch DecodingError.typeMismatch {
            do {
                player = try container.decode(String.self, forKey: .player)
            } catch DecodingError.typeMismatch {
                do {
                    initiative = try container.decode(Int.self, forKey: .initiative)
                } catch DecodingError.typeMismatch {
                    do {
                        state = try container.decode(STATE.self, forKey: .state)
                    } catch DecodingError.typeMismatch {
                        do {
                            level = try container.decode(Int.self, forKey: .level)
                        } catch DecodingError.typeMismatch {
                            do {
                                isSelected = try container.decode(Bool.self, forKey: .isSelected)
                            }
                        }
                    }
                }
            }
        }
    }
    */
}

/*extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}*/
    
extension Fighter {
    mutating func changeFighterState(stateInt: Int) {
        if stateInt == 1 {
            self.state = .attack
        } else if stateInt == 2 {
            self.state = .defense
        } else {
            self.state = .neutral
        }
    }
    mutating func setInitiativeSPS() {
        let dices = (0..<3).map { _ in Int.random(in: 1...6) }.sorted()
        if self.level == 1 {
            self.initiative = dices[0]
        } else if self.level == 2 {
            self.initiative = dices[1]
        } else if self.level == 3 {
            self.initiative = dices[2]
        } else if self.level == 4 {
            self.initiative = dices[0]+dices[1]
        } else if self.level == 5 {
            self.initiative = dices[2]+dices[1]
        } else if self.level == 6 {
            self.initiative = dices.reduce(0, +)
        } else if self.level == 7 {
            self.initiative = dices[2]+2*dices[1]
        } else if self.level == 8 {
            self.initiative = dices[0]+2*dices[2]
        } else if self.level == 9 {
            self.initiative = 2*dices[2]+dices[1]
        } else if self.level == 10 {
            self.initiative = 3*dices[2]
        } else {
            if dices[2] % 2 == 0 {
                self.initiative = dices[0]
            } else {
                self.initiative = -dices[0]
            }
        }
    }
}

extension Fighters {
    
    /*func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }*/
    
    mutating func allInitiativeSPS() {
        for index in fighters.indices {
            fighters[index].setInitiativeSPS()
        }
    }
    
    mutating func NPCs(){
        var toRemove = [Int]()
        for index in fighters.indices {
            if fighters[index].player != "PNJ" {
                toRemove.append(index)
            }
        }
        for i in toRemove.reversed() {
            fighters.remove(at: i)
        }
    }
    
    mutating func Players(){
        var toRemove = [Int]()
        for index in fighters.indices {
            if fighters[index].player == "PNJ" {
                toRemove.append(index)
            }
        }
        for i in toRemove.reversed() {
            fighters.remove(at: i)
        }
    }
    
    mutating func sortFighters() {
        var toRemove = [Int]()
        for index in fighters.indices {
            if !fighters[index].isSelected {
                toRemove.append(index)
            }
        }
        for i in toRemove.reversed() {
            fighters.remove(at: i)
        }
    }
    
    mutating func arrangeFighters() {
        fighters.sort { $0.initiative < $1.initiative }
    }
    
    func fightersOrder(fighters: Fighters) -> [Fighter] {
        var fightersOrder : [Fighter] = []
        var fightersTemp = Fighters(fighters: fighters)
        fightersTemp.fighters.sort { $0.initiative > $1.initiative }
        while fightersTemp.fighters[0].initiative > 0 {
            fightersOrder.append(fightersTemp.fighters[0])
            fightersTemp.fighters[0].initiative -= 5
            fightersTemp.fighters.sort { $0.initiative > $1.initiative }
        }
        return fightersOrder
    }

    mutating func deselectFighters() {
        for index in fighters.indices {
            fighters[index].isSelected = false
        }
    }
    
    func findFighter(name: String) -> Fighter {
        var foundFighter = Fighter()
        for index in fighters.indices {
            if fighters[index].name == name {
                foundFighter = fighters[index]
            }
        }
        return foundFighter
    }
    /*func saveFirstFighter(fileName: String) {
        let fighterString = try! JSONEncoder().encode(fighters.first)
        let jsonString = String(data: fighterString, encoding: .utf8)!
        let url = getDocumentsDirectory()
            .appendingPathComponent(fileName)
            .appendingPathExtension("json")
        do {
            try jsonString.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
    }*/
}
