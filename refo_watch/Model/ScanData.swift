//
//  ScanData.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 26/07/22.
//

import Foundation

struct ScanData:Identifiable {
    var id = UUID()
    let content:String
    
    init(content:String) {
        self.content = content
    }
}
