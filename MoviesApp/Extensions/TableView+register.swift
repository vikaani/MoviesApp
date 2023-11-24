//
//  TableView+register.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where  T: ReusingCell {
        let nib = T.nib
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T   where  T: ReusingCell {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier , for: indexPath) as! T
    }
}


