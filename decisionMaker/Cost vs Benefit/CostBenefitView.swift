//
//  CostBenefitView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct CostBenefitView: View {
    @State var question: String = ""
    @State var points: [String] = []
    var body: some View {
        List {
            Section {
                TextField(
                    "Enter a term: ",
                    text: $question
                )
            }
            
            if points.isEmpty {
                HStack {
                    Spacer()
                    Button {
                        generateAnswer(question: question) { points in
                            self.points = (points?.map {
                                String($0)
                            })!
                        }
                    } label: {
                        Text("Ask")
                    }
                    .padding(4)
                    .padding(.horizontal, 12)
                    .background {
//                        Color.red
                        Color.init(red: 0.624, green: 1.243, blue: 0.936)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
            } else {
                Section {
                    Spacer()
                    Button() {
                        generateAnswer(question: question) { points in
                            self.points = (points?.map {
                                String($0)
                            })!
                        }
                    }label: {
                        Text("Ask")
                    }
                    .padding(4)
                    .padding(.horizontal, 12)
                    .background {
//                      The Color is Aquamarine
                        Color.init(red: 0.624, green: 1.243, blue: 0.936)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
                Section {
                    Spacer()
                    ForEach(points, id: \.self) { word in
                        if word == "Pros:" || word == "Cons:"{
                            Text("\n" + word)
                        } else {
                            Text(word)
                                .padding(8)
                                .background {
                //                 The Color is Salmon
                                    Color.init(red: 1.219, green: 0.624, blue: 0.556)
                                        .cornerRadius(25)
                                }
                        }
                    }
                }
            }
        }
    }
}

struct CostBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        CostBenefitView()
    }
}
