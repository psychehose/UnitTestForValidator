//
//  ValidatorSlowTest.swift
//  ValidatorTests
//
//  Created by 김호세 on 2023/03/24.
//

import Foundation
import XCTest
@testable import Validator

final class ValidatorSlowTest: XCTestCase {

  var sut: Validator!

  override func setUpWithError() throws {
    try super.setUpWithError()
    let config = URLSessionConfiguration.ephemeral
    sut = Validator(configuration: config)

  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_available_api_test() async throws{

    guard
      let url = URL(
        string: ""
      )
    else {
      return
    }

    let result = try await sut.isValidationFromServer(url)

    XCTAssertEqual(result, true)
  }
  func test_no_available_api_test() async throws{

    guard
      let url = URL(
        string: ""
      )
    else {
      return
    }

    let result = try await sut.isValidationFromServer(url)

    XCTAssertEqual(result, false)
  }
  func test_empty_api_test() async throws{

    guard
      let url = URL(
        string: ""
      )
    else {
      return
    }

    let result = try await sut.isValidationFromServer(url)

    XCTAssertEqual(result, true)
  }
}

