//
//  CostBenefitView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI
import LoaderUI


struct CostBenefitView: View {
    @State var question: String = ""
    @State var proPoints: [String] = []
    @State var conPoints: [String] = []
    @State var error: String = ""
    @State var isLoading: Bool = false

    var body: some View {
        List {
            Section {
                TextField(
                    "Enter a term: ",
                    text: $question
                )

                if proPoints.isEmpty && conPoints.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            ask()
                        } label: {
                            Text("Ask")
                        }
                        .disabled(question.isEmpty)
                        Spacer()
                    }
                }
            }

            if isLoading {
                Section {
                    HStack {
                        BallScaleRippleMultiple()
                            .frame(width: 120, height: 120)
                            .padding(93)
                    }
                }
            }

            if !error.isEmpty {
                Section {
                    Text(error)
                }
            }

            if !(proPoints.isEmpty && conPoints.isEmpty) {
                Section("Pros") {
                    ForEach(proPoints, id: \.self) { word in
                        Text(word)
                    }
                }
                Section("Cons") {
                    ForEach(conPoints, id: \.self) { word in
                        Text(word)
                    }
                }
            }
        }
        .navigationTitle("AI Pros and Cons")
        .navigationBarTitleDisplayMode(.inline)
    }

    func ask() {
        isLoading = true
        generateAnswer(question: question) { points in
            defer { isLoading = false }

            let strPoints = (points?.map {
                String($0)
            }) ?? []

            guard let prosIndex = strPoints.firstIndex(of: "Pros:"),
                  let consIndex = strPoints.firstIndex(of: "Cons:")
            else { return }

            self.proPoints = Array(strPoints[(prosIndex+1)..<(consIndex)])
            self.conPoints = Array(strPoints[(consIndex+1)...])
        } onError: { error in
            isLoading = false
            self.error = "Failure: \(error.localizedDescription)"
        }
    }
}

struct CostBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CostBenefitView()
        }
    }
}
