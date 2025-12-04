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
    @State private var inMiles = true // if false, then the user chose kilometers
    var body: some View {
        ZStack{
            Color.blue.opacity(0.1).ignoresSafeArea()
            VStack {
                Text("Pace Calculator") // title
                    .font(Font.custom("Party LET", size: 75))
                Text("enter your time")
                    .font(Font.custom("Didot", size: 37))
                HStack { // textfields for users to enter data
                    TextField("Minutes", text: $minutes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad) // changes to number keyboard (brings up only numbers): https://developer.apple.com/documentation/uikit/uikeyboardtype
                }
                Text("enter your distance")
                    .font(Font.custom("Didot", size: 37))
                TextField("Distance (ex. 3.1)", text: $distance)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad) // changes to decimal keyboard: https://developer.apple.com/documentation/uikit/uikeyboardtype
                HStack { // user can toggle distance units from km to m (and vice versa)
                    Text("units:")
                    Text("km")
                    Toggle("", isOn: $inMiles)
                    Text("mi")
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PaceView()
}
