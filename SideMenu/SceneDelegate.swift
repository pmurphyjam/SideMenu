//
//  SceneDelegate.swift
//  SwiftDemo
//
//  Created by Pat Murphy on 7/28/20.
//  Copyright © 2020 Pat Murphy. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let kGuardian = KeyboardGuardian(textFieldCount: 4)
        //Add the KeyBoardGuardian as an EnvironmentObject since this is the only way it works properly otherwise slide is not correct
        let viewModel = LoginVM(username: "", navBarHidden: NavBarHidden())
        let rootView = AppRootView().environmentObject(kGuardian).environmentObject(viewModel)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func changeRootSwiftViewToMenu() {
        guard let window = self.window else {
            return
        }
        let username = Settings.shared.userName
        let viewModel = LoginVM(username:username, navBarHidden: NavBarHidden())
        viewModel.password = Settings.shared.userPassword
        let contentView = MenuView(menuState: MenuState()).environmentObject(viewModel)
        let cv = UIHostingController(rootView: contentView)
        window.rootViewController = cv
    }

    func changeRootSwiftViewToLogin() {
        guard let window = self.window else {
            return
        }
        let kGuardian = KeyboardGuardian(textFieldCount: 4)
        //Add the KeyBoardGuardian as an EnvironmentObject since this is the only way it works properly otherwise slide is not correct
        let viewModel = LoginVM(username: "", navBarHidden: NavBarHidden())
        let contentView = LoginView().environmentObject(kGuardian).environmentObject(viewModel)
        let cv = UIHostingController(rootView: contentView)
        window.rootViewController = cv
    }

    func changeRootSwiftViewToLoginWithUsername(username:String) {
        guard let window = self.window else {
            return
        }
        let kGuardian = KeyboardGuardian(textFieldCount: 4)
        //Add the KeyBoardGuardian as an EnvironmentObject since this is the only way it works properly otherwise slide is not correct
        let viewModel = LoginVM(username:username, navBarHidden: NavBarHidden())
        let contentView = LoginView().environmentObject(kGuardian).environmentObject(viewModel)
        let cv = UIHostingController(rootView: contentView)
        window.rootViewController = cv
    }
}

