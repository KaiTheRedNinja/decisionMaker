//
//  DiceView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct DiceView: View {
    @State var currentFace: Int = 1
    @State var bounce: Bool = false
    @State var rotation: CGFloat = 0
    @State var horizontalOffset: CGFloat = 0

    var body: some View {
        VStack {
            Button {
                roll(times: 5)
            } label: {
                dice
                    .foregroundColor(.primary)
            }
            Color.primary
                .frame(height: 6)
        }
    }

    var dice: some View {
        Image(systemName: "die.face.\(currentFace)")
            .resizable()
            .frame(width: 100, height: 100)
            .rotation3DEffect(.degrees(rotation), axis: (x: 0,
                                                         y: 0,
                                                         z: 1))
            .offset(x: horizontalOffset, y: bounce ? -10 : 10)
    }

    func roll(times: Int) {
        let duration = 0.1

        guard times > 0 else {
            withAnimation {
                horizontalOffset = 0
            }
            return
        }
        if horizontalOffset > 80*2 {
            horizontalOffset = -80*2
        }
        withAnimation(.linear(duration: duration * 2)) {
            horizontalOffset += 80
        }
        withAnimation(.easeIn(duration: duration)) {
            bounce.toggle()
            rotation += 45
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.easeOut(duration: duration)) {
                bounce.toggle()
                rotation += 45
                currentFace = .random(in: 1..<7)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                roll(times: times-1)
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
