//
//  Buttons.swift
//  Assistant
//
//  Created by Dendarii on 16/03/2023.
//

import SwiftUI
import Foundation

struct BlueButton: ButtonStyle {
    var isActive = Bool(true)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isActive ? Color(red: 0, green: 0, blue: 0.5) : Color(red: 0.2, green: 0.2, blue: 0.2))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct BigBlueButton: ButtonStyle {
    var isActive = Bool(true)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isActive ? Color(red: 0, green: 0, blue: 0.5) : Color(red: 0.2, green: 0.2, blue: 0.2))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .fontWeight(.bold)
            .font(.title)
    }
}

extension HorizontalAlignment {
    private enum MyAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.trailing]
        }
    }
    
    static let myAlignment = HorizontalAlignment(MyAlignment.self)
}
