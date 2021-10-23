//
//  MainModuleAssembly.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

final class MainModuleAssembly {
  static func build() -> MainView {
    let coreDataStack = CoreDataStackImp(with: "SportEvent")
    let storateService = SportEventStorageServiceImp(coreDataStack: coreDataStack)
    let firebaseProvider = FirebaseDatabaseProviderImp()
    let repository = SportEventRepositoryImp(storageService: storateService,
                                             firabaseProvider: firebaseProvider)
    let viewModel = MainViewModel(repository: repository)
    return MainView(viewModel: viewModel)
  }
}
