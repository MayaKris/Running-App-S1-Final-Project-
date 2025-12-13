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
    @State private var timer: Timer? // optional, can be a real timer when running (active) or nil when no timer exists; controls stopwatch updates
    @State private var statusMessage = "Ready to run?" // status message
    @State private var milestonesReached: Set<Int> = [] // so messages don't repeat every 0.01 seconds by tracking which motivational messages the user has already triggered; starts empty and stores integers via <Int> ; is a data structure (similar to an array, but stores items only once and has no duplicates so good for checking if something has been done before)
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).ignoresSafeArea() // changed background color to light blue
            VStack {
                Text("⏱️") // added clock icon above title
                    .font(Font.custom("Party LET", size: 115))
                Text(statusMessage) // display status message
                    .font(Font.custom("Didot", size: 40))
                Text((isRunning || time == 0) ? formatTimeRunning(time) : formatTime(time)) // creates string in time (0:00) format, with 2 decimal places (%.2f)
                    .font(Font.custom("Party LET", size: 107))
                    .monospacedDigit() // makes sure spacing is correct between digits whenever it's moving, each number takes the same width (for example with 1 and 9, where 1 is typically thinner than 9)
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
    
    private func formatTime(_ time: Double) -> String { // change stopwatch to counting in mm:ss format (https://chatgpt.com/s/t_69378cc1aad48191906a68ac810a8426)
        let totalMili = Int(time * 100)
        let minutes = totalMili / 6000
        let seconds = (totalMili / 100) % 60
        let mili = totalMili % 100
        return String(format: "%02d:%02d:%02d", minutes, seconds, mili)
    }
    
    private func formatTimeRunning(_ time: Double) -> String {
        let totalMili = Int(time * 100)
        let minutes = totalMili / 6000
        let seconds = (totalMili / 100) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        isRunning = true
        if time == 0 { // THS INITIAL MESSAGE IS ONLY FOR WHEN USERS FIRST BEGIN THEIR RUN
            statusMessage = "Off to a great start!" // status message changed to motivational message
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) // makes it repeat in milliseconds
        { _ in // closure: block of code that runs later; _ is a parameter but doesn't use it (ignores the input)
            time += 0.01
            checkMilestones()
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate() // stopwatch is stopped
        if time > 0 {
            statusMessage = "Great run!" // status message changed to congratulatory message
        }
    }
    
    private func resetTimer() {
        let wasRunning = time > 0 // to determine if stopwatch was reset AFTER a run (because stopwatch was running)
        stopTimer() // stopwacth is stopped, using call to stopTimer() function
        time = 0.0 // time (displayed) is reset to 0:00
        milestonesReached.removeAll()
        if wasRunning {
            statusMessage = "Running more?" // if stopwatch was reset AFTER a run, display new message
        }
        else if statusMessage == "Running more?" {
            statusMessage = "Running more?" // status message is kept same after a run (in case reset button is clicked multiple times after a run)
        }
        else {
            statusMessage = "Ready to run?" // if stopwatch was not running (no run), keep initial status message (in case reset button is just clicked multiple times, without starting or stopping the stopwatch to run)
        }
    }
    
    private func checkMilestones() {
        let seconds = Int(time) // time (double) is converted to whole seconds (integer)
        let milestones: [Int: String] = [ // creating an array of different motivational messages, so it changes/updates as you reach more milestones (as you run for longer)
            300: "You're doing great!",
            600: "Keep pushing!",
            1200: "You're a pro!",
            1800: "You're unstoppable!",
            2400: "Don't give up." ]
        for (milestoneTime, message) in milestones {
            if seconds >= milestoneTime && !milestonesReached.contains(milestoneTime) {
                statusMessage = message // checking if the array already contains a message, which would mean it has already been displayed
                milestonesReached.insert(milestoneTime) // if not, then this new milestone motivational message is added
            }
        }
    }
}

#Preview {
    StopwatchView()
}
