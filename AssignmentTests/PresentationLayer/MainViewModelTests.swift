//
//  MainViewModelTests.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import XCTest
@testable import Assignment

class MainViewModelTests: XCTestCase {

  private var repository: SportEventRepositorySpy!
  private var sut: MainViewModel!

  
  override func setUp() {
    super.setUp()
    repository = SportEventRepositorySpy()
    sut = MainViewModel(repository: repository)
  }
  
  override func tearDown() {
    repository = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Tests

  func testFetchEvents() {
    // Arrange
    let event = SportEventModel(name: "Name", venue: "Venue", duration: 10, inRemote: false)
    repository.callbackResult = .success([event])
    // Act
    sut.fetchEvents()
    // Assert
    XCTAssertTrue(repository.getSportEventsInvoked)
    XCTAssert(sut.events.count == 1)
    XCTAssert(sut.events.first?.name == "Name")
    XCTAssert(sut.events.first?.venue == "Venue")
    XCTAssert(sut.events.first?.duration == 10)
  }
  
  func testAddEvent() {
    // Arrange
    let event = SportEventModel(name: "Name", venue: "Venue", duration: 10, inRemote: false)
    // Act
    sut.add(event: event)
    // Assert
    XCTAssertTrue(repository.addEventInvoked)
    XCTAssert(sut.events.count == 1)
  }
  
  func testFilter() {
    // Arrange
    let remoteEvent = SportEventModel(name: "Remote", venue: "Venue", duration: 10, inRemote: true)
    let localEvent = SportEventModel(name: "Local", venue: "Venue", duration: 10, inRemote: false)
    // Act
    sut.add(event: remoteEvent)
    sut.add(event: localEvent)
    sut.selectedStorage = 1
    // Assert
    XCTAssert(sut.filteredEvents.count == 1)
    XCTAssert(sut.filteredEvents.first?.name == "Remote")
    // Act
    sut.selectedStorage = 2
    XCTAssert(sut.filteredEvents.count == 1)
    XCTAssert(sut.filteredEvents.first?.name == "Local")
  }
}
