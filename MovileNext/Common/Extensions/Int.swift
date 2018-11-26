//
//  Int+TimeInterval.swift
//  MovileNext
//
//  Created by Matheus on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    func timeFromMiliseconds() -> String {
        
        let seconds = Int(self/1000)
        let tSeconds = Int(self/1000) % 60
        
        let minutes = Int(seconds/60)
        let tMinutes = Int(seconds/60) % 60
        
        let hours = Int(minutes/60)
        
        return String(format: "%0.2d:%0.2d:%0.2d", hours, tMinutes, tSeconds)
    }
}
