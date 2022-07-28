//
//  TabViewCoba.swift
//  refo_watch WatchKit Extension
//
//  Created by Bryan Kenneth on 25/07/22.
//

import SwiftUI


struct TabViewCoba: View {
    @State var timeRemaining = 6720
    @State var isPaused = false
    @State private var selection = 2
    @State var startTime = 6720
    @State var isBreak = false
    
    
    func convertToTime(seconds: Int) -> String{
        let minutes = seconds / 60
        let second = seconds % 60
        return String(format: "%02i:%02i", minutes, second)
    }
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        TabView(selection: $selection) {
           
            
            GeometryReader {g in
                VStack{
                    Text(convertToTime(seconds: timeRemaining))
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryColor"))
                        .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.4: g.size.height * 0.4))
                        .onReceive(timer){_ in
                            if(timeRemaining > 0){
                                timeRemaining -= 1
                            } else {
                                WKInterfaceDevice.current().play(.success)
                               
                                
                                if startTime == 6720{
                                    isBreak = true
                                    startTime = 1560
                                    timeRemaining = 1560
                                } else {
                                    isBreak = false
                                    startTime = 6720
                                    timeRemaining = 6720
                                }
                                
                            }
                            
                        }
                    
                    

                       
                }
                
                .frame(width: g.size.width, height: g.size.height, alignment: .center)
            }
            
            VStack {
                Button {
                    isPaused = !isPaused
                    if isPaused{
                        timer.upstream.connect().cancel()
                    } else {
                        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                } label: {
                    HStack {
                        Image(systemName: !isPaused ? "pause.fill" : "play.fill")
                            .foregroundColor(Color("SecondaryColor"))
                        
                        Text(!isPaused ? "Pause" : "Resume")
                            .fontWeight(.bold)
                            .foregroundColor(Color("SecondaryColor"))
                    }
                }.background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    
                Button {
                    timeRemaining = startTime
                } label: {
                    HStack {
                        Image(systemName: "repeat")
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Text("Reset")
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("PrimaryColor"), lineWidth: 2))
            }
            .padding(.horizontal)
        
            Text(!isBreak ? "Your focus determines your reality💪" : "A break from reality is needed✌️")
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryColor"))
                
        }.tabViewStyle(PageTabViewStyle())
    }
}

struct TabViewCoba_Previews: PreviewProvider {
    static var previews: some View {
        TabViewCoba()
    }
}
