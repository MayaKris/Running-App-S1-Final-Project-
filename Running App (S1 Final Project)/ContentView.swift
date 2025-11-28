//
//  ContentView.swift
//  Running App (S1 Final Project)
//
//  Created by Maya Krishnan on 11/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text(" ")
                .font(Font.custom("Party LET", size: 55))
            Text("welcome")
                .font(Font.custom("Party LET", size: 70))
            Text("Runner!")
                .font(Font.custom("Party LET", size: 100)).italic()
            Image("TwoRunners").resizable().frame(width: 275, height: 250)
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
