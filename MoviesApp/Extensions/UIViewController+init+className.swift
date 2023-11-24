//
//  UIViewController+init+className.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import UIKit

extension UIViewController {
    static var className: String {
        "\(Self.self)"
    }
    
    convenience init(bundle: Bundle? = nil) {
        self.init(nibName: UIViewController.className, bundle: bundle)
    }
}
