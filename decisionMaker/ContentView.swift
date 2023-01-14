//
//  ContentView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RandomView()
                .tabItem {
                    Label("Random",
                          systemImage: "dice")
                }
            DecisionMatrixView()
                .tabItem {
                    Label("Considerations",
                          systemImage: "squareshape.split.3x3")
                }
            ReinforcementView()
                .tabItem {
                    Label("Confirm",
                          systemImage: "checkmark.circle.badge.questionmark")
                }
            CostBenefitView()
                .tabItem {
                    // I'd like a justice system scale
                    // but sf icons doesn't seem to have one
                    Label("Trade",
                          systemImage: "arrow.left.arrow.right")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
