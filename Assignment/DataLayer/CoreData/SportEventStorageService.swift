//
//  SportEventStorageService.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation
import CoreData

protocol SportEventStorageService {
  func getSportEvents() -> Result<[SportEventModel], Error>
  func add(sportEvent: SportEventModel)
}

final class SportEventStorageServiceImp {
  
  private let coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
}

extension SportEventStorageServiceImp: SportEventStorageService {
  func add(sportEvent: SportEventModel) {
    let event = SportEventMO(context: coreDataStack.mainContext)
    event.name = sportEvent.name
    event.venue = sportEvent.venue
    event.duration = Int32(sportEvent.duration)
    coreDataStack.saveMainContext()
  }
  
  func getSportEvents() -> Result<[SportEventModel], Error> {
    let eventFetch: NSFetchRequest<SportEventMO> = SportEventMO.fetchRequest()
    do {
      let results = try coreDataStack.mainContext.fetch(eventFetch)
      return .success(results.map {
        SportEventModel(name: $0.name ?? "",
                        venue: $0.venue ?? "",
                        duration: Int($0.duration),
                        inRemote: false)})
    } catch let error as NSError {
      return .failure(error)
    }
  }
}
