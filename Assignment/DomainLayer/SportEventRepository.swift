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
  private let firebaseProvider: FirebaseDatabaseProvider
  init(storageService: SportEventStorageService,
       firebaseProvider: FirebaseDatabaseProvider) {
    self.storageService = storageService
    self.firebaseProvider = firebaseProvider
  }
}

extension SportEventRepositoryImp: SportEventRepository {
  func getSportEvents(callback: @escaping Callback<[SportEventModel]>) {
    var events: [SportEventModel] = []
    
    let storedEventsResult = storageService.getSportEvents()
    switch storedEventsResult {
    case .success(let storedEvents):
      events = storedEvents
    case .failure(let error):
      callback(.failure(error))
      return
    }
    
    firebaseProvider.getEvents { result in
      switch result {
      case .success(let firebaseEvents):
        callback(.success(firebaseEvents + events))
      case .failure(let error):
        callback(.failure(error))
      }
    }
  }
  
  func add(sportEvent: SportEventModel) {
    if sportEvent.inRemote {
      firebaseProvider.add(event: sportEvent)
    } else {
      storageService.add(sportEvent: sportEvent)
    }
  }
}

