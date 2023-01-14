//
//  CoinView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct CoinView: View {
    @State var yRotations: CGFloat = 0
    @State var zRotations: CGFloat = 0
    @State var bounce: Bool = false

    @State var coinState: Bool = true
    @State var veryBlurIcon: Bool = false

    @State var flipNumber: Int = 0

    var body: some View {
        VStack {
            Button {
                let currentFlipNumber = flipNumber

                yRotations = 0
                zRotations = 0
                withAnimation(.easeOut(duration: 2)) {
                    yRotations = 360 * CGFloat(Int.random(in: 3..<7))
                }
                withAnimation(.easeInOut(duration: 2/3)) {
                    zRotations = 5
                    veryBlurIcon = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2/3) {
                    guard currentFlipNumber == flipNumber else { return }
                    coinState = .random()
                    withAnimation(.easeInOut(duration: 2/3)) {
                        zRotations = -5
                        veryBlurIcon = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2/3) {
                        guard currentFlipNumber == flipNumber else { return }
                        withAnimation(.easeInOut(duration: 2/3)) {
                            zRotations = 0
                        }
                    }
                }
            } label: {
                coin
            }
        }
    }

    var coin: some View {
        ZStack {
            Circle()
                .foregroundColor(.yellow)
            Image(systemName: coinState ? "crown" : "leaf")
                .font(.title)
                .foregroundColor(.primary)
                .blur(radius: veryBlurIcon ? 20 : 0)
        }
        .frame(width: 160, height: 160)
        .rotation3DEffect(.degrees(yRotations), axis: (x: 0,
                                                      y: 1,
                                                      z: 0))
        .rotation3DEffect(.degrees(zRotations), axis: (x: 0,
                                                      y: 0,
                                                      z: 1))
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView()
    }
}
