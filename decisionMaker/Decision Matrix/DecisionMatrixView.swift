//
//  DecisionMatrixView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct DecisionMatrixView: View {
    var body: some View {
        NavigationView {
            CreateCategoriesView()
        }
    }
}

struct Category: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var weight: Int
}

struct Option: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var scores: [Category: Int]

    func totalScore() -> Int {
        scores.map { key, value in
            (key.weight+1) * value
        }
        .reduce(0) { partialResult, value in
            partialResult + value
        }
    }
}

struct DecisionMatrixView_Previews: PreviewProvider {
    static var previews: some View {
        DecisionMatrixView()
    }
}
