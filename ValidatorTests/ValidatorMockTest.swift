
//  ValidatorMockTest.swift
//  ValidatorTests
//
//  Created by 김호세 on 2023/03/24.


import Foundation
import XCTest
@testable import Validator

final class ValidatorMockTest: XCTestCase {

  var sut: Validator!

  override func setUpWithError() throws {
    try super.setUpWithError()
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    sut = Validator(configuration: config)

  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_available_from_mock() async throws {

    // Mock을 생성 -> 이것이 우리가 받을 결과임
    MockURLProtocol.responseHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!

      let mockResult: [Bool] = [true]
      let mockResponseData = try! JSONEncoder().encode(mockResult)

      let responseData = CustomResponse.success(mockResponseData)

      return (response, responseData)
    }
//     URL에 "https://" 이런식으로 말이 되는 URL 넣으면 됩니다. scheme host 다 있어야함

    let testTargetValue = try await sut.isValidationFromServer(URL(string: "https://www.test11111.com")!)
    XCTAssertEqual(testTargetValue, true)
  }

  func test_no_available_from_mock() async throws {

    MockURLProtocol.responseHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!

      let mockResult: [Bool] = [false]
      let mockResponseData = try! JSONEncoder().encode(mockResult)

      let responseData = CustomResponse.success(mockResponseData)

      return (response, responseData)
    }

    let testTargetValue = try await sut.isValidationFromServer(URL(string: "https://www.test11111.com")!)
    XCTAssertEqual(testTargetValue, false)
  }

  func test_empty_error_from_mock() async throws {

    MockURLProtocol.responseHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 404,
        httpVersion: nil,
        headerFields: nil
      )!

      let mockResult: [Bool] = []
      let responseData = CustomResponse.failure(NSError(domain: "No data. Empty", code: -10))

      return (response, responseData)
    }

    let testTargetValue = try await sut.isValidationFromServer(URL(string: "https://www.test11111.com")!)
    XCTAssertEqual(testTargetValue, false)
  }
}

