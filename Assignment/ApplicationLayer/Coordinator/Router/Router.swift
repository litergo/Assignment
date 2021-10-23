//
//  Router.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import SwiftUI

protocol Router {
  var navigationController: UINavigationController? { get }
  
  var viewController: UIViewController? { get }
  
  func present<Content: View>(style: UIModalPresentationStyle,
                              view: Content,
                              completion: Completion?)
  
  
  func setRootNavigation<Content:View>(views:[Content], animated:Bool)
  
  func dismiss(animated: Bool, completion: (() -> Void)?)
}
