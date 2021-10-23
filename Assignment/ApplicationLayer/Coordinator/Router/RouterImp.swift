//
//  RouterImp.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import SwiftUI


final class RouterImp {
  var rootController: UINavigationController?
  
  init(rootController: UINavigationController?) {
    self.rootController = rootController
  }
}

extension RouterImp: Router {
  
  var navigationController: UINavigationController? {
    return rootController
  }
  
  var viewController: UIViewController? {
    return rootController?.viewControllers.last
  }
  
  func present<Content: View>(style: UIModalPresentationStyle = .automatic,
                              view: Content,
                              completion: Completion? = nil) {
    let toPresent = UIHostingController(rootView: view)
    let navToPresent = UINavigationController(rootViewController: toPresent)
    navToPresent.navigationBar.isHidden = true
    rootController?.present(navToPresent, animated: true, completion: completion)
  }
  
  func setRootNavigation<Content:View>(views: [Content], animated: Bool = true) {
    let controllers =  views.compactMap { UIHostingController(rootView: $0) }
    rootController?.setViewControllers(controllers, animated: animated)
  }
  
  func dismiss(animated: Bool = true, completion: Completion? = nil) {
    rootController?.dismiss(animated: animated, completion: completion)
  }
  
}
