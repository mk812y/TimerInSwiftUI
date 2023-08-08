//
//  ContentView.swift
//  TimerInSwiftUI
//
//  Created by Михаил Куприянов on 8.8.23..
//

import SwiftUI

struct ContentView: View {
    @State var currentDate = Date.now
    @State var count = 0
    
    @State var dateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() //date timer update the time for every second
    @State var countTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() //update the counter
    
    var body: some View {
        VStack {
            Text("Date: \(currentDate.formatted(date: .numeric, time: .standard))")
                .font(.title)
                .onReceive(dateTimer) { input in
                    currentDate = input
                }
            Text("Count: \(count)")
                .font(.largeTitle)
                .onReceive(countTimer) { _ in
                    count += 1
                }
            Group {
                Button("Stop the timers") {
                    dateTimer.upstream.connect().cancel()
                    countTimer.upstream.connect().cancel()
                }
                Button("Restart the timer") {
                    dateTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    countTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
                .padding()
                .background(.blue)
                .cornerRadius(8)
                .foregroundColor(.white)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
