//
//  SportEventStorageServiceTests.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import XCTest
@testable import Assignment

class SportEventStorageServiceTests: XCTestCase {
  
  private var fakeCoreDataStack: FakeCoreDataStack!
  private var sut: SportEventStorageService!

  
  override func setUp() {
    super.setUp()
    fakeCoreDataStack = FakeCoreDataStack()
    sut = SportEventStorageServiceImp(coreDataStack: fakeCoreDataStack)
  }
  
  override func tearDown() {
    fakeCoreDataStack = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Tests

  func testAddEvent() {
    // Act
    sut.add(sportEvent: SportEventModel(name: "Name", venue: "Venue", duration: 10, inRemote: false))
    // Assert
    XCTAssertTrue(fakeCoreDataStack.saveMainContextInvoked)
  }
  
  func testGetEvents() {
    // Arrange
    sut.add(sportEvent: SportEventModel(name: "Name", venue: "Venue", duration: 10, inRemote: false))
    
    // Act
    let result = sut.getSportEvents()
    
    // Assert
    switch result {
    case .failure:
      XCTFail("Get events should return model")
    case .success(let events):
      XCTAssert(events.count == 1)
      XCTAssert(events.first?.name == "Name")
      XCTAssert(events.first?.venue == "Venue")
      XCTAssert(events.first?.duration == 10)
      XCTAssertFalse(events.first?.inRemote ?? true)
    }
  }
}
