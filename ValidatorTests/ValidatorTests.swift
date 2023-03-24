//
//  ValidatorTests.swift
//  ValidatorTests
//
//  Created by 김호세 on 2023/03/15.
//

import XCTest
@testable import Validator

final class ValidatorTests: XCTestCase {

  var sut: Validator!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Validator()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testFailFirstNumberID() throws {
    let id = "1psychese"

    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, false)
  }

  func testFailFirstSpecialSymbolID() throws {
    let id = "_psychehose"

    let result = sut.idValidateByClient(id)
    XCTAssertEqual(result, false)
  }

  func testFailFirstCaptialID() throws {
    let id = "Psychehose"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, false)
  }

  func testFailFirstKoreanID() throws {
    let id = "김psychehose"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, false)
  }

  func testFailOneLetterID() throws {
    let id = "p"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, false)
  }

  func testFailFourLetterLetterID() {
    let id = "abcd"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, false)
  }
  func testFailThirteenLetterID() throws {
    let id = "abcde12345678"
    let result = sut.idValidateByClient(id)
    XCTAssertEqual(result, false)
  }

  func testFailIDWithSymbol() throws {
    let id = "ab!cdef"
    let result = sut.idValidateByClient(id)
    XCTAssertEqual(result, false)
  }

  func testSuccessFiveLetterID() throws {
    let id = "abcde"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, true)
  }
  func testSuccessID() throws {
    let id = "psychehose"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, true)
  }

  func testSuccessTwelveLetterID() throws {
    let id = "abcdeabcdeab"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, true)
  }

  func testSuccessIDWithNumber1() throws {
    let id = "abcd1234"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, true)
  }
  func testSuccessIDWithNumber2() throws {
    let id = "a1b2c3d4"
    let result = sut.idValidateByClient(id)

    XCTAssertEqual(result, true)
  }
}
