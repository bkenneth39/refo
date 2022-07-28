//
//  ContentView.swift
//  refo_watch WatchKit Extension
//
//  Created by Bryan Kenneth on 23/07/22.
//

import SwiftUI
import Foundation
import UIKit

struct ContentView: View {
    
//    init(){
//        UINavigationBar.appearance().
//    }
    
    @State private var selection: String? = nil
    
    
    var body: some View {
       
                VStack {
                    Text("Where do you want to start?")
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding()
                        .foregroundColor(Color("PrimaryColor"))
                        .frame( height:60)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: TabViewCoba(timeRemaining: 6720, startTime: 6720)) {
                        Text("Work 💪")
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryColor"))
                    }.background(Color("SecondaryColor"))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: TabViewCoba(timeRemaining: 1560, startTime: 1560)) {
                        Text("Break 😄")
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryColor"))
                    }.background(Color("SecondaryColor"))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                }
                    .frame(width: .infinity, height: .infinity, alignment: .center)
                    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
