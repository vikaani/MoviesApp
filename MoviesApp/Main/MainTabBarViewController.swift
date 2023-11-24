//
//  MainTabBarViewController.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit

struct TabBarModel {
    var image: UIImage
    var title: String
    var viewController: UIViewController
}

class MainTabBarController: UITabBarController {
    private let models: [TabBarModel]
    
    init(models: [TabBarModel]) {
        self.models = models
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewControllers = models.map { $0.viewController }
        
        models.enumerated().forEach { index,model in
            setupTabBarItem(index: index, model: model)
        }
    }
    
    private func setupTabBarItem(index: Int, model: TabBarModel) {
        tabBar.items![index].image = model.image
        tabBar.items![index].title = model.title
    }
}

