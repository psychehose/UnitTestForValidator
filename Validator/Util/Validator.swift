//
//  Validator.swift
//  Validator
//
//  Created by 김호세 on 2023/03/15.
//

import Foundation

public struct Validator {
  public init() { }
  private let idValidationPattern: String = "^[a-z]{1}[a-z0-9]{4,11}$"
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
}
