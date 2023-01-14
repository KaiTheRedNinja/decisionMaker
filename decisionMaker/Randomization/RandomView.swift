//
//  RandomView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct RandomView: View {
    @State var selection: String = "coin"

    var body: some View {
        VStack {
            Spacer()
            switch selection {
            case "coin":
                CoinView()
            default:
                Text("You've gone too far")
            }
            Spacer()
        }
        .safeAreaInset(edge: .top) {
            Picker(selection: $selection) {
                ForEach(["coin", "dice", "8ball"], id: \.self) { name in
                    Text(name)
                }
            } label: {
                EmptyView()
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 10)
        }
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
