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

extension MainFlow: BaseFlow {
  func start() {
    let coreDataStack = CoreDataStackImp(with: "SportEvent")
    let storageService = SportEventStorageServiceImp(coreDataStack: coreDataStack)
    let firebaseProvider = FirebaseDatabaseProviderImp()
    let repository = SportEventRepositoryImp(storageService: storageService,
                                             firebaseProvider: firebaseProvider)
    let viewModel = MainViewModel(repository: repository)
    var destination = MainView(viewModel: viewModel)
    
    destination.presentSheet = { [weak self] in
      self?.startCreateEventFlow(viewModel: viewModel)
    }
    
    router.setRootNavigation(views: [destination], animated: false)
  }
}

private extension MainFlow {
  func startCreateEventFlow(viewModel: MainViewModel) {
    let createEventViewModel = CreateEventViewModel()
    var createEvent = CreateEventView(viewModel: createEventViewModel)
    
    createEventViewModel.finishFlow = { model in
      viewModel.add(event: model)
      self.router.dismiss(animated: true, completion: nil)
    }
    
    createEvent.cancelFlow = { [weak self] in
      self?.router.dismiss(animated: true, completion: nil)
    }
    
    router.present(style: .formSheet, view: createEvent, completion: nil)
  }
}
