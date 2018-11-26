//
//  UIViewController.swift
//  MovileNext
//
//  Created by Matheus on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var theme: Theme = Theme(rawValue: 0)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listSubviewsOfView(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        theme = ThemeManager.currentTheme()
        changeTheme()
    }
    
    var list: [UIView] = []
    func listSubviewsOfView (view:UIView) {
        let subviews = view.subviews
        
        if subviews.count == 0 {
            return
        }
        
        for subview in subviews {
            list.append(subview)
            listSubviewsOfView(view: subview)
        }
    }
    
    func changeTheme() {
        self.view.backgroundColor = theme.backgroundColor
        
        for v in list {
            if let lb = v as? UILabel {
                lb.textColor = theme.titleTextColor
            } else if let bt = v as? UIButton {
                bt.backgroundColor = theme.backgroundColor
                bt.titleLabel?.textColor = theme.titleTextColor
                bt.imageView?.tintColor = theme.titleTextColor
            } else if let sc = v as? UISegmentedControl {
                sc.tintColor = theme.titleTextColor
            }
        }
    }
}
