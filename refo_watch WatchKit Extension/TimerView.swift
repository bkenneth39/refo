//
//  TimerView.swift
//  refo_watch WatchKit Extension
//
//  Created by Bryan Kenneth on 24/07/22.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining = 6720
    @State var isPaused = false
    
    func convertToTime(seconds: Int) -> String{
        let minutes = seconds / 60
        let second = seconds % 60
        return String(format: "%02i:%02i", minutes, second)
    }
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
                Text("Hello World")
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
