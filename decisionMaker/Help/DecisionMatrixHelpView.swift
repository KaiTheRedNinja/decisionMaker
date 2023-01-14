//
//  DecisionMatrixHelpView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct DecisionMatrixHelpView: View {
    var body: some View {
        List {
            Section("What a decision matrix is") {
                Text("""
A decision matrix, also known as a decision-making matrix, is a tool used to evaluate and prioritize different options based on specific criteria. It is typically a table that lists the options being considered along one axis and the criteria used to evaluate them along the other. Each option is then scored or ranked based on how well it meets each criterion, and the scores are entered into the corresponding cells in the table. The scores can then be used to compare and rank the options, allowing for a more systematic and objective decision-making process.
""")
            }

            Section("Adding categories") {
                Image("createCategories")
                    .resizable()
                    .scaledToFit()
                Text("Press the plus button, then give it a name and a weightage out of 5 for how important that factor is")
            }
            Section("Adding options") {
                Image("createOptions")
                    .resizable()
                    .scaledToFit()
                Text("Press the plus button, then give it a name")
            }
            Section("Filling in the matrix") {
                Image("goSelectNext")
                    .resizable()
                    .scaledToFit()
                Text("Press next once you have filled in your options and categories")
                Image("starScores")
                    .resizable()
                    .scaledToFit()
                Text("""
Slide/tap the stars for each category to how much you think that option deserves for that category (eg. "making a flying car" may get a 1 for "feasability"). The options will be sorted by their score.
""")
            }
        }
    }
}

struct DecisionMatrixHelpView_Previews: PreviewProvider {
    static var previews: some View {
        DecisionMatrixHelpView()
    }
}
