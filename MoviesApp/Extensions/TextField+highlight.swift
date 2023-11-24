//
//  UITextField+highiglight.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import UIKit

extension UITextField {
    func highiglight(_ highlighted: Bool) {
        if highlighted {
            layer.borderWidth = 2
            layer.borderColor = UIColor.blue.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
    }
}
