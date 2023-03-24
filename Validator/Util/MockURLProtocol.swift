//
//  MockURLProtocol.swift
//  Validator
//
//  Created by 김호세 on 2023/03/24.
//

import Foundation

typealias CustomResponse = Result<Data, Error>

class MockURLProtocol: URLProtocol {
  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

  static var responseHandler: ((URLRequest) throws -> (response: HTTPURLResponse, data: CustomResponse))?

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    guard let handler = MockURLProtocol.responseHandler else {
      return
    }
    do {
      let result = try handler(request)
      let httpResponse = result.response
      let customResponse = result.data
      switch customResponse {

      case .success(let data):
        client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)

      case .failure(let error):
        client?.urlProtocol(self, didFailWithError: error)
      }
    }
    catch {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }
  override func stopLoading() {
    debugPrint("Stop Loading")
  }
}
