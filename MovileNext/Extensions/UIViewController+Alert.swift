//
//  UIViewController+Alert.swift
//  MovileNext
//
//  Created by Matheus on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let title = "Erro"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
