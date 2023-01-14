//
//  RandomizationMatrixHelpView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 15/1/23.
//

import SwiftUI

struct RandomizationHelpView: View {
    var body: some View {
        List {
            Section("Changing the randomization method") {
                Image("changeDevice")
                    .resizable()
                    .scaledToFit()
                Text("Choose a method in the picker")
            }
            Section("Flipping the coin") {
                Image("coin")
                    .resizable()
                    .scaledToFit()
                Text("Tap on the coin. The coin will spin and the answer will appear.")
            }
            Section("Rolling the dice") {
                Image("dice")
                    .resizable()
                    .scaledToFit()
                Text("Tap on the dice. The dice will roll and stop at a number.")
            }
            Section("Shaking the 8 ball") {
                Image("8ball")
                    .resizable()
                    .scaledToFit()
                Text("Tap on the 8 ball. The ball will shake and then zoom in to reveal the answer.")
            }
            Section("Exiting the 8 ball") {
                Image("zoom")
                    .resizable()
                    .scaledToFit()
                Text("Tap on the 8 ball again to exit the zoomed state")
            }
        }
    }
}

struct RandomizationMatrixHelpView_Previews: PreviewProvider {
    static var previews: some View {
        RandomizationHelpView()
    }
}
