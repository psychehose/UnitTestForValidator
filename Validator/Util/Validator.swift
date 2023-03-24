//
//  Validator.swift
//  Validator
//
//  Created by 김호세 on 2023/03/15.
//

import Foundation

public struct Validator {
  public init(configuration: URLSessionConfiguration = .default) {
    self.configuration = configuration
  }

  private let configuration: URLSessionConfiguration
  private let idValidationPattern: String = "^[a-z]{1}[a-z0-9]{4,11}$"

  private var session: URLSession {
    return URLSession(configuration: self.configuration)
  }
}

public extension Validator {
  func idValidateByClient(_ input: String) -> Bool {
    guard
      let regex = try? NSRegularExpression(
        pattern: idValidationPattern,
        options: []
      ) else {
      assertionFailure("Regex not valid")
      return false
    }
    let regexFirstMatch = regex
      .firstMatch(
        in: input,
        options: [],
        range: NSRange(location: 0, length: input.count)
      )
    return regexFirstMatch != nil
  }

  func isValidationFromServer(_ url: URL) async throws -> Bool {
    let url = url
    let urlRequest = URLRequest(url: url)
    let (data, _) = try await session.data(for: urlRequest)
    
    guard let isValidate = try JSONDecoder().decode([Bool].self, from: data).first else {
      throw NSError(domain: "No Data", code: -1)
    }

    return isValidate
  }
}
