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
    func listSubviewsOfView (view:UIView){
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
            if v is UILabel {
                (v as! UILabel).textColor = theme.titleTextColor
            }
            if v is UIButton {
                (v as! UIButton).backgroundColor = theme.backgroundColor
                (v as! UIButton).titleLabel?.textColor = theme.titleTextColor
                (v as! UIButton).imageView?.tintColor = theme.titleTextColor
            }
            if v is UISegmentedControl {
                (v as! UISegmentedControl).tintColor = theme.titleTextColor
            }
        }
    }
}
