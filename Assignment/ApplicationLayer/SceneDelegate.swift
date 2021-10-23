//
//  SceneDelegate.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var router: Router?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = (scene as? UIWindowScene) ?? window?.windowScene {
      let window = UIWindow(windowScene: windowScene)
      router = RouterImp(rootController: UINavigationController())
      let rootViewController = router?.navigationController
      rootViewController?.navigationBar.isHidden = true
      window.rootViewController = rootViewController
      self.window = window
      window.makeKeyAndVisible()
      if let router = router {
        let mainFlow = MainFlow(router: router)
        mainFlow.start()
      }
    }
  }
}

