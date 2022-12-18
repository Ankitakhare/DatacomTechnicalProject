//
//  SpyInternetChecker.swift
//  Album_iosTests
//

import Foundation
@testable import Album_ios

class SpyInternetChecker: InternetCheckerProtocol {

    var invokedIsInternetAvailable = false
    var invokedIsInternetAvailableCount = 0
    var stubbedIsInternetAvailableResult: Bool! = false

    func isInternetAvailable() -> Bool {
        invokedIsInternetAvailable = true
        invokedIsInternetAvailableCount += 1
        return stubbedIsInternetAvailableResult
    }
}
