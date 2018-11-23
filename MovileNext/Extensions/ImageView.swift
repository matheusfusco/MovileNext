//
//  ImageView.swift
//  MovileNext
//
//  Created by Matheus on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromURL(_ url: String) {
        let url = URL(string: url)!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}
