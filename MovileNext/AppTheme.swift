//
//  AppTheme.swift
//  MovileNext
//
//  Created by Matheus on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import UIKit

enum Theme: Int {
    
    case theme1, theme2
    
    var backgroundColor: UIColor {
        switch self {
        case .theme1:
            return .white
        case .theme2:
            return .black
        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .theme1:
            return .black
        case .theme2:
            return .white
        }
    }

}

class ThemeManager {
    
    static func currentTheme() -> Theme {
        return Theme(rawValue: UserDefaults.standard.integer(forKey: "color")) ?? .theme1
    }
    
    static func applyTheme(_ theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: "color")
        UserDefaults.standard.synchronize()
    }
    
}
