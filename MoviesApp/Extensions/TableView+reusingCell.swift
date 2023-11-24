//
//  TableView+reusingCell.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit

protocol ReusingCell {
    static var className: String { get }
}

extension ReusingCell  {
    
    static var className: String {
        "\(Self.self)"
        
    }
    
    static var reuseIdentifier: String {
        return self.className
    }
    
    static var nib : UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}

extension UITableViewCell : ReusingCell {}


