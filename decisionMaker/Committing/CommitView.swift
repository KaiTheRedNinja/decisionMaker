//
//  CommitView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import SwiftUI

struct CommitView: View {
    @State var goingToDo: Bool?
    @State var percentTimeLeft: CGFloat = 1

    var body: some View {
        ZStack {
            if goingToDo != nil {
                doOrDoNotView
            } else {
                willYouDoItView
            }
        }
    }

    var willYouDoItView: some View {
        VStack {
            Text("Are you going to do it?")
                .font(.title)
                .padding(.bottom, 30)
            HStack {
                Spacer()
                Button {
                    goingToDo = true
                } label: {
                    Text("YES")
                        .font(.title)
                        .foregroundColor(.init(uiColor: UIColor.systemBackground))
                        .frame(width: 140, height: 100)
                        .background {
                            Color.green
                                .cornerRadius(15)
                        }
                }
                Spacer()
                Button {
                    goingToDo = false
                } label: {
                    Text("NO")
                        .font(.title)
                        .foregroundColor(.init(uiColor: UIColor.systemBackground))
                        .frame(width: 140, height: 100)
                        .background {
                            Color.red
                                .cornerRadius(15)
                        }
                }
                Spacer()
            }
        }
    }

    var doItView: some View {
        ZStack {
            Color.green
                .opacity(0.5)
                .ignoresSafeArea()
            Text("GO DO IT!")
                .font(.title)
                .bold()
        }
    }

    var doOrDoNotView: some View {
        ZStack {
            if goingToDo ?? true {
                Color.green
                    .opacity(0.5)
                    .ignoresSafeArea()
                Text("GO DO IT!")
            } else {
                Color.red
                    .opacity(0.5)
                    .ignoresSafeArea()
                Text("DONT DO IT!")
            }
        }
        .font(.title)
        .bold()
        .safeAreaInset(edge: .bottom) {
            Button {
                withAnimation {
                    goingToDo = nil
                }
            } label: {
                Text("Return")
                    .foregroundColor(.primary)
                    .padding(10)
                    .background {
                        GeometryReader { proxy in
                            if goingToDo ?? true {
                                Color.green
                                    .cornerRadius(5)
                                    .frame(width: proxy.size.width*percentTimeLeft)
                            } else {
                                Color.red
                                    .cornerRadius(5)
                                    .frame(width: proxy.size.width*percentTimeLeft)
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.linear(duration: 5)) {
                                percentTimeLeft = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation {
                                    goingToDo = nil
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    percentTimeLeft = 1
                                }
                            }
                        }
                    }
            }
        }
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView()
    }
}
