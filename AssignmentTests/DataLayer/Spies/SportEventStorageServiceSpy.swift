//
//  SportEventStorageServiceSpy.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

@testable import Assignment

final class SportEventStorageServiceSpy: SportEventStorageService {
  var getSportEventsInvoked = false
  var addEventInvoked = false
  var getSportEventsReturnValue: Result<[SportEventModel], Error> = .success([])
  
  func getSportEvents() -> Result<[SportEventModel], Error> {
    getSportEventsInvoked = true
    return getSportEventsReturnValue
  }
  
  func add(sportEvent: SportEventModel) {
    addEventInvoked = true
  }
}
