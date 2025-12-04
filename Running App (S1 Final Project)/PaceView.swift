//
//  PaceView.swift
//  Running App (S1 Final Project)
//
//  Created by Maya Krishnan on 12/1/25.
//

import SwiftUI

struct PaceView: View {
    @State private var minutes = ""
    @State private var seconds = ""
    @State private var distance = ""
    var body: some View {
        VStack {
            Text("Pace Calculator") // title
                .font(Font.custom("Party LET", size: 75))
            Text("Enter your time:")
                .font(Font.custom("Didot", size: 40))
            HStack { // textfields for users to enter data
                TextField("Minutes", text: $minutes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad) // changes to number keyboard (brings up only numbers): https://developer.apple.com/documentation/uikit/uikeyboardtype
            }
            Text("Enter your distance")
                .font(Font.custom("Didot", size: 40))
            TextField("Distance (ex. 3.1)", text: $distance)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad) // changes to decimal keyboard: https://developer.apple.com/documentation/uikit/uikeyboardtype
        }
    }
}

#Preview {
    PaceView()
}
