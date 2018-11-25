//
//  AboutViewController.swift
//  MovileNext
//
//  Created by Matheus on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = AboutView()
    }

}
