//
//  AuthCoordinator.swift
//  MoviesApp
//
//  Created by 1 on 18.11.2023.
//

import UIKit

protocol Coordinator {
    func start()
}

class AuthCoordinator: Coordinator {
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
        openSignInScreen()
    }
    
    private func openSignInScreen() {
        let signInAutenticator = FireBaseSignInAuthenticator()
        let signInViewController = SignInViewController(signInAutenticator: signInAutenticator)
        signInViewController.onTapSignUpButton = openSignUpScreen
        signInViewController.onCompleteSignIn = onFinish
        navigationController.pushViewController(signInViewController, animated: true)
    }
    
    private func openSignUpScreen() {
        let signUpAutenticator = FireBaseSignUpAuthenticator()
        let signUpViewController = SignUpViewController(signUpAutenticator: signUpAutenticator)
        signUpViewController.onCompleteSignUp = onFinish
        navigationController.viewControllers.append(signUpViewController)
    }
    
}
