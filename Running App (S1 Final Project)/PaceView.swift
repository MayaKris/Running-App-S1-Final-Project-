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
    @State private var pace = ""
    @State private var speed = ""
    @State private var convPace = ""
    @State private var convSpeed = ""
    @State private var calculated = false // to check if user is still typing/recalculating, or if calculation is true
    @State private var lastPace = "" // to store last calculated pace
    @State private var lastSpeed = "" // to store last calculated speed
    var body: some View {
        ZStack{
            Color.blue.opacity(0.1).ignoresSafeArea()
            VStack {
                Text("👟") // added shoe icon above title
                    .font(Font.custom("Party LET", size: 82))
                Text(" ") // added blank space between shoe icon and title
                    .font(Font.custom("Party LET", size: 22))
                Text("Pace Calculator") // title
                    .font(Font.custom("Party LET", size: 80))
                Text("enter your time:")
                    .font(Font.custom("Didot", size: 37))
                HStack { // textfields for users to enter data
                    TextField("Minutes", text: $minutes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)
                        .keyboardType(.numberPad) // changes to number keyboard (brings up only numbers): https://developer.apple.com/documentation/uikit/uikeyboardtype
                        .onTapGesture {
                            calculated = false // set to false when user starts typing new time (minutes)
                        }
                    TextField("Seconds", text: $seconds)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            calculated = false // set to false when user starts typing new time (seconds)
                        }
                }
                Text("enter your distance:")
                    .font(Font.custom("Didot", size: 37))
                TextField("Distance (ex. 3.1)", text: $distance)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 312)
                    .keyboardType(.decimalPad) // changes to decimal keyboard: https://developer.apple.com/documentation/uikit/uikeyboardtype
                    .onTapGesture {
                        calculated = false // set to false when user starts typing new distance
                    }
                HStack(spacing: 12) { // user can toggle distance units from km to mi (and vice versa)
                    Text("units:")
                        .font(.subheadline)
                    Text("km")
                        .font(.subheadline)
                        .fontWeight(inMiles ? .regular : .bold)
                        .foregroundColor(inMiles ? .secondary : .primary)
                    Toggle("", isOn: $inMiles)
                        .frame(width: 60)
                    Text("mi")
                        .font(.subheadline)
                        .fontWeight(inMiles ? .bold : .regular)
                        .foregroundColor(inMiles ? .primary : .secondary)
                }
                .padding()
                Button("Calculate Pace") {
                    calculated = false // reset old data
                    calculate()
                    calculated = true // show new data
                }
                .padding(10)
                if pace != "" {
                    Text("your pace: \(pace)")
                        .font(Font.custom("Didot", size: 20))
                        .padding(.bottom, 2)
                    Text("your speed: \(speed)")
                        .font(Font.custom("Didot", size: 20))
                        .padding(.top, 2)
                    Button("Convert") {
                        convertUnits()
                    }
                    .padding(10)
                    
                    
                    if convPace != "" {
                        Text("pace: \(convPace)")
                            .font(Font.custom("Didot", size: 20))
                            .padding(.bottom, 2)
                        Text("speed: \(convSpeed)")
                            .font(Font.custom("Didot", size: 20))
                            .padding(.top, 2)
                    }
                }
            }
        }
    }
    
    private func calculate() {
        let mins = Double(minutes) ?? 0 // converts text to number, else use 0
        let secs = Double(seconds) ?? 0
        let dist = Double(distance) ?? 0
        let totalSeconds = mins * 60 + secs
        if dist == 0 || totalSeconds == 0 { // in case user inputs zero or no value
            pace = ""
            speed = ""
            convPace = ""
            convSpeed = ""
            return
        }
        let secondsPerUnit = totalSeconds / dist
        let paceMin = Int(secondsPerUnit) / 60
        let paceSec = Int(secondsPerUnit) % 60
        let paceString = String(format: "%d:%02d", paceMin, paceSec) // %02d: always show two digits
        let newPace = paceString
        let newSpeedCalc = dist / (totalSeconds / 3600.0)
        let newSpeed = String(format: "%.2f", newSpeedCalc)
        if newPace != lastPace || newSpeed != lastSpeed {
            convPace = ""
            convSpeed = ""
        } // so that if a new speed/pace is calculated, the old converted results (from last values) do not still display
        if inMiles {
            pace = "\(paceString)  min/mi"
        }
        else {
            pace = "\(paceString)  min/km"
        }
        let hours = totalSeconds / 3600.0
        let speedValue = dist / hours
        if inMiles {
            speed = "\(String(format: "%.2f", speedValue)) mph"
        }
        else {
            speed = "\(String(format: "%.2f", speed)) km/h"
        }
        lastPace = newPace // save current pace as new "last" pace
        lastPace = newSpeed // save current speed as new "last" speed
    }
    
    private func convertUnits() {
        let mins = Double(minutes) ?? 0
        let secs = Double(seconds) ?? 0
        let dist = Double(distance) ?? 0
        let totalSeconds = mins * 60 + secs
        let hours = totalSeconds / 3600
        if inMiles {
            let km = dist * 1.60934
            let secPerKm = totalSeconds / km
            let min = Int(secPerKm) / 60 
            let sec = Int(secPerKm) % 60
            convPace = "\(String(format: "%d:%02d", min, sec))  min/km"
            let kmh = km / hours
            convSpeed = "\(String(format: "%.2f", kmh)) km/h"
        }
        else {
            let miles = dist * 0.621371
            let secPerMile = totalSeconds / miles
            let min = Int(secPerMile) / 60
            let sec = Int(secPerMile) % 60
            convPace = "\(String(format: "%d:%02d", min, sec))  min/mi"
            let mph = miles / hours
            convSpeed = "\(String(format: "%.2f", mph)) mph"
        }
        
    }
}


#Preview {
    PaceView()
}
