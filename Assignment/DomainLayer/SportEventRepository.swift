//
//  SportEventRepository.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

protocol SportEventRepository {
  func getSportEvents(callback: @escaping Callback<[SportEventModel]>)
  func add(sportEvent: SportEventModel)
}

class SportEventRepositoryImp {
  
  private let storageService: SportEventStorageService
  private let firabaseProvider: FirebaseDatabaseProvider
  init(storageService: SportEventStorageService,
       firabaseProvider: FirebaseDatabaseProvider) {
    self.storageService = storageService
    self.firabaseProvider = firabaseProvider
  }
}

extension SportEventRepositoryImp: SportEventRepository {
  func getSportEvents(callback: @escaping Callback<[SportEventModel]>) {
    let storedEvents = storageService.getSportEvents()
    firabaseProvider.getEvents {
      if case let .success(result) = $0 {
        callback(.success(storedEvents + result))
      } else {
        callback(.success(storedEvents))
      }
    }
  }
  
  func add(sportEvent: SportEventModel) {
    if sportEvent.inRemote {
      firabaseProvider.add(event: sportEvent)
    } else {
      storageService.add(sportEvent: sportEvent)
    }
  }
}

