//
//  SceneDelegate.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    var isUserSignIn: Bool {
        Auth.auth().currentUser != nil
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        if isUserSignIn {
            showMainScreen()
        } else {
            showSignInScreen()
        }
        
        window.makeKeyAndVisible()
    }
    
    func showSignInScreen() {
        let authCoordinator = AuthCoordinator(navigationController: UINavigationController(),
                                              onFinish: showMainScreen)
        
        window?.rootViewController = authCoordinator.rootViewController
        authCoordinator.start()
    }
    
    func showMainScreen() {
        let movieCordinator = MovieCoordinator(navigationController: UINavigationController())
        let favoriteMoviesCoordinator = FavoriteMoviesCoordinator(navigationController: UINavigationController())
        let userProfileCoordinator = UserProfileCoordinator(navigationController: UINavigationController(), onFinish: { [weak self] in
            
            let authCoordinator = AuthCoordinator(navigationController: UINavigationController(), onFinish: { [weak self] in
                self?.showMainScreen()
            })
            
            self?.window?.rootViewController = authCoordinator.rootViewController
            
            authCoordinator.start()
            
        })
        
        
        let firstTabModel = TabBarModel(image: .moviesTabImage,
                                        title: "Movies",
                                        viewController: movieCordinator.rootViewController)
        
        let secondTabModel = TabBarModel(image: .favoriteMoviesTabImage,
                                         title: "Favorites",
                                         viewController: favoriteMoviesCoordinator.rootViewController)
        
        let thirdTabModel = TabBarModel(image: .userProfileTabImage,
                                        title: "Profile",
                                        viewController: userProfileCoordinator.rootViewController)
        
        let tabBarController = MainTabBarController(models: [
            firstTabModel,
            secondTabModel,
            thirdTabModel
        ])
        
        window?.rootViewController = tabBarController
        
        movieCordinator.start()
        favoriteMoviesCoordinator.start()
        userProfileCoordinator.start()
    }
}

