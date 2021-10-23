//
//  MainFlow.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

class MainFlow {
  let router: Router
  
  init(router: Router) {
    self.router = router
  }
}

extension MainFlow {
  func start() {
    var destination = MainModuleAssembly.build()
    
    destination.presentSheet = {
      self.startCreateEventFlow(from: destination)
    }
    
    router.setRootNavigation(views: [destination], animated: false)
  }
}

private extension MainFlow {
  func startCreateEventFlow(from view: MainView) {
    let createEvent = CreateEventModuleAssembly.build()
    createEvent.viewModel.finishFlow = { model in
      view.viewModel.add(event: model)
      self.router.dismiss(animated: true, completion: nil)
    }
    router.present(style: .formSheet, view: createEvent, completion: nil)
  }
}
