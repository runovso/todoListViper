//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = ToDoListAssembly.build()
        let nc = UINavigationController(rootViewController: vc)
        window.rootViewController = nc
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CDContainer.Context.allCases.forEach {
            let moc = $0.moc
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print("Error trying to save changes in \(moc) while entering background: \(error.localizedDescription)")
                }
            }
        }
    }
}

