//
//  FirebaseDatabaseProviderSpy.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

@testable import Assignment

final class FirebaseDatabaseProviderSpy: FirebaseDatabaseProvider {
  var getSportEventsInvoked = false
  var addEventInvoked = false

  func add(event: SportEventModel) {
    addEventInvoked = true
  }
  
  func getEvents(callback: @escaping Callback<[SportEventModel]>) {
    getSportEventsInvoked = true
  }
}
