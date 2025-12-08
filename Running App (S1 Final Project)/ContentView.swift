//
//  ContentView.swift
//  Running App (S1 Final Project)
//
//  Created by Maya Krishnan on 11/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{ // similar NavigationView{ ("legacy API", good if only supporting older device OS versions), but more modern (https://chatgpt.com/s/t_692e6d21be7081919093886f00d55dcc)
            ZStack{
                Color.blue.opacity(0.2).ignoresSafeArea() // changed background color to light blue
                VStack {
                    Text(" ") // added space above title
                        .font(Font.custom("Party LET", size: 40))
                    Text("welcome")
                        .font(Font.custom("Party LET", size: 75))
                    Text("Runner!")
                        .font(Font.custom("Party LET", size: 100)) // added titles with custom font and swize
                    Image("TwoRunners").resizable().frame(width: 300, height: 250) // added image of two runners (potential app icon?)
                        .padding(10)
                    Spacer()
                        NavigationLink("time my run ⏱︎", destination: StopwatchView()) // navigation link to go to stopwatch view (time your run)
                            .font(Font.custom("Didot", size: 40))
                    NavigationLink("what's my pace? 👟", destination: PaceView())
                        .font(Font.custom("Didot", size: 40))
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
