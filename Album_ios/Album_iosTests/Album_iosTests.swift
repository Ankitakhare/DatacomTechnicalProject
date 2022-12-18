

import XCTest
@testable import Album_ios

class Album_iosTests: XCTestCase {

    let internetChecker = SpyInternetChecker()
    let apiManager = SpyApiManager()
    
    var viewModel: AlbumViewModel!
    
    override func setUp() {
        viewModel = AlbumViewModel(apiManager: apiManager, internetChecker: internetChecker)
    }
    
    func testFetchUserDetail() {
        internetChecker.stubbedIsInternetAvailableResult = true
        viewModel.fetchUserDetail()
        XCTAssertTrue(apiManager.invokedFetchUserDetail)
    }

}
