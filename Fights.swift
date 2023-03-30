//
//  Fights.swift
//  Assistant
//
//  Created by Dendarii on 10/02/2023.
//

import Foundation
import SwiftUI

class Fights : ObservableObject {
    @Published var fights = [Fight()]
    
    init(fights: [Fight] = [
        Fight(name: "Générale", fighters: Fighters())
        ])
    {
        self.fights = fights
    }
}

struct Fight : Identifiable {
    var name = ""
    var fighters = Fighters()
    var id = UUID()
}
