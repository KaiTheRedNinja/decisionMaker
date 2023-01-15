//
//  EightBallView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

var options: [String] = [
    "It is certain.",
    "It is decidedly so.",
    "Without a doubt.",
    "Yes definitely.",
    "You may rely on it.",

    "As I see it, yes.",
    "Most likely.",
    "Outlook good.",
    "Yes.",
    "Signs point to yes.",

    "Reply hazy, try again.",
    "Ask again later.",
    "Better not tell you now.",
    "Cannot predict now.",
    "Concentrate and ask again.",

    "Don't count on it.",
    "My reply is no.",
    "My sources say no.",
    "Outlook not so good.",
    "Very doubtful."
]

struct EightBallView: View {
    @State var bounce: Bool = false
    @State var viewOffset: Bool = true
    @State var zoomIntoTriangle: Bool = false
    @State var triangleIsVisible: Bool = false
    @State var option: String = ""

    var body: some View {
        VStack {
            eightBall
                .scaleEffect(zoomIntoTriangle ?
                    .init(width: 4, height: 4) :
                    .init(width: 1, height: 1))
                .onTapGesture {
                    if zoomIntoTriangle {
                        withAnimation {
                            zoomIntoTriangle = false
                            viewOffset = true
                        }
                    } else {
                        bounce(times: 5)
                        withAnimation {
                            triangleIsVisible = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                            option = options.randomElement() ?? "Try Again Later"
                            withAnimation {
                                triangleIsVisible = true
                                zoomIntoTriangle = true
                                viewOffset = false
                            }
                        }
                    }
                }
        }
    }

    var eightBall: some View {
        ZStack {
            Circle()
                .foregroundColor(.black)
                .frame(width: 300, height: 300)
                .blur(radius: 20)
                .offset(x: -8, y: 10)
            Circle()
                .foregroundColor(.black)
                .frame(width: 300, height: 300)

            ZStack {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 120, height: 120)
                Circle()
                    .foregroundColor(.secondary)
                    .frame(width: 100, height: 100)
                Triangle()
                    .foregroundColor(.init(red: 0,
                                           green: 0,
                                           blue: 80/255))
                    .offset(y: -8)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                    .frame(width: 50*1.5,
                           height: 43*1.5)
                    .overlay {
                        Text(option)
                            .foregroundColor(.init(uiColor: .systemBackground))
                            .multilineTextAlignment(.center)
                    }
                    .opacity(triangleIsVisible ? 1 : 0)
            }
            .offset(x: viewOffset ? 15 : 0,
                    y: viewOffset ? 15 : 0)
        }
        .offset(y: bounce ? -100 : 0)
    }

    func bounce(times: Int) {
        guard times > 0 else { return }
        let duration = 0.1
        withAnimation(.easeInOut(duration: duration)) {
            bounce = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.easeInOut(duration: duration)) {
                bounce = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            bounce(times: times-1)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct EightBallView_Previews: PreviewProvider {
    static var previews: some View {
        EightBallView()
    }
}
