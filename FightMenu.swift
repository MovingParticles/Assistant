//
//  FightCount.swift
//  Assistant
//
//  Created by Dendarii on 27/03/2023.
//

import SwiftUI

struct HighlightedView: View {
    @Binding var fightersOrder : [Fighter]
    @Environment(\.colorScheme) var colorScheme
    var index : Int
    
    var body: some View {
        if fightersOrder[index].isSelected {
            HStack {
                HStack {
                    Text(String(index+1))
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                    Spacer()
                    Text(fightersOrder[index].player == "PNJ" ? fightersOrder[index].name.components(separatedBy: " ").first! : fightersOrder[index].player)
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(ColorCard(state: fightersOrder[index].state), lineWidth: 3)
                        .frame(width: 200, height: 30, alignment: .trailing)
                )
            }
            .frame(width: 180, height: 30, alignment: .center)
        }
    }
    
    func ColorCard(state: STATE) -> Color {
        switch state {
        case .attack:
            return .red
        case .neutral:
            return (colorScheme == .dark ? .white : .black)
        case .defense:
            return .blue
        }
    }
}

struct NormalView: View {
    @Binding var fightersOrder : [Fighter]
    @Environment(\.colorScheme) var colorScheme
    var index : Int
    
    var body: some View {
        if !fightersOrder[index].isSelected {
            HStack {
                HStack{
                    Text(String(index+1))
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.body)
                    Spacer()
                    Text(fightersOrder[index].player == "PNJ" ? fightersOrder[index].name.components(separatedBy: " ").first! : fightersOrder[index].player)
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(ColorCard(state: fightersOrder[index].state), lineWidth: 2)
                        .frame(width: 160, height: 20, alignment: .trailing)
                )
            }
            .frame(width: 150, height: 25, alignment: .center)
        }
    }
    
    func ColorCard(state: STATE) -> Color {
        switch state {
        case .attack:
            return .red
        case .neutral:
            return (colorScheme == .dark ? .white : .black)
        case .defense:
            return .blue
        }
    }
}

struct FightMenu: View {
    @Binding var fightersOrder : [Fighter]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .myAlignment) {
            ForEach(fightersOrder.indices, id: \.self) { index in
                //containedView(index: index)
                HighlightedView(fightersOrder: $fightersOrder, index: index)
                    //.onAppear{print(String(index))}
                    .offset(x: -20)
                NormalView(fightersOrder: $fightersOrder, index: index)
                    //.onAppear{print(String(index))}
                    .offset(x: -20)
            }
            .onAppear {
                
            }
        }
    }
    
    func containedView(index: Int) -> AnyView {
        if fightersOrder[index].isSelected {
            return AnyView(HighlightedView(fightersOrder: $fightersOrder, index: index))
        } else {
            return AnyView(NormalView(fightersOrder: $fightersOrder, index: index))
        }
    }
}

struct FightMenu_Previews: PreviewProvider {
    @State static var previewFightersOrder = [Fighter]()
    
    static var previews: some View {
        FightMenu(fightersOrder: $previewFightersOrder)
    }
}
