//
//  UserProfileCoordinator.swift
//  MoviesApp
//
//  Created by 1 on 20.11.2023.
//

import UIKit

class UserProfileCoordinator: Coordinator {
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    private let navigationController: UINavigationController
    private let onFinish: () -> Void
    
    init(navigationController: UINavigationController, onFinish: @escaping () -> Void) {
        self.navigationController = navigationController
        self.onFinish = onFinish
    }
    
    func start() {
        openUserProfileScreen()
    }
    
    private func openUserProfileScreen() {
        let store = FirebaseUserAvatarImageStore()
        let userProfileViewController = UserProfileViewController(userAvatarImageStore: store)
        userProfileViewController.onTapSignOutButton = onFinish
        navigationController.viewControllers = [userProfileViewController]
    }
}
