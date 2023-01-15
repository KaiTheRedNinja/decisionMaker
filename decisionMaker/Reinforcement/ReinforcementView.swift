//
//  ReinforcementView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 14/1/23.
//

import UserNotifications
import SwiftUI

struct ReinforcementView: View {
    @State var goingToDo: Bool?
    @State var percentTimeLeft: CGFloat = 1
    @State var showHelp: Bool = false

    var body: some View {
        ZStack {
            if goingToDo != nil {
                doOrDoNotView
            } else {
                willYouDoItView
            }
        }
        .sheet(isPresented: $showHelp) {
            NavigationView {
                ReinforcementHelpView()
                    .navigationTitle("Help")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    var willYouDoItView: some View {
        VStack {
            HStack {
                Text("Are you going to do it?")
                    .font(.title)
                Button {
                    showHelp = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
            }
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
                            ZStack {
                                Color.green
                                    .cornerRadius(15)
                                    .blur(radius: 10)
                                Color.green
                                    .cornerRadius(15)
                            }
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
                            ZStack {
                                Color.red
                                    .cornerRadius(15)
                                    .blur(radius: 10)
                                Color.red
                                    .cornerRadius(15)
                            }
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
                                    .onAppear(perform: {sendNotif()})
                            } else {
                                Color.red
                                    .cornerRadius(5)
                                    .frame(width: proxy.size.width*percentTimeLeft)
                            }
                        }
                    }
                    .onAppear {
                        percentTimeLeft = 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.linear(duration: 5)) {
                                percentTimeLeft = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                guard percentTimeLeft == 0 else { return }
                                withAnimation {
                                    goingToDo = nil
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    guard percentTimeLeft == 0 else { return }
                                    percentTimeLeft = 1
                                }
                            }
                        }
                    }
            }
        }
    }
    
    func sendNotif() {
        let content = UNMutableNotificationContent()
        content.title = "Have you done it yet?"
        content.body = "Have you completed your task yet? If yes good job!"
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
           
        // Create the trigger as a repeating event.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1800, repeats: false)
        //Create notification request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        print("notification scheduled")
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
    }
}


struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        ReinforcementView()
    }
}
