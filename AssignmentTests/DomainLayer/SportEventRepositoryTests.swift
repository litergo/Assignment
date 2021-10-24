//
//  SportEventRepositoryTests.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import XCTest
@testable import Assignment

enum TestError: Error {
  case fail
}

class SportEventRepositoryTests: XCTestCase {
  
  private var firebaseProvider: FirebaseDatabaseProviderSpy!
  private var storageService: SportEventStorageServiceSpy!
  private var sut: SportEventRepositoryImp!

  
  override func setUp() {
    super.setUp()
    storageService = SportEventStorageServiceSpy()
    firebaseProvider = FirebaseDatabaseProviderSpy()
    sut = SportEventRepositoryImp(storageService: storageService,
                                  firebaseProvider: firebaseProvider)
  }
  
  override func tearDown() {
    storageService = nil
    firebaseProvider = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Tests

  func testAddEventToRemote() {
    // Arrange
    let event = SportEventModel(name: "", venue: "", duration: 0, inRemote: true)
    // Act
    sut.add(sportEvent: event)
    // Assert
    XCTAssertTrue(firebaseProvider.addEventInvoked)
    XCTAssertFalse(storageService.addEventInvoked)
  }
  
  func testAddEventToLocalStorage() {
    // Arrange
    let event = SportEventModel(name: "", venue: "", duration: 0, inRemote: false)
    // Act
    sut.add(sportEvent: event)
    // Assert
    XCTAssertTrue(storageService.addEventInvoked)
    XCTAssertFalse(firebaseProvider.addEventInvoked)
  }
  
  func testGetEventsWithError() {
    // Arrange
    storageService.getSportEventsReturnValue = .failure(TestError.fail)
    // Act
    sut.getSportEvents { result in
      if case .success = result {
        XCTFail("Should be an error")
      }
    }
    // Assert
    XCTAssertTrue(storageService.getSportEventsInvoked)
    XCTAssertFalse(firebaseProvider.getSportEventsInvoked)
  }
  
  func testGetEvents() {
    // Arrange
    let event = SportEventModel(name: "Name", venue: "Venue", duration: 0, inRemote: false)
    storageService.getSportEventsReturnValue = .success([event])
    // Act
    sut.getSportEvents { result in
      if case let .success(events) = result {
        XCTAssert(events.count == 1)
        XCTAssert(events.first?.name == "Name")
        XCTAssert(events.first?.venue == "Venue")
        XCTAssert(events.first?.duration == 0)

      }
    }
    // Assert
    XCTAssertTrue(storageService.getSportEventsInvoked)
    XCTAssertTrue(firebaseProvider.getSportEventsInvoked)
  }
}
