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
  private let passwordValidationPattern: String = "^(?!([A-Za-z]+|[~!@#$%^&*()_+=]+|(?=[0-9]+))$)[A-Za-z\\d~!@#$%^&*()_+=]{8,12}$"
  private let contactNumber: String = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
  private let emailValidationPattern: String = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
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
  func passwordValidateByClient(_ input: String) -> Bool {
    guard
      let regex = try? NSRegularExpression(
        pattern: passwordValidationPattern,
        options: []
      )
    else {
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
  func emailValidateByClient(_ input: String) -> Bool {
    guard
      let regex = try? NSRegularExpression(
        pattern: emailValidationPattern,
        options: [.caseInsensitive]
      )
    else {
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
  func contactNumberValidateByClient(_ input: String) -> Bool {
    guard
      let regex = try? NSRegularExpression(
        pattern: contactNumber,
        options: [.caseInsensitive]
      )
    else {
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
