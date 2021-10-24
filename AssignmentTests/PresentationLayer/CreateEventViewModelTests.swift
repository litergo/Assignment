//
//  CreateEventViewModelTests.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import XCTest
@testable import Assignment

class CreateEventViewModelTests: XCTestCase {

  private var sut: CreateEventViewModel!

  
  override func setUp() {
    super.setUp()
    sut = CreateEventViewModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: Tests
  
  func testCreateModel() {
    // Arrange
    sut.nameInput = "Name"
    sut.venueInput = "Venue"
    sut.durationInput = "10"
    // Act
    let model = sut.sportEventModel
    // Assert
    XCTAssertNotNil(model)
    XCTAssert(model?.name == "Name")
  }
  
  func testDurationInput() {
    // Arrange
    sut.durationInput = "10"
    // Act
    let input = sut.durationFormatted
    // Assert
    XCTAssertNotNil(input)
  }
  
  func testWrongDurationInput() {
    // Arrange
    sut.durationInput = "10seconds"
    // Act
    let input = sut.durationFormatted
    // Assert
    XCTAssertNil(input)
  }
}
