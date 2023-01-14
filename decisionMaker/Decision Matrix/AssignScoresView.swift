//
//  AssignScoresView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct AssignScoresView: View {
    @State var categories: [Category]
    @State var options: [Option]

    var body: some View {
        List {
            ForEach($options) { $option in
                Section {
                    ForEach(categories) { category in
                        SetScoreCell(option: $option, category: category)
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text(option.title)
                        if options.first?.id == option.id {
                            HStack {
                                Text("Category Name")
                                Spacer()
                                Text("Score")
                            }
                        }
                    }
                }
            }

            Section("Scores") {
                ForEach(Array(options.sorted(by: {
                    $0.totalScore() > $1.totalScore()
                }).enumerated()), id: \.element) { index, option in
                    if index == 0 {
                        HStack {
                            Text(option.title)
                            Spacer()
                            Text(String(option.totalScore()))
                        }
                        .listRowBackground(Color.green.opacity(0.3))
                    } else {
                        HStack {
                            Text(option.title)
                            Spacer()
                            Text(String(option.totalScore()))
                        }
                    }
                }
            }
        }
        .navigationTitle("Assign Scores")
    }
}

struct AssignScoresView_Previews: PreviewProvider {
    static var previews: some View {
        AssignScoresView(categories: [
            .init(title: "test 1", weight: 3),
            .init(title: "i am cat", weight: 2),
            .init(title: "oooo", weight: 5),
        ], options: [
            .init(title: "option b", scores: [:]),
            .init(title: "hello there", scores: [:])
        ])
    }
}
