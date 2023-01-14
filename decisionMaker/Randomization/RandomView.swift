//
//  RandomView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct RandomView: View {
    @State var selection: String = "coin"
    @State var showHelp: Bool = false

    var body: some View {
        VStack {
            Spacer()
            switch selection {
            case "coin":
                CoinView()
            case "dice":
                DiceView()
            case "8ball":
                EightBallView()
            default:
                Text("You've gone too far")
            }
            Spacer()
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Picker(selection: $selection) {
                    ForEach(["coin", "dice", "8ball"], id: \.self) { name in
                        Text(name)
                    }
                } label: {
                    EmptyView()
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)

                Button {
                    showHelp = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
                .offset(x: -6)
            }
        }
        .sheet(isPresented: $showHelp) {
            NavigationView {
                RandomizationHelpView()
                    .navigationTitle("Help")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
