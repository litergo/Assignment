//
//  SportEventRepositorySpy.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

@testable import Assignment

final class SportEventRepositorySpy: SportEventRepository {
  var getSportEventsInvoked = false
  var addEventInvoked = false
  var callbackResult: Result<[SportEventModel], Error> = .success([])
  
  func getSportEvents(callback: @escaping Callback<[SportEventModel]>) {
    callback(callbackResult)
    getSportEventsInvoked = true
  }
  
  func add(sportEvent: SportEventModel) {
    addEventInvoked = true
  }
}
