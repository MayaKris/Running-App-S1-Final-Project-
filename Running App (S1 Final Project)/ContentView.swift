//
//  ContentView.swift
//  Running App (S1 Final Project)
//
//  Created by Maya Krishnan on 11/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.blue.opacity(0.4).ignoresSafeArea() // changed background color to light blue
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
                HStack{
                    NavigationLink("time my run ⏱︎", destination: StopwatchView()) // navigation link to go to stopwatch view (time your run)
                        .font(Font.custom("Party LET", size: 75))
                    
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
