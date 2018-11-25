//
//  SettingsViewController.swift
//  MovileNext
//
//  Created by Matheus on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var scColors: UISegmentedControl!
    @IBOutlet weak var swAutoplay: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scColors.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "color")
        swAutoplay.setOn(UserDefaults.standard.bool(forKey: "autoplay"), animated: false)
    }
    
    @IBAction func changeColor(_ sender: UISegmentedControl) {
        ThemeManager.applyTheme(Theme(rawValue: scColors.selectedSegmentIndex)!)
        changeTheme()
    }
    
    @IBAction func changeAutoplay(_ sender: UISwitch) {
        UserDefaults.standard.set(swAutoplay.isOn, forKey: "autoplay")
    }

}
