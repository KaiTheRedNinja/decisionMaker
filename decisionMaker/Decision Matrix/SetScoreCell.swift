//
//  SetScoreCell.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct SetScoreCell: View {
    @Binding var option: Option
    @State var category: Category

    var body: some View {
        HStack {
            HStack {
                Text(category.title)
                Spacer()

                HStack {
                    ForEach(0..<5) { index in
                        ZStack {
                            Image(systemName: "star.fill")

                            if index < (option.scores[category] ?? 0) {
                                Image(systemName: "circle.fill")
                                    .blur(radius: 25)
                            }
                        }
                        .foregroundColor(index < (option.scores[category] ?? 0) ? .yellow : .gray)
                    }
                }
                .overlay {
                    GeometryReader { geometry in
                        Color.white.opacity(0.001)
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged{ gesture in
                                    let segmentWidth = geometry.size.width/5
                                    let location = Int(gesture.location.x/segmentWidth)
                                    withAnimation(.linear(duration: 0.1)) {
                                        option.scores[category] = max(0, min(location+1, 5))
                                    }
                                }
                                .onEnded { gesture in
                                    let segmentWidth = geometry.size.width/5
                                    let location = Int(gesture.location.x/segmentWidth)
                                    withAnimation(.linear(duration: 0.1)) {
                                        option.scores[category] = max(0, min(location+1, 5))
                                    }
                                })
                    }
                }
            }
        }
    }
}
