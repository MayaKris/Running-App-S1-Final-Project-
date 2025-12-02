//
//  StopwatchView.swift
//  Running App (S1 Final Project)
//
//  Created by Maya Krishnan on 11/27/25.
//

import SwiftUI

struct StopwatchView: View {
    // tutorial used to create stopwatch: https://youtu.be/NYL9roIH4cg?si=oGUXozqaKbIW_I2R
    @State private var time: Double = 0.0
    @State private var isRunning: Bool = false // stopwatch starts NOT running (initally, isRunning = false), so that it is not running as soon as you go to the stopwatch view
    @State private var timer: Timer? // optional; controls stopwatch updates
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).ignoresSafeArea() // changed background color to light blue
            VStack {
                Text("⏱︎") // added space above title
                    .font(Font.custom("Party LET", size: 115))
                Text(String(format: "%.2f", time)) // creates string in time (0:00) format, with 2 decimal places (%.2f)
                    .font(Font.custom("Party LET", size: 115))
                    .monospacedDigit() // makes sure spacing is correct between digits whenever it's moving
                    .padding()
                HStack {
                    Button(action: {
                        if isRunning { // checks in stopwatch is running
                            stopTimer()
                        }
                        else {
                            startTimer()
                        }
                    })
                    {
                        Image(isRunning ? "Pause" : "Play").resizable().frame(width: 50, height: 50) // if the stopwatch is running, it'll display the "pause" image, otherwise if the stopwatch isn't running it'll display the "play" image
                    }
                    .padding()
                    .background(isRunning ? .red : .green) // if the stopwatch is running, the background will be red, otherwise if the stopwatch is not running the background will be green (pause button is red, play button is green)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .padding()
                    Button(action: {
                        resetTimer()
                    })
                    {
                        Image("Reset").resizable().frame(width: 50, height: 50)
                    }
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) // makes it repeat in milliseconds
        { _ in
            time += 0.01
        }
        RunLoop.main.add(timer!, forMode: .common) // explicitly placing the stopwatch/timer on the main run loop
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate() // stopwatch is stopped
    }
    
    private func resetTimer() {
        stopTimer() // stopwacth is stopped, using call to stopTimer() function
        time = 0.0 // time (displayed) is reset to 0:00
    }
}

#Preview {
    StopwatchView()
}
