//
//  ReinforcementHelpView.swift
//  decisionMaker
//
//  Created by Kai Quan Tay on 15/1/23.
//

import SwiftUI

struct ReinforcementHelpView: View {
    var body: some View {
        List {
            Section("How does this work?") {
                Text("Certain decisions are decisions that are obvious which option you should take. However, you may be unwilling to do it. For example, surfing social media until sunrise vs going to sleep.")
                Text("By pressing a button, you, in a way, solidify your choice. This makes it psychologically easier to do or not do whatever you're thinking of.")
            }
        }
    }
}

struct ReinforcementHelpView_Previews: PreviewProvider {
    static var previews: some View {
        ReinforcementHelpView()
    }
}
